
<?php


require '../config.php';

class OrdersAPI
{
    private $db;

    public function __construct($db)
    {
        $this->db = $db;
    }

    public function addOrder($user_id, $products, $payment, $bukti_pay, $tgl, $status_kirim)
    {
        $query = "INSERT INTO orders (user_id, products, payment, bukti_pay, tgl, status_kirim) 
                  VALUES (:user_id, :products, :payment, :bukti_pay, :tgl, :status_kirim)";
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(":user_id", $user_id);
        $stmt->bindParam(":products", $products);
        $stmt->bindParam(":payment", $payment);
        $stmt->bindParam(":bukti_pay", $bukti_pay);
        $stmt->bindParam(":tgl", $tgl, PDO::PARAM_STR); // Specify the parameter type as string
        $stmt->bindParam(":status_kirim", $status_kirim);

        if ($stmt->execute()) {
            $order_id = $this->db->lastInsertId();
            return $order_id;
        } else {
            return false;
        }
    }
}

// Menggunakan koneksi database yang sudah ada
$database = new Database();
$db = $database->dbConnection();

// Membuat instance API Orders
$ordersAPI = new OrdersAPI($db);

// Mendapatkan data yang diperlukan dari request
$data = json_decode(file_get_contents('php://input'), true);

$user_id = isset($data['user_id']) ? $data['user_id'] : null;
$products = isset($data['products']) ? $data['products'] : null;
$payment = isset($data['payment']) ? $data['payment'] : null;
$bukti_pay = isset($data['bukti_pay']) ? $data['bukti_pay'] : null;
$tgl = isset($data['tgl']) ? date('Y-m-d', strtotime($data['tgl'])) : null; // Format the date correctly
$status_kirim = isset($data['status_kirim']) ? $data['status_kirim'] : null;


// Memanggil fungsi addOrder()
if ($user_id && $products && $payment && $bukti_pay && $tgl && $status_kirim) {
    $order_id = $ordersAPI->addOrder($user_id, $products, $payment, $bukti_pay, $tgl, $status_kirim);

    if ($order_id) {
        $response = array(
            'success' => true,
            'message' => 'Order added successfully.',
            'order_id' => $order_id
        );
    } else {
        $response = array(
            'success' => false,
            'message' => 'Failed to add order.'
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
?>
