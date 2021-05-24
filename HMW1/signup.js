
function onJson(json){
    if(!json.exists){
        document.querySelector('#emailError').classList.add('hidden');
    }
}

function onResponse(response){
    return response.json();
}

function jsonCheckUsername(json) {
    if (formStatus.username = !json.exists) {
        document.querySelector('.username').classList.remove('errorj');
    } else {
        document.querySelector('.username').createElement('div').textContent = "Nome utente già utilizzato";
        document.querySelector('.username').classList.add('errorj');
    }
    checkForm();
}

function checkUsername(event) {
    const input = document.querySelector('.username input');

    if(!/^[a-zA-Z0-9_]{1,15}$/.test(input.value)) {
        input.parentNode.createElement('div').textContent = "Sono ammesse lettere, numeri e underscore. Max. 15";
        input.parentNode.parentNode.classList.add('errorj');
        formStatus.username = false;
        checkForm();
    } else {
        fetch("controlloUsername.php?q="+encodeURIComponent(input.value)).then(onResponse).then(jsonCheckUsername);
    }    
}

function checkPassword(event){
    if(form.password.value.length > 15 || form.password.value.length == 0){
        formStatus.password= false;
        const div = form.querySelector('#checkPassword');
        div.classList.remove('hidden');
        div.textContent = "Password mancante o troppo lunga, inserire massimo 15 caratteri";

    }else{
        formStatus.password = true;
        const div = form.querySelector('#checkPassword');
        div.classList.add('hidden');
    }
    checkForm();
}

function checkNome(event){
    if(formStatus.nome = form.name.value.length > 0){
        document.querySelector('#nameError').classList.add('hidden');
    }else{
        document.querySelector('#nameError').classList.remove('hidden');
        document.querySelector('#nameError').textContent ='Nome mancante';
    }
    checkForm();
}

function checkCognome(event){
    if(formStatus.cognome = form.surname.value.length > 0){
        document.querySelector('#surnameError').classList.add('hidden');

        
    }else{
        document.querySelector('#surnameError').textContent ='Cognome mancante';
        document.querySelector('#surnameError').classList.remove('hidden');
    }
    checkForm();
}

function onEmailJson(json, event){
    if (formStatus.email = !json.exists) {
        document.querySelector('#emailError').classList.add('hidden');
    } else {
        document.querySelector('#emailError').classList.remove('hidden');
        document.querySelector('#emailError').textContent = "Email già utilizzata";
    }
    checkForm();
}

function checkEmail(event){
    if(!/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/.test(String(form.email.value).toLowerCase())) {
        document.querySelector('#emailError').classList.remove('hidden');
        formStatus.email = false;
        checkForm();   
    } else {
        fetch("controlloEmail.php?q="+encodeURIComponent(form.email.value)).then(onResponse).then(function (json){ return onEmailJson(json, event); });
    }
}
function onCodiceJson(json, event) {
    if (formStatus.cod = !json.exists) {
        document.querySelector('#codError').classList.add('hidden');
    } else {
        document.querySelector('#codError').textContent = "Codice Fiscale già presente";
        document.querySelector('#codError').classList.remove('hidden');
    }
    checkForm();
}

function checkCf(event){
    if(!/^[a-zA-Z0-9]{1,16}$/.test(form.cod.value)) {
        formStatus.cod = false;
         const error = document.querySelector('#codError')
        error.textContent ='Codice fiscale non valido';
        error.classList.remove('hidden');
        checkForm();
    }else{
        fetch("controlloCF.php?q="+encodeURIComponent(form.cod.value)).then(onResponse).then(function (json){ return onCodiceJson(json, event); });
    } 
}

function checkDataNa(event){
    if (form.dataNa.value.substring(2,3) != "/" ||
    form.dataNa.value.substring(5,6) != "/" ||
    isNaN(form.dataNa.value.substring(0,2)) ||
    isNaN(form.dataNa.value.substring(3,5)) ||
    isNaN(form.dataNa.value.substring(6,10))) {
        const error = document.querySelector('#dataError')
        error.textContent ='Inserire data nascita nel formato gg/mm/aa';
        error.classList.remove('hidden');
        formStatus.dataNa=false;
        return;
    } else if (form.dataNa.value.substring(0,2) > 31) {
        const error = document.querySelector('#dataError')
        error.textContent ='Impossibile utilizzare un valore superiore a 31 per i giorni';
        error.classList.remove('hidden');
        formStatus.dataNa=false;
        return;
    } else if (form.dataNa.value.substring(3,5) > 12) {
        const error = document.querySelector('#dataError')
        error.textContent ='Impossibile utilizzare un valore superiore a 12 per i mesi';
        error.classList.remove('hidden');
        formStatus.dataNa=false;
        return;
    } else if (form.dataNa.value.substring(6,10) < 1900) {
        const error = document.querySelector('#dataError')
        error.textContent ='Impossibile utilizzare un valore inferiore a 1900 per anno';
        error.classList.remove('hidden'); 
        formStatus.dataNa=false; 
        return;
    }
    formStatus.dataNa=true;
    checkForm();
}

function checkConfirmPassword(event) {
    const confermaPasswordInput = document.querySelector('.confermaPassword input');
    if (formStatus.confermaPassword = confermaPasswordInput.value === document.querySelector('.password input').value) {
        document.querySelector('.confermaPassword').classList.remove('errorj');
    } else {
        document.querySelector('.confermaPassword').classList.add('errorj');
    }
    checkForm();
}

function checkallow(event){
    if(formStatus.allow = form.allow.checked){
        document.querySelector('#allowError').classList.add('hidden');
    }else{
        document.querySelector('#allowError').textContent = 'Dare il consenso per il trattamento dei dati';
        document.querySelector('#allowError').classList.remove('hidden');
    }
    checkForm();
}


function checkForm(){
    console.log(Object.keys(formStatus).length);
    console.log(formStatus);
    form.submit.disabled =  Object.keys(formStatus).length !== 9 || Object.values(formStatus).includes(false);
}

const form = document.forms['signup'];

const formStatus = { };
form.name.addEventListener('blur', checkNome);
form.surname.addEventListener('blur', checkCognome);
form.username.addEventListener('blur',checkUsername);
form.email.addEventListener('blur', checkEmail);
form.cod.addEventListener('blur', checkCf);
form.dataNa.addEventListener('blur',checkDataNa);
form.password.addEventListener('blur', checkPassword);
form.confermaPassword.addEventListener('blur',checkConfirmPassword);
form.allow.addEventListener('blur', checkallow);


