var cont;
var contenuti;
function onJson(json){
    console.log(json);
    contenuti=json;
    for(cont in json){
    const event=document.createElement("div");
    const h1=document.createElement("h1");
    h1.textContent=json[cont].titolo;

    const image=document.createElement("img");
    image.setAttribute("src",json[cont].url);

    const desc=document.createElement("p");
    desc.classList.add("hidden");
    desc.textContent=json[cont].descrizione;
    
    const details=document.createElement("p");
    details.classList.add("dettagli");
    details.textContent="Mostra più"
    
    
    const favor=document.createElement("img");
    favor.classList.add("preferito");
    favor.setAttribute("src","favorites.png");

    event.appendChild(favor);
    event.appendChild(h1);
    event.appendChild(image);
    event.appendChild(desc);
    event.appendChild(details);
    document.querySelector("#griglia").appendChild(event);
    }    
    begin();
    addFavourites();
}

function onResponse(response){
    return response.json();
}
fetch("contents.php").then(onResponse).then(onJson);

function load(){
    for(cont in contenuti){
        const event=document.createElement("div");
        const h1=document.createElement("h1");
        h1.textContent=contenuti[cont].titolo;
    
        const image=document.createElement("img");
        image.setAttribute("src",contenuti[cont].url);
    
        const desc=document.createElement("p");
        desc.classList.add("hidden");
        desc.textContent=contenuti[cont].descrizione;
        
        const details=document.createElement("p");
        details.classList.add("dettagli");
        details.textContent="Mostra più"
        
        
        const favor=document.createElement("img");
        favor.classList.add("preferito");
        favor.setAttribute("src","favorites.png");
    
        event.appendChild(favor);
        event.appendChild(h1);
        event.appendChild(image);
        event.appendChild(desc);
        event.appendChild(details);
        document.querySelector("#griglia").appendChild(event);
        }
        begin();
        addFavourites();
}
function lessDetails(event){
    const big=event.currentTarget.parentNode;
    const det=event.currentTarget;
    det.textContent="Mostra più";
    const desc=big.querySelector("p");
    desc.classList.add("hidden");
    big.classList.remove("inEvidenza");
    det.removeEventListener("click",lessDetails);
    det.addEventListener("click",moreDetails);
}


function moreDetails(event){
    const big=event.currentTarget.parentNode;
    const det=event.currentTarget;
    det.textContent="Mostra meno";
    const desc=big.querySelector("p");
    desc.classList.remove("hidden");
    big.classList.add("inEvidenza");
    det.removeEventListener("click",moreDetails);
    det.addEventListener("click",lessDetails);
}


function begin(){
    const listaDettagli= document.querySelectorAll(".dettagli")
    for(let det of listaDettagli){
        det.addEventListener("click",moreDetails)
    }
}

function rimuovi(event){
    const pNode=event.currentTarget.parentNode;
    const blocco=document.querySelector("#pre");
    blocco.removeChild(pNode);
    const alldiv=document.querySelectorAll("#griglia div");
    const testo=pNode.querySelector("h1").textContent;
    for(let i=0;i<alldiv.length;i++){
        const hi=alldiv[i].querySelector("h1").textContent;
        if(hi===testo){
            const im=alldiv[i].querySelector(".preferito");
            im.addEventListener("click",aggiunto);
            break;
        }
    }
    cont--;
    console.log(cont);
    if(cont === 4){
        const pref=document.querySelector("#pr");
        pref.classList.add("hidden");
        const pre=document.querySelector("#pre");
        pre.classList.add("hidden");
        return;
    }
}



function aggiunto(event){
    const pNode=event.currentTarget.parentNode;
    const pref=document.querySelector("#pr");
    pref.classList.remove("hidden");
    const blockP=document.querySelector("#pre");
    blockP.classList.remove("hidden");
    const im=event.currentTarget;
    const image=document.createElement("img");
    image.src="selected.jpg";
    image.classList.add("preferito");
    const newElem=document.createElement("div");
    const testo=document.createElement("h1");
    testo.textContent=pNode.querySelector("h1").textContent;
    const immagine=document.createElement("img");
    immagine.setAttribute("src",pNode.querySelectorAll("img")[1].src);
    newElem.appendChild(testo);
    newElem.appendChild(image);
    newElem.appendChild(immagine);
    blockP.appendChild(newElem);
    if(isNaN(cont)){
        cont=0;
    }
    cont++;
    
    im.removeEventListener("click",aggiunto);
    image.addEventListener("click",rimuovi);
}

function addFavourites(){
    const iconePreferiti=document.querySelectorAll(".preferito");
    for(let icon of iconePreferiti){
        icon.addEventListener("click",aggiunto);
    }
}

function ricercare(event){
    const griglia=document.querySelector("#griglia");
    griglia.innerHTML='';
    load();
    const inserimento=event.currentTarget;
    const testo=inserimento.value;
    const listaTitoli=document.querySelectorAll("#griglia div h1");
    for(const hi of listaTitoli){
        const testoMinuscolo=hi.textContent.toLowerCase();
        if((testoMinuscolo.search(testo))===-1){
            griglia.removeChild(hi.parentNode);
        }
    }
}


const cercare=document.querySelector("#ricerca");
cercare.addEventListener("keyup",ricercare);