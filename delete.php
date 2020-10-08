<?php
require_once('movies.php');

if(empty($_GET['id'])){
  header('Location: movies.php');
}
$id = $_GET['id'];

if($id){
  delete($id);
  header('Location: movies.php');
} else {
  header('Location: movies.php');
}

 ?>
