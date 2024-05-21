<?php
// read.php
header('Content-Type: application/json');
include 'config.php';

// Ambil user_id dari parameter GET
$user_id = isset($_GET['user_id']) ? intval($_GET['user_id']) : 0;

if ($user_id > 0) {
    // Query untuk mengambil data schedules berdasarkan user_id
    $sql = "SELECT schedule_id, user_id, schedule_date, note, note_detail FROM schedules WHERE user_id = $user_id";
    $result = $conn->query($sql);

    $schedules = array();

    if ($result->num_rows > 0) {
        // Output data setiap row
        while($row = $result->fetch_assoc()) {
            $schedules[] = $row;
        }
    }

    echo json_encode($schedules);
} else {
    echo json_encode(array("message" => "Invalid user_id"));
}

$conn->close();
?>
