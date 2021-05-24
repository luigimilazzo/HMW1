<?php
require_once 'autenticazione.php';

    // Se la sessione è scaduta, esco
    if (!checkAuth()) exit;
    
    // Imposto l'header della risposta
    header('Content-Type: application/json');
    $connessione = mysqli_connect($configurazionedb['host'], $configurazionedb['user'], $configurazionedb['password'], $configurazionedb['name']);
    $use=mysqli_real_escape_string($connessione,$_GET['q']);
    $idP=$_GET['IDp'];
    $query= "SELECT testo,username,Nome_penitenziario from commenti join carcere on carcere=ID_penitenziario where username='$use' and carcere=$idP";
    $result = mysqli_query($connessione, $query) or die(mysqli_error($connessione));
    $array=array();
    while($row=mysqli_fetch_assoc($result)){
        $array[]=$row;    
    }
    echo json_encode($array);
    mysqli_close($connessione);
?>