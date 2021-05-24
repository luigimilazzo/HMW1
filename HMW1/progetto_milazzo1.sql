-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mag 24, 2021 alle 23:18
-- Versione del server: 10.4.14-MariaDB
-- Versione PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `progetto_milazzo1`
--

DELIMITER $$
--
-- Procedure
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `carc_impiegato` (IN `cod1` INTEGER, IN `cod2` INTEGER)  begin 
	drop table if exists tmp1;
    create table tmp1 (
		carcere integer,
        nome varchar(255),
        sede varchar(255),
        impiegato varchar(16)
    );
    insert into tmp1
    select im.Carcere,c.Nome_penitenziario,c.Sede,im.CF_impiegato
    from imp_carcere im join carcere c on im.Carcere=c.ID_penitenziario
    where im.CF_impiegato in (select Impiegato from impiego where Impiegato=cod1 or Impiegato=cod2);
    select * from tmp1;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `d_ag` (IN `lettera` VARCHAR(1))  begin 
	drop table if exists tmp;
    create table tmp (
		carcere integer ,
        conteggio integer
    );
	insert into tmp
	select  Carcere, count(CF) 
	from  detenuti_carcere
	where CF in (select cf  from detenuto d join detenuto_ag da on d.CF=da.Detenuto where d.Cognome like concat(lettera,'%'))
	group by Carcere;
    select * from tmp;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `inserimento_detenuto` (IN `cod` VARCHAR(16), IN `n` VARCHAR(255), `c` VARCHAR(255), IN `d_n` DATE, IN `a` VARCHAR(16))  begin 
	case 
		when (year(current_date)-year(d_n))>=18
        then insert into detenuto values (cod,n,c,d_n,a);
        when (year(current_date)-year(d_n))<18
        then SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Detenuto minorenne non può essere rinchiuso in un carcere per adulti';
	end case;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `n_det` (IN `n1` INTEGER, IN `n2` INTEGER)  begin 
	drop table if exists tmp2;
    create table  tmp2 (
		n_cella integer,
        n_detenuti integer
    );
	insert into tmp2
    select N_cella,Detenuti_presenti
    from cella 
    where N_cella between n1 and n2;
	
	select * from tmp2;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `p1` (IN `d` VARCHAR(16), IN `c` INTEGER, IN `i` DATE, IN `dt` DATE)  begin
		insert into pigione values (d,c,i,dt);
        if exists (select * from pigione where Detenuto=d and Cella<>c) and dt IS NULL
		then update pigione set Data_trasferimento=i where Detenuto=d and Data_trasferimento IS NULL and Cella<>c;
		end if;
     
        if exists (select * from pigione where Detenuto=d and Data_trasferimento=i) 
		then update cella set Detenuti_presenti=Detenuti_presenti-1 where N_cella in (select Cella from pigione where Detenuto=d and Data_trasferimento=i);
		end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `p2` (IN `c` INTEGER, IN `imp` INTEGER, IN `i` DATE, IN `df` DATE)  begin
		insert into impiego values (c,imp,i,df);
        if exists (select * from impiego where Impiegato=imp) and df IS NULL 
		then update impiego set Data_fine=i where Impiegato=imp and Data_fine IS NULL and Carcere<>c;
		end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `p3` (IN `d` VARCHAR(16), IN `c` INTEGER, IN `i` DATE, IN `dt` DATE)  begin
		insert into locazione values (d,c,i,dt);
		if exists (select * from locazione where Detenuto=d) and dt IS NULL
		then update locazione set Data_trasferimento=i where Detenuto=d and Data_trasferimento IS NULL and Carcere<>c;
		end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `p6` (IN `d` VARCHAR(16), IN `c` INTEGER)  begin
	drop temporary table if exists tmp5;
    create temporary table tmp5 (
		Impiegato varchar(16)
    );
	insert into tmp5
    select Impiegato	
	from impiego 
	where Inizio between (select Inizio from locazione where Detenuto=d and Carcere=c) and Current_date
    and Carcere=c;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `avvocato`
--

CREATE TABLE `avvocato` (
  `CF_avvocato` varchar(16) NOT NULL,
  `Nome` varchar(255) DEFAULT NULL,
  `Cognome` varchar(255) DEFAULT NULL,
  `Data_nascita` date DEFAULT NULL,
  `Specializzazione` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `avvocato`
--

INSERT INTO `avvocato` (`CF_avvocato`, `Nome`, `Cognome`, `Data_nascita`, `Specializzazione`) VALUES
('LIESBT52S63G392V', 'Leonardo', 'Esposito', '1980-10-24', 'Diritto informativo'),
('MLZLGU78GG789HJK', 'Luigi', 'Milazzo', '1999-03-19', 'Diritto penale'),
('NNLCLD45P51F208T', 'Nunzio', 'Locatelli', '1970-02-25', 'Diritto civile'),
('NTRGZR46C62D614W', 'Natalia', 'Riggi', '1985-12-11', 'Diritto amministrativo'),
('RGGMFT93L70B138C', 'Ruggero', 'Meli', '1987-11-24', 'Diritto internazionale');

-- --------------------------------------------------------

--
-- Struttura della tabella `carcere`
--

CREATE TABLE `carcere` (
  `ID_penitenziario` int(11) NOT NULL,
  `Nome_penitenziario` varchar(255) DEFAULT NULL,
  `Sede` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `carcere`
--

INSERT INTO `carcere` (`ID_penitenziario`, `Nome_penitenziario`, `Sede`) VALUES
(1, 'Ucciardone', 'Palermo'),
(2, 'Rebibbia', 'Roma'),
(3, 'Regina Coeli', 'Roma'),
(4, 'San Vittore', 'Milano'),
(5, 'Badu e Carros', 'Nuoro');

-- --------------------------------------------------------

--
-- Struttura della tabella `cella`
--

CREATE TABLE `cella` (
  `N_cella` int(11) NOT NULL,
  `Tipo_cella` varchar(255) DEFAULT NULL,
  `Detenuti_presenti` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `cella`
--

INSERT INTO `cella` (`N_cella`, `Tipo_cella`, `Detenuti_presenti`) VALUES
(1, 'Liscia', 1),
(2, 'Isolamento', 1),
(3, 'Liscia', 1),
(4, 'Isolamento', 1),
(5, 'Isolamento', 1),
(6, 'Liscia', 1),
(7, 'Liscia', 1),
(8, 'Isolamento', 1),
(9, 'Liscia', 1),
(10, 'Isolamento', 1);

-- --------------------------------------------------------

--
-- Struttura della tabella `colloquio_familiare`
--

CREATE TABLE `colloquio_familiare` (
  `ID_colloquio` int(11) NOT NULL,
  `Giorno_settimana` varchar(255) DEFAULT NULL,
  `Orario_colloquio` time DEFAULT NULL,
  `Categoria_conoscente` varchar(255) DEFAULT NULL,
  `Detenuto` varchar(16) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `colloquio_familiare`
--

INSERT INTO `colloquio_familiare` (`ID_colloquio`, `Giorno_settimana`, `Orario_colloquio`, `Categoria_conoscente`, `Detenuto`) VALUES
(1, 'Lunedì', '12:00:00', 'Familiare', 'GFNBFP54C59G672U'),
(2, 'Martedì', '13:00:00', 'Amico', 'PVCFHK87H10G078J'),
(3, 'Mercoledì', '11:00:00', 'Convivente', 'VJVNZM45C14D715K'),
(4, 'Giovedì', '10:00:00', 'Familiare', 'GTVXRS28C50A380D'),
(5, 'Venerdì', '09:00:00', 'Amico', 'FLLZFD92P47E431C');

-- --------------------------------------------------------

--
-- Struttura della tabella `colloquio_reale`
--

CREATE TABLE `colloquio_reale` (
  `Data_colloquio` date NOT NULL,
  `Colloquio` int(11) NOT NULL,
  `Nome_conoscente` varchar(255) DEFAULT NULL,
  `Cognome_conoscente` varchar(255) DEFAULT NULL,
  `Persona_incontrata` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `colloquio_reale`
--

INSERT INTO `colloquio_reale` (`Data_colloquio`, `Colloquio`, `Nome_conoscente`, `Cognome_conoscente`, `Persona_incontrata`) VALUES
('2021-01-11', 1, 'Paolo', 'Di Mauro', 'Cugino'),
('2021-01-12', 2, 'Mario', 'Mosca', 'Amico'),
('2021-01-13', 3, 'Girolamo', 'Guidi', 'Coinquilino'),
('2021-01-14', 4, 'Giuseppe', 'Caio', 'Zio'),
('2021-01-15', 5, 'Gerlando', 'Guizzoni', 'Amico');

-- --------------------------------------------------------

--
-- Struttura della tabella `commenti`
--

CREATE TABLE `commenti` (
  `id_commento` int(11) NOT NULL,
  `testo` varchar(255) DEFAULT NULL,
  `username` varchar(16) DEFAULT NULL,
  `carcere` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `commenti`
--

INSERT INTO `commenti` (`id_commento`, `testo`, `username`, `carcere`) VALUES
(1, 'c', 'luigi99', 1),
(2, 'd', 'luigi99', 1),
(3, 'c', 'luigi99', 1),
(4, 'e', 'luigi99', 1);

-- --------------------------------------------------------

--
-- Struttura della tabella `contenuti`
--

CREATE TABLE `contenuti` (
  `titolo` varchar(255) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `descrizione` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `contenuti`
--

INSERT INTO `contenuti` (`titolo`, `url`, `descrizione`) VALUES
('Badu e Carros', 'BaduCarros.jpg', 'Situato a Nuoro presenta 272 detenuti'),
('Rebibbia', 'Rebibbia.jpg', 'Situato a Roma presenta 323 detenuti'),
('Regina Coeli', 'ReginaCoeli.jpg', 'Situato a Roma presenta 1026 detenuti'),
('San Vittore', 'SanVittore.jpg', 'Situato a Milano presenta 944 detenuti'),
('Ucciardone', 'Ucciardone.jpg', 'Situato a Palermo presenta 424 detenuti');

-- --------------------------------------------------------

--
-- Struttura stand-in per le viste `detenuti_carcere`
-- (Vedi sotto per la vista effettiva)
--
CREATE TABLE `detenuti_carcere` (
`Carcere` int(11)
,`Inizio` date
,`Data_trasferimento` date
,`CF` varchar(16)
,`Nome` varchar(255)
,`Cognome` varchar(255)
,`Data_nascita` date
,`Avvocato` varchar(16)
);

-- --------------------------------------------------------

--
-- Struttura della tabella `detenuto`
--

CREATE TABLE `detenuto` (
  `CF` varchar(16) NOT NULL,
  `Nome` varchar(255) DEFAULT NULL,
  `Cognome` varchar(255) DEFAULT NULL,
  `Data_nascita` date DEFAULT NULL,
  `Avvocato` varchar(16) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `detenuto`
--

INSERT INTO `detenuto` (`CF`, `Nome`, `Cognome`, `Data_nascita`, `Avvocato`) VALUES
('DJDSGU48L27B368T', 'Dario', 'Di Natale', '1983-12-25', 'LIESBT52S63G392V'),
('DPWHNX45R10L078A', 'Dino', 'Pasquale', '1969-10-18', 'RGGMFT93L70B138C'),
('FLLZFD92P47E431C', 'Filippo', 'Lorenzini', '1984-07-28', 'LIESBT52S63G392V'),
('FZGPJV31R30H997C', 'Francesco', 'Zirigo', '1980-05-25', 'NTRGZR46C62D614W'),
('GFNBFP54C59G672U', 'Gennaro', 'Bruno', '1986-08-15', 'MLZLGU78GG789HJK'),
('GTVXRS28C50A380D', 'Gianni', 'Attardo', '1990-01-17', 'RGGMFT93L70B138C'),
('NMBSLD39M18I732O', 'Giacomo', 'Andreini', '1995-11-16', 'MLZLGU78GG789HJK'),
('PVCFHK87H10G078J', 'Paolo', 'Marino', '1978-09-12', 'NNLCLD45P51F208T'),
('PWPQWL68A57L112K', 'Pietro', 'Mistretta', '1998-06-14', 'NNLCLD45P51F208T'),
('VJVNZM45C14D715K', 'Vincenzo', 'Pisano', '1985-10-30', 'NTRGZR46C62D614W');

-- --------------------------------------------------------

--
-- Struttura della tabella `detenuto_ag`
--

CREATE TABLE `detenuto_ag` (
  `Detenuto` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `detenuto_ag`
--

INSERT INTO `detenuto_ag` (`Detenuto`) VALUES
('DJDSGU48L27B368T'),
('DPWHNX45R10L078A'),
('FZGPJV31R30H997C'),
('NMBSLD39M18I732O'),
('PWPQWL68A57L112K');

-- --------------------------------------------------------

--
-- Struttura della tabella `detenuto_c`
--

CREATE TABLE `detenuto_c` (
  `Detenuto` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `detenuto_c`
--

INSERT INTO `detenuto_c` (`Detenuto`) VALUES
('FLLZFD92P47E431C'),
('GFNBFP54C59G672U'),
('GTVXRS28C50A380D'),
('PVCFHK87H10G078J'),
('VJVNZM45C14D715K');

-- --------------------------------------------------------

--
-- Struttura della tabella `direzione`
--

CREATE TABLE `direzione` (
  `Direttore` int(11) NOT NULL,
  `Carcere` int(11) DEFAULT NULL,
  `Data_inizio` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `direzione`
--

INSERT INTO `direzione` (`Direttore`, `Carcere`, `Data_inizio`) VALUES
(6, 1, '2011-05-12'),
(7, 2, '2004-07-11'),
(8, 3, '2008-08-08'),
(9, 4, '2018-10-09'),
(10, 5, '2016-07-05');

-- --------------------------------------------------------

--
-- Struttura della tabella `impiegato`
--

CREATE TABLE `impiegato` (
  `id` int(11) NOT NULL,
  `username` varchar(16) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `CF` varchar(16) DEFAULT NULL,
  `Nome` varchar(255) NOT NULL,
  `Cognome` varchar(255) NOT NULL,
  `Data_nascita` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `impiegato`
--

INSERT INTO `impiegato` (`id`, `username`, `password`, `email`, `CF`, `Nome`, `Cognome`, `Data_nascita`) VALUES
(1, 'ivanb', 'ivan@120', 'ivan1903@gmail.com', 'ZBKHGZ49R19G630Q', 'Ivan', 'Barbieri', '1980-12-11'),
(2, 'aleg', 'aleg#110', 'alegiacc@gmail.com', 'ZMXJZH94H03L500R', 'Alessio', 'Giaccone', '1995-12-10'),
(3, 'mariogen', 'mgen13@0', 'mariogentile@gmail.com', 'VZOMCV82D10G290F', 'Mario', 'Gentile', '2000-11-15'),
(4, 'marcom', 'ciao1824#', 'marcomark@gmail.com', 'SGRCDG87L18Z146F', 'Marco', 'Marconi', '1994-08-10'),
(5, 'francomi', 'franchino@86', 'franchino_mi@gmail.com', 'HJWYJW78C30F561R', 'Franco', 'Milano', '1990-10-08'),
(6, 'giacomodp', 'giacomino78@', 'giacomo_dp@gmail.com', 'RLHNDJ39S51E585G', 'Giacomo', 'Di Piero', '1996-05-11'),
(7, 'carlodb', 'carletto99#', 'carlodb@gmail.com', 'CJDVJY97A27A081O', 'Carlo', 'Di Bilio', '1987-07-12'),
(8, 'biagiogagl', 'biagino78@', 'biagio78@gmail.com', 'BKGRNM72T24A157K', 'Biagio', 'Gagliano', '1973-01-11'),
(9, 'riccardoro', 'riccardino55@', 'riccardo55@gmail.com', 'RVSQZG85M45B128L', 'Riccardo', 'Rosa', '1980-10-15'),
(10, 'kevinbu', 'kevin99#', 'kevinbu@gmail.com', 'KHSQHJ78A66A108Z', 'Kevin', 'Burgio', '2000-04-24'),
(11, 'luigi99', '$2y$10$0b/PD/jqSq0DXuxZmb.2keo81Dnwvd.imRrRky.dG.E6h/gXE6soK', 'gigi99mil@gmail.com', '', 'Luigi', 'Milazzo', '0000-00-00');

-- --------------------------------------------------------

--
-- Struttura della tabella `impiego`
--

CREATE TABLE `impiego` (
  `Carcere` int(11) NOT NULL,
  `Impiegato` int(11) NOT NULL,
  `Inizio` date NOT NULL,
  `Data_fine` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `impiego`
--

INSERT INTO `impiego` (`Carcere`, `Impiegato`, `Inizio`, `Data_fine`) VALUES
(1, 1, '2015-11-12', '2020-01-19'),
(1, 5, '1995-03-19', '2004-03-18'),
(2, 1, '2010-11-12', '2011-11-11'),
(2, 1, '2020-01-19', NULL),
(2, 2, '2010-12-10', NULL),
(3, 2, '2000-12-10', '2010-12-09'),
(3, 3, '2005-05-25', NULL),
(4, 3, '2003-05-25', '2005-05-24'),
(4, 4, '2006-10-12', NULL),
(5, 4, '1999-10-12', '2006-10-11'),
(5, 5, '2004-03-19', NULL);

-- --------------------------------------------------------

--
-- Struttura stand-in per le viste `imp_carcere`
-- (Vedi sotto per la vista effettiva)
--
CREATE TABLE `imp_carcere` (
`CF_impiegato` varchar(16)
,`Nome_impiegato` varchar(255)
,`Cognome_impiegato` varchar(255)
,`Data_nascita` date
,`Carcere` int(11)
,`Inizio` date
,`Data_fine` date
);

-- --------------------------------------------------------

--
-- Struttura della tabella `lavoro`
--

CREATE TABLE `lavoro` (
  `id_impiegato` int(11) NOT NULL,
  `carcere` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `lavoro`
--

INSERT INTO `lavoro` (`id_impiegato`, `carcere`) VALUES
(11, 1),
(11, 2),
(11, 3);

-- --------------------------------------------------------

--
-- Struttura della tabella `legge`
--

CREATE TABLE `legge` (
  `N_legge` int(11) NOT NULL,
  `N_articoli` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `legge`
--

INSERT INTO `legge` (`N_legge`, `N_articoli`) VALUES
(34, 60),
(201, 30),
(231, 40),
(309, 50),
(547, 25);

-- --------------------------------------------------------

--
-- Struttura della tabella `locazione`
--

CREATE TABLE `locazione` (
  `Detenuto` varchar(16) NOT NULL,
  `Carcere` int(11) NOT NULL,
  `Inizio` date NOT NULL,
  `Data_trasferimento` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `locazione`
--

INSERT INTO `locazione` (`Detenuto`, `Carcere`, `Inizio`, `Data_trasferimento`) VALUES
('DJDSGU48L27B368T', 5, '2000-08-12', '2009-08-11'),
('DJDSGU48L27B368T', 5, '2009-08-12', NULL),
('DPWHNX45R10L078A', 2, '2010-02-07', '2015-02-06'),
('DPWHNX45R10L078A', 3, '2015-02-07', NULL),
('FLLZFD92P47E431C', 2, '2010-11-15', '2015-11-14'),
('FLLZFD92P47E431C', 5, '2015-11-15', NULL),
('FZGPJV31R30H997C', 4, '1999-01-10', NULL),
('FZGPJV31R30H997C', 5, '1995-01-10', '1999-01-09'),
('GFNBFP54C59G672U', 1, '2005-10-13', NULL),
('GFNBFP54C59G672U', 2, '2003-10-13', '2005-10-12'),
('GTVXRS28C50A380D', 3, '2008-12-13', '2010-12-12'),
('GTVXRS28C50A380D', 4, '2010-12-13', NULL),
('NMBSLD39M18I732O', 1, '2012-10-15', NULL),
('NMBSLD39M18I732O', 4, '2012-10-15', '2012-10-14'),
('PVCFHK87H10G078J', 1, '2004-11-12', '2006-11-11'),
('PVCFHK87H10G078J', 2, '2006-11-12', NULL),
('PWPQWL68A57L112K', 2, '2000-12-17', NULL),
('PWPQWL68A57L112K', 3, '1990-12-17', '2000-12-16'),
('VJVNZM45C14D715K', 3, '2004-06-10', NULL),
('VJVNZM45C14D715K', 4, '2003-06-10', '2004-06-05');

-- --------------------------------------------------------

--
-- Struttura della tabella `pena`
--

CREATE TABLE `pena` (
  `Detenuto` varchar(16) NOT NULL,
  `Reato` int(11) NOT NULL,
  `Legge` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `pena`
--

INSERT INTO `pena` (`Detenuto`, `Reato`, `Legge`) VALUES
('DJDSGU48L27B368T', 5, 34),
('DPWHNX45R10L078A', 3, 231),
('FLLZFD92P47E431C', 5, 34),
('FZGPJV31R30H997C', 2, 309),
('GFNBFP54C59G672U', 1, 231),
('GTVXRS28C50A380D', 4, 231),
('NMBSLD39M18I732O', 6, 201),
('PVCFHK87H10G078J', 2, 309),
('PWPQWL68A57L112K', 7, 547),
('VJVNZM45C14D715K', 3, 231);

-- --------------------------------------------------------

--
-- Struttura della tabella `pigione`
--

CREATE TABLE `pigione` (
  `Detenuto` varchar(16) NOT NULL,
  `Cella` int(11) NOT NULL,
  `Inizio` date NOT NULL,
  `Data_trasferimento` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `pigione`
--

INSERT INTO `pigione` (`Detenuto`, `Cella`, `Inizio`, `Data_trasferimento`) VALUES
('DJDSGU48L27B368T', 2, '2016-06-10', '2018-06-09'),
('DJDSGU48L27B368T', 10, '2018-06-10', NULL),
('DPWHNX45R10L078A', 1, '2015-07-07', '2016-07-06'),
('DPWHNX45R10L078A', 9, '2016-07-07', NULL),
('FLLZFD92P47E431C', 5, '2009-04-08', NULL),
('FLLZFD92P47E431C', 7, '2005-04-08', '2009-04-07'),
('FZGPJV31R30H997C', 8, '2008-12-12', NULL),
('FZGPJV31R30H997C', 10, '2006-12-12', '2008-12-11'),
('GFNBFP54C59G672U', 1, '2015-05-10', NULL),
('GFNBFP54C59G672U', 3, '2010-05-10', '2015-05-09'),
('GTVXRS28C50A380D', 4, '2010-03-06', NULL),
('GTVXRS28C50A380D', 6, '2004-03-06', '2010-03-05'),
('NMBSLD39M18I732O', 6, '2005-04-23', NULL),
('NMBSLD39M18I732O', 8, '2000-04-23', '2005-04-22'),
('PVCFHK87H10G078J', 2, '2016-10-10', NULL),
('PVCFHK87H10G078J', 4, '2013-10-10', '2016-10-09'),
('PWPQWL68A57L112K', 7, '2007-11-10', NULL),
('PWPQWL68A57L112K', 9, '2006-11-10', '2007-11-09'),
('VJVNZM45C14D715K', 3, '2014-10-09', NULL),
('VJVNZM45C14D715K', 5, '2010-10-09', '2014-10-08');

--
-- Trigger `pigione`
--
DELIMITER $$
CREATE TRIGGER `allineamento_e_brule` AFTER INSERT ON `pigione` FOR EACH ROW begin
	if(select count(*) from pigione where Cella=new.Cella and Data_trasferimento IS NULL)<=2
	then update cella set Detenuti_presenti=Detenuti_presenti+1 where N_cella=new.Cella;
    else SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ogni cella può contenere al massimo due detenuti';
	end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `reato`
--

CREATE TABLE `reato` (
  `ID_reato` int(11) NOT NULL,
  `Nome` varchar(255) DEFAULT NULL,
  `Pena_scontare` int(11) DEFAULT NULL,
  `Categoria` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `reato`
--

INSERT INTO `reato` (`ID_reato`, `Nome`, `Pena_scontare`, `Categoria`) VALUES
(1, 'Omicidio', 21, 'Doloso'),
(2, 'Evasione fiscale', 8, 'Doloso'),
(3, 'Omicidio', 5, 'Colposo'),
(4, 'Stupro', 12, 'Doloso'),
(5, 'Detenzione di armi', 3, 'Doloso'),
(6, 'Spaccio', 4, 'Doloso'),
(7, 'Delitto informatico', 3, 'Doloso');

-- --------------------------------------------------------

--
-- Struttura della tabella `tmp`
--

CREATE TABLE `tmp` (
  `carcere` int(11) DEFAULT NULL,
  `conteggio` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura per vista `detenuti_carcere`
--
DROP TABLE IF EXISTS `detenuti_carcere`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `detenuti_carcere`  AS SELECT `l`.`Carcere` AS `Carcere`, `l`.`Inizio` AS `Inizio`, `l`.`Data_trasferimento` AS `Data_trasferimento`, `de`.`CF` AS `CF`, `de`.`Nome` AS `Nome`, `de`.`Cognome` AS `Cognome`, `de`.`Data_nascita` AS `Data_nascita`, `de`.`Avvocato` AS `Avvocato` FROM ((`locazione` `l` join `detenuto_ag` `d` on(`l`.`Detenuto` = `d`.`Detenuto`)) join `detenuto` `de` on(`d`.`Detenuto` = `de`.`CF`)) ;

-- --------------------------------------------------------

--
-- Struttura per vista `imp_carcere`
--
DROP TABLE IF EXISTS `imp_carcere`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `imp_carcere`  AS SELECT `i`.`CF` AS `CF_impiegato`, `i`.`Nome` AS `Nome_impiegato`, `i`.`Cognome` AS `Cognome_impiegato`, `i`.`Data_nascita` AS `Data_nascita`, `im`.`Carcere` AS `Carcere`, `im`.`Inizio` AS `Inizio`, `im`.`Data_fine` AS `Data_fine` FROM (`impiegato` `i` join `impiego` `im` on(`i`.`id` = `im`.`Impiegato`)) ;

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `avvocato`
--
ALTER TABLE `avvocato`
  ADD PRIMARY KEY (`CF_avvocato`);

--
-- Indici per le tabelle `carcere`
--
ALTER TABLE `carcere`
  ADD PRIMARY KEY (`ID_penitenziario`);

--
-- Indici per le tabelle `cella`
--
ALTER TABLE `cella`
  ADD PRIMARY KEY (`N_cella`);

--
-- Indici per le tabelle `colloquio_familiare`
--
ALTER TABLE `colloquio_familiare`
  ADD PRIMARY KEY (`ID_colloquio`),
  ADD KEY `idx_det` (`Detenuto`);

--
-- Indici per le tabelle `colloquio_reale`
--
ALTER TABLE `colloquio_reale`
  ADD PRIMARY KEY (`Data_colloquio`,`Colloquio`),
  ADD KEY `idx_col` (`Colloquio`);

--
-- Indici per le tabelle `commenti`
--
ALTER TABLE `commenti`
  ADD PRIMARY KEY (`id_commento`),
  ADD KEY `idx_ca` (`carcere`);

--
-- Indici per le tabelle `contenuti`
--
ALTER TABLE `contenuti`
  ADD PRIMARY KEY (`titolo`);

--
-- Indici per le tabelle `detenuto`
--
ALTER TABLE `detenuto`
  ADD PRIMARY KEY (`CF`),
  ADD KEY `idx_a` (`Avvocato`);

--
-- Indici per le tabelle `detenuto_ag`
--
ALTER TABLE `detenuto_ag`
  ADD PRIMARY KEY (`Detenuto`),
  ADD KEY `idx_prigioniero` (`Detenuto`);

--
-- Indici per le tabelle `detenuto_c`
--
ALTER TABLE `detenuto_c`
  ADD PRIMARY KEY (`Detenuto`),
  ADD KEY `idx_galeotto` (`Detenuto`);

--
-- Indici per le tabelle `direzione`
--
ALTER TABLE `direzione`
  ADD PRIMARY KEY (`Direttore`),
  ADD KEY `idx_dir` (`Direttore`),
  ADD KEY `idx_carc` (`Carcere`);

--
-- Indici per le tabelle `impiegato`
--
ALTER TABLE `impiegato`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indici per le tabelle `impiego`
--
ALTER TABLE `impiego`
  ADD PRIMARY KEY (`Carcere`,`Impiegato`,`Inizio`),
  ADD KEY `idx_ca` (`Carcere`),
  ADD KEY `idx_i` (`Impiegato`);

--
-- Indici per le tabelle `lavoro`
--
ALTER TABLE `lavoro`
  ADD PRIMARY KEY (`id_impiegato`,`carcere`),
  ADD KEY `idx_ca` (`carcere`),
  ADD KEY `idx_i` (`id_impiegato`);

--
-- Indici per le tabelle `legge`
--
ALTER TABLE `legge`
  ADD PRIMARY KEY (`N_legge`);

--
-- Indici per le tabelle `locazione`
--
ALTER TABLE `locazione`
  ADD PRIMARY KEY (`Detenuto`,`Carcere`,`Inizio`),
  ADD KEY `idx_de` (`Detenuto`),
  ADD KEY `idx_c` (`Carcere`);

--
-- Indici per le tabelle `pena`
--
ALTER TABLE `pena`
  ADD PRIMARY KEY (`Detenuto`,`Reato`,`Legge`),
  ADD KEY `idx_d` (`Detenuto`),
  ADD KEY `idx_r` (`Reato`),
  ADD KEY `idx_l` (`Legge`);

--
-- Indici per le tabelle `pigione`
--
ALTER TABLE `pigione`
  ADD PRIMARY KEY (`Detenuto`,`Cella`,`Inizio`),
  ADD KEY `idx_deten` (`Detenuto`),
  ADD KEY `idx_cel` (`Cella`);

--
-- Indici per le tabelle `reato`
--
ALTER TABLE `reato`
  ADD PRIMARY KEY (`ID_reato`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `commenti`
--
ALTER TABLE `commenti`
  MODIFY `id_commento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT per la tabella `impiegato`
--
ALTER TABLE `impiegato`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `colloquio_familiare`
--
ALTER TABLE `colloquio_familiare`
  ADD CONSTRAINT `colloquio_familiare_ibfk_1` FOREIGN KEY (`Detenuto`) REFERENCES `detenuto` (`CF`);

--
-- Limiti per la tabella `colloquio_reale`
--
ALTER TABLE `colloquio_reale`
  ADD CONSTRAINT `colloquio_reale_ibfk_1` FOREIGN KEY (`Colloquio`) REFERENCES `colloquio_familiare` (`ID_colloquio`);

--
-- Limiti per la tabella `commenti`
--
ALTER TABLE `commenti`
  ADD CONSTRAINT `commenti_ibfk_1` FOREIGN KEY (`carcere`) REFERENCES `carcere` (`ID_penitenziario`);

--
-- Limiti per la tabella `detenuto`
--
ALTER TABLE `detenuto`
  ADD CONSTRAINT `detenuto_ibfk_1` FOREIGN KEY (`Avvocato`) REFERENCES `avvocato` (`CF_avvocato`);

--
-- Limiti per la tabella `detenuto_ag`
--
ALTER TABLE `detenuto_ag`
  ADD CONSTRAINT `detenuto_ag_ibfk_1` FOREIGN KEY (`Detenuto`) REFERENCES `detenuto` (`CF`);

--
-- Limiti per la tabella `detenuto_c`
--
ALTER TABLE `detenuto_c`
  ADD CONSTRAINT `detenuto_c_ibfk_1` FOREIGN KEY (`Detenuto`) REFERENCES `detenuto` (`CF`);

--
-- Limiti per la tabella `direzione`
--
ALTER TABLE `direzione`
  ADD CONSTRAINT `direzione_ibfk_1` FOREIGN KEY (`Direttore`) REFERENCES `impiegato` (`id`),
  ADD CONSTRAINT `direzione_ibfk_2` FOREIGN KEY (`Carcere`) REFERENCES `carcere` (`ID_penitenziario`);

--
-- Limiti per la tabella `impiego`
--
ALTER TABLE `impiego`
  ADD CONSTRAINT `impiego_ibfk_1` FOREIGN KEY (`Carcere`) REFERENCES `carcere` (`ID_penitenziario`),
  ADD CONSTRAINT `impiego_ibfk_2` FOREIGN KEY (`Impiegato`) REFERENCES `impiegato` (`id`);

--
-- Limiti per la tabella `lavoro`
--
ALTER TABLE `lavoro`
  ADD CONSTRAINT `lavoro_ibfk_1` FOREIGN KEY (`carcere`) REFERENCES `carcere` (`ID_penitenziario`),
  ADD CONSTRAINT `lavoro_ibfk_2` FOREIGN KEY (`id_impiegato`) REFERENCES `impiegato` (`id`);

--
-- Limiti per la tabella `locazione`
--
ALTER TABLE `locazione`
  ADD CONSTRAINT `locazione_ibfk_1` FOREIGN KEY (`Detenuto`) REFERENCES `detenuto` (`CF`),
  ADD CONSTRAINT `locazione_ibfk_2` FOREIGN KEY (`Carcere`) REFERENCES `carcere` (`ID_penitenziario`);

--
-- Limiti per la tabella `pena`
--
ALTER TABLE `pena`
  ADD CONSTRAINT `pena_ibfk_1` FOREIGN KEY (`Detenuto`) REFERENCES `detenuto` (`CF`),
  ADD CONSTRAINT `pena_ibfk_2` FOREIGN KEY (`Reato`) REFERENCES `reato` (`ID_reato`),
  ADD CONSTRAINT `pena_ibfk_3` FOREIGN KEY (`Legge`) REFERENCES `legge` (`N_legge`);

--
-- Limiti per la tabella `pigione`
--
ALTER TABLE `pigione`
  ADD CONSTRAINT `pigione_ibfk_1` FOREIGN KEY (`Detenuto`) REFERENCES `detenuto` (`CF`),
  ADD CONSTRAINT `pigione_ibfk_2` FOREIGN KEY (`Cella`) REFERENCES `cella` (`N_cella`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
