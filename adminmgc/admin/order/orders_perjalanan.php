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
              <li class="breadcrumb-item active">Orders</li>
              <li class="breadcrumb-item active">Perjalanan</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

<link rel="stylesheet" href="../../assets/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
  <link rel="stylesheet" href="../../assets/plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
  <link rel="stylesheet" href="../../assets/plugins/datatables-buttons/css/buttons.bootstrap4.min.css">

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-12">
            <div class="card">
              <div class="card-header">
                
                <form action="index.php?p=gridview_perjalanan" method="POST" >
                <div class="row g-3 align-items-left">
                    <div class="">
                        <label class="col-form-label">Periode</label>
                    </div>
                    <div class="col-sm-2">
                        <input type="date" class="form-control" name="dari" required>
                    </div>
                    
                    <div class="col-sm-2">
                        <input type="date" class="form-control" name="ke" required>
                    </div>
                   
                        <button type="submit" name="pencarian" class="btn btn-primary float-right"><i class="fa fa-search"> Search</i></button>      
                </div>
            </form>
              </div>
           
              <div class="card-body">
                <div class="box box-info">
            <!-- /.box-header -->
       
           <div class="box-body">
              <div id="printableArea" class="table-responsive">
              <p>Tanggal & Waktu: <span id="tanggalwaktu"></span></p>
              <table id="example" class="table table-striped table-bordered nowrap" style="width:100%">
                 <form action="" method="GET">
                 <caption>Laporan barang dalam perjalanan</caption>
                <thead>
                  <tr>
                    <th>Id</th>
                    <th>Products</th>
                    <th>Payment</th>
                    <th>User ID</th>
                    <th>Status Pengiriman</th>
                    <th>Tanggal</th>
                    <th>Aksi</th>                    
                  </tr>
                  </thead>
        
                  <tbody>
                  <?php
                  $data = mysqli_query($conn, "SELECT * FROM checkout WHERE status_pengiriman ='dalam perjalanan' ORDER BY order_id ASC limit 50");
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
                    <td>
                      <a href="index.php?p=detailorder&order_id=<?=$d['order_id'];?>" class="btn btn-info btn-sm"><i class="fa fa-eye"></i></a>
                    </td>
                  </tr>
                    
                  <?php
                  
                    }
                  ?>
                  </tbody>
                </table>
                  </body>
                <script>
                    $(document).ready(function() {
                        var table = $('#example').DataTable( {
                            responsive: true
                        } );
                    
                        new $.fn.dataTable.FixedHeader( table );
                    } );
                </script>
                <script>
                  var dt = new Date();
                  document.getElementById("tanggalwaktu").innerHTML = dt.toLocaleString();
                </script>
                </form>
               

                </div>
              <!-- /.card-body -->
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
    <!-- /.content -->
  
       