## Case Study
ToysGroup è un’azienda che distribuisce articoli (giocatoli) in diverse aree geografiche del mondo.  
I prodotti sono classificati in categorie e i mercati di riferimento dell’azienda sono classificati in regioni di vendita.  
In particolare:
1)	Le entità individuabili in questo scenario sono le seguenti:
	-	Product
	-	Region
	-	Sales

2)	Le relazioni tra le entità possono essere descritte nel modo seguente:
	-	Product e Sales  
		Un prodotto puo’ essere venduto tante volte (o nessuna) per cui è contenuto in una o più transazioni di vendita.  
		Ciascuna transazione di vendita è riferita ad uno solo prodotto
	-	Region e Sales  
		Possono esserci molte o nessuna transazione per ciascuna regione  
		Ciascuna transazione di vendita è riferita ad una sola regione

3)	Le entità Product e Region presentano delle gerarchie:
	-	L’entità prodotto contiene, oltre alle informazioni del singolo prodotto, anche la descrizione della categoria di appartenenza. L’entità prodotto contiene quindi una gerarchia: un prodotto puo’ appartenere ad una sola categoria mentre la stessa categoria puo’ essere associata a molti prodotti diversi.  
Esempio: gli articoli ‘Bikes-100’ e ‘Bikes-200’ appartengono alla categoria Bikes; gli articoli ‘Bike Glove M’ e ‘Bike Gloves L’ sono classificati come Clothing.
	-	L’entità regione contiene una gerarchia: più stati sono classificati in una stessa regione di vendita e una stessa regione di vendita include molti stati.  
Esempio: gli stati ‘France’ e ‘Germany’ sono classificati nella region WestEurope; gli stati ‘Italy’ e ‘Greece’ sono classificati nel mercato SouthEurope.

È necessario progettare e implementare fisicamente un database che modelli lo scenario garantendo l’integrità referenziale e la minimizzazione della ridondanza dei dati.
In altre parole, progetta opportunamente un numero di tabelle e di relazioni tra queste sufficiente a garantire la consistenza del dato.

*Task 1: Proponi una progettazione concettuale e logica della base dati*  
La progettazione concettuale deve includere tutte le entità coinvolte e le relazioni tra queste. Per ciascuna entità indica l’attributo chiave e i principali attributi descrittivi (non è necessario indicare tutti gli attributi).  
La progettazione logica deve includere, per ciascuna tabella, tutte le colonne che poi verranno implementate fisicamente e deve esplicitare la cardinalità dei campi utilizzati per definire la relazione.

*Task 2: Descrivi la struttura delle tabelle che reputi utili e sufficienti a modellare lo scenario proposto tramite la sintassi DDL. Implementa fisicamente le tabelle utilizzando il DBMS SQL Server (o altro).*

*Task 3: Popola le tabelle utilizzando dati a tua discrezione (sono sufficienti pochi record per tabella; riporta le query utilizzate)* 

*Task 4: Dopo aver popolate le tabelle, scrivi delle query utili a:*  
1)	Verificare che i campi definiti come PK siano univoci. In altre parole, scrivi una query per determinare l’univocità dei valori di ciascuna PK (una query per tabella implementata).
2)	Esporre l’elenco delle transazioni indicando nel result set il codice documento, la data, il nome del prodotto, la categoria del prodotto, il nome dello stato, il nome della regione di vendita e un campo booleano valorizzato in base alla condizione che siano passati più di 180 giorni dalla data vendita o meno (>180 -> True, <= 180 -> False)
3)	Esporre l’elenco dei soli prodotti venduti e per ognuno di questi il fatturato totale per anno. 
4)	Esporre il fatturato totale per stato per anno. Ordina il risultato per data e per fatturato decrescente.
5)	Rispondere alla seguente domanda: qual è la categoria di articoli maggiormente richiesta dal mercato?
6)	Rispondere alla seguente domanda: quali sono, se ci sono, i prodotti invenduti? Proponi due approcci risolutivi differenti.
7)	Esporre l’elenco dei prodotti cona la rispettiva ultima data di vendita (la data di vendita più recente).
8)	Creare una vista sui prodotti in modo tale da esporre una “versione denormalizzata” delle informazioni utili (codice prodotto, nome prodotto, nome categoria)
9)	Creare una vista per restituire una versione “denormalizzata” delle informazioni geografiche
10)	Esercizio opzionale: ottenute le viste per la costruzione delle dimensioni di analisi prodotto (punto 8)  e area geografica (punto 9), implementa un modello logico in Power Query e costruisci un report per l’analisi delle vendite
