<?php defined('BASEPATH') OR exit('No direct script access allowed');


// Include Rest Controller library 
require APPPATH . '/libraries/REST_Controller.php'; 


class Api extends REST_Controller {

    public function __construct() {

    	date_default_timezone_set("Asia/Calcutta"); 

        parent::__construct();
		$this->load->model("ItemModel","item_model");
		$this->load->model("Authcheck","authcheck");
    }


    // list from item table with post method

    public function get_data_post() 
    {

        header('Content-type: application/json');
		
		$postData = json_decode(file_get_contents('php://input'), true);


        if(empty($postData))
        {
            return false;
        }

		/* checked authorization code valid or not */

        $tmp_output  = $this->authcheck->token_verify($postData);

        if(isset($tmp_output) && $tmp_output['status'] == false)
        {
        	echo json_encode($tmp_output);
            return false;
        }
        
        $tmp_user_id = preg_replace('/[^0-9]/', '', $postData['user_id']);

        if(!isset($postData['user_id']) || $postData['user_id'] == "" || $tmp_user_id == '' || $tmp_user_id <=0 )
        {
            $output['status'] = false;
            $output['message'] = "Send valid user id.";

            echo json_encode($output);
            return false;
        }

        $output = $this->item_model->itemList($postData);

        echo json_encode($output);
    }


	// save / insert into item table

    public function add_items_post() 
    {

        header('Content-type: application/json');
		$output = array();

		$postData = json_decode(file_get_contents('php://input'), true);
			
        if(empty($postData))
        {
            return false;
        }

        /* checked authorization code valid or not */
		
        $tmp_output  = $this->authcheck->token_verify($postData);

        if(isset($tmp_output) && $tmp_output['status'] == false)
        {
        	echo json_encode($tmp_output);
            return false;
        }
        
        
        $tmp_user_id = preg_replace('/[^0-9]/', '', $postData['user_id']);

        if(!isset($postData['user_id']) || $postData['user_id'] == "" || $tmp_user_id == '' || $tmp_user_id <=0 )
        {
            $output['status'] = false;
            $output['message'] = "Send valid user id.";

            echo json_encode($output);
            return false;
        }

        if(isset($postData['name']) && $postData['name'] == "")
        {
        	$output['status'] = false;
            $output['message'] = "Please enter valid item names";
            echo json_encode($output);
            exit;
        }

        $output = $this->item_model->add_items($postData);
        echo json_encode($output);
    }

	/* JWT Token has been generated */
    public function jwtTokenGenerate_post()
    {
    	$this->load->library('jsonwebtokens');
		
		header('Content-type: application/json');
		

		$postData = json_decode(file_get_contents('php://input'), true);
		
        if(empty($postData))
        {
            return false;
        }
        
        $tmp_user_id = preg_replace('/[^0-9]/', '', $postData['user_id']);

        if(!isset($postData['user_id']) || $postData['user_id'] == "" || $tmp_user_id == '' || $tmp_user_id <=0 )
        {
            $output['status'] = false;
            $output['message'] = "Send valid user id.";

            echo json_encode($output);
            return false;
        }

        $output  = $this->authcheck->token_generate($postData);
        echo json_encode($output);
    }
}