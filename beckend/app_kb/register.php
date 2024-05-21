<?php
// Konfigurasi koneksi ke database
$host = 'localhost'; // Host database
$dbname = 'app_kb'; // Nama database
$username = 'root'; // Nama pengguna database
$password = ''; // Kata sandi database

// Membuat koneksi ke database menggunakan PDO
try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    // Menangani kesalahan koneksi
    die("Koneksi database gagal: " . $e->getMessage());
}

header('Content-Type: application/json');

// Mengecek apakah request menggunakan metode POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Mengambil data dari request body
    $data = json_decode(file_get_contents('php://input'), true);

    // Validasi input
    if (empty($data['name']) || empty($data['email']) || empty($data['password']) || empty($data['birth_date']) || empty($data['address']) || empty($data['phone_number'])) {
        echo json_encode(['status' => 'error', 'message' => 'All fields are required']);
        exit;
    }

    // Sanitasi input
    $name = htmlspecialchars($data['name']);
    $email = htmlspecialchars($data['email']);
    $password = htmlspecialchars($data['password']); // Hash password untuk keamanan
    $birth_date = htmlspecialchars($data['birth_date']);
    $address = htmlspecialchars($data['address']);
    $phone_number = htmlspecialchars($data['phone_number']);

    // Menyimpan data ke database
    try {
        $stmt = $pdo->prepare("INSERT INTO users (name, email, password, birth_date, address, phone_number) VALUES (:name, :email, :password, :birth_date, :address, :phone_number)");
        $stmt->bindParam(':name', $name);
        $stmt->bindParam(':email', $email);
        $stmt->bindParam(':password', $password);
        $stmt->bindParam(':birth_date', $birth_date);
        $stmt->bindParam(':address', $address);
        $stmt->bindParam(':phone_number', $phone_number);

        if ($stmt->execute()) {
            echo json_encode(['status' => 'success', 'message' => 'User registered successfully']);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Failed to register user']);
        }
    } catch (PDOException $e) {
        echo json_encode(['status' => 'error', 'message' => 'Database error: ' . $e->getMessage()]);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid request method']);
}
?>
