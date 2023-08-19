<?php 
// koneksi database
include '../../config.php';
 
// menangkap data id yang di kirim dari url
$d =$_GET['product_id'];

// menghapus data dari database
mysqli_query($conn,"DELETE FROM products WHERE product_id='$d'");

//pengalihan halaman ini harus ditambah admin
echo "<script>window.location.href='../admin/index.php?p=products'</script>";
 
?>