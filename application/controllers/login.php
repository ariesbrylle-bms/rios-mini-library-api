<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Login extends CI_Controller {

	/* 
	 * This is the default function of the Login Controller
	 * This will return an Invalid Request if called.
	 * @return array('message' => 'Unauthorized Access', 'status' => 403);
	*/
	public function index()
	{
		json_output(403,array('status' => 403,'message' => 'Unauthorized Access.'));
	}

	/* 
	 * This function validates username and password
	 * Method: POST
	 * Output: json
	*/
	public function validate_credentials()
	{
		$method = $_SERVER['REQUEST_METHOD'];
		$input = json_decode(file_get_contents('php://input'),true);

		if($method != 'POST'){
			json_output(400, array('status' => 400,'message' => 'Bad Request.'));
		}else{
			// validate fields
			$post = array('username', 'password');
			$label = array('Username', 'Password');
			$this->validate_form($post, $label);

			// validate username and password
			$response = $this->rest_model->validate_credentials($input['username'], $input['password']);
		}
	}

	/* 
	 * This function change password 
	 * Method: POST
	 * Output: json
	*/
	public function change_password()
	{
		$method = $_SERVER['REQUEST_METHOD'];
		$input = json_decode(file_get_contents('php://input'),true);

		if($method != 'POST'){
			json_output(400, array('status' => 400,'message' => 'Bad Request.'));
		}else{
			$check_auth_client = $this->rest_model->check_auth_client();
			if($check_auth_client){
				$post = array('p_password', 'n_password');
				$label = array('Current Password', 'New Password');
				$this->validate_form($post, $label);

				$response = $this->rest_model->auth();
		        if($response['status'] == 200){
		        	$response = $this->rest_model->change_credentials($input['p_password'], $input['n_password']);
				}
			}
		}
	}

	/* 
	 * This function validates required input.
	 * Output: json
	*/
	public function validate_form($post, $label){
		$error = array();
		$ctr = 0;
		$hasError = 0;

		$input = json_decode(file_get_contents('php://input'),true);
		foreach ($post as $key) {
			if ($input[$key] == ""){
				$error[] = $label[$ctr].' is required.'; 
				$hasError = 1;
			}
			$ctr++;
		}

		if ($hasError == 1)
			json_output(400, array('statys' => 400, 'message' => $error));
	}
}

/* End of file login.php */
/* Location: ./application/controllers/login.php */