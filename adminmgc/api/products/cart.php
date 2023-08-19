<?php
require '../config.php';

class CartAPI
{
    private $db;

    public function __construct($db)
    {
        $this->db = $db;
    }

    public function getCart($cart_id)
    {
        $query = "SELECT * FROM cart WHERE cart_id = :cart_id";
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(":cart_id", $cart_id);
        $stmt->execute();
        $cart = $stmt->fetch(PDO::FETCH_ASSOC);
        return $cart;
    }

    public function addCart($user_id, $product_id, $product, $category, $qty, $price, $total)
    {
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
        $stmt->execute();
        $cart_id = $this->db->lastInsertId();
        return $cart_id;
    }

    public function updateCart($cart_id, $qty)
    {
        $query = "UPDATE cart SET qty = :qty WHERE cart_id = :cart_id";
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(":qty", $qty);
        $stmt->bindParam(":cart_id", $cart_id);
        $stmt->execute();
        return true;
    }

    public function deleteCart($cart_id)
    {
        $query = "DELETE FROM cart WHERE cart_id = :cart_id";
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(":cart_id", $cart_id);
        $stmt->execute();
        return true;
    }

    public function getCartsByUserId($user_id)
    {
        $query = "SELECT * FROM cart WHERE user_id = :user_id";
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(":user_id", $user_id);
        $stmt->execute();
        $carts = $stmt->fetchAll(PDO::FETCH_ASSOC);
        return $carts;
    }
}

// Menggunakan koneksi database yang sudah ada
$database = new Database();
$db = $database->dbConnection();

// Membuat instance API Cart
$cartAPI = new CartAPI($db);

// Mendapatkan user_id dari parameter URL
$user_id = isset($_GET['user_id']) ? $_GET['user_id'] : null;

// Mendapatkan semua cart berdasarkan user_id
if ($user_id) {
    $carts = $cartAPI->getCartsByUserId($user_id);
    $response = array(
        'success' => true,
        'message' => 'Data carts retrieved successfully.',
        'data' => $carts
    );
} else {
    $response = array(
        'success' => false,
        'message' => 'Invalid user_id parameter.'
    );
}

// Menampilkan hasil dalam format JSON
header('Content-Type: application/json');
echo json_encode($response);
