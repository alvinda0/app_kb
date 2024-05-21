<?php
$servername = "localhost"; // Sesuaikan dengan server database Anda
$username = "root"; // Sesuaikan dengan username database Anda
$password = ""; // Sesuaikan dengan password database Anda
$dbname = "app_kb"; // Sesuaikan dengan nama database Anda

// Membuat koneksi
$conn = new mysqli($servername, $username, $password, $dbname);

// Memeriksa koneksi
if ($conn->connect_error) {
    die("Koneksi gagal: " . $conn->connect_error);
}

// Mendapatkan data dari permintaan POST dan memeriksa apakah data ada
$user_id = isset($_POST['user_id']) ? $_POST['user_id'] : null;
$schedule_date = isset($_POST['schedule_date']) ? $_POST['schedule_date'] : null;
$note = isset($_POST['note']) ? $_POST['note'] : null;
$note_detail = isset($_POST['note_detail']) ? $_POST['note_detail'] : null;

if (!$user_id || !$schedule_date || !$note || !$note_detail) {
    die("Data tidak lengkap. Harap pastikan semua data terkirim.");
}

// Menyiapkan pernyataan SQL untuk menyisipkan data
$sql = "INSERT INTO schedules (user_id, schedule_date, note, note_detail) 
        VALUES ('$user_id', '$schedule_date', '$note', '$note_detail')";

if ($conn->query($sql) === TRUE) {
    echo "Data berhasil ditambahkan.";
} else {
    echo "Gagal menambahkan data: " . $conn->error;
}

// Menutup koneksi
$conn->close();
?>
