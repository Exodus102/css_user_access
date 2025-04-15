<?php
$servername = "sql308.infinityfree.com";
$username = "if0_38730001";
$password = "0JF2uHbJGhYwhbX";
$dbname = "if0_38730001_db_css";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
