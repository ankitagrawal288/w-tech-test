<?php
defined('BASEPATH') OR exit('No direct script access allowed');

use \Firebase\JWT\JWT;

class Jsonwebtokens {

	public function init() 

	{
		include APPPATH . 'third_party/firebase-jwt/src/JWT.php';
	}

	public function  generate_jswt($data = array(), $validity = 'P30D') 
	{

		$CI =& get_instance();

		$this->init();
		$jwt = '';

		$date = new DateTime();
		$timeStart = $date->getTimestamp();
		$date->add(new DateInterval($validity));
		$timeEnd = $date->getTimestamp();

		/*
		* iss – Issuer application.
		* iat – timestamp of token issuing.
		* nbf – Timestamp of when the token should start being considered valid.
		* exp – Timestamp of when the token should cease to be valid.
		* data – Array of data
		*/

		try {

			$token = array(
				"iss" => "MyApplicationName.com",
				"aud" => "MyApplication Name",
				"iat" => $timeStart,
				"nbf" => $timeStart,
				"exp" => $timeEnd,
				"data" => $data);

			$jwt = JWT::encode($token, "MyGeneratedKey","HS256");

		} catch (Exception $ex) {
			log_message('error',$ex->getMessage());
		} finally {
			return $jwt;
		}
	}

	public function validate_jswt($token) 
	{

		$this->init();

		$jwt = null;

		try {
			$jwt = JWT::decode($token, "MyGeneratedKey",array("HS256"));
		} catch (Exception $ex) {
			log_message('error',$ex->getMessage());
		} finally {
			return $jwt;
		}
	}
} 