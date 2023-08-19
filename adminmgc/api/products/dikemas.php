<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Credentials: true");
header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    http_response_code(405);
    echo json_encode([
        'success' => 0,
        'message' => 'Invalid Request Method. HTTP method should be GET',
    ]);
    exit;
}

require '../config.php';
$database = new Database();
$conn = $database->dbConnection();

try {
    if (isset($_GET['user_id'])) {
        $user_id = filter_var($_GET['user_id'], FILTER_VALIDATE_INT, [
            'options' => [
                'min_range' => 1
            ]
        ]);

        // Mengambil data orders berdasarkan user_id
        $stmt = $conn->prepare("SELECT * FROM orders WHERE user_id = :user_id");
        $stmt->bindParam(':user_id', $user_id, PDO::PARAM_INT);
        $stmt->execute();
        $orders = $stmt->fetchAll(PDO::FETCH_ASSOC);
    } else {
        // Mengambil semua data orders jika user_id tidak disertakan dalam permintaan
        $stmt = $conn->query("SELECT * FROM orders");
        $orders = $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    if ($stmt->rowCount() > 0) {
        echo json_encode([
            'success' => 1,
            'data' => $orders,
        ]);
    } else {
        echo json_encode([
            'success' => 0,
            'message' => 'No Orders Found!',
        ]);
    }
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        'success' => 0,
        'message' => $e->getMessage()
    ]);
    exit;
}
