<?php 
include '../../config.php';

if(isset($_POST['simpan']))
    {
        $id=$_POST['product_id'];   
        $i=$_FILES['gambar']['name'];
        $target_dir = "../../assets/image/";
        $target_file = $target_dir . basename($_FILES["gambar"]["name"]);
        $FileType = strtolower(pathinfo($target_file,PATHINFO_EXTENSION));
        
        
        if (move_uploaded_file($_FILES["gambar"]["tmp_name"], $target_file)) 
        {
            $sql="Update `products` set img='$i' where product_id='".$id."'";
            if(mysqli_query($conn,$sql))
            {
            echo "<script>alert('Gambar berhasil diupdate');window.location.href='../index.php?p=products'</script>";
            
            }
            else 
            {
                echo 'not updated';
            }
        }
    }
   ?>