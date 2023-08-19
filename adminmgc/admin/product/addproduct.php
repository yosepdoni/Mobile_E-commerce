<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Add Product</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="index.php?p=dashboard">Home</a></li>
              <li class="breadcrumb-item active">Add Product</li>
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
                <h3 class="card-title">Add Product</h3>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                <div class="box box-info">
            <!-- /.box-header -->

           <div class="box-body">                    
           <form class="form-horizontal" method="POST" action="product/actionaddproduct.php" enctype="multipart/form-data">
            <div class="box-body">
                
                <div class="form-group">
                    <label class="col-sm-2 control-label">Nama Produk</label>
                    <div class="input-group mb-3">
                        <input type="text" class="form-control" name="product"  autocomplete="off" onkeypress="return harusHuruf(event)" required>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">Stok</label>
                    <div class="input-group mb-3">
                        <input type="number" class="form-control" name="stok"   autocomplete="off" onkeypress="return harusHuruf(event)" required>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">Kategori</label>
                    <div class="input-group mb-3">
                        <input type="text" class="form-control" name="category"   autocomplete="off" onkeypress="return harusHuruf(event)" required>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">Deskripsi</label>
                    <div class="input-group mb-3">
                        <textarea name="descriptions" style="width: 100%;height: 150px; padding: 12px 20px;resize: none;"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">HARGA</label>
                    <div  class="input-group mb-3">
                        <input type="number" class="form-control" name="price"  autocomplete="off" onkeypress="return isNumberKey(this, event);" required>
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group mb-3">
                    <label class="input-group-text" for="inputimage">Upload</label>
                    <input type="file"  name="gambar" class="form-control" id="inputimage" >
                    </div> 
                </div>

        
            </div>
            <!-- /.box-body -->
            
            <div class="box-footer">
            <button type="submit" name="simpan" class="btn btn-info float-right"><i class="fa fa-plus"> SIMPAN</i></button>
            
            </div>
            <!-- /.box-footer -->
        </form>
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
