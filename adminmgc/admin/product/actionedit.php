  <?php 
// koneksi database
include '../../config.php';

// menangkap data yang di kirim dari form
$product_id = $_POST['product_id'];
$product = $_POST['product'];
$stok = $_POST['stok'];
$category = $_POST['category'];
$descriptions = $_POST['descriptions'];
$price = $_POST['price'];

// update data ke database
mysqli_query($conn,"UPDATE products SET product='$product', stok='$stok', category='$category', descriptions='$descriptions', price='$price' WHERE product_id='$product_id'");
echo "<script>window.location.href='../index.php?p=products'</script>";

?>