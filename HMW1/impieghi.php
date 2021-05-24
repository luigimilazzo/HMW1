<?php
    session_start();
?>

<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" href="impieghi.css">
    <script src="impieghi.js" defer="true"></script>
  </head>
    <body>
    <span>
        <?php
            if(isset($_SESSION['prigioniUserId'])) echo $_SESSION['prigioneUsername'];
          ?>
    </span>
    <a href='logout.php'> Logout </a>
    <a href='mhw1.php'>Home</a>
    <p class='intro'>Qui puoi visualizzare i tuoi impieghi (passati e presenti) </p>
    </body>
</html>