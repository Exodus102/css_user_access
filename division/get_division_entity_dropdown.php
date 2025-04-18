<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");
header('Access-Control-Allow-Headers: Content-Type');

require '../index.php';

$sql = "SELECT division FROM tbl_division";
$result = $conn->query($sql);

$divisions = [];
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $divisions[] = $row['division'];
    }
}

echo json_encode($divisions);

$conn->close();
