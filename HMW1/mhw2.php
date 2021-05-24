<?php
  session_start();
?>

<html>
  <head>
    <meta charset="utf-8">
    <title>Prigioni preferite</title>
    <link rel="stylesheet" href="mhw2.css">
    <script src="mhw2.js" defer="true"></script>
  </head>
  <body>
  <span><?php
            if(isset($_SESSION['prigioniUserId'])) echo $_SESSION['prigioneUsername'];
          ?>
          </span>
    <a href='logout.php'>Logout</a>
    <a href='mhw1.php'>Home</a>
    <h1 id="pr" class="hidden">Preferiti</h1>
    <div id="pre" class="hidden">
    </div>
    <div class="intro">
    <h1> Tutti i carceri </h1>
    <p>Cerca</p>
    <input type="text" id="ricerca">
    </div>
    <div id="griglia">
    </div>
</body>
  </html>