<?php

class Rest_model extends CI_Model {
	
	public function __construct()
	{
		parent::__construct();
		$this->api_service = API_SERVICE;
    	$this->auth_key = AUTH_KEY;
	}

    /* 
     * This function validates the header of the service and auth key
     * @return true|json
    */
    public function check_auth_client(){
        $l_api_service = $this->input->get_request_header('Ffuf-library-service', TRUE);
        $l_auth_key  = $this->input->get_request_header('X-api-key', TRUE);
        
        if($l_api_service == $this->api_service && $l_auth_key == $this->auth_key){
            return true;
        }else{
            json_output(400, array('status' => 400,'message' => 'Bad Request.'));
        }
    }

    /* 
     * This function validates the login credentials of the user.
     * @param username
     * @param password
     * @return userid, token, service, auth key
    */
    public function validate_credentials($username, $password){
    	$q = $this->db->query("select id, password from users where username = ?", $username);

    	if ($q->num_rows() > 0){
    		if (hash_equals($q->row()->password, crypt($password, $q->row()->password))){
    			$last_login = date('Y-m-d H:i:s');
    			$token = crypt(substr(md5(rand()), 0, 7),'');
                $expired_at = date("Y-m-d H:i:s", strtotime('+12 hours'));
                $user_id = $q->row()->id;

                $this->db->trans_start();
                $this->db->where('id',$user_id);
                $this->db->update('users', array('last_login' => $last_login));

                $this->db->insert('users_authentication', array('users_id' => $user_id,'token' => $token ,'expired_at' => $expired_at));

                if ($this->db->trans_status() === FALSE){
                  $this->db->trans_rollback();
                  json_output(500, array('status' => 500, 'message' => 'Internal server error.'));
                }else{
                  $this->db->trans_commit();
                  json_output(200, array('status' => 200, 'message' => 'Successfully Login.', 'id' => $user_id, 'token' => $token, 'username' => $username, 'api_service' => $this->api_service, 'api_auth_key' => $this->auth_key));
                }
    		}else{
    			json_output(403, array('status' => 403, 'message' => 'Invalid Password.'));
    		}
    	}else{
    		json_output(403, array('status' => 403, 'message' => 'User not found.'));
    	}
    }

    /* 
     * This is the function for the change password.
     * @param p_password = current password
     * @param n_password = new password
     * @return json
    */
    public function change_credentials($p_password, $n_password){
        $l_users_id  = $this->input->get_request_header('User-id', TRUE);
        $q = $this->db->query("select id, password from users where id = ?", $l_users_id);

        if ($q->num_rows() > 0){
            if (hash_equals($q->row()->password, crypt($p_password, $q->row()->password))){
                $user_id = $q->row()->id;

                $this->db->where('id',$user_id);
                $this->db->update('users', array('password' => crypt($n_password,'')));

                json_output(200, array('status' => 200, 'message' => 'Password has been successfully Changed.'));
            }else{
                json_output(403, array('status' => 403, 'message' => 'Invalid Current Password.'));
            }
        }else{
            json_output(403, array('status' => 403, 'message' => 'User not found.'));
        }
    }

    /* 
     * This function authenticats the headers (service,auth_key,user_id,token) from the user request
     * @return json
    */
    public function auth()
    {
    	$l_api_service = $this->input->get_request_header('Ffuf-library-service', TRUE);
        $l_auth_key  = $this->input->get_request_header('X-api-key', TRUE);
        $l_users_id  = $this->input->get_request_header('User-id', TRUE);
        $l_token     = $this->input->get_request_header('Authorization', TRUE);

        $q = $this->db->query("select expired_at from users_authentication where users_id = ? and token = ?", array($l_users_id, $l_token));

        if ($q->num_rows() > 0){
        	if($q->row()->expired_at < date('Y-m-d H:i:s')){
                json_output(401,array('status' => 401,'message' => 'Your session has been expired.'));
            }else{
                $updated_at = date('Y-m-d H:i:s');
                $expired_at = date("Y-m-d H:i:s", strtotime('+12 hours'));
                $this->db->where('users_id',$l_users_id);
                $this->db->where('token',$l_token);
                $this->db->update('users_authentication', array('expired_at' => $expired_at,'updated_at' => $updated_at));

                return array('status' => 200,'message' => 'Authorized.');
            }
        }else{
        	json_output(401, array('status' => 401, 'message' => 'Unauthorized.'));
        }
    }

    /* 
     * This is the function for adding new books
     * @param post = array();
     * @return json
    */
    public function add_book($post){
    	$data = array(
    		'title' => $post['book_title'],
    		'author' => $post['book_author'],
    		'genre' => $post['book_genre'],
    		'section' => $post['book_section'],
    		'is_available' => 'Yes',
    		'status' => 'Active',
    		'date_added' => date('Y-m-d H:i:s'),
    		'added_by' => $this->input->get_request_header('User-id', TRUE)
    	);

    	$this->db->insert('books', $data);
    	json_output(200, array('status' => 200, 'message' => 'Book has been successfully created.'));
    }

    /* 
     * This is the function for updating book details
     * @param post = array();
     * @return json
    */
    public function edit_book($post){
    	$data = array(
    		'title' => $post['book_title'],
    		'author' => $post['book_author'],
    		'genre' => $post['book_genre'],
    		'section' => $post['book_section'],
    		'is_available' => 'Yes',
    		'status' => 'Active',
    		'updated_at' => date('Y-m-d H:i:s'),
    		'updated_by' => $this->input->get_request_header('User-id', TRUE)
    	);
    	$this->db->where('id', $post['book_id']);
    	$this->db->update('books', $data);
    	json_output(200, array('status' => 200, 'message' => 'Book has been successfully updated.'));
    }

     /* 
     * This is the function for updating book's status
     * @param post = array();
     * @return json
    */
    public function delete_book($post){
        $data = array(
            'is_available' => 'No',
            'status' => 'Inactive',
            'updated_at' => date('Y-m-d H:i:s'),
            'updated_by' => $this->input->get_request_header('User-id', TRUE)
        );
        $this->db->where('id', $post['book_id']);
        $this->db->update('books', $data);
        json_output(200, array('status' => 200, 'message' => 'Book has been successfully deleted.'));
    }

     /* 
     * This is the function for getting list of books or specific book details
     * @param post = array();
     * @return json
    */
    public function get_book($post){
    	$add_q = '';

    	if ($post['id'] != ''){
    		$add_q = ' and id = '.$post['id'];
    	}
    	$q = $this->db->query("select id, title, author, genre, section, case when is_available = 'Yes' then 'Available' else 'Unavailable' end as is_available, status from books where status = 'Active' $add_q order by title asc");

    	if ($q->num_rows() > 0){
    		json_output(200, array('status' => 200, 'message' => 'Returned Book Data', 'book_data' => $q->result()));
    	}
    	
    }

    /* 
     * This is the function for getting list of available books
     * @return json
    */
    public function get_available_book(){
        $q = $this->db->query("select id, title, author, genre, section, case when is_available = 'Yes' then 'Available' else 'Unavailable' end as is_available, status from books where is_available = 'Yes' and status = 'Active' order by title asc");

        if ($q->num_rows() > 0){
            json_output(200, array('status' => 200, 'message' => 'Returned Book Data', 'book_data' => $q->result()));
        }
        
    }

    /* 
     * This is the function for getting list of unreturned borrowed books
     * @return json
    */
    public function get_borrowed_book(){
        $q = $this->db->query("select b.id, bb.id as borrow_id, b.title, b.author, b.genre, b.section, case when b.is_available = 'Yes' then 'Available' else 'Unavailable' end as is_available, b.status, bb.borrower, DATE_FORMAT(bb.date_added, '%d %M %Y') as date_borrowed
            from books b 
            inner join borrowed_books bb on bb.book_id = b.id
            where b.is_available = 'No' and b.status = 'Active' and bb.status = 'Pending'
            order by title asc");

        if ($q->num_rows() > 0){
            json_output(200, array('status' => 200, 'message' => 'Returned Book Data', 'book_data' => $q->result()));
        }
        
    }

    /* 
     * This is the function for getting list of borrowed books history
     * @return json
    */
    public function get_borrowed_history(){
        $q = $this->db->query("select b.id, bb.id as borrow_id, b.title, b.author, b.genre, b.section, case when b.is_available = 'Yes' then 'Available' else 'Unavailable' end as is_available, b.status, bb.borrower, DATE_FORMAT(bb.date_added, '%d %M %Y') as date_borrowed,DATE_FORMAT(bb.updated_at, '%d %M %Y') as date_returned
            from books b 
            inner join borrowed_books bb on bb.book_id = b.id
            where bb.status = 'Returned'
            order by title asc");

        if ($q->num_rows() > 0){
            json_output(200, array('status' => 200, 'message' => 'Returned Book Data', 'book_data' => $q->result()));
        }
        
    }

    /* 
     * This is the function for getting data for the dashboard
     * @return json
    */
    public function get_dashboard(){
        $q = $this->db->query("select count(id) cnt,1 from books where status = 'Active' union all
                               select count(id) cnt,2 from borrowed_books union all
                               select count(id) cnt,3 from borrowed_books where status = 'Returned'");

        if ($q->num_rows() > 0){
            json_output(200, array('status' => 200, 'message' => 'Returned Dashboard', 'dashboard' => $q->result()));
        }
        
    }

    /* 
     * This is the function for tagging book as borrowed
     * @param post = array()
     * @return json
    */
    public function borrow_book($post){
        $data = array(
            'book_id' => $post['book_id'],
            'borrower' => $post['borrower'],
            'status' => 'Pending',
            'date_added' => date('Y-m-d H:i:s'),
            'added_by' => $this->input->get_request_header('User-id', TRUE)
        );

        $this->db->insert('borrowed_books', $data);

        $this->db->query("update books set is_available = 'No' where id = ?", $post['book_id']);

        json_output(200, array('status' => 200, 'message' => 'Book has been successfully borrowed.'));
    }

    /* 
     * This is the function for tagging book as returned
     * @param post = array()
     * @return json
    */
    public function return_book($post){
        $data = array(
            'status' => 'Returned',
            'updated_at' => date('Y-m-d H:i:s'),
            'updated_by' => $this->input->get_request_header('User-id', TRUE)
        );
        $this->db->where('id', $post['borrow_id']);
        $this->db->update('borrowed_books', $data);

        $this->db->query("update books set is_available = 'Yes' where id = ?", $post['book_id']);

        json_output(200, array('status' => 200, 'message' => 'Book has been successfully returned.'));
    }
}