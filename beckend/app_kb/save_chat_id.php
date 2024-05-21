<?php
require 'config.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);

    if (empty($data['chat_id']) || empty($data['user_id'])) {
        echo json_encode(['status' => 'error', 'message' => 'Chat ID and user ID are required']);
        exit;
    }

    $chatId = $data['chat_id'];
    $userId = $data['user_id'];

    try {
        $stmt = $pdo->prepare("INSERT INTO chat_ids (chat_id, user_id) VALUES (:chat_id, :user_id)");
        $stmt->bindParam(':chat_id', $chatId);
        $stmt->bindParam(':user_id', $userId);

        if ($stmt->execute()) {
            echo json_encode(['status' => 'success', 'message' => 'Chat ID saved successfully']);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Failed to save chat ID']);
        }
    } catch (PDOException $e) {
        echo json_encode(['status' => 'error', 'message' => 'Database error: ' . $e->getMessage()]);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid request method']);
}
?>
