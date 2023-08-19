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
              <li class="breadcrumb-item active">Dikirim</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>
    <!-- <script src="https://code.jquery.com/jquery-3.5.1.js"></script> -->
<!-- <script src="https://cdn.datatables.net/1.11.4/js/jquery.dataTables.min.js"></script> -->

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
                
                <form action="index.php?p=gridview_dikirim" method="POST" >
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
            <caption>Laporan barang dikirim</caption>
            <thead>
              <tr>
                <th>Id</th>
                <th>Products</th>
                <th>Payment</th>
                <th>User ID</th>
                <th>Status</th>
                <th>Tanggal</th>
                <th>Aksi</th>  
                <th>---></th>  
              </tr>
            </thead>
            <tbody>
              <?php
                $data = mysqli_query($conn, "SELECT * FROM checkout WHERE status_pengiriman = 'dikirim'");
                $no = 1;
                while ($d = mysqli_fetch_array($data)) {
                ?>
                <?php
                  if (isset($_POST['update_status']) && $_POST['update_status'] == $d['order_id']) {
                    // Perform the database update
                    $orderId = $d['order_id'];
                    $updateQuery = "UPDATE checkout SET status_pengiriman = 'dalam perjalanan' WHERE order_id = '$orderId'";
                    $result = mysqli_query($conn, $updateQuery);
                    if ($result) {
                      $d['status_pengiriman'] = 'dalam perjalanan';
                      echo "<script>window.location.href='../admin/index.php?p=orders_dikirim'</script>";
                      exit;
                    } else {
                      echo "Gagal update status: " . $d['order_id'];
                    }
                  }
                ?>
                <tr> 
                  <td><?php echo $no++;?></td>
                  <td><p class="card-text m-10" style="white-space: pre-wrap;"><?=substr($d['products'], 0,90); ?> ...</p></td>
                  <td><?= "Rp ".number_format($d['payment']); ?></td>
                  <td><?= $d['user_id']; ?></td>
                  <td><?= $d['status_pengiriman']; ?></td>
                  <td><?= $d['tgl']; ?></td>
                  <td>
                    <a href="index.php?p=detailorder&order_id=<?=$d['order_id'];?>" class="btn btn-info btn-sm"><i class="fa fa-eye"></i></a>
                  </td>
                  <td>
                    <form method="post">
                      <input type="hidden" name="update_status" value="<?= $d['order_id']; ?>">
                      <button type="submit" class="btn btn-info btn-sm"> > </button>
                    </form>
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


