<?php 

	include 'database.php';

	$id = $_POST['id'];

	$link->query("DELETE FROM users WHERE id = '".$id."'");