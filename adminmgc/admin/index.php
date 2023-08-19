<?php
include '../config.php';
include '../user/sesi_login.php';
$neworder = mysqli_query($conn,"SELECT * FROM orders");
$neworder = mysqli_num_rows($neworder);
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>MGC | Dashboard</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../assets/plugins/fontawesome-free/css/all.min.css">
  
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Tempusdominus Bootstrap 4 -->
  <link rel="stylesheet" href="../assets/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
  <!-- iCheck -->
  <link rel="stylesheet" href="../assets/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- JQVMap -->
  <link rel="stylesheet" href="../assets/plugins/jqvmap/jqvmap.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../assets/dist/css/adminlte.min.css">
  <!-- overlayScrollbars -->
  <link rel="stylesheet" href="../assets/plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
  <!-- Daterange picker -->
  <link rel="stylesheet" href="../assets/plugins/daterangepicker/daterangepicker.css">
  <!-- summernote -->
  <link rel="stylesheet" href="../assets/plugins/summernote/summernote-bs4.min.css">
  <link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/sweetalert2@7.12.15/dist/sweetalert2.min.css'>  
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<!-- session -->
   
  
<div class="wrapper">

  <!-- Navbar -->
  <nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
      </li>
      <li class="nav-item d-none d-sm-inline-block">
        <a href="index.php?p=dashboard" class="nav-link">Home</a>
      </li>
    </ul>

    <!-- Right navbar links -->
    <ul class="navbar-nav ml-auto">
      <!-- Navbar Search -->

      </li>

      <!-- Messages Dropdown Menu -->
     
      <!-- Notifications Dropdown Menu -->
      
       <li class="nav-item">
        <a class="nav-link" onclick="logout()" role="button">
          <i class="fas fa-sign-out-alt"> Logout</i>
        </a>
      </li>
      
    </ul>
  </nav>
  <!-- /.navbar -->

  <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="index3.html" class="brand-link">
      <img src="../assets/dist/img/AdminLTELogo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
      <span class="brand-text font-weight-light">MagiComputer </span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
          <img src="../assets/dist/img/admin.jpg" class="img-circle elevation-2" alt="User Image">
        </div>
        <div class="info">
          <h6><a class="d-block"><?= $session_email;?> </a></h6>
        </div>
      </div>

      <!-- SidebarSearch Form -->
      <div class="form-inline">
        <div class="input-group" data-widget="sidebar-search">
          <input class="form-control form-control-sidebar" type="search" placeholder="Search" aria-label="Search">
          <div class="input-group-append">
            <button class="btn btn-sidebar">
              <i class="fas fa-search fa-fw"></i>
            </button>
          </div>
        </div>
      </div>

      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
          <li class="nav-item menu-open">
            <a href="index.php?p=dashboard" class="nav-link ">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                Dashboard
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="index.php?p=dashboard" class="nav-link">
                  <i class="far fa-circle nav-icon "></i>
                  <p>Dashboard</p>
                </a>
              </li>
            </ul>
          </li>
          <li class="nav-item menu-open">
            <a href="index.php?p=dashboard" class="nav-link ">
              <i class="nav-icon ion ion-bag"></i>
              <p>
                Products   
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="index.php?p=products" class="nav-link">
                  <i class="nav-icon fas fa-table"></i>
                  <p>Products</p>
                </a>
              </li>
            </ul>
          </li>
          <li class="nav-item menu-open">
            <a href="index.php?p=dashboard" class="nav-link ">
              <i class="nav-icon ion ion-bag"></i>
              <p>
                Orders   
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
          
             <ul class="nav nav-treeview">
                <li class="nav-item">
                <a href="index.php?p=neworders" class="nav-link">
                  <i class="far far fa-circle nav-icon"></i>
                  <p>
                    New Orders
                    <span class="badge badge-info right"><?=$neworder;?></span> 
                  </p>
                </a>
              </li>
            </ul>
            <ul class="nav nav-treeview">
                <li class="nav-item">
                <a href="index.php?p=orders_dikirim" class="nav-link">
                  <i class="far far fa-circle nav-icon"></i>
                  <p>
                     Orders Dikirim
                  </p>
                </a>
              </li>
            </ul>
            <ul class="nav nav-treeview">
                <li class="nav-item">
                <a href="index.php?p=orders_perjalanan" class="nav-link">
                  <i class="far far fa-circle nav-icon"></i>
                  <p>
                     Orders Perjalanan
                  </p>
                </a>
              </li>
            </ul>
            <ul class="nav nav-treeview">
                <li class="nav-item">
                <a href="index.php?p=orders_diterima" class="nav-link">
                  <i class="far far fa-circle nav-icon"></i>
                  <p>
                     Orders Diterima
                  </p>
                </a>
              </li>
            </ul>
            <ul class="nav nav-treeview">
                <li class="nav-item">
                <a href="index.php?p=orders_dibatalkan" class="nav-link">
                  <i class="far far fa-circle nav-icon"></i>
                  <p>
                     Orders Dibatalkan
                  </p>
                </a>
              </li>
            </ul>
          </li>


          <!--<li class="nav-header">EXAMPLES</li>-->
          <!--<li class="nav-item">-->
          <!--  <a href="#" class="nav-link">-->
          <!--    <i class="nav-icon fa fa-cog"></i>-->
          <!--    <p>-->
          <!--      ACCOUNT   -->
          <!--    </p>-->
          <!--  </a> -->
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
    <!-- Main content -->
    <section class="content">
    <?php

        error_reporting(0);

        $page = $_GET['p'];

        if($page=="dashboard"){
            include "dashboard.php";
        }
        else if($page=="products"){
            include "product/products.php";  
        }
        else if($page=="neworders"){
            include "order/neworders.php";   
        }
        else if($page=="orders_dikirim"){
            include "order/orders_dikirim.php";   
        }
        else if($page=="orders_perjalanan"){
          include "order/orders_perjalanan.php";   
        }
        else if($page=="orders_diterima"){
          include "order/orders_diterima.php";   
        }
        else if($page=="orders_dibatalkan"){
          include "order/orders_dibatalkan.php";   
        } 
        else if($page=="datatables"){
            include "order/datatables.php";   
        }
        else if($page=="detailneworder"){
            include "order/detailneworder.php";   
        }
        else if($page=="detailorder"){
          include "order/detailorder.php";   
        }
        else if($page=="detailorder_dikirim"){
          include "order/detailorder_dikirim.php";   
        }
        else if($page=="detailorder_perjalanan"){
          include "order/detailorder_perjalanan.php";   
        }
        else if($page=="detailorder_diterima"){
          include "order/detailorder_diterima.php";   
        }
        else if($page=="detailorder_dibatalkan"){
          include "order/detailorder_dibatalkan.php";   
        }
        if($page=="produk"){
            include "produk.php";
        }else if($page=="addproduct"){
            include "product/addproduct.php";
        }
        else if($page=="editproduct"){
            include "product/editproduct.php";
        }
        else if($page=="editimage"){
          include "product/editimage.php";
       }
        else if($page=="actiondelete"){
            include "product/actiondelete.php";
        }
        else if($page=="gridview_dikirim"){
          include "laporan/gridview_orders_dikirim.php";
        }
        else if($page=="gridview_perjalanan"){
          include "laporan/gridview_orders_perjalanan.php";
        }
        else if($page=="gridview_diterima"){
          include "laporan/gridview_orders_diterima.php";
        }
        else if($page=="gridview_dibatalkan"){
          include "laporan/gridview_orders_dibatalkan.php";
        }
    ?>
</section>

  <!-- /.content-wrapper -->
  <footer class="main-footer">
    <strong>Copyright &copy; 2023-2024 <a href="https://adminlte.io">MagiComputer Sintang</a>.</strong>
    All rights reserved.
    <div class="float-right d-none d-sm-inline-block">
      <b>Version</b> 3.2.0
    </div>
  </footer>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- jQuery -->
<script src="../assets/plugins/jquery/jquery.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="../assets/plugins/jquery-ui/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<!-- Bootstrap 4 -->
<script src="../assets/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- ChartJS -->
<script src="../assets/plugins/chart.js/Chart.min.js"></script>
    <!-- Sparkline -->
    <script src="../assets/plugins/sparklines/sparkline.js"></script>
    <!-- JQVMap -->
    <script src="../assets/plugins/jqvmap/jquery.vmap.min.js"></script>
    <script src="../assets/plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
    <!-- jQuery Knob Chart -->
    <script src="../assets/plugins/jquery-knob/jquery.knob.min.js"></script>
    <!-- daterangepicker -->
    <script src="../assets/plugins/moment/moment.min.js"></script>
    <script src="../assets/plugins/daterangepicker/daterangepicker.js"></script>
    <!-- Tempusdominus Bootstrap 4 -->
    <script src="../assets/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
    <!-- Summernote -->
<script src="../assets/plugins/summernote/summernote-bs4.min.js"></script>
<!-- overlayScrollbars -->
<script src="../assets/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
<!-- AdminLTE App -->
<script src="../assets/dist/js/adminlte.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../assets/dist/js/rm-banner.js"></script>
<!-- remove banner 00 web host) -->

<script type="text/javascript">
    function logout(){
        Swal.fire({
  title: 'Apa kamu Yakin Ingin Logout?',
  text: "Kamu akan dialihkan ke halaman utama!",
  icon: 'warning',
  showCancelButton: true,
  confirmButtonColor: '#3085d6',
  cancelButtonColor: '#d33',
  confirmButtonText: 'Ya, Logout!'
}).then((result) => {
  if (result.isConfirmed) {
    window.location.href = "../user/logout.php";
  }
})};
</script>
</body>
</html>
