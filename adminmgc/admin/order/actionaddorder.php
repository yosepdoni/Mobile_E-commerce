<?php 
// koneksi database
include '../../config.php';
 
// menangkap data yang di kirim dari form
$order_id = $_POST['order_id'];
$user_id = $_POST['user_id'];
$products = $_POST['products'];
$payment = $_POST['payment'];
$bukti_pay = $_POST ['bukti_pay'];
$status_pengiriman = $_POST['status_pengiriman'];
$tgl = $_POST ['tgl'];

 
// menginput data ke database
mysqli_query($conn,"insert into checkout values('$order_id','$user_id','$products','$payment','$bukti_pay','$status_pengiriman','$tgl')");
?>  
<?php 
// koneksi database
include '../../config.php';
 
// menangkap data id yang di kirim dari url
$d =$_POST['order_id'];

// menghapus data dari database
mysqli_query($conn,"DELETE FROM orders where order_id='$d'");

echo "<script>window.location.href='../index.php?p=neworders'</script>";
 
?>