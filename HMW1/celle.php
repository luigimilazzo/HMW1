<?php
  session_start();
?>


<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" href="celle.css">
    <script src="celle.js" defer="true"></script>
  </head>
  <body>
          <span class='utente'><?php
            if(isset($_SESSION['prigioniUserId'])) echo $_SESSION['prigioneUsername'];
          ?>
        <a href='logout.php'>Logout</a>
        <a href='mhw1.php'>Home</a>
        <form name='invioDato' method='post' enctype="multipart/form-data" autocomplete="off">
        <div><label for='numero'>Numero per la ricerca</label></div>
        <input type='text' name='numero' id='numero'>
        <div class='bigger'>
        <div class='big'>
            <div id='cella'> Cella</div>
            <div id='dp'> N_detenuti</div>

        </div>
        </div>
    </body>