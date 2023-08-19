<?php 
include '../../config.php';

  if (isset($_POST['simpan'])){
	$fileName = $_FILES['gambar']['name'];

	 $sql = "insert into products (product, stok, category, descriptions, price, img) values (
		'".$_POST['product']."', 
		'".$_POST['stok']."', 
		'".$_POST['category']."', 
		'".$_POST['descriptions']."', 
		'".$_POST['price']."', 
		'$fileName')";
	 mysqli_query($conn, $sql);
	 // Simpan di Folder Gambar
	 move_uploaded_file($_FILES['gambar']['tmp_name'], "../../assets/image/".$_FILES['gambar']['name']);
	 echo "<script>alert('Data berhasil disimpan');window.location.href='../index.php?p=addproduct'</script>";
	} 
   ?>