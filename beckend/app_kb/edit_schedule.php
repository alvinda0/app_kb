<?php
include 'config.php';

// Cek apakah kunci-kunci yang diharapkan ada di array $_POST
if (!isset($_POST['user_id']) || !isset($_POST['schedule_date']) || !isset($_POST['note'])) {
    echo json_encode(['status' => 'error', 'message' => 'Invalid input']);
    exit;
}

// Mendapatkan data dari request
$user_id = $_POST['user_id'];
$schedule_date = $_POST['schedule_date'];
$note = $_POST['note'];

// Validasi input
if (empty($user_id) || empty($schedule_date)) {
    echo json_encode(['status' => 'error', 'message' => 'Invalid input']);
    exit;
}

// Query untuk mengupdate data
$sql = "UPDATE schedules SET schedule_date = ?, note = ? WHERE user_id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ssi", $schedule_date, $note, $user_id);

if ($stmt->execute()) {
    echo json_encode(['status' => 'success', 'message' => 'Schedule updated successfully']);
} else {
    echo json_encode(['status' => 'error', 'message' => 'Failed to update schedule']);
}

$stmt->close();
$conn->close();
?>
