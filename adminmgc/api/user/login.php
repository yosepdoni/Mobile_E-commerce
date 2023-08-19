<?php
require '../config.php';

class UserAPI
{
    private $db;

    public function __construct()
    {
        $database = new Database();
        $this->db = $database->dbConnection();
    }

    public function getUsersByEmailAndPassword($email, $password)
    {
        try {
            $hashedPassword = md5($password);

            $stmt = $this->db->prepare("SELECT * FROM users WHERE email = :email AND password = :password");
            $stmt->bindParam(':email', $email);
            $stmt->bindParam(':password', $hashedPassword);
            $stmt->execute();

            if ($stmt->rowCount() > 0) {
                $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
                return array(
                    "success" => true,
                    "data" => $data
                );
            } else {
                return array(
                    "success" => false,
                    "message" => "Invalid email or password"
                );
            }
        } catch (PDOException $e) {
            return array(
                "success" => false,
                "message" => "Error retrieving users: " . $e->getMessage()
            );
        }
    }
}

// Menggunakan API
$userAPI = new UserAPI();

// Ambil data yang dikirimkan melalui POST request
$requestBody = json_decode(file_get_contents('php://input'), true);
$email = $requestBody['email'];
$password = $requestBody['password'];

// Panggil metode getUsersByEmailAndPassword dari API
$response = $userAPI->getUsersByEmailAndPassword($email, $password);

// Mengirim respons dalam format JSON
header('Content-Type: application/json');
echo json_encode($response);
?>
