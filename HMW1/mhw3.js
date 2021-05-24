/*function onJsonOP(json){
    console.log(json);
    const libri=document.querySelector("#libri");
    libri.innerHTML='';
    let n=Math.round(Math.random()*10);
    for(let i=0;i<4;i++){
        let doc = json.docs[n];
        const titolo=doc.title;
        for(block in contenuti){
            const elemento=contenuti[block].titolo;
            if(titolo===elemento){
                var id=contenuti[block].id;
                break;
            }
        }
        const coverUrl='http://covers.openlibrary.org/b/id/'+ id +'-M.jpg';
        const books=document.createElement('div');
        books.classList.add('elementi');
        const img=document.createElement('img');
        img.src=coverUrl;
        const description=document.createElement('p');
        description.textContent=titolo;
        books.appendChild(img);
        books.appendChild(description);
        libri.appendChild(books); 
        if(n===10) n=1;
        else n++;       
    }
}

function OnResponse(response){
    return response.json();
}

const subject=encodeURIComponent('Mystery and detective stories');
const url='http://openlibrary.org/search.json?subject=' + subject;
fetch(url).then(OnResponse).then(onJsonOP);

*/
function onJsonNYT(json){
    console.log(json);
    const articoli=document.querySelector("#articles");
    articoli.innerHTML='';
    let n=Math.round(Math.random()*9);
    for(let i=0;i<5;i++){
        let art=json.response.docs[n];
        const blocco=document.createElement("p");
        const riferimento=document.createElement("a");
        riferimento.textContent=art.headline.main;
        riferimento.href=art.web_url;
        blocco.appendChild(riferimento);
        articoli.appendChild(blocco);
        if(n===9) n=1;
        else n++;
    }
}


function OnResponseNYT(response){
    return response.json();
}

fetch('NYTApi.php').then(OnResponseNYT).then(onJsonNYT);



function onTokenJson(json)
{
  token = json.access_token;
}

function onTokenResponse(response)
{
  return response.json();
}


let token;
fetch("spotify.php").then(onTokenResponse).then(onTokenJson);

function onJson(json) {
    console.log(json);
    const albumList = document.querySelector('#album');
    albumList.classList.remove("hidden");
    albumList.innerHTML = '';
    const results = json.albums.items;
    const risultati=4;
    for(let i=0; i<risultati; i++)
    {
      const album_i = results[i]
      const title = album_i.name;
      const img = album_i.images[0].url;
      const album = document.createElement('div');
      const image = document.createElement('img');
      image.src = img;
      const description = document.createElement('p');
      description.textContent = title;
      album.appendChild(image);
      album.appendChild(description);
      albumList.appendChild(album);
    }
  }
  
  function onResponse(response) {
    return response.json();
  }

function search(event)
{
  event.preventDefault();
  const albumInput = document.querySelector('#canzone');
  const albumValue = encodeURIComponent(albumInput.value);
  fetch("https://api.spotify.com/v1/search?type=album&q=" + albumValue,
    {
      headers:
      {
        'Authorization': 'Bearer ' + token
      }
    }
  ).then(onResponse).then(onJson);
}

const form=document.querySelector("form");
form.addEventListener('submit',search);


function openModal(event){
    const immagine=document.createElement('img');
    immagine.src=event.currentTarget.src;
    mod.style.top=window.pageYOffset+'px';
    document.body.classList.add('no-scroll');
    mod.classList.remove('hidden');
    mod.appendChild(immagine);
}


function closeModal(){
    document.body.classList.remove('no-scroll');
    mod.classList.add('hidden');
    mod.innerHTML='';
}


const mod=document.querySelector('#modalView');
setTimeout(()=>{const imgList=document.querySelectorAll('#libri .elementi img');
for(let ima of imgList){
    ima.addEventListener('click',openModal);
}
mod.addEventListener('click',closeModal);},20000);

