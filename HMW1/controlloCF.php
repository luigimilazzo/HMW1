<?php 
    /*******************************************************
        Controlla che il codice fiscale sia unico
    ********************************************************/
    require_once 'configurazionedb.php';
    
    if (!isset($_GET["q"])) {
        echo "Non dovresti essere qui";
        exit;
    }

    header('Content-Type: application/json');
    $connessione = mysqli_connect($configurazionedb['host'], $configurazionedb['user'], $configurazionedb['password'], $configurazionedb['name']);
    $cod = mysqli_real_escape_string($connessione, $_GET["q"]);
    $query = "SELECT CF FROM impiegato WHERE CF = '$cod'";
    $result = mysqli_query($connessione, $query) or die(mysqli_error($connessione));
    echo json_encode(array('exists' => mysqli_num_rows($result) > 0 ? true : false));
    mysqli_close($connessione);
?>