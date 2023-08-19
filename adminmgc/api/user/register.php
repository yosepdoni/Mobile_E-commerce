<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: POST");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode([
        'success' => 0,
        'message' => 'Invalid Request Method. HTTP method should be POST',
    ]);
    exit;
}

require '../config.php';
$database = new Database();
$conn = $database->dbConnection();

$data = json_decode(file_get_contents("php://input"));

if (
    !isset($data->email) ||
    !isset($data->nama) ||
    !isset($data->password) ||
    !isset($data->telp) ||
    !isset($data->alamat) ||
    !isset($data->role)
) {
    echo json_encode([
        'success' => 0,
        'message' => 'Please fill all the fields | email, nama, password, telp, alamat.',
    ]);
    exit;
} elseif (
    empty(trim($data->email)) ||
    empty(trim($data->nama)) ||
    empty(trim($data->password)) ||
    empty(trim($data->telp)) ||
    empty(trim($data->alamat)) ||
      empty(trim($data->role))
) {
    echo json_encode([
        'success' => 0,
        'message' => 'Oops! empty field detected. Please fill all the fields.',
    ]);
    exit;
}

try {
    $email = htmlspecialchars(trim($data->email));
    $nama = htmlspecialchars(trim($data->nama));
    $password = md5(htmlspecialchars(trim($data->password)));
    $telp = htmlspecialchars(trim($data->telp));
    $alamat = htmlspecialchars(trim($data->alamat));
    $role = htmlspecialchars(trim($data->role));


    $query = "INSERT INTO users (email, nama, password, telp, alamat, role) VALUES (:email, :nama, :password, :telp, :alamat, :role)";
    $stmt = $conn->prepare($query);
    $stmt->bindParam(':email', $email);
    $stmt->bindParam(':nama', $nama);
    $stmt->bindParam(':password', $password);
    $stmt->bindParam(':telp', $telp);
    $stmt->bindParam(':alamat', $alamat);
    $stmt->bindParam(':role', $role);

    if ($stmt->execute()) {
        $userId = $conn->lastInsertId();

        $response = [
            'success' => 1,
            'message' => 'User registered successfully',
            'data' => [
                'user_id' => $userId,
                'email' => $email,
                'nama' => $nama,
                'password' => '********', // Hanya menampilkan bintang sebagai placeholder untuk password
                'telp' => $telp,
                'alamat' => $alamat,
                'role'=> $role,
            ],
        ];

        echo json_encode($response);
        exit;
    } else {
        echo json_encode([
            'success' => 0,
            'message' => 'Data not inserted.',
        ]);
        exit;
    }
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        'success' => 0,
        'message' => 'Registration failed: ' . $e->getMessage(),
    ]);
    exit;
}
