function onJso(json){
    console.log(json);
    const e=document.querySelectorAll('.padre');
    for(cont in json){
    for(let i=0;i<e.length;i++){
        var figlio=e[i].querySelector('p');
        if(figlio.textContent===json[cont].Nome_penitenziario){
            var us=document.createElement('p');
            us.textContent=json[cont].username;
            us.classList.add('com');
            var comment=document.createElement('p');
            comment.textContent=json[cont].testo;
            comment.classList.add('com1');
            e[i].appendChild(us);
            e[i].appendChild(comment);
        }
    }    
    }
}


function onJ(json){
    console.log(json);
}

function onClick(event){
    const gen=event.currentTarget.parentNode;
    const com=gen.querySelector('input');
    console.log(com.value);
    const d=document.createElement('div');
    const us=document.createElement('p');
    us.textContent=gen.dataset.us;
    us.classList.add('com');
    const comment=document.createElement('p');
    comment.textContent=com.value;
    comment.classList.add('com1');
    const i=document.createElement('p');
    i.textContent=gen.dataset.id;
    gen.appendChild(us);
    gen.appendChild(comment);
    fetch('addCommento.php?q='+encodeURIComponent(comment.textContent)+'&us='+encodeURIComponent(us.textContent)+'&IDp='+encodeURIComponent(i.textContent)).then(onResponse).then(onJ);
}




function onJson(json){
    console.log(json);
    for(cont in json){
        const p=document.createElement('div');
        p.classList.add('padre');
        p.dataset.us=json[cont].username;
        p.dataset.id=json[cont].ID_penitenziario;
        const use=document.createElement('p');
        use.textContent=json[cont].username;
        use.classList.add('com');
        var inp =document.createElement('input');
        inp.type='text';
        inp.name='commento';
        inp.classList.add('commento');
        inp.placeholder='Aggiugi commento';
        var but =document.createElement('button');
        but.type='button';
        but.value='Invia';
        but.textContent='Invia';
        but.addEventListener('click',onClick);
        e=document.createElement('p');
        e.textContent=json[cont].Nome_penitenziario;
        p.appendChild(e);
        p.appendChild(inp);
        p.appendChild(but);
        //p.appendChild(use);
        b=document.querySelector('body');
        b.appendChild(p);
        fetch('trovaTesto.php?q='+encodeURIComponent(use.textContent)+'&IDp='+encodeURIComponent(p.dataset.id)).then(onResponse).then(onJso);
    }
}


function onResponse(response){
    return response.json();
}

fetch('trovaImpieghi.php').then(onResponse).then(onJson);