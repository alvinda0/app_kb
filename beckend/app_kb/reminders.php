<?php
header('Content-Type: application/json');
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require_once "db.php";
session_start();

if (!isset($_SESSION['user_id'])) {
    echo json_encode(array("status" => "error", "message" => "Not logged in"));
    exit;
}

$link = getDbConnection();
$user_id = $_SESSION['user_id'];
$sql = "SELECT reminder_date, message FROM reminders WHERE user_id = $user_id";
$result = $link->query($sql);

$reminders = array();
while ($row = $result->fetch_assoc()) {
    $reminders[] = $row;
}

echo json_encode(array("status" => "success", "data" => $reminders));

$link->close();
?>
