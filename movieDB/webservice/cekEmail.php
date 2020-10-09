<?php

require "../config/connect.php";

$response = array();


if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    # code...
    if (empty($_POST['email'])) {
        # code...
        $response['value'] = 0;
        $response['message'] = "Email Mondatary";
        echo json_encode($response);
    } else {
        # code...
        $email = $_POST['email'];

        $cekEmail = mysqli_query($con, "SELECT * FROM users WHERE email = '$email'");
        $found = mysqli_fetch_array($cekEmail);

        if (isset($found)) {
            # code...
            $response['value'] = 1;
            $response['message'] = "Email ditemukan";
            $response['namaLengkap'] = $found['namaLengkap'];
            $response['email'] = $found['email'];
            $response['phone'] = $found['phone'];
            $response['photo'] = $found['photo'];
            $response['createdDate'] = $found['createdDate'];
            echo json_encode($response);
        
        } else {
            # code...
            $response['value'] = 0;
            $response['message'] = "Email belum terdaftar";
            echo json_encode($response);
        }
        
    }
    
} 



