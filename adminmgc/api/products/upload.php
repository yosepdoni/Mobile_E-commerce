<?php
$targetDir = "../../assets/image/"; // Ensure the path ends with a trailing slash
$allowedExtensions = ['jpg', 'jpeg', 'png']; // Allowed image extensions

header('Content-Type: application/json');

if (isset($_FILES['file'])) {
    $file = $_FILES['file'];

    // Check if the file is an image
    $extension = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));
    if (!in_array($extension, $allowedExtensions)) {
        http_response_code(400);
        echo json_encode(['error' => 'Only JPG, JPEG, and PNG images are allowed.']);
        exit;
    }

    // Use the original file name provided by Flutter
    $fileName = $file['name'];
    $targetPath = $targetDir . $fileName;

    // Move the uploaded image to the target directory
    if (move_uploaded_file($file['tmp_name'], $targetPath)) {
        echo json_encode(['success' => true, 'message' => 'Image uploaded successfully.', 'url' => 'https://tingbers.site/assets/image/' . $fileName]);
    } else {
        http_response_code(500);
        echo json_encode(['error' => 'Failed to upload the image.']);
    }
} else {
    http_response_code(400);
    echo json_encode(['error' => 'No image file received.']);
}
?>
