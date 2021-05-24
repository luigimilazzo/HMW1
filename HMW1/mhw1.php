<?php
  session_start();
?>


<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>5 Prigioni italiane</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://fonts.googleapis.com/css2?family=Rock+Salt&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Paytone+One&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Courgette&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=ABeeZee&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Syne+Mono&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Zilla+Slab:ital,wght@1,300&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Amatic+SC&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="mhw1.css">
    <script src="mhw3.js" defer="true"></script>
    <script src="dati_libri.js" defer="true"></script>
  </head>
  <body>
    <header>
      <div class="overlay"></div>
      <nav>
        <div>
        <div id="links">
          <span><?php
            if(isset($_SESSION['prigioniUserId'])) echo 'Benvenuto '. $_SESSION['prigioneUsername'];
          ?>
          </span>
          <a href='logout.php'> Logout </a>
          <a href='inserisciCarcere.php'>Inserisci Carcere </a>
          <a href='celle.php'>Celle</a>
          <a href='impieghi.php'>Visualizza impieghi</a>
          <a id="button" href='archivio.php'> Archivio detenuti </a>
        </div>
        <div id="menu">
          <div></div>
          <div></div>
          <div></div>
        </div>
      </nav>
      <h1> 5 Prigioni italiane </h1>  
      </header>  
   
     <div class="intro">
      <span class="saluto"> Benvenuti in questa pagina web</span>
      </div>
   <article>
   <section>
     <div class="n"> 1 </div>
     <div class="descrizione">
       <div class="container">
     <img src="img2.jpg">
       </div> 
        <div class="specifiche">
        <h1> <em> Ucciardone </em> </h1>
        <div class="pericolosita"> 
        <div>Livello di pericolosità:8</div>
        <div class="cond">Condizione struttura: </div>
        </div>
        <p>L'edificio è molto antico e presenta vari problemi legati alla sua età. I lavori degli ultimi anni ne hanno migliorato significativamente le condizioni generali, in particolare quelle dei padiglioni n° 5 e 7. Il 5° padiglione è stato completamente ristrutturato di recente, il che ha creato ambienti esteticamente e architettonicamente gradevoli, che valorizzano la cifra storica dell'edificio. Purtroppo, si verificano già alcuni problemi di infiltrazione d'acqua dalle coperture visibili, con grandi marche di umidità nella maggior parte degli ambienti dell'ultimo livello. 
        </p>
        <a class="info" href="https://www.antigone.it/osservatorio_detenzione/sicilia/149-casa-circondariale-di-palermo-ucciardone"> Per maggiori info clicca qui</a>
       </div>
     
     </div>
     </section>
     <section>
     <div class="n"> 2 </div>
     <div class="descrizione">
       <div class="container">
     <img src="img3.jpg">
       </div> 
       
     <div class="specifiche">
        <h1> <em> Rebibbia </em> </h1>
        <div class="pericolosita"> 
          <div>Livello di pericolosità:9 </div>
          <div class="cond"> Condizione struttura:</div>          
        </div>
        
        <p>L'edificio necessita di interventi di manutenzione. Al momento della visita erano in ristrutturazione, in vista di una prossima apertura (giugno 2019) un corridoio al piano terra con 58 nuovi posti, due corridoi rispettivamente al primo e secondo piano. Il reparto G9 è quello che versa in condizioni più critiche. Di prossima apertura nuove stanze detentive (da 2 o da 6) con doccia nel bagno, ma saranno realizzate anche docce comuni. Questi lavori sono stati realizzati dai detenuti.        
        </p>
        <a class="info" href="https://www.antigone.it/osservatorio_detenzione/lazio/106-casa-circondariale-rebibbia-nuovo-complesso"> Per maggiori info clicca qui</a>
       </div>
     </div>
     </section>
     <section>
     <div class="n"> 3 </div>
     <div class="descrizione">
    <div class="container">
     <img src="img4.jpg">
    </div>
      <div class="specifiche">
        <h1> <em> Regina Coeli </em> </h1>
        <div class="pericolosita"> 
          <div>Livello di pericolosità:7 </div>
          <div class="cond">Condizione struttura: </div>          
        </div>
        
        <p>L'Istituto si divide in due parti, separate da 2 rotonde. Le sezioni vanno in ordine numerico. Nella prima rotonda ci sono la sezione prima, seconda, terza e quarta quest'ultima ospita persone tossicodipendenti. Dalla seconda rotonda si sviluppano altre 4 sezioni: la quinta è a vigilanza dinamica ed ospita in prevalenza lavoranti, anche la sesta è a custodia aperta. La settima sezione attualmente ospita nuovi giunti che devono sottoporsi all'isolamento preventivo causa Covid e l' ottava è la sezione protetta.
        </p>
        <a class="info" href="https://www.antigone.it/osservatorio_detenzione/lazio/110-casa-circondariale-di-regina-coeli"> Per maggiori info clicca qui</a>
       </div>
     </div>
     </section>
    <section>
     <div class="n"> 4 </div>
     <div class="descrizione">
    <div class="container">
     <img src="img5.jpg">
    </div> 
     <div class="specifiche">
        <h1> <em> San Vittore </em>  </h1>
        <div class="pericolosita"> 
          <div>Livello di pericolosità:8 </div>
          <div class="cond">Condizione struttura: </div>          
        </div>
        
        <p>Le condizioni dell'istituto sono discrete, soprattutto in considerazione della vetustà della struttura. I reparti danneggiati dopo le rivolte del 9 Marzo 2020 sono stati completamente ripristinati nelle condizioni precedenti. Non sono in programma al momento altre importanti ristrutturazioni.
        </p>
        <a class="info" href="https://www.antigone.it/osservatorio_detenzione/lombardia/98-casa-circondariale-di-milano-san-vittore">Per maggiori info clicca qui</a>
       </div>
     </div>
     </section>
      <section>
     <div class="n"> 5 </div>
     <div class="descrizione">
    <div class="container">
     <img src="img6.jpg">
    </div> 
     <div class="specifiche">
        <h1> <em> Badu e Carros </em>  </h1>
        <div class="pericolosita"> 
          <div>Livello di pericolosità:7.5 </div>
          <div class="cond"> Condizione struttura: </div>          
        </div>
        
        <p>Nell'istituto sono stati realizzati recentemente dei lavori di ristrutturazione e che hanno interessato la sezione di Media Sicurezza, alcuni corridoi e la sezione AS2 che ha subito dei recenti lavori di tinteggiatura interna. Dal 2018 è stata aperta una nuova sezione, la quinta, di 3 piani: il piano terra dedicato alle attività ricreative e trattamentali e il 1 e il 2 piano alla custodia in cella dei detenuti. Allo stato attuale sono previsti dei lavori nella ex sezione femminile, mentre alcuni spazi necessitano ancora di interventi di restauro.
        </p>
        <a class="info" href="https://www.antigone.it/osservatorio_detenzione/sardegna/22-istituto-c-c-badu-e-carros-nuoro"> Per maggiori info clicca qui</a>
       </div>
     </div>
     </section>  
    </article>
    <div class="favourite">
    <a class="preferiti" href="mhw2.php">Clicca qui per scegliere i preferiti</a>
    </div>
    <!-- <p class="stories">Ecco alcuni libri su storie di detective che potrebbero interessarti</p>
    <div id="libri"></div>
    -->
    <p class="stories">Ecco alcuni articoli direttamente dal New York Times </p>
    <div id="articles"></div>
    <p class="music">L’Associazione Arpamagica, insieme ad alcuni docenti del corso di formazione in musicoterapia, ha messo a punto un progetto d’intervento negli istituti penitenziari proponendo attività di musicoterapia rivolte ai detenuti che lo desiderano e un programma particolare dedicato alle donne del carcere di Bollate. L’obiettivo è quello di creare attraverso il ” far musica ” un clima non conflittuale e non competitivo nel quale trovare nuove modelli relazionali improntati alla cooperazione e alla condivisione empatica. Ecco qui puoi cercare gli album di canzoni che proporresti in un carcere?
      <form>
      <input type='text' id='canzone'>
      <input type='submit' id='submit' value='Cerca'>
      </form>
    </p>
    <div id="album" class="hidden"></div>
    <div id="icona">
      <img src="img7.jpg">
    </div>
    <div id="modalView" class="hidden"></div>
   <footer>
     <address>Milazzo Luigi</address>
      <p>O46002005</p>
    </footer>
  </body>
</html>
    
