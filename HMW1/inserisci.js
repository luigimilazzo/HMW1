function onJson(json){
    console.log(json);
    for(cont in json){
        const father=document.querySelector('#penitenziario');
        elem=document.createElement('p');
        elem.dataset.id=json[cont].ID_penitenziario;
        elem.textContent=json[cont].Nome_penitenziario;
        father.appendChild(elem);
    }
}
function onResponse(response){
    return response.json();
}
fetch('inserimento.php').then(onResponse).then(onJson);


setTimeout(()=>{
    function onJsonResponse(json){
        console.log(json);
    }
    
    
    function onClick(event){
        console.log(event.currentTarget.dataset.id);
        fetch('insert.php?q='+encodeURIComponent(event.currentTarget.dataset.id)).then(onResponse).then(onJsonResponse);
        event.currentTarget.removeEventListener('click',onClick);
    }

    const tutti=document.querySelectorAll("#padre #penitenziario p");
    for(let t of tutti){
    t.addEventListener("click",onClick);
    }},2000);