<?php
require('../index.php');

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");
header('Access-Control-Allow-Headers: Content-Type');

$year = $_POST['year'];
$quarter = $_POST['quarter'];
$name = $_POST['name'];
$campus = $_POST['campus'];
$endorse_by = isset($_POST['endorse_by']) ? $_POST['endorse_by'] : null;

$filename = "{$campus}_report_{$year}_{$quarter}.pdf";
$file_path = "../uploads/" . $filename;
$status = 'Pending';

$sql = "INSERT INTO tbl_sent_reports (year, quarter, name, campus, filename, file_path, endorse_by, status)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ssssssss", $year, $quarter, $name, $campus, $filename, $file_path, $endorse_by, $status);
$stmt->execute();
$stmt->close();

$conn->close();
