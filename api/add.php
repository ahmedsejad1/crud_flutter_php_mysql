<?php 

	include 'database.php';

	$nom = $_POST['nom'];
	$tel = $_POST['tel'];
	$email = $_POST['email'];
	$mdp = $_POST['mdp'];

	$link->query("INSERT INTO users(nom,tel,email,mdp)VALUES('".$nom."','".$tel."','".$email."','".$mdp."')");













































	// include 'database.php';

	// $fistname = $_POST['fistname'];
	// $lastname = $_POST['lastname'];
	// $phone = $_POST['phone'];
	// $address = $_POST['address'];

	// $link->query("INSERT INTO person(fistname,lastname,phone,address)VALUES('".$fistname."','".$lastname."','".$phone."','".$address."')");

