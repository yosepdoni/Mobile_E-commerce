<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Edit Product</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="index.php?p=dashboard">Home</a></li>
              <li class="breadcrumb-item active">Edit Product</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdn.datatables.net/1.11.4/js/jquery.dataTables.min.js"></script>

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-12">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">Edit Product</h3>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                <div class="box box-info">
            <!-- /.box-header -->

           <div class="box-body">                    
       <?php
                  
                  include "../../config.php";
                  $d =$_GET['product_id'];
                  $data = mysqli_query($conn, "select * from products where product_id='$d'");
                  while($da = mysqli_fetch_array($data)){
                ?>
        <form class="form-horizontal" method="POST" action="product/actioneditimage.php" enctype="multipart/form-data">
            <div class="box-body">
              
                        <input type="hidden" class="form-control" name="product_id" value="<?=$da['product_id']; ?>">
        
                <div class="form-group">
                    <div class="input-group mb-3">
                    <label class="input-group-text" for="inputimage">Upload</label>
                    <input type="file" value="" name="gambar" class="form-control" id="inputimage" >
                    </div> 
                </div>
        
            </div>
            <!-- /.box-body -->
            
            <div class="box-footer">
            <button type="submit" name="simpan" class="btn btn-info float-right"><i class="fa fa-save"> UPDATE</i></button>
            
            </div>
            <!-- /.box-footer -->
        </form>
        <?php 
  }
  ?>
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
  </div>
