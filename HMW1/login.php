<?php
    // Verifica che l'utente sia già loggato, in caso positivo va direttamente alla home
    include 'autenticazione.php';
    if (checkAuth()) {
        header('Location: mhw1.php');
        exit;
    }

    if (!empty($_POST["username"]) && !empty($_POST["password"]) )
    {
        // Se username e password sono stati inviati
        // Connessione al DB
        $connessione = mysqli_connect($configurazionedb['host'], $configurazionedb['user'], $configurazionedb['password'], $configurazionedb['name']) or die(mysqli_error($connessione));
        // Preparazione 
        $username = mysqli_real_escape_string($connessione, $_POST['username']);
        $password = mysqli_real_escape_string($connessione, $_POST['password']);
        // Permette l'accesso tramite email o username in modo intercambiabile
        $searchField = filter_var($username, FILTER_VALIDATE_EMAIL) ? "email" : "username";
        // ID e Username per sessione, password per controllo
        $query = "SELECT id, username, password FROM impiegato WHERE $searchField = '$username'";
        // Esecuzione
        $res = mysqli_query($connessione, $query) or die(mysqli_error($connessione));;
        if (mysqli_num_rows($res) > 0) {
            // Ritorna una sola riga, il che ci basta perché l'utente autenticato è solo uno
            $entry = mysqli_fetch_assoc($res);
            if (password_verify($_POST['password'], $entry['password'])) {
                $_SESSION["prigioneUsername"] = $entry['username'];
                $_SESSION["prigioniUserId"] = $entry['id'];
                header("Location: mhw1.php");
                mysqli_free_result($res);
                mysqli_close($connessione);
                exit;
            }
        }
        // Se l'utente non è stato trovato o la password non ha passato la verifica
        $error = "Username e/o password errati.";
    }
    else if (isset($_POST["username"]) || isset($_POST["password"])) {
        // Se solo uno dei due è impostato
        $error = "Inserisci username e password.";
    }

?>


<html>
    <head>
        <link rel='stylesheet' href='login.css'>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Prigioni - Accedi</title>
    </head>
    <body>
            <h1>Benvenuto in questo sito web</h1>
            <?php
                // Verifica la presenza di errori
                if (isset($error)) {
                    echo "<span class='error'>$error</span>";
                }
                
            ?>
            <div id='intro'>
            <form name='login' method='post'>
                <!-- Seleziono il valore di ogni campo sulla base dei valori inviati al server via POST -->
                <div class="username">
                    <div><label for='username'>Username o email</label></div>
                    <div><input type='text' name='username' <?php if(isset($_POST["username"])){echo "value=".$_POST["username"];} ?>></div>
                </div>
                <div class="password">
                    <div><label for='password'>Password</label></div>
                    <div><input type='password' name='password' <?php if(isset($_POST["password"])){echo "value=".$_POST["password"];} ?>></div>
                </div>
                <div class="remember">
                    <div><input type='checkbox' name='remember' value="1" <?php if(isset($_POST["remember"])){echo $_POST["remember"] ? "checked" : "";} ?>></div>
                    <div><label for='remember'>Ricorda l'accesso</label></div>
                </div>
                <div>
                    <input type='submit' value="Accedi">
                </div>
            </form>
           <div class="signup">Non hai un account? <a href="signup.php">Iscriviti</a>
            </div>
        </body>
</html>
