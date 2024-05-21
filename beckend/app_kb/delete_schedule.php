<?php
include 'config.php';

// Cek apakah kunci schedule_id ada di array $_POST
if (!isset($_POST['schedule_id'])) {
    echo json_encode(['status' => 'error', 'message' => 'Invalid input']);
    exit;
}

// Mendapatkan data dari request
$schedule_id = $_POST['schedule_id'];

// Validasi input
if (empty($schedule_id)) {
    echo json_encode(['status' => 'error', 'message' => 'Invalid input']);
    exit;
}

// Query untuk menghapus data
$sql = "DELETE FROM schedules WHERE schedule_id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $schedule_id);

if ($stmt->execute()) {
    echo json_encode(['status' => 'success', 'message' => 'Schedule deleted successfully']);
} else {
    echo json_encode(['status' => 'error', 'message' => 'Failed to delete schedule']);
}

$stmt->close();
$conn->close();
?>
