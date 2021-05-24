<?php
    require_once 'autenticazione.php';

    // Se la sessione è scaduta, esco
    if (!checkAuth()) exit;
    
    // Imposto l'header della risposta
    header('Content-Type: application/json');
    $client_id = 'db7abddff8fd4cfb8131340de72a7103'; 
    $client_secret = '087aa88366e44896b4910aa70f2ccb3b'; 

    // ACCESS TOKEN
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, 'https://accounts.spotify.com/api/token' );
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    # Eseguo la POST
    curl_setopt($ch, CURLOPT_POST, 1);
    # Setto body e header della POST
    curl_setopt($ch, CURLOPT_POSTFIELDS, 'grant_type=client_credentials'); 
    curl_setopt($ch, CURLOPT_HTTPHEADER, array('Authorization: Basic '.base64_encode($client_id.':'.$client_secret))); 
    $token=curl_exec($ch);
    curl_close($ch);
    echo $token;      


?>