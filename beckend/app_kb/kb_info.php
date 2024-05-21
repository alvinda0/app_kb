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
$sql = "SELECT method_name, description, effectiveness, side_effects FROM kb_methods";
$result = $link->query($sql);

$kb_methods = array();
while ($row = $result->fetch_assoc()) {
    $kb_methods[] = $row;
}

echo json_encode(array("status" => "success", "data" => $kb_methods));

$link->close();
?>
