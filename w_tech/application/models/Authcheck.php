<?php

class Authcheck extends CI_Model {
    
     function __construct() {
        $this->load->database();
    }

    public function token_generate($postData)
    {
        $output = array();
        
        $tmp_user_id = preg_replace('/[^0-9]/', '', $postData['user_id']);

        $token = $this->jsonwebtokens->generate_jswt($tmp_user_id,'P30D'); 

        //  Update token if token expired
        
        $this->db->where("user_id",$tmp_user_id);
        $this->db->where("expired_on <",date("Y-m-d H:i:s"));
        $this->db->update("user_token",array("is_expired" => '1'));

        /* checking here token is exist or not*/

        $this->db->select("*");
        $this->db->from("user_token");
        $this->db->where("is_expired","0");
        $this->db->where("user_id",$tmp_user_id);
        $query = $this->db->get();
        $tmpResult = $query->result_array();

        if(!empty($tmpResult) && sizeof($tmpResult) > 0 )
        {
            $data = array();
            $data = array(
                "token"         =>  $tmpResult[0]['token'],
                "added_at"      =>  $tmpResult[0]['added_at'],
                "expired_on"    =>  $tmpResult[0]['expired_on'],
                "is_expired"    =>  $tmpResult[0]['is_expired'],
                "user_id"       =>  $tmpResult[0]['user_id']
            );
        } 
        else{
            $data = array();
            $data = array(
                "token"         =>  $token,
                "added_at"      =>  date("Y-m-d H:i:s"),
                "expired_on"    =>  date("Y-m-d H:i:s", strtotime("+6 hours")), // here token valid for 6 hours
                "is_expired"    => '0',
                "user_id"       => $tmp_user_id
            );

            $this->db->insert("user_token", $data);
            $last_id = $this->db->insert_id();
            if($last_id != "")
            {
                unset($data['added_at']);
                unset($data['is_expired']);
            }
        }
        return $data;
    }

    public function token_verify($postData)
    {
        $getHeaders = apache_request_headers();

        header('Content-type: application/json');
        $postData = json_decode(file_get_contents('php://input'), true);

        if(!isset($getHeaders['authorization']))
        {
            $output['status'] = false;
            $output['message'] = "Please provide valid authorization.";
           
            return $output;
        }
        $authorization = $getHeaders['authorization'];
        if(isset($authorization) && $authorization != "")
        {
            $postData['token'] = $authorization;
            $output = array();
            $tmp_user_id = preg_replace('/[^0-9]/', '', $postData['user_id']);

            /* checking here token is exist or not*/

            $this->db->select("token");
            $this->db->from("user_token");
            $this->db->where("is_expired","0");
            $this->db->where("user_id",$tmp_user_id);
            $this->db->where("token ", $postData['token']);
            $query = $this->db->get();
            $tmpResult = $query->result_array();
            if(!empty($tmpResult) && sizeof($tmpResult) > 0 )
            {
                $output['status'] = true;
                return $output;
            } 
            else{
                $output['status'] = false;
                $output['message'] = "Authorization token has been expired";
                return $output;
            }
        }
        else{
            $output['status'] = false;
            $output['message'] = "Invalid authorization code.";
            return $output;
        }
    }
}