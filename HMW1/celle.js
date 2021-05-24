
function onJson(json){
    console.log(json);
    for(cont in json){
        const elem=document.querySelector('#cella');
        numero=document.createElement('p');
        numero.textContent=json[cont].N_cella;
        elem.appendChild(numero);
        const elem1=document.querySelector('#dp');
        d=document.createElement('p');
        d.textContent=json[cont].Detenuti_presenti;
        elem1.appendChild(d);
    }  
}

function onResponse(response){
    return response.json();
}


function checkNumero(){
    fetch('celleN.php?q='+encodeURIComponent(form.numero.value)).then(onResponse).then(onJson);
}



const form = document.forms['invioDato'];
form.numero.addEventListener('blur',checkNumero);