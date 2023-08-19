<?php
require '../config.php';

class CartAPI
{
    private $db;

    public function __construct($db)
    {
        $this->db = $db;
    }

    public function isProductInCart($user_id, $product_id)
    {
        $query = "SELECT COUNT(*) FROM cart WHERE user_id = :user_id AND product_id = :product_id";
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(":user_id", $user_id);
        $stmt->bindParam(":product_id", $product_id);
        $stmt->execute();
        $count = $stmt->fetchColumn();
        return $count > 0;
    }

    public function addCart($user_id, $product_id, $product, $category, $qty, $price, $total)
    {
        if ($this->isProductInCart($user_id, $product_id)) {
            return false; // Produk sudah ada dalam keranjang
        }

        $query = "INSERT INTO cart (user_id, product_id, product, category, qty, price, total) 
                  VALUES (:user_id, :product_id, :product, :category, :qty, :price, :total)";
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(":user_id", $user_id);
        $stmt->bindParam(":product_id", $product_id);
        $stmt->bindParam(":product", $product);
        $stmt->bindParam(":category", $category);
        $stmt->bindParam(":qty", $qty);
        $stmt->bindParam(":price", $price);
        $stmt->bindParam(":total", $total);

        if ($stmt->execute()) {
            $cart_id = $this->db->lastInsertId();
            return $cart_id;
        } else {
            return false;
        }
    }
}

// Menggunakan koneksi database yang sudah ada
$database = new Database();
$db = $database->dbConnection();

// Membuat instance API Cart
$cartAPI = new CartAPI($db);

// Mendapatkan data yang diperlukan dari request
$data = json_decode(file_get_contents('php://input'), true);

$user_id = isset($data['user_id']) ? $data['user_id'] : null;
$product_id = isset($data['product_id']) ? $data['product_id'] : null;
$product = isset($data['product']) ? $data['product'] : null;
$category = isset($data['category']) ? $data['category'] : null;
$qty = isset($data['qty']) ? $data['qty'] : null;
$price = isset($data['price']) ? $data['price'] : null;
$total = isset($data['total']) ? $data['total'] : null;

// Memanggil fungsi addCart()
if ($user_id && $product_id && $product && $category && $qty && $price && $total) {
    $cart_id = $cartAPI->addCart($user_id, $product_id, $product, $category, $qty, $price, $total);

    if ($cart_id) {
        $response = array(
            'success' => true,
            'message' => 'Cart added successfully.',
            'cart_id' => $cart_id
        );
    } else {
        $response = array(
            'success' => false,
            'message' => 'Failed to add cart.'
        );
    }
} else {
    $response = array(
        'success' => false,
        'message' => 'Invalid data.'
    );
}

// Menampilkan hasil dalam format JSON
header('Content-Type: application/json');
echo json_encode($response);
