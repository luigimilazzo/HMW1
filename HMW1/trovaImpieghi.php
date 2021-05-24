<?php
require_once 'autenticazione.php';

    // Se la sessione è scaduta, esco
    if (!checkAuth()) exit;
    
    // Imposto l'header della risposta
    header('Content-Type: application/json');
    $id = $_SESSION['prigioniUserId'] ;
    $connessione = mysqli_connect($configurazionedb['host'], $configurazionedb['user'], $configurazionedb['password'], $configurazionedb['name']);
    $query= "SELECT c.ID_penitenziario as ID_penitenziario, c.Nome_penitenziario as Nome_penitenziario, i.username as username FROM (carcere c join lavoro l on c.ID_penitenziario=l.carcere) join impiegato i on l.id_impiegato=i.id where l.id_impiegato=$id";
    $result = mysqli_query($connessione, $query) or die(mysqli_error($connessione));
    while($row=mysqli_fetch_assoc($result)){
        $array[]=$row;    
    }
    echo json_encode($array);
    mysqli_close($connessione);

?>

