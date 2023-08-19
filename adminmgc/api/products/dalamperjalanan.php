<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Credentials: true");
header("Content-Type: application/json; charset=UTF-8");

require '../config.php';
$database = new Database();
$conn = $database->dbConnection();

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if (isset($_GET['user_id'])) {
        $user_id = filter_var($_GET['user_id'], FILTER_VALIDATE_INT, [
            'options' => [
                'min_range' => 1
            ]
        ]);

        // Get checkout data based on user_id and status_pengiriman "Dikirim"
        $stmt = $conn->prepare("SELECT * FROM checkout WHERE user_id = :user_id AND status_pengiriman = 'dalam perjalanan'");
        $stmt->bindValue(':user_id', $user_id, PDO::PARAM_INT);
        $stmt->execute();
        $checkoutData = $stmt->fetchAll(PDO::FETCH_ASSOC);

        if ($stmt->rowCount() > 0) {
            echo json_encode([
                'success' => true,
                'data' => $checkoutData,
            ]);
        } else {
            echo json_encode([
                'success' => false,
                'message' => 'No Checkout Data Found for the given user_id and status_pengiriman "dalam perjalanan"!',
            ]);
        }
    } else {
        echo json_encode([
            'success' => false,
            'message' => 'Missing user_id parameter!',
        ]);
    }
    exit;
}

// Add other API methods (e.g., POST, PUT, DELETE) for creating, updating, and deleting checkout data if required.
// ...

// Return 405 Method Not Allowed for invalid request methods
http_response_code(405);
echo json_encode([
    'success' => false,
    'message' => 'Invalid Request Method. HTTP method should be GET.',
]);
exit;
