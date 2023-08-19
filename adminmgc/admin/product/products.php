
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Data Product</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="index.php?p=dashboard">Home</a></li>
              <li class="breadcrumb-item active">Data Product</li>
            </ol>
          </div>
        </div>
      </div>
    </section>


    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-12">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">Product </h3><br>
                <a href="index.php?p=addproduct" class="btn btn-info float-right"><i class="fa fa-plus"> Add Product</i></a> 
              </div>
              
              <div class="card-body">                 
                <div class="box-body">
                  <input type="text" class="form-control col-sm-3" id="myInput" onkeyup="myFunction()" placeholder="Search for name products.." autocomplete="off">
                  <br>
                      <div class="table-responsive">   
                          <table id="myTable" class="table table-striped table-hover">
                              <tr class="header">
                                <th>Id</th>
                                <th>Gambar</th>
                                <th>Nama Barang</th>
                                <th>Stok</th>
                                <th>Kategori</th>
                                <th>Deskripsi</th>
                                <th>Harga</th>
                                <th>Aksi</th>
                              </tr>
                                
                              <?php
                       
                              $data = mysqli_query($conn, "select * from products ORDER BY product ASC");
                              $no =1;
                              while($d = mysqli_fetch_array($data)){
                              ?>

                              <tr> 
                                <td><?=$no++;?></td>
                                <td><a href="#<?=$d['img'];?>"> <img src="../assets/image/<?=$d['img'];?>" alt="gambar" width="70" height="70"> </a> </td>
                                   
                                <!-- view image -->
                                    <div class="overlay" id="<?=$d['img'];?>">
                                      <a href="#" class="close">
                                          <svg style="width:47px;height:47px" viewBox="0 0 20 30">
                                              <path fill="currentColor" d="M12,20C7.59,20 4,16.41 4,12C4,7.59 7.59,4 12,4C16.41,4 20,7.59 20,12C20,16.41 16.41,20 12,20M12,2C6.47,2 2,6.47 2,12C2,17.53 6.47,22 12,22C17.53,22 22,17.53 22,12C22,6.47 17.53,2 12,2M14.59,8L12,10.59L9.41,8L8,9.41L10.59,12L8,14.59L9.41,16L12,13.41L14.59,16L16,14.59L13.41,12L16,9.41L14.59,8Z" />
                                          </svg>
                                      </a>
                                      <img src="../assets/image/<?=$d['img'];?>" alt="gambar" width="300" height="600">
                                      <a href="index.php?p=editimage&product_id=<?=$d['product_id'];?>" class="update"><i class="fa fa-edit"> Update Image</i></a>
                                    </div>
                                    <!-- end view image -->
                                    
                                <td><p class="card-text m-1" style="white-space: pre-wrap;"><?=substr($d['product'], 0,20); ?> ..</p></td>
                                <td><?=$d['stok']; ?></td>
                                <td><?=$d['category']; ?></td>
                                <td><p class="card-text m-1" style="white-space: pre-wrap;"><?=substr($d['descriptions'], 0,25); ?> ..</p></td>
                                <td><?="Rp ".number_format($d['price']); ?></td>
                                <td>
                                <a href="index.php?p=editproduct&product_id=<?=$d['product_id'];?>" class="btn btn-info btn-sm"><i class="fa fa-edit"></i></a>&nbsp;
                                <a onclick="return confirm('apakah anda yakin? ');" href="index.php?p=actiondelete&product_id=<?=$d['product_id'] ?>" class="btn btn-danger btn-sm"><i class= "fa fa-trash">&nbsp;</i></a>
                                </td>
                              </tr>
                                
                              <?php
                                }
                              ?>
                            </table>
                           
                    </div>
                     <!-- /.card-body -->
                  </div>
               </div>      
            </div>
            <!-- /.card -->
          </div>
          <!-- /.col -->
        </div>
        <!-- /.row -->
      </div>
    </section>
    <!-- /.content -->
  </div>
  <script>
  function myFunction() {
    var input, filter, table, tr, td, i, txtValue;
    input = document.getElementById("myInput");
    filter = input.value.toUpperCase();
    table = document.getElementById("myTable");
    tr = table.getElementsByTagName("tr");
    for (i = 0; i < tr.length; i++) {
      td = tr[i].getElementsByTagName("td")[2];
      if (td) {
        txtValue = td.textContent || td.innerText;
        if (txtValue.toUpperCase().indexOf(filter) > -1) {
          tr[i].style.display = "";
        } else {
          tr[i].style.display = "none";
        }
      }       
    }
  }
  </script>
  <style>
    .mainwrapper {
    background: #fefefe;
    display: flex;
    width: 100%;
    height: 650px;
    justify-content: center;
    align-items: center;
}
.update {
    margin-left: -15%;
    margin-top:30%;
    color: white;
    right: 90%;
}

.overlay {
    width: 0;
    height: 0;
    overflow: hidden;
    position: fixed;
    top: 0;
    left: 0;
    background: rgba(0, 0, 0, 0);
    z-index: 9999;
    transition: .8s;
    text-align: center;
    padding: 150px 0;
}

.overlay:target {
    width: auto;
    height: auto;
    bottom: 0;
    right: 0;
    background: rgba(0, 0, 0, .7);
}

.overlay img {
    max-height: 100%;
    box-shadow: 2px 2px 7px rgba(0, 0, 0, .5);
}

.overlay:target img {
    animation: zoomDanFade 1s;
}

.overlay .close {
    position: absolute;
    top: 15%;
    right: 2%;
    margin-left: -20px;
    color: white;
    text-decoration: none;
    line-height: 14px;
    padding: 5px;
    opacity: 0;
}

.overlay:target .close {
    animation: slideDownFade .5s .5s forwards;
}

/* animasi */
@keyframes zoomDanFade {
    0% {
        transform: scale(0);
        opacity: 0;
    }

    100% {
        transform: scale(1);
        opacity: 1;
    }
}

@keyframes slideDownFade {
    0% {
        opacity: 0;
        margin-top: -20px;
    }

    100% {
        opacity: 1;
        margin-top: 0;
    }
}
  </style>