<?php
    require_once 'configurazionedb.php';

    header('Content-Type: application/json');
    $connessione = mysqli_connect($configurazionedb['host'], $configurazionedb['user'], $configurazionedb['password'], $configurazionedb['name']);
    $query= 'SELECT * FROM contenuti';
    $result = mysqli_query($connessione, $query) or die(mysqli_error($connessione));
    while($row=mysqli_fetch_assoc($result)){
        $array[]=$row;    
    }
    echo json_encode($array);
    mysqli_close($connessione);
?>