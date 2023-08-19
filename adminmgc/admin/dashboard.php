<?php
include '../config.php';

$neworder = mysqli_query($conn,"SELECT * FROM orders");
$neworder = mysqli_num_rows($neworder);
$orders = mysqli_query($conn,"SELECT * FROM checkout WHERE status_pengiriman='dikirim' or status_pengiriman='dalam perjalanan' or status_pengiriman='diterima'");
$orders = mysqli_num_rows($orders);
$orders_dibatalkan = mysqli_query($conn,"SELECT * FROM checkout WHERE status_pengiriman='dibatalkan'");
$orders_dibatalkan = mysqli_num_rows($orders_dibatalkan);
$user = mysqli_query($conn,"SELECT * FROM users where role='user'");
$user = mysqli_num_rows($user); 
?>
<?php
include ('../config.php');
$conn=mysqli_query($conn," SELECT * FROM checkout where status_pengiriman != 'dibatalkan'");
while($h=mysqli_fetch_array($conn)){
?>
<p hidden>  
<?="Rp".number_format($total[] =$h['payment'],0,",",".");?>
<?="Rp".number_format($h['payment'],0,",","."); ?>
</p>

      <?php
      }
      $sum = array_sum($total);
      ?>
 <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Dashboard</h1>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Dashboard </li>
            </ol>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <!-- Small boxes (Stat box) -->
        <div class="row">
          <div class="col-lg-3 col-6">
            <!-- small box -->
            <div class="small-box bg-info">
              <div class="inner">
                <h3><?= $neworder; ?></h3>

                <p>New Orders</p>
              </div>
              <div class="icon">
                <i class="ion ion-bag"></i>
              </div>
              <!--<a href="#" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>-->
            </div>
          </div>
          <!-- ./col -->
          <div class="col-lg-3 col-6">
            <!-- small box -->
            <div class="small-box bg-success">
              <div class="inner">
                <h3><?= $orders; ?></h3>

                <p>Order Totals </p>
              </div>
              <div class="icon">
                <i class="ion ion-stats-bars"></i>
              </div>
              <!--<a href="#" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>-->
            </div>
          </div>
          <!-- ./col -->
          <div class="col-lg-3 col-6">
            <!-- small box -->
            <div class="small-box bg-secondary">
              <div class="inner">
                <h3><?= $orders_dibatalkan; ?></h3>

                <p>Cancel Order Totals </p>
              </div>
              <div class="icon">
                <i class="ion ion-stats-bars"></i>
              </div>
              <!--<a href="#" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>-->
            </div>
          </div>
          <!-- ./col -->
          <div class="col-lg-3 col-6">
            <!-- small box -->
            <div class="small-box bg-warning">
              <div class="inner">
                <h3><?= $user; ?></h3>

                <p>User Registrations</p>
              </div>
              <div class="icon">
                <i class="ion ion-person-add"></i>
              </div>
              <!--<a href="#" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>-->
            </div>
          </div>
          <!-- ./col -->
          <div class="col-lg-3 col-6">
            <!-- small box -->
            <div class="small-box bg-danger">
              <div class="inner">
                <h3><?php echo "Rp".number_format($sum,0,",",".");?></h3>

                <p>Income </p>
              </div>
              <div class="icon">
                <i class="ion ion-pie-graph"></i>
              </div>
              <!--<a href="#" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>-->
            </div>
          </div>
          <!-- ./col -->
        </div>
        <!-- /.row -->

      </div><!-- /.container-fluid -->
    </section>
    <!-- /.content -->
  </div>