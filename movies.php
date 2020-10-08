<?php
require_once("header.php");


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

function insert(){
  $connection = connection();
  $title = $_POST['title'];
  $year = $_POST['year'];
  $fname = $_POST['fname'];
  $lname = $_POST['lname'];
  $rating = $_POST['rating'];
  $price = $_POST['min'];
  $genre = $_POST['genre'];
  $oscar = $_POST['oscar'];
  $sql = "INSERT INTO the_movies(title, year, fname, lname, rating, price, genre_id, oscar_id) VALUES('".$title."', '".$year."', '".$fname."', '".$lname."', '".$rating."', '".$price."', '".$genre."', '".$oscar."')";
  if($connection->query($sql)){
    $message = "Informations are inserted";
  }else{
    echo "Error : " . $connection->error;
  }
}
function search(){
  $connection = connection();
  $sql = "SELECT * FROM genre_view;";
  $result = $connection->query($sql);
  $row = mysqli_fetch_assoc($result);
  return $result;
}
function comedy(){
  $connection = connection();
  $sql = "SELECT * FROM comedy_view;";
  $result = $connection->query($sql);
  $row = mysqli_fetch_assoc($result);
  return $result;
}
function horror(){
  $connection = connection();
  $sql = "SELECT * FROM horror_view;";
  $result = $connection->query($sql);
  $row = mysqli_fetch_assoc($result);
  return $result;
}
function action(){
  $connection = connection();
  $sql = "SELECT * FROM action_view;";
  $result = $connection->query($sql);
  $row = mysqli_fetch_assoc($result);
  return $result;
}
function scifi(){
  $connection = connection();
  $sql = "SELECT * FROM scifi_view;";
  $result = $connection->query($sql);
  $row = mysqli_fetch_assoc($result);
  return $result;
}
function mystery(){
  $connection = connection();
  $sql = "SELECT * FROM mystery_view;";
  $result = $connection->query($sql);
  $row = mysqli_fetch_assoc($result);
  return $result;
}
function romantic(){
  $connection = connection();
  $sql = "SELECT * FROM romantic_view;";
  $result = $connection->query($sql);
  $row = mysqli_fetch_assoc($result);
  return $result;
}
function o_yes_view(){
  $connection = connection();
  $sql = "SELECT * FROM o_yes_view;";
  $result = $connection->query($sql);
  $row = mysqli_fetch_assoc($result);
  return $result;
}
function o_no_view(){
  $connection = connection();
  $sql = "SELECT * FROM o_no_view;";
  $result = $connection->query($sql);
  $row = mysqli_fetch_assoc($result);
  return $result;
}
function min_max(){
  $connection = connection();
  $mn = $_POST['min'];
  $mx = $_POST['max'];
  $sql = "CALL min_max(".$mn.", ".$mx.")";
  $result = $connection->query($sql);
  $row = mysqli_fetch_assoc($result);
  return $result;
}
function full_search(){
  $connection = connection();
  $title = $_POST['title'];
  $year = $_POST['year'];
  $fname = $_POST['fname'];
  $lname = $_POST['lname'];
  $rating = $_POST['rating'];
  $price = $_POST['min'];
  $genre = $_POST['genre'];
  $oscar = $_POST['oscar'];
  $sql = "CALL full_search('".$title."', ".$year.", '".$fname."', '".$lname."', ".$rating.", ".$price.", ".$genre.", ".$oscar.")";
  $result = $connection->query($sql);
  $row = mysqli_fetch_assoc($result);
  return $result;
}
function year(){
  $connection = connection();
  $y = $_POST['year'];
  $sql = "CALL m_year(".$y.")";
  $result = $connection->query($sql);
  $row = mysqli_fetch_assoc($result);
  return $result;
}
function rating(){
  $connection = connection();
  $r = $_POST['rating'];
  $sql = "CALL m_rating(".$r.")";
  $result = $connection->query($sql);
  $row = mysqli_fetch_assoc($result);
  return $result;
}
function actor(){
  $connection = connection();
  $fname = $_POST['fname'];
  $lname = $_POST['lname'];
  $sql = "CALL m_actor('".$fname."', '".$lname."')";
  $result = $connection->query($sql);
  $row = mysqli_fetch_assoc($result);
  return $result;
}
function full_actor(){
  $connection = connection();
  $fname = $_POST['fname'];
  $lname = $_POST['lname'];
  $sql = "CALL m_full_actor('".$fname."', '".$lname."')";
  $result = $connection->query($sql);
  $row = mysqli_fetch_assoc($result);
  return $result;
}
function title(){
  $connection = connection();
  $title = $_POST['title'];
  $sql = "CALL m_title('".$title."')";
  $result = $connection->query($sql);
  $row = mysqli_fetch_assoc($result);
  return $result;
}
function delete($m_id){
  $connection = connection();
  $sql = "DELETE FROM the_movies WHERE id = '$m_id'";
  $connection->query($sql);
  return (mysqli_affected_rows($connection) == 1) ? true : false;
}



if(isset($_POST['save'])){
  insert();
}
if(isset($_POST['search'])){
  if(!empty($_POST['genre'])){
    $g = $_POST['genre'];
    if(!empty($_POST['title'])){
      $row = full_search();
    }elseif($g == 10){
      $row = comedy();
    }elseif($g == 1){
      $row = action();
    }elseif($g == 2){
      $row = horror();
    }elseif($g == 3){
      $row = scifi();
    }elseif($g == 4){
      $row = romantic();
    }elseif($g == 5){
      $row = mystery();
    }else{
      $row = comedy();
    }
  }elseif(!empty($_POST['oscar'])){
    $o = $_POST['oscar'];
    if($o == 1){
      $row = o_yes_view();
    }else{
      $row = o_no_view();
    }
  }elseif(!empty($_POST['min']) ** !empty($_POST['max'])){
    $row = min_max();
  }elseif(!empty($_POST['year'])){
    $row = year();
  }elseif(!empty($_POST['rating'])){
    $row = rating();
  }elseif(!empty($_POST['fname']) && !empty($_POST['lname'])){
    $row = full_actor();
  }elseif(!empty($_POST['fname']) || !empty($_POST['lname'])){
    $row = actor();
  }elseif(!empty($_POST['title'])){
    $row = title();
  }else{
    $row = search();
  }
}else{
  $row = array();
}

?>

<div class="bg-success text-center mrr pb-3">
  <h1 class="pt-3 pb-1" style="color:white">Movies DataBase search</h1>
</div>
<div class="container text-center">
  <form class="pt-3" action="movies.php" method="post">
    <label>Movie Title</label><br>
    <input type="text" name="title" value=""> <br> <hr>
    <label>Year of release</label> <br>
    <input type="text" name="year" value=""> <br> <hr>
    <label>Main Actor</label> <br>
    First_Name <input type="text" name="fname" value=""> <br>
    Last_Name <input type="text" name="lname" value="" class="mt-1"> <br> <hr>
    <label>Movie Rating *(1-10)</label><br>
    <input type="text" name="rating" value=""> <br> <hr>
    <label>Genre *(0 - Comedy , 1 - Action , 2 - Horror , 3 - Sci-Fi , 4 - Romantic , 5 - Mystery)</label><br>
    <input type="text" name="genre" value=""> <br> <hr>
    <label>Oscar *(0 - No / 1 - Yes)</label><br>
    <input type="text" name="oscar" value=""> <br> <hr>
    <label>Ticket Price *(din)</label> <br>
    min <input type="text" name="min" value="">
    - <input type="text" name="max" value=""> max <br> <hr>
    <button class="btn btn-outline-danger" type="submit" name="search">SEARCH</button>
    <button class="btn btn-outline-success" type="submit" name="save">SAVE</button>
  </form>
</div>
<div class="text-center bg-danger mt-3 mb-0 pb-3">
  <h1 class="pt-3 pb-3" style="color:white;">RESULTS</h1>
  <div class="container">
    <?php if(isset($_POST['search'])): ?>
      <table class="tbl">
        <thead>
          <tr>
            <th>Title</th>
            <th>Year</th>
            <th>Main Actor</th>
            <th>Genre</th>
            <th>Rating</th>
            <th>Oscar</th>
            <th>Price</th>
            <th>Action</th>
          </tr>
        </thead>
        <?php foreach($row as $res=>$value): ?>
          <tbody>
            <tr>
              <td><?php echo $value['title']; ?></td>
              <td><?php echo $value['year']; ?></td>
              <td><?php echo $value['fname']." ".$value['lname'];?></td>
              <td><?php echo $value['genre']; ?></td>
              <td><?php echo $value['rating']; ?></td>
              <td><?php echo $value['oscar']; ?></td>
              <td><?php echo $value['price']; ?></td>
              <td>
                <a href="delete.php?id=<?php echo $value['id']; ?>"><i class="fas fa-ban fa-2x"></i></a>
                <a href="update.php?id=<?php echo $value['id']; ?>"><i class="fas fa-pen-square fa-2x"></i></a>
              </td>
            </tr>
          </tbody>
        <?php endforeach; ?>
      </table>
    <?php endif; ?>
  </div>
</div>
