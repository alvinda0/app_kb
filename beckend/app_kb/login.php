<?php
require_once 'config.php';

// Get POST data
$email = isset($_POST['email']) ? $_POST['email'] : '';
$password = isset($_POST['password']) ? $_POST['password'] : '';

// SQL injection prevention
$email = mysqli_real_escape_string($conn, $email);
$password = mysqli_real_escape_string($conn, $password);

// Fetch user details
$sql = "SELECT * FROM users WHERE email='$email' AND password='$password'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $response = array(
        "status" => "success",
        "message" => "Login successful",
        "user_id" => $row['user_id'],
        "name" => $row['name'],
        "email" => $row['email'],
        "birth_date" => $row['birth_date'],
        "address" => $row['address'],
        "phone_number" => $row['phone_number']
    );
} else {
    $response = array("status" => "error", "message" => "Invalid email or password");
}

echo json_encode($response);

$conn->close();
?>
