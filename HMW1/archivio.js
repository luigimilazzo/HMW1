
function onJson(json){
    console.log(json);
    for(cont in json){
        const elem=document.querySelector('#nome');
        nome=document.createElement('p');
        nome.textContent=json[cont].Nome;
        elem.appendChild(nome);
        const elem1=document.querySelector('#cognome');
        cognome=document.createElement('p');
        cognome.textContent=json[cont].Cognome;
        elem1.appendChild(cognome);
        const elem2=document.querySelector('#penitenziario');
        penitenziario=document.createElement('p');
        penitenziario.textContent=json[cont].Nome_penitenziario;
        elem2.appendChild(penitenziario);
    }
}

function onResponse(response){
    return response.json();
}



function checkLettera(event){
        fetch('archivioDetenuti.php?q='+encodeURIComponent(form.lettera.value.toUpperCase())).then(onResponse).then(onJson);
}


const form = document.forms['invioDato'];
form.lettera.addEventListener('blur',checkLettera);