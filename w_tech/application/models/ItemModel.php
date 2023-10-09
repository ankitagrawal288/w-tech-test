<?php

class ItemModel extends CI_Model {
    
     function __construct() {
        $this->load->database();
    }
    
    public function itemList($postData)
    {
        $output = array();
        $this->db->select("sql_calc_found_rows items.*", false);
        $this->db->from("items");
        if((isset($postData['page_no']) && $postData['page_no']!="") && (isset($postData['record_per_page']) && $postData['record_per_page']!=""))
        {

            $start = $postData['page_no'];
            $this->db->limit($postData['record_per_page'],$start);
        }

        $this->db->where("status","1");
        
        $this->db->order_by("id", "desc");
        $query = $this->db->get();
        $tmpResult = $query->result_array();

        $count_rows = 0;
        if(!empty($tmpResult)) {          
            $count_query = $this->db->query("SELECT found_rows() as count");
            $tmpCount = $count_query->row();
            $count_rows = $tmpCount->count;
        }

        $output['status'] = true;
        $output['count'] = $count_rows;
        $output['response'] = $tmpResult;
        return $output;
    }

    public function add_items($postData)
    {
       
        $output = array();
        $this->db->select("id");
        $this->db->from("items");

        if(isset($postData['name']) && $postData['name'] != "")
        {
            $this->db->where("name", $postData['name']);
        }

        $query = $this->db->get();

        $tmpResult = array();
        $tmpResult = $query->result_array();

        if(!empty($tmpResult) && sizeof($tmpResult))
        {
            $output['status'] = false;
            $output['message'] = "Item name already exists. Please check item name.";
            return $output;
            exit;
        }

        $this->db->insert("items", array("name" => $postData['name']));

        $output['status'] = true;
        $output['response'] = "Item added successfully.";
        return $output;
    }

}