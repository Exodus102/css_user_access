<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");
header('Access-Control-Allow-Headers: Content-Type');

require '../index.php';

// Get campus and year from the GET request
$campus = isset($_GET['campus']) ? $conn->real_escape_string($_GET['campus']) : '';
$year = isset($_GET['year']) ? $conn->real_escape_string($_GET['year']) : '';

// Fetch unique offices based on campus and year filter
$sql = "
    SELECT DISTINCT o.office
    FROM tbl_responses r
    JOIN tbl_office o ON o.office = r.response
    WHERE r.analysis = 'neutral'
    AND o.campus LIKE '%$campus%'
    AND YEAR(r.timestamp) = '$year'";

$result = $conn->query($sql);

$negative_offices = [];

if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $negative_offices[] = [
            'office' => $row['office'],
            'Actions' => 'View',
            'Status' => 'Unresolved'
        ];
    }
}

$conn->close();

echo json_encode($negative_offices);
