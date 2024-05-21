<?php
// Include your database connection code here
// For example:
$conn = new mysqli('localhost', 'root', '', 'app_kb');

// Check if user exists in the database
function checkChatIdExists($userId) {
    global $conn;

    $sql = "SELECT COUNT(*) AS count FROM users WHERE chat_id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $userId);
    $stmt->execute();
    $result = $stmt->get_result();
    $row = $result->fetch_assoc();
    $count = $row['count'];

    return $count > 0;
}

// Main code
$data = json_decode(file_get_contents('php://input'), true);

if (isset($data['user_id'])) {
    $userId = $data['user_id'];

    $response = array();

    // Check if chat ID exists for the user
    $chatIdExists = checkChatIdExists($userId);

    $response['chat_id_exists'] = $chatIdExists;

    header('Content-Type: application/json');
    echo json_encode($response);
} else {
    header("HTTP/1.1 400 Bad Request");
    echo json_encode(array("message" => "Missing user_id parameter"));
}
?>
