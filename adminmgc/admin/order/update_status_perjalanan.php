<?php 
// koneksi database
include '../../config.php';

// // menangkap data yang di kirim dari form
// $order_id = $_POST['order_id'];
// $status_pengiriman = $_POST['status_pengiriman'];

// // update data ke database
// mysqli_query($conn,"UPDATE checkout SET status_pengiriman='$status_pengiriman' WHERE order_id='$order_id'");
// echo "<script>window.location.href='../index.php?p=orders'</script>";
            
if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST["order_id"])) {
    $orderId = $_POST["order_id"];

    // Perform the update in the database
    $updateQuery = "UPDATE checkout SET status_pengiriman = 'dalam perjalanan' WHERE order_id = '$orderId'";
    mysqli_query($conn, $updateQuery);

    // Send a response back to the client (you can customize the response if needed)
    echo "Status updated successfully";
}

?>