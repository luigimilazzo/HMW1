<?php 
    /*******************************************************
        Controlla che l'username sia unico
    ********************************************************/
    require_once 'configurazionedb.php';
    
    if (!isset($_GET["q"])) {
        echo "Non dovresti essere qui";
        exit;
    }

    header('Content-Type: application/json');
    $connessione = mysqli_connect($configurazionedb['host'], $configurazionedb['user'], $configurazionedb['password'], $configurazionedb['name']);
    $username = mysqli_real_escape_string($connessione, $_GET["q"]);
    $query = "SELECT username FROM impiegato WHERE username = '$username'";
    $result = mysqli_query($connessione, $query) or die(mysqli_error($connessione));
    echo json_encode(array('exists' => mysqli_num_rows($result) > 0 ? true : false));
    mysqli_close($connessione);
?>