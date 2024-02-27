/*
Task 2: Descrivi la struttura delle tabelle che reputi utili e sufficienti a modellare lo scenario proposto tramite la sintassi DDL.
Implementa fisicamente le tabelle utilizzando il DBMS SQL Server (o altro).
*/

--Creo il database
CREATE DATABASE ToysGroup;

--Passiamo dentro al database appena creato
USE ToysGroup;

--Creo la tabella Categories
/*
Short Description: tabella a livello 1 (parent), troviamo una PK e una nomenclatura di ogni categoria esistente
*/
CREATE TABLE Categories
(
    CategoryID          INT NOT NULL,
    CategoryName        VARCHAR(20) NOT NULL

    CONSTRAINT PK_Categories PRIMARY KEY (CategoryID)
);

--Creo la tabella Product
/*
Short Description: tabella a livello 2 (child), troviamo una PK e una FK che punta alla PK di Categories. Inoltre troviamo una descrizione
del nome del prodotto, un cambo booleano per definire se il prodotto è finito (quindi vendibile) o no, e infine il costo standard di produzione.
*/
CREATE TABLE Products
(
    ProductID           INT NOT NULL,
    ProductName         VARCHAR(35) NOT NULL,
    CategoryID          INT NOT NULL,
    FinishedGoodFlag    BIT NOT NULL,
    StandardCost        MONEY,

    CONSTRAINT PK_Products PRIMARY KEY (ProductID),
    CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryID)
        REFERENCES Categories (CategoryID)
);

--Creo la tabella Regions
/*
Short Description: tabella a livello 1 (parent), esiste una PK e una FK che può essere NULL; la FK rimanda alla PK della stessa tabella.
Ho fatto questa scelta pur non essendo la più "semplice" o "immediata" solo con in mente l'idea di rispettare lo standard di normalizzazione.
Per essere poi intellettualmente onesto con me stesso, la tabella Regions di conseguenza avrebbe più senso se intitolata Zones o SaleZone.
Un altro motivo che mi ha portato a questa scelta è per utilizzare un po' tutti i concetti studiati nel modulo, compresa la selfjoin che
utilizzerò nella vista per denormalizzare pre analisi, al contrario di Products e Categories che invece sono divise utilizzando un altro approccio.
*/
CREATE TABLE Regions
(
    RegionID            INT NOT NULL,
    RegionName          VARCHAR(25) NOT NULL,
    ShortName           VARCHAR(3),
    StateID             INT,

    CONSTRAINT PK_Regions PRIMARY KEY (RegionID),
    CONSTRAINT FK_Regions_Regions FOREIGN KEY (StateID)
        REFERENCES Regions (RegionID)
);

--Creo la tabella Sales
/*
Short Description: tabella a livello 3 (child di Products), esiste una PK di ogni ordine, una FK che rimanda alla PK di Products
e una seconda FK che rimanda alla PK di Regions. Inoltre un attributo SalesAmount a quantificare il totale in denaro dell'ordine
e la data di acquisto in formato DATE, quindi senza ore, minuti e secondi.
Ho voluto aggiungere la proprietà IDENTITY alla PK di Sales come controllo in più. Se non ho capito male il suo funzionamento,
dovrebbe garantire una sicurezza in più inserendo i dati automaticamente in Sales, cioè quando si inserisce un nuovo record il campo
OrderID verrà automaticamente riempito partendo dal valore del record precedente e aggiungendo 1. Questo perchè se non specificato
il default di IDENTITY è (1,1) dove il primo indica da quale valore partire nel caso non ci fosse un precedente, e il secondo è il "passo"
*/
CREATE TABLE Sales
(
    OrderID             INT NOT NULL IDENTITY,
    ProductID           INT NOT NULL,
    RegionID            INT NOT NULL,
    SalesAmount         MONEY NOT NULL,
    OrderDate           DATE NOT NULL,

    CONSTRAINT PK_Sales PRIMARY KEY (OrderID),
    CONSTRAINT FK_Sales_Products FOREIGN KEY (ProductID)
        REFERENCES Products (ProductID),
    CONSTRAINT FK_Sales_Regions FOREIGN KEY (RegionID)
        REFERENCES Regions (RegionID)
);

/*
Task 3: Popola le tabelle utilizzando dati a tua discrezione (sono sufficienti pochi record per tabella; riporta le query utilizzate)
*/

/*
Per creare e popolare le tabelle ho fatto riferimento allo script utile a ricreare il db di Esercizi del libro TSQL Fundamentals di 
Itzik Ben-Gan. Sottolineo questo per far notare che sono al corrente di poter inserire diversi record all'interno di una tabella con solo
uno statement INSERT aggiungengo qualche virgola dopo ogni set di valori, dividendoli però siamo più sicuri e riduciamo il margine di errore.
*/
--Popolo la tabella Categories
INSERT INTO Categories (CategoryID, CategoryName)
    VALUES (1, 'Giochi da Tavolo');
INSERT INTO Categories (CategoryID, CategoryName)
    VALUES (2, 'Giochi a Batterie');
INSERT INTO Categories (CategoryID, CategoryName)
    VALUES (3, 'Giochi per Neonati');
INSERT INTO Categories (CategoryID, CategoryName)
    VALUES (4, 'Bambole');
INSERT INTO Categories (CategoryID, CategoryName)
    VALUES (5, 'Action Figures');
INSERT INTO Categories (CategoryID, CategoryName)
    VALUES (6, 'Pistole ad Acqua');

--Popolo la tabella Products
INSERT INTO Products (ProductID, ProductName, CategoryID, FinishedGoodFlag, StandardCost)
    VALUES (1, 'Monopoly', 1, 1, 15.00);
INSERT INTO Products (ProductID, ProductName, CategoryID, FinishedGoodFlag, StandardCost)
    VALUES (2, 'Risiko', 1, 1, 17.50);
INSERT INTO Products (ProductID, ProductName, CategoryID, FinishedGoodFlag, StandardCost)
    VALUES (3, 'Ferrari radiocomandata', 2, 1, 33.00);
INSERT INTO Products (ProductID, ProductName, CategoryID, FinishedGoodFlag, StandardCost)
    VALUES (4, 'Drone XYZ', 2, 1, 58.00);
INSERT INTO Products (ProductID, ProductName, CategoryID, FinishedGoodFlag, StandardCost)
    VALUES (5, 'Paperella di gomma gialla', 3, 1, 3.35);
INSERT INTO Products (ProductID, ProductName, CategoryID, FinishedGoodFlag, StandardCost)
    VALUES (6, 'Il Libro delle Forme', 3, 1, 12.50);
INSERT INTO Products (ProductID, ProductName, CategoryID, FinishedGoodFlag, StandardCost)
    VALUES (7, 'Barbie Influencer', 4, 1, 35.30);
INSERT INTO Products (ProductID, ProductName, CategoryID, FinishedGoodFlag, StandardCost)
    VALUES (8, 'Cicciobello', 4, 1, 23.00);
INSERT INTO Products (ProductID, ProductName, CategoryID, FinishedGoodFlag, StandardCost)
    VALUES (9, 'Batman', 5, 1, 25.50);
INSERT INTO Products (ProductID, ProductName, CategoryID, FinishedGoodFlag, StandardCost)
    VALUES (10, 'Iron Man', 5, 1, 22.45);
INSERT INTO Products (ProductID, ProductName, CategoryID, FinishedGoodFlag, StandardCost)
    VALUES (11, 'SuperLiquidator', 6, 1, 50.00);
INSERT INTO Products (ProductID, ProductName, CategoryID, FinishedGoodFlag, StandardCost)
    VALUES (12, 'WaterSniper', 6, 1, 55.00);

--Popolo la tabella Regions
INSERT INTO Regions (RegionID, RegionName, ShortName, StateID)
    VALUES (1, 'North America', 'NA', NULL);
INSERT INTO Regions (RegionID, RegionName, ShortName, StateID)
    VALUES (2, 'Europe', 'EU', NULL);
INSERT INTO Regions (RegionID, RegionName, ShortName, StateID)
    VALUES (3, 'Asia', 'AS', NULL);
INSERT INTO Regions (RegionID, RegionName, ShortName, StateID)
    VALUES (4, 'Oceania', 'OC', NULL);
INSERT INTO Regions (RegionID, RegionName, ShortName, StateID)
    VALUES (5, 'United States of America', 'USA', 1);
INSERT INTO Regions (RegionID, RegionName, ShortName, StateID)
    VALUES (6, 'Canada', 'CA', 1);
INSERT INTO Regions (RegionID, RegionName, ShortName, StateID)
    VALUES (7, 'Italy', 'IT', 2);
INSERT INTO Regions (RegionID, RegionName, ShortName, StateID)
    VALUES (8, 'France', 'FR', 2);
INSERT INTO Regions (RegionID, RegionName, ShortName, StateID)
    VALUES (9, 'China', 'CH', 3);
INSERT INTO Regions (RegionID, RegionName, ShortName, StateID)
    VALUES (10, 'India', 'ROI', 3);
INSERT INTO Regions (RegionID, RegionName, ShortName, StateID)
    VALUES (11, 'Australia', 'AU', 4);
INSERT INTO Regions (RegionID, RegionName, ShortName, StateID)
    VALUES (12, 'New Zeland', 'NZ', 4);

--Popolo la tabella Sales
/*
Avendo usato la proprietà IDENTITY, ora dobbiamo abilitarne la modifica prima di poter inserire i dati manualmente nel campo chiave,
successivamente bisogna disabilitarla. In un caso reale, il manager andrebbe in errore se provassimo ad aprire una seconda IDENTITY_INSERT
con una prima già aperta.
*/
SET IDENTITY_INSERT Sales ON;
INSERT INTO Sales (OrderID, ProductID, RegionID, SalesAmount, OrderDate)
    VALUES (1, 1, 5, 45.00, '20220907');
INSERT INTO Sales (OrderID, ProductID, RegionID, SalesAmount, OrderDate)
    VALUES (2, 1, 6, 45.00, '20221130');
INSERT INTO Sales (OrderID, ProductID, RegionID, SalesAmount, OrderDate)
    VALUES (3, 2, 7, 52.50, '20221222');
INSERT INTO Sales (OrderID, ProductID, RegionID, SalesAmount, OrderDate)
    VALUES (4, 3, 8, 99.00, '20221223');
INSERT INTO Sales (OrderID, ProductID, RegionID, SalesAmount, OrderDate)
    VALUES (5, 4, 9, 174.00, '20230130');
INSERT INTO Sales (OrderID, ProductID, RegionID, SalesAmount, OrderDate)
    VALUES (6, 5, 10, 10.05, '20230218');
INSERT INTO Sales (OrderID, ProductID, RegionID, SalesAmount, OrderDate)
    VALUES (7, 5, 11, 10.05, '20230219');
INSERT INTO Sales (OrderID, ProductID, RegionID, SalesAmount, OrderDate)
    VALUES (8, 6, 12, 37.50, '20230824');
INSERT INTO Sales (OrderID, ProductID, RegionID, SalesAmount, OrderDate)
    VALUES (9, 7, 7, 105.90, '20231017');
INSERT INTO Sales (OrderID, ProductID, RegionID, SalesAmount, OrderDate)
    VALUES (10, 8, 5, 69.00, '20240102');
INSERT INTO Sales (OrderID, ProductID, RegionID, SalesAmount, OrderDate)
    VALUES (11, 9, 9, 76.50, '20240104');
INSERT INTO Sales (OrderID, ProductID, RegionID, SalesAmount, OrderDate)
    VALUES (12, 10, 10, 67.35, '20240112');
INSERT INTO Sales (OrderID, ProductID, RegionID, SalesAmount, OrderDate)
    VALUES (13, 11, 6, 150.00, '20240123');
INSERT INTO Sales (OrderID, ProductID, RegionID, SalesAmount, OrderDate)
    VALUES (14, 9, 8, 76.50, '20240125');
INSERT INTO Sales (OrderID, ProductID, RegionID, SalesAmount, OrderDate)
    VALUES (15, 9, 7, 76.50, '20240126');
SET IDENTITY_INSERT Sales OFF;

SELECT *
FROM Products
/*
Task 4: Dopo aver popolate le tabelle, scrivi delle query utili a: (ho deciso di incominciare dal punto 8 e 9 per creare ora le viste
        in modo da poterle utilizzare nelle query successive)

8)	Creare una vista sui prodotti in modo tale da esporre una “versione denormalizzata” delle informazioni utili 
    (codice prodotto, nome prodotto, nome categoria)
*/
CREATE VIEW VW_RP_Products_Categories AS (
    SELECT p.ProductID, p.ProductName, c.CategoryID, c.CategoryName
    FROM Products AS p
    LEFT JOIN Categories AS c
    ON p.CategoryID = c.CategoryID
);

/*
9)	Creare una vista per restituire una versione “denormalizzata” delle informazioni geografiche
*/
CREATE VIEW VW_RP_Regions_States AS (
    SELECT
        r1.RegionID,
        r1.RegionName AS StateName,
        r1.ShortName AS ShortStateName,
        r2.RegionName,
        r2.ShortName AS ShortRegionName
    FROM Regions AS r1
    INNER JOIN Regions AS r2
    ON r1.StateID = r2.RegionID
);

/*
1)	Verificare che i campi definiti come PK siano univoci. In altre parole,
    scrivi una query per determinare l’univocità dei valori di ciascuna PK (una query per tabella implementata).
*/
--UNIQUE PK_Categories (il result set deve essere vuoto)
SELECT COUNT(*) AS Count
FROM Categories
GROUP BY CategoryID
HAVING COUNT(*) > 1;

--UNIQUE PK_Products
SELECT COUNT(*) AS Count
FROM Products
GROUP BY ProductID
HAVING COUNT(*) > 1;

--UNIQUE PK_Regions
SELECT COUNT(*) AS Count
FROM Regions
GROUP BY RegionID
HAVING COUNT(*) > 1;

--UNIQUE PK_Sales
SELECT COUNT(*) AS Count
FROM Sales
GROUP BY OrderID
HAVING COUNT(*) > 1;

/*
2)	Esporre l’elenco delle transazioni indicando nel result set il codice documento, la data, il nome del prodotto, la categoria del prodotto,
    il nome dello stato, il nome della regione di vendita e un campo booleano valorizzato in base alla condizione 
    che siano passati più di 180 giorni dalla data vendita o meno (>180 -> True, <= 180 -> False)
*/
SELECT
    s.OrderID,
    s.OrderDate,
    pc.ProductName,
    pc.CategoryName,
    rs.RegionName,
    CASE
        WHEN DATEDIFF(DAY, s.OrderDate, GETDATE()) > 180 THEN 'True'
        ELSE 'False'
    END AS Expired
FROM Sales AS s
INNER JOIN VW_RP_Products_Categories AS pc
ON s.ProductID = pc.ProductID
INNER JOIN VW_RP_Regions_States AS rs
ON s.RegionID = rs.RegionID;

/*
3)	Esporre l’elenco dei soli prodotti venduti e per ognuno di questi il fatturato totale per anno
*/

SELECT
    p.ProductID,
    YEAR(s.OrderDate) AS Year,
    SUM(s.SalesAmount) AS TotalAmount
FROM Products AS p
INNER JOIN Sales AS s
ON p.ProductID = s.ProductID
GROUP BY p.ProductID, YEAR(s.OrderDate);

/*
4)	Esporre il fatturato totale per stato per anno. Ordina il risultato per data e per fatturato decrescente.
*/

SELECT
    rs.RegionID,
    YEAR(OrderDate) AS Year,
    SUM(s.SalesAmount) AS TotalAmount
FROM Sales AS s
INNER JOIN VW_RP_Regions_States AS rs
ON s.RegionID = rs.RegionID
GROUP BY rs.RegionID, YEAR(s.OrderDate)
ORDER BY YEAR(s.OrderDate), TotalAmount DESC;

/*
5)	Rispondere alla seguente domanda: qual è la categoria di articoli maggiormente richiesta dal mercato?
Credo che la risposta sia che la più richiesta dal mercato è la categoria che conta più vendite, quindi aggrego per category contando ogni riga.
Inserisco diversi approcci al problema, alcuni con sintassi che non abbiamo visto ma che ho studiato sul libro T-SQL fundamentals 
consigliato da Luca Canonico
*/

--Versione "incompleta", restituisce solo il max count di ogni transazione gruppata per categoria. Incompleta perchè il dato non è parlante
SELECT MAX(s1.MostSales) AS MostSales
FROM (
    SELECT CategoryName, COUNT(*) AS MostSales
    FROM VW_RP_Products_Categories AS pc
    INNER JOIN Sales AS s
    ON pc.ProductID = s.ProductID
    GROUP BY CategoryName
) AS s1;

--Versione con OFFSET/FETCH filter
SELECT CategoryName, COUNT(*) AS MostSales
FROM VW_RP_Products_Categories AS pc
INNER JOIN Sales AS s
ON pc.ProductID = s.ProductID
GROUP BY CategoryName
ORDER BY MostSales DESC 
    OFFSET 0 ROWS FETCH NEXT 1 ROW ONLY;

--Stessa cosa della coppia SELECT TOP (1) E ORDER BY
SELECT  TOP 1 CategoryName, COUNT(*) AS MostSales
FROM VW_RP_Products_Categories AS pc
INNER JOIN Sales AS s
ON pc.ProductID = s.ProductID
GROUP BY CategoryName
ORDER BY MostSales DESC;

/*
6)	Rispondere alla seguente domanda: quali sono, se ci sono, i prodotti invenduti? Proponi due approcci risolutivi differenti.
Ho evitato di inserire appositamente nella tabella Sales una transazione con il prodotto 12-'WaterSniper'
*/

/*
Versione con left "anti" join, semplicemente pongo un filtro su un campo "NULL" della tabella di destra (Sales),
così da mostrare i record che esistono solo in quella di sinistra (Product).
*/
SELECT
    pc.ProductID,
    pc.ProductName,
    pc.CategoryName
FROM VW_RP_Products_Categories AS pc
LEFT JOIN Sales AS s
ON pc.ProductID = s.ProductID
WHERE s.OrderDate IS NULL;

/*
Versione con NOT EXIST e subquery. Nella query esterna si richiama la tabella prodotti e si filtra per tutti i valori che NON esistono
incrociati con la tabella sales tramite la ProductID nella subquery. Molto meno intuitivo dal momento che i filtri lavorano solo con
i valori True e dobbiamo usare la negazione. Il PRO è certamente il fatto che non si utilizza una JOIN
*/
SELECT
    pc.ProductID,
    pc.ProductName,
    pc.CategoryName
FROM VW_RP_Products_Categories AS pc
WHERE NOT EXISTS (
    SELECT s.ProductID
    FROM Sales AS s
    WHERE pc.ProductID = s.ProductID
);

/*
7)	Esporre l’elenco dei prodotti con la rispettiva ultima data di vendita (la data di vendita più recente).
*/

--Versione con subquery dipendente
SELECT
    s1.ProductID,
    pc.ProductName,
    s1.OrderDate AS LastOrderDate
FROM Sales AS s1
INNER JOIN VW_RP_Products_Categories AS pc
ON s1.ProductID = pc.ProductID
WHERE s1.OrderDate IN (
    SELECT MAX(s2.OrderDate)
    FROM Sales AS s2
    WHERE s1.ProductID = s2.ProductID
);

/*
10)	Esercizio opzionale: ottenute le viste per la costruzione delle dimensioni di analisi prodotto (punto 8)  e area geografica (punto 9),
implementa un modello logico in Power Query e costruisci un report per l’analisi delle vendite
*/
--Di seguito riporto le query che mi servono per importare i dati su EXCEL

--Dim Prodotto
SELECT *
FROM VW_RP_Products_Categories;

--Dim Regione
SELECT *
FROM VW_RP_Regions_States;

--Fact Sales
SELECT *
FROM Sales;

