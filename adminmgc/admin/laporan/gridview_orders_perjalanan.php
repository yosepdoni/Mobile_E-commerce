<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Orders</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="index.php?p=dashboard">Home</a></li>
              <li class="breadcrumb-item active">GridView</li>
              <li class="breadcrumb-item active">Dalam Perjalanan</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>


    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-12">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">GridView </h3>
              </div>
           
              <div class="card-body">
                <div class="box box-info">
            <!-- /.box-header -->
       
           <div class="box-body">
              <div id="printableArea" class="table-responsive">
              <p>Tanggal & Waktu: <span id="tanggalwaktu"></span></p>
                <table id="example" class="table table-striped table-bordered nowrap" style="width:100%">
                  <form action="" method="GET">
                  <caption>Laporan barang sedang dalam perjalanan</caption>
                  <thead>
                    <tr>
                      <th>Id</th>
                      <th>Items</th>
                      <th>Payment</th>
                      <th>User ID</th>
                      <th>Status Pengiriman</th>
                      <th>Tanggal Pemesanan</th>
                    </tr>
                    </thead>
          
                    <tbody>
                    <?php
                    
                    include "../../config.php";
                    if(isset($_POST['pencarian'])){ 
                      //menangkap nilai form
                      $tanggal_awal=$_POST['dari'];
                      $tanggal_akhir=$_POST['ke'];
                    // tampilkan data yang sesuai dengan range tanggal yang dicari 
                      $data = mysqli_query($conn, "SELECT * FROM checkout WHERE tgl BETWEEN '$tanggal_awal' and '$tanggal_akhir' AND status_pengiriman ='dalam perjalanan'");
                      }else{
                          // $data = mysqli_query($conn, "select * from checkout ORDER BY order_id ASC");
                          $data = mysqli_query($conn, "select * from checkout where status_pengiriman ='dalam perjalanan' ORDER BY order_id ASC");
                      }
                          $no =1;
                          while($d = mysqli_fetch_array($data)){
                     ?>
                    <tr> 
                      <td><?php echo $no++;?></td>
                      <td><p class="card-text m-1" style="white-space: pre-wrap;"><?=substr($d['products'], 0,90); ?> ...</p></td>
                      <td><?= "Rp ".number_format($d['payment']); ?></td>
                      <td><?= $d['user_id']; ?></td>
                      <td><?= $d['status_pengiriman']; ?></td>
                      <td><?= $d['tgl']; ?></td>
                    </tr>
                      
                    <?php
                    
                      }
                    ?>
                    </tbody>
                  </table>
                <script>
                  var dt = new Date();
                  document.getElementById("tanggalwaktu").innerHTML = dt.toLocaleString();
                  function printDiv(divName) {
                  var printContents = document.getElementById(divName).innerHTML;
                  var originalContents = document.body.innerHTML;

                  document.body.innerHTML = printContents;

                  window.print();

                  document.body.innerHTML = originalContents;
              }
                </script>
                </form>
             

              </div>
              <!-- /.card-body -->
              <button onclick="printDiv('printableArea')" class="btn btn-success float-right"><i class="fa fa-print"> Print</i></button>
            </div>
            <!-- /.card -->
            
            <!-- /.card -->
          </div>
          <!-- /.col -->
        </div>
        <!-- /.row -->
      </div>
      <!-- /.container-fluid -->
    </section>