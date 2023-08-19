
<?php 
	session_start();
	if (!empty($_SESSION['user_id'])){
	$session_id_usr=$_SESSION['user_id'];
	$session_email=$_SESSION['email'];
	$session_nama=$_SESSION['nama'];
	$session_telp=$_SESSION['telp'];
	$session_alamat=$_SESSION['alamat'];	
	}
	else{
		header ("Location:../user/index.php");
	}
