<?php
session_start();
include '../config.php';
$email = $_POST['email'];
$password = md5($_POST['password']);
$login = mysqli_query($conn,"select * from users where email='$email' and password='$password' limit 1");
$cek = mysqli_num_rows($login);
 $data = mysqli_fetch_assoc($login);
if($cek > 0){
  $_SESSION['user_id'] = $data['user_id'];
  $_SESSION['email'] = $email;
  $_SESSION['password'] = $password;
  $_SESSION['nama'] = $data['nama'];
  $_SESSION['telp'] = $data['telp'];
  $_SESSION['alamat'] = $data['alamat'];
//   header("location:admin/index.php?p=dashboard");
  echo "<script>window.location.href='../admin/index.php?p=dashboard'</script>";
}else{
  echo "<script>alert('Maaf email tidak terdaftar');window.location.href='../user/index.php';</script>";
	// header("location:index.php?pesan=gagal");
 }
