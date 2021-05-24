<?php
  session_start();
?>


<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" href="inserisci.css">
    <script src="inserisci.js" defer="true"></script>
  </head>
    <body>
    
    <span><?php
            if(isset($_SESSION['prigioniUserId'])) echo $_SESSION['prigioneUsername'];
          ?>
          </span>
          <a href='logout.php'> Logout </a>
          <a href='mhw1.php'>Home </a>
          <p id='intro'>Inserisci qui il carcere in cui lavori tra quelli suggeriti </p>
          <div id='padre'>
            <div id='penitenziario'> Carcere</div>
          </div>

    </body>
</html>