<?php
    require_once 'autenticazione.php';

    if (checkAuth()) {
        header("Location: mhw1.php");
        exit;
    }   

    // Verifica l'esistenza di dati POST
    if (!empty($_POST["username"]) && !empty($_POST["password"]) && !empty($_POST["email"]) && !empty($_POST["name"]) && 
        !empty($_POST["surname"]) && !empty($_POST["cod"]) && !empty($_POST["dataNa"]) && !empty($_POST["confermaPassword"]) && !empty($_POST["allow"]))
    {
        $error = array();
        $connessione = mysqli_connect($configurazionedb['host'], $configurazionedb['user'], $configurazionedb['password'], $configurazionedb['name']) or die(mysqli_error($connessione));

        if(!preg_match('/^[a-zA-Z0-9]{1,16}$/', $_POST['cod'])) {
            $error[] = "Codice Fiscale non valido";
        } else {
            $codi = mysqli_real_escape_string($conn, $_POST["cod"]);
            $query = "SELECT CF FROM impiegato WHERE CF = '$codi'";
            $res = mysqli_query($conn, $query);
            if (mysqli_num_rows($res) > 0) {
                $error[] = "Codice Fiscale già utilizzato";
            }
        }

        # USERNAME
        // Controlla che l'username rispetti il pattern specificato
        if(!preg_match('/^[a-zA-Z0-9_]{1,15}$/', $_POST['username'])) {
            $error[] = "Username non valido";
        } else {
            $username = mysqli_real_escape_string($connessione, $_POST['username']);
            // Cerco se l'username esiste già o se appartiene a una delle 3 parole chiave indicate
            $query = "SELECT username FROM impiegato WHERE username = '$username'";
            $res = mysqli_query($connessione, $query);
            if (mysqli_num_rows($res) > 0) {
                $error[] = "Username già utilizzato";
            }
        }
        # PASSWORD
        if (strlen($_POST["password"]) < 8) {
            $error[] = "Caratteri password insufficienti";
        } 
        # CONFERMA PASSWORD
        if (strcmp($_POST["password"], $_POST["confermaPassword"]) != 0) {
            $error[] = "Le password non coincidono";
        }
        # EMAIL
        if (!filter_var($_POST['email'], FILTER_VALIDATE_EMAIL)) {
            $error[] = "Email non valida";
        } else {
            $email = mysqli_real_escape_string($connessione, strtolower($_POST['email']));
            $res = mysqli_query($connessione, "SELECT email FROM impiegato WHERE email = '$email'");
            if (mysqli_num_rows($res) > 0) {
                $error[] = "Email già utilizzata";
            }
        }
        # REGISTRAZIONE NEL DATABASE
        if (count($error) == 0) {
            $name = mysqli_real_escape_string($connessione, $_POST['name']);
            $surname = mysqli_real_escape_string($connessione, $_POST['surname']);

            $password = mysqli_real_escape_string($connessione, $_POST['password']);
            $password = password_hash($password, PASSWORD_BCRYPT);
            $dataNasc=mysqli_real_escape_string($connessione,$_POST['dataNascita']);
            $query = "INSERT INTO impiegato(username, password, email, CF, nome, cognome,Data_nascita) VALUES('$username', '$password', '$email','$codi', '$name', '$surname','$dataNasc')";
            
            if (mysqli_query($connessione, $query)) {
                $_SESSION["prigioniUsername"] = $_POST["username"];
                $_SESSION["prigioniUserId"] = mysqli_insert_id($connessione);
                mysqli_close($connessione);
                header("Location: mhw1.php");
                exit;
            } else {
                $error[] = "Errore di connessione al Database";
            }
        }

        mysqli_close($connessione);
    }
    else if (isset($_POST["username"])) {
        $error = array("Riempi tutti i campi");
    }

?>


<html>
    <head>
        <link rel='stylesheet' href='signup.css'>
        <script src='signup.js' defer></script>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Prigioni - Registrati</title>
    </head>
    <body>
            <h1>Inserisci qui i tuoi dati</h1>
            <div id="contenuto">
            <form name='signup' method='post' enctype="multipart/form-data" autocomplete="off">
                <div class="nomi">
                    <div class="nome">
                        <div><label for='name'>Nome</label></div>
                        <!-- Se il submit non va a buon fine, il server reindirizza su questa stessa pagina, quindi va ricaricata con 
                            i valori precedentemente inseriti -->
                        <div><input type='text' name='name' <?php if(isset($_POST["name"])){echo "value=".$_POST["name"];} ?> ></div>
                    </div>
                    <div class="surnames">
                        <div><label for='surname'>Cognome</label></div>
                        <div><input type='text' name='surname' <?php if(isset($_POST["surname"])){echo "value=".$_POST["surname"];} ?> ></div>
                    </div>
                </div>
                <div class='codFisc'>
                <div><label for='codice'>Codice fiscale</label></div>
                    <div><input type='text' name='cod' <?php if(isset($_POST["cod"])){echo "value=".$_POST["cod"];} ?>></div>
                </div>
                <div class='dataN'>
                <div><label for='data'>Data Nascita</label></div>
                    <div><input type='text' name='dataNa' <?php if(isset($_POST["dataNa"])){echo "value=".$_POST["dataNa"];} ?>></div>
                </div>
                <div class="username">
                    <div><label for='username'>Nome utente</label></div>
                    <div><input type='text' name='username' <?php if(isset($_POST["username"])){echo "value=".$_POST["username"];} ?>></div>
                </div>
                <div class="emails">
                    <div><label for='email'>Email</label></div>
                    <div><input type='text' name='email' <?php if(isset($_POST["email"])){echo "value=".$_POST["email"];} ?>></div>
                </div>
                <div class="password">
                    <div><label for='password'>Password</label></div>
                    <div><input type='password' name='password' <?php if(isset($_POST["password"])){echo "value=".$_POST["password"];} ?>></div>
                </div>
                <div class="confermaPassword">
                    <div><label for='confirm_password'>Conferma Password</label></div>
                    <div><input type='password' name='confermaPassword' <?php if(isset($_POST["confermaPassword"])){echo "value=".$_POST["confermaPassword"];} ?>></div>
                </div>
                <div class="allows"> 
                    <div><input type='checkbox' name='allow' value="1" <?php if(isset($_POST["allow"])){echo $_POST["allow"] ? "checked" : "";} ?>></div>
                    <div><label for='remember'>Ricorda l'accesso</label></div>
                </div>
                <div class="submit">
                    <input type='submit' value="Registrati" name="submit" disabled>
                </div>
                <div id = 'error'>
                        <div id ="nameError" class= 'hidden' class ='error'></div>
                        <div id="dataError" class='hidden' class='error'></div>
                        <div id ="surnameError" class= 'hidden' class ='error'></div>
                        <div id ='checkPassword' class = 'hidden' class ='error'>Password non valida</div>
                        <div id='emailError' class ='hidden' class ='error'>Email non valida</div>
                        <div id='codError' class ='hidden' class ='error'></div>  
                        <div id='allowError' class ='hidden' class ='error'></div>
                       
                      <?php if(isset($error)) foreach($error as $key) echo  "<div>".$key."</div>"; ?>
                </div>  
                </form>
            <div class="signup">Hai già un account? <a href="login.php">Accedi</a>
        </div>
        </body>
</html>