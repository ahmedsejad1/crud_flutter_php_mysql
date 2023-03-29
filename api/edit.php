<?php 

	include 'database.php';

	$id = $_POST['id'];
	$nom = $_POST['nom'];
	$tel = $_POST['tel'];
	$email = $_POST['email'];
	$mdp = $_POST['mdp'];

	$link->query("UPDATE users SET nom = '".$nom."',tel = '".$tel."',email = '".$email."',mdp = '".$mdp."' WHERE id = '".$id."'");


?>