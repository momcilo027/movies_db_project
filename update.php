<?php

 require_once('header.php');

 function connection(){
   $host = "localhost";
   $user = "root";
   $pw = "";
   $dbname = "movies";
   $message = "";
   $connection = mysqli_connect($host, $user, $pw, $dbname);
   if($connection){
     $message = "Connected";
   } else {
     die("Connection closed! ".mysqli_connect_error());
   }
   return $connection;
 }
 function update($m_id){
   $connection = connection();
   $title = $_POST['title'];
   $year = $_POST['year'];
   $fname = $_POST['fname'];
   $lname = $_POST['lname'];
   $rating = $_POST['rating'];
   $genre = $_POST['genre'];
   $oscar = $_POST['oscar'];
   $price = $_POST['min'];
   $sql = "UPDATE the_movies SET title = '".$title."', year = '".$year."', fname = '".$fname."', lname = '".$lname."', rating = '".$rating."', genre_id = '".$genre."', oscar_id = '".$oscar."', price = '".$price."' WHERE id = '".$m_id."'";
   $connection->query($sql);
   return (mysqli_affected_rows($connection) == 1) ? true : false;
 }


 if(empty($_GET['id'])){
   header('Location: movies.php');
 } else {
   $id = $_GET['id'];
   $connection = connection();
   $sql = "SELECT * FROM the_movies WHERE id = '$id'";
   $result = $connection->query($sql);
   $row = mysqli_fetch_assoc($result);
   if(isset($_POST['update'])){
     update($id);
     header('Location: movies.php');
   }
 }

  ?>

  <div class="bg-success text-center">
    <h1 class="pt-3 pb-3" style="color:white">UPDATE MOVIE INFO</h1>
  </div>
  <div class="container text-center pb-5">
    <form class="pt-3" action="" method="post">
      <label>Movie Title</label><br>
      <input type="text" name="title" value="<?php echo $row['title']; ?>"> <br> <hr>
      <label>Year of release</label> <br>
      <input type="text" name="year" value="<?php echo $row['year']; ?>"> <br> <hr>
      <label>Main Actor</label> <br>
      First_Name <input type="text" name="fname" value="<?php echo $row['fname']; ?>"> <br>
      Last_Name <input type="text" name="lname" value="<?php echo $row['lname']; ?>" class="mt-1"> <br> <hr>
      <label>Movie Rating *(1-10)</label><br>
      <input type="text" name="rating" value="<?php echo $row['rating']; ?>"> <br> <hr>
      <label>Genre *(0 - Comedy , 1 - Action , 2 - Horror , 3 - Sci-Fi , 4 - Romantic , 5 - Mystery)</label><br>
      <input type="text" name="genre" value="<?php echo $row['genre_id']; ?>"> <br> <hr>
      <label>Oscar *(0 - No / 1 - Yes)</label><br>
      <input type="text" name="oscar" value="<?php echo $row['oscar_id']; ?>"> <br> <hr>
      <label>Ticket Price *(din)</label> <br>
      min <input type="text" name="min" value="<?php echo $row['price']; ?>">
      - <input type="text" name="max" value=""> max <br> <hr>
      <button class="btn btn-outline-success" type="submit" name="update">UPDATE</button>
    </form>
  </div>
