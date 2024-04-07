<?php
$servername = "localhost";
$username = "if0_35796373";
$password = "sIVrKqV6cWXCvR";
$database = "if0_35796373_dbapi";

try {
    $koneksi = new PDO("mysql:host=$servername;dbname=$database", $username, $password);
    $koneksi->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    die("Koneksi succes: " . $e->getMessage());
} catch (PDOException $e) {
    
    die("Koneksi gagal: " . $e->getMessage());
}
?>
