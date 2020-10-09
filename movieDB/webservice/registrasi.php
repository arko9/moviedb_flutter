<?php

require "../config/connect.php";

$response = array();


if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    
        # code...
        $email = $_POST['email'];
        $namaLengkap = $_POST['namaLengkap'];
        $phone = $_POST['phone'];
        $photo = $_POST['photo'];

        $cekEmail = mysqli_query($con, "SELECT * FROM users WHERE email = '$email'");
        $found = mysqli_fetch_array($cekEmail);

        if (isset($found)) {
            # code...
            $response['value'] = 0;
            $response['message'] = "Email sudah terdaftar";
            echo json_encode($response);
        
        } else {
            # code...
            $insert = "INSERT INTO users VALUE (NULL,'$email','$namaLengkap','$phone','$photo',NOW(),'1','1')";
            if (mysqli_query($con, $insert)) {
                # code...
                $response['value'] = 1;
                $response['message'] = "Berhasil";
                $response['namaLengkap'] = $namaLengkap;
                $response['email'] = $email;
                $response['phone'] = $phone;
                $response['photo'] = $photo;
                $response['createdDate'] = date("Y-m-d H:i:s");
                echo json_encode($response);
            }
            
        }
        
    }
    


