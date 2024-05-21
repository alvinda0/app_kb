<?php
header('Content-Type: application/json');
session_start();

if (isset($_SESSION['user_id'])) {
    // Lakukan operasi dashboard karena pengguna sudah login
    $response = array(
        "status" => "success",
        "data" => array(
            "user_id" => $_SESSION['user_id'],
            "name" => $_SESSION['name']
        )
    );
} else {
    // Jika sesi pengguna tidak ditemukan
    $response = array(
        "status" => "error",
        "message" => "User not logged in"
    );
}

echo json_encode($response); // pastikan respons diencode ke JSON dengan benar
?>
