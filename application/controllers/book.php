<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Book extends CI_Controller {

	/* 
	 * This is the default function of the Book Controller
	 * This will return an Invalid Request if called.
	 * @return array('message' => 'Unauthorized Access', 'status' => 403);
	*/
	public function index()
	{
		json_output(403,array('status' => 403,'message' => 'Unauthorized Access.'));
	}

	/* 
	 * This is a function for adding a book
	 * Method: POST
	 * Output: json
	*/
	public function add_book()
	{
		$method = $_SERVER['REQUEST_METHOD'];
		$input = json_decode(file_get_contents('php://input'),true);

		if($method != 'POST'){
			json_output(400, array('status' => 400,'message' => 'Bad Request.'));
		}else{

			// validate fields
			$post = array('book_title', 'book_author','book_genre', 'book_section');
			$label = array('Book Title', 'Author', 'Genre', 'Library Section');
			$this->validate_form($post, $label);
	
			$check_auth_client = $this->rest_model->check_auth_client();
			if($check_auth_client){
				$response = $this->rest_model->auth();
		        if($response['status'] == 200){
		        	$response = $this->rest_model->add_book($input);
				}
			}
		}
	}

	/* 
	 * This function updates book details
	 * Method: PUT
	 * Output: json
	*/
	public function edit_book()
	{
		$method = $_SERVER['REQUEST_METHOD'];
		$input = json_decode(file_get_contents('php://input'),true);

		if($method != 'PUT'){
			json_output(400, array('status' => 400,'message' => 'Bad Request.'));
		}else{
			// validate fields
			$post = array('book_title', 'book_author','book_genre', 'book_section', 'book_id');
			$label = array('Book Title', 'Author', 'Genre', 'Library Section', 'Book ID');
			$this->validate_form($post, $label);
	
			$check_auth_client = $this->rest_model->check_auth_client();
			if($check_auth_client){
				$response = $this->rest_model->auth();
		        if($response['status'] == 200){
		        	$response = $this->rest_model->edit_book($input);
				}
			}
		}
	}

	/* 
	 * This function updates book's status to 'Inactive'
	 * Method: PUT
	 * Output: json
	*/
	public function delete_book()
	{
		$method = $_SERVER['REQUEST_METHOD'];
		$input = json_decode(file_get_contents('php://input'),true);

		if($method != 'PUT'){
			json_output(400, array('status' => 400,'message' => 'Bad Request.'));
		}else{
			// validate fields
			$post = array('book_id');
			$label = array('Book ID');
			$this->validate_form($post, $label);
	
			$check_auth_client = $this->rest_model->check_auth_client();
			if($check_auth_client){
				$response = $this->rest_model->auth();
		        if($response['status'] == 200){
		        	$response = $this->rest_model->delete_book($input);
				}
			}
		}
	}

	/* 
	 * This function gets list of books / specific book details
	 * Method: GET
	 * Output: json
	*/
	public function get_book()
	{
		$method = $_SERVER['REQUEST_METHOD'];

		if($method != 'GET'){
			json_output(400, array('status' => 400,'message' => 'Bad Request.'));
		}else{
			$check_auth_client = $this->rest_model->check_auth_client();
			if($check_auth_client){
				$response = $this->rest_model->auth();
		        if($response['status'] == 200){
		        	$response = $this->rest_model->get_book($_GET);
				}
			}
		}
	}

	/* 
	 * This function tag the book as borrowed
	 * Method: POST
	 * Output: json
	*/
	public function borrow_book()
	{
		$method = $_SERVER['REQUEST_METHOD'];
		$input = json_decode(file_get_contents('php://input'),true);

		if($method != 'POST'){
			json_output(400, array('status' => 400,'message' => 'Bad Request.'));
		}else{
			// validate fields
			$post = array('book_id', 'borrower');
			$label = array('Book', 'borrower');
			$this->validate_form($post, $label);
	
			$check_auth_client = $this->rest_model->check_auth_client();
			if($check_auth_client){
				$response = $this->rest_model->auth();
		        if($response['status'] == 200){
		        	$response = $this->rest_model->borrow_book($input);
				}
			}
		}
	}

	/* 
	 * This function tag the book as returned
	 * Method: POST
	 * Output: json
	*/
	public function return_book()
	{
		$method = $_SERVER['REQUEST_METHOD'];
		$input = json_decode(file_get_contents('php://input'),true);

		if($method != 'POST'){
			json_output(400, array('status' => 400,'message' => 'Bad Request.'));
		}else{
			// validate fields
			$post = array('book_id','borrow_id');
			$label = array('Book','Borrow Id');
			$this->validate_form($post, $label);
	
			$check_auth_client = $this->rest_model->check_auth_client();
			if($check_auth_client){
				$response = $this->rest_model->auth();
		        if($response['status'] == 200){
		        	$response = $this->rest_model->return_book($input);
				}
			}
		}
	}

	/* 
	 * This function gets the list of available books for borrowing
	 * Method: GET
	 * Output: json
	*/
	public function get_available_book()
	{
		$method = $_SERVER['REQUEST_METHOD'];

		if($method != 'GET'){
			json_output(400, array('status' => 400,'message' => 'Bad Request.'));
		}else{
			$check_auth_client = $this->rest_model->check_auth_client();
			if($check_auth_client){
				$response = $this->rest_model->auth();
		        if($response['status'] == 200){
		        	$response = $this->rest_model->get_available_book();
				}
			}
		}
	}

	/* 
	 * This function gets the list of borrowed books
	 * Method: GET
	 * Output: json
	*/
	public function get_borrowed_book()
	{
		$method = $_SERVER['REQUEST_METHOD'];

		if($method != 'GET'){
			json_output(400, array('status' => 400,'message' => 'Bad Request.'));
		}else{
			$check_auth_client = $this->rest_model->check_auth_client();
			if($check_auth_client){
				$response = $this->rest_model->auth();
		        if($response['status'] == 200){
		        	$response = $this->rest_model->get_borrowed_book();
				}
			}
		}
	}

	/* 
	 * This function gets the list of borrowed books history
	 * Method: GET
	 * Output: json
	*/
	public function get_borrowed_history()
	{
		$method = $_SERVER['REQUEST_METHOD'];

		if($method != 'GET'){
			json_output(400, array('status' => 400,'message' => 'Bad Request.'));
		}else{
			$check_auth_client = $this->rest_model->check_auth_client();
			if($check_auth_client){
				$response = $this->rest_model->auth();
		        if($response['status'] == 200){
		        	$response = $this->rest_model->get_borrowed_history();
				}
			}
		}
	}

	/* 
	 * This function gets data for the dashboard
	 * Method: GET
	 * Output: json
	*/
	public function get_dashboard()
	{
		$method = $_SERVER['REQUEST_METHOD'];

		if($method != 'GET'){
			json_output(400, array('status' => 400,'message' => 'Bad Request.'));
		}else{
			$check_auth_client = $this->rest_model->check_auth_client();
			if($check_auth_client){
				$response = $this->rest_model->auth();
		        if($response['status'] == 200){
		        	$response = $this->rest_model->get_dashboard();
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
			json_output(400, array('status' => 400, 'message' => $error));
	}
}

/* End of file Book.php */
/* Location: ./application/controllers/book.php */