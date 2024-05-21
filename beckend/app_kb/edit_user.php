<?php
include 'config.php';

// Cek apakah kunci-kunci yang diharapkan ada di array $_POST
if (
    !isset($_POST['user_id']) ||
    !isset($_POST['name']) ||
    !isset($_POST['email']) ||
    !isset($_POST['birth_date']) ||
    !isset($_POST['address']) ||
    !isset($_POST['phone_number'])
) {
    echo json_encode(['status' => 'error', 'message' => 'Invalid input']);
    exit;
}

// Mendapatkan data dari request
$user_id = $_POST['user_id'];
$name = $_POST['name'];
$email = $_POST['email'];
$birth_date = $_POST['birth_date'];
$address = $_POST['address'];
$phone_number = $_POST['phone_number'];

// Validasi input
if (empty($user_id) || empty($name) || empty($email) || empty($birth_date) || empty($address) || empty($phone_number)) {
    echo json_encode(['status' => 'error', 'message' => 'Invalid input']);
    exit;
}

// Query untuk mengupdate data
$sql = "UPDATE users SET name = ?, email = ?, birth_date = ?, address = ?, phone_number = ? WHERE user_id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("sssssi", $name, $email, $birth_date, $address, $phone_number, $user_id);

if ($stmt->execute()) {
    echo json_encode(['status' => 'success', 'message' => 'User updated successfully']);
} else {
    echo json_encode(['status' => 'error', 'message' => 'Failed to update user']);
}

$stmt->close();
$conn->close();
?>
