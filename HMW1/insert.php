<?php 
    require_once 'autenticazione.php';
    // Se la sessione è scaduta, esco
    if (!checkAuth()) exit;
    header('Content-Type: application/json');
    $id = $_SESSION['prigioniUserId'] ;
    $connessione = mysqli_connect($configurazionedb['host'], $configurazionedb['user'], $configurazionedb['password'], $configurazionedb['name']);
    $id = mysqli_real_escape_string($connessione, $id);
    //$carcere = mysqli_real_escape_string($connessione, $_GET['q']);
    $carcere=$_GET['q'];
    $query = "INSERT into lavoro (id_impiegato,carcere) values ($id,$carcere)";
    $result = mysqli_query($connessione, $query) or die(mysqli_error($connessione));
    echo $result;
    mysqli_close($connessione);
?>




