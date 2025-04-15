<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

require '../index.php';

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$campus = $_GET['campus'];  // The campus parameter passed from the request
$office = $_GET['office'];  // The office parameter passed from the request

// Query to fetch responses with both campus and office filters
$sql = "SELECT response, COUNT(*) AS response_count 
        FROM tbl_responses 
        WHERE response LIKE '%$office%' AND response LIKE '%$campus%' 
        GROUP BY response";
$result = mysqli_query($conn, $sql);

$responses = [];

if (mysqli_num_rows($result) > 0) {
    // Fetch data if available
    while ($row = mysqli_fetch_assoc($result)) {
        // Store the office (response) and count in the array
        $responses[] = [
            'response' => $row['response'],
            'count' => (int)$row['response_count']
        ];
    }
} else {
    // If no responses found, ensure a valid empty JSON response is returned
    $responses = [];
}

// Return the response as JSON
header('Content-Type: application/json');
echo json_encode($responses);
