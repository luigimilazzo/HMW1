<?php
  session_start();
?>


<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" href="archivio.css">
    <script src="archivio.js" defer="true"></script>
  </head>
  <body>
          <span class='utente'><?php
            if(isset($_SESSION['prigioniUserId'])) echo $_SESSION['prigioneUsername'];
          ?>
        <a href='logout.php'>Logout</a>
        <a href='mhw1.php'>Home</a>
        <form name='invioDato' method='post' enctype="multipart/form-data" autocomplete="off">
        <div><label for='let'>Lettera per la ricerca</label></div>
        <input type='text' name='lettera' id='lettera'>
        <div class='bigger'>
        <div class='big'>
            <div id='nome'> Nome</div>
            <div id='cognome'> Cognome</div>
            <div id='penitenziario'> Carcere</div>

        </div>
        </div>
    </body>