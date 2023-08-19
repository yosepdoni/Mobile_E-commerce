<?php
require '../config.php';

class CartAPI
{
    private $db;

    public function __construct($db)
    {
        $this->db = $db;
    }

    public function deleteCart($cart_id)
    {
        $query = "DELETE FROM cart WHERE cart_id = :cart_id";
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(":cart_id", $cart_id);
        $stmt->execute();
        return true;
    }
}

// Menggunakan koneksi database yang sudah ada
$database = new Database();
$db = $database->dbConnection();

// Membuat instance API Cart
$cartAPI = new CartAPI($db);

// Mendapatkan cart_id dari parameter URL
$cart_id = isset($_GET['cart_id']) ? $_GET['cart_id'] : null;

// Menghapus cart berdasarkan cart_id
if ($cart_id) {
    $result = $cartAPI->deleteCart($cart_id);
    if ($result) {
        $response = array(
            'success' => true,
            'message' => 'Cart deleted successfully.'
        );
    } else {
        $response = array(
            'success' => false,
            'message' => 'Failed to delete cart.'
        );
    }
} else {
    $response = array(
        'success' => false,
        'message' => 'Invalid cart_id parameter.'
    );
}

// Menampilkan hasil dalam format JSON
header('Content-Type: application/json');
echo json_encode($response);
?>
