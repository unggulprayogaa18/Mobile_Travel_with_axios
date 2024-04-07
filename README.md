# abdullahsidik_uts

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
sidikabdQ123@


<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

include 'mobile_koneksi.php';

// Membuat prepared statement untuk mengambil semua data dari tabel mobile_hotel
$selectStatement = $koneksi->prepare("SELECT id,namahotel,hargahotel,rating,tentanghotel,image,created_at FROM mobile_hotel");
$selectStatement->execute();

// Mengambil semua hasil sebagai array associative
$result = $selectStatement->fetchAll(PDO::FETCH_ASSOC);
// Fetch image URL based on your server directory structure
$imagePath = 'https://sidikwebsite.000webhostapp.com/uploads_mobile/' . basename($_FILES["image"]["name"]);

// Return imagePath along with other data
echo json_encode(['status' => 'success', 'data' => ['imagePath' => $imagePath, 'id' => $insertStatement->rowCount(), 'nama' => $namahotel, 'hargahotel' => $hargahotel, 'rating' => $rating, 'tentanghotel' => $tentanghotel, 'created_at' => date('Y-m-d H:i:s')]]);

?>
