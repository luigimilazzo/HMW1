<?php
    require_once 'autenticazione.php';

    // Se la sessione è scaduta, esco
    if (!checkAuth()) exit;
    
    // Imposto l'header della risposta
    header('Content-Type: application/json');
    
    $apikey = 'kyVVvBb03a7jgxPok3RdBqvuUFrVhMQF';
    
    $url = 'https://api.nytimes.com/svc/search/v2/articlesearch.json?q=escapes&api-key='.$apikey;
    
    # Creo il CURL handle per l'URL selezionato
    $ch = curl_init($url);
    # Setto che voglio ritornato il valore, anziché un boolean (default)
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    # Eseguo la richiesta all'URL
    $data = curl_exec($ch);
    curl_close($ch);
    echo $data;
?>