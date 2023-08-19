<?php
    include '../koneksi.php';
    if(isset($_POST['checkout'])){
    // HAPUS SELURUH ISI DALAM TABLE TRANSAKSIVIEW
    $sql=mysqli_query($conn, "DELETE FROM orderantampung");
                
    }
?>