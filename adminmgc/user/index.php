<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://getbootstrap.com/docs/5.2/assets/css/docs.css" rel="stylesheet">
    <title>Magicomputer</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>
<body>
<div class="container">
	<center><img src="https://img.icons8.com/ios-filled/2x/user-male-circle.png" alt=""></center>
	<h4 class="text-center">Login MagiComputer</h4>
		<form action="c_login.php" method="POST">
		<div class="mb-3">
			<label for="email" class="form-label">Email address</label>
			<input type="email" name="email" class="form-control" id="email" aria-describedby="emailHelp">
			<div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>
		</div>
		<div class="mb-3">
			<label for="exampleInputPassword1" class="form-label">Password</label>
			<input type="password" name="password" class="form-control" id="pwd">
		</div>
		<div class="mb-3 form-check">
			<input type="checkbox" class="form-check-input" id="chk">
			<label class="form-check-label" id="lbl" for="chk">Show Password</label>
		</div>
    <div class="mb-3">
    <button type="submit" class="btn btn-primary"><i class="fa fa-sign-in-alt"> Login</i></button>
    </div>
    <!--<div class="mb-3">-->
    <!--  <a href="" onclick="new.window.open('Lupa password')" style="text-decoration:none; color:blue;"><i>Forget your password?</i></a><br>-->
    <!--  Don't have an account?<a href="route.php?p=register" style="text-decoration:none; color:blue;"> <i>Sign Up</i></a>-->
    <!--</div>-->
		</form>
	</div>
</body>
</html>


  
<script type="text/javascript">
	var lihat = document.getElementById('pwd'),
	cek = document.getElementById('chk'),
	label =document.getElementById('lbl');

		cek.onclick =function (){
			if (cek.checked){
				lihat.setAttribute('type','text');
				label.lbl='Hide Password';
			}else{
				lihat.setAttribute('type','password');
				label.lbl='Show Password';
			}
		}
</script>
