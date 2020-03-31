-- Cleanup:
DROP TABLE IF EXISTS BestellPosition;
DROP TABLE IF EXISTS Bestellung;
DROP TABLE IF EXISTS Kunde;
DROP TABLE IF EXISTS Produkt;


-- Aufgabe 1:
CREATE TABLE Kunde (
    kNr NVARCHAR(20) NOT NULL CONSTRAINT pk_Kunde PRIMARY KEY,
    kName NVARCHAR(30) NOT NULL,
    kVorname NVARCHAR(30) NOT NULL,
    Adresse NVARCHAR(30) NULL,
    PLZ NCHAR(5) NULL,
    Stadt NVARCHAR(30) NULL
);

-- Aufgabe 2:
CREATE TABLE Produkt(
    pNr NVARCHAR(20) NOT NULL CONSTRAINT pk_Produkt PRIMARY KEY,
    pName NVARCHAR(30) NOT NULL,
    preis DECIMAL(19, 2) NOT NULL  -- Hier wäre auch MONEY denkbar, aber Angabe verlangt DECIMAL.

);

-- Aufgabe 3:
CREATE TABLE Bestellung (
    bNr NVARCHAR(20) NOT NULL CONSTRAINT pk_Bestellung PRIMARY KEY,
    kNr NVARCHAR(20) NOT NULL CONSTRAINT fk_Bestellung_Kunde FOREIGN KEY REFERENCES Kunde(kNr),
    bestellDatum DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    lieferDatum DATETIME NULL DEFAULT NULL,
    bezahlt BIT DEFAULT 0
);

-- Aufgabe 4:
CREATE TABLE BestellPosition (
    bNr NVARCHAR(20) NOT NULL,
    bpNr INT NOT NULL,
    pNr NVARCHAR(20) NOT NULL,
    anzahl INT NOT NULL,
    preis MONEY NOT NULL,
    gesamtpreis AS (anzahl * preis),
    CONSTRAINT pk_BestellPosition PRIMARY KEY (bNr, bpNr),
    CONSTRAINT fk_BestellPosition_Bestellung FOREIGN KEY (bNr) REFERENCES Bestellung(bNr),
    CONSTRAINT fk_BestellPosition_Produkt FOREIGN KEY (pNr) REFERENCES Produkt(pNr),
    CONSTRAINT ck_BestellPosition_anzahl CHECK (0 < anzahl)
);

-- Aufgabe 5:
INSERT INTO Kunde
    (kNr, kName, kVorname, Adresse, PLZ, Stadt)
VALUES
    ('10001000', 'Lustig', 'Peter', 'Elchwinkel 3', '65388', 'Bärstadt'),
    ('10001001', 'Traurig', 'Trude', 'Friedhofstr. 44', '44404', 'Dortmund');

-- Aufgabe 6:
INSERT INTO Produkt
    (pNr, pName, preis)
VALUES
    ('X100T234', 'Taschenlampe', 199.99),
    ('X100T235', 'Stirnlampe', 89.95),
    ('X100T236', 'Deckenlampe', 349.50),
    ('Y222T123', 'AAA Batterien 4er Packung', 2.99);

-- Aufgabe 7:
BEGIN
    DECLARE @reduzierter_preis DECIMAL(14, 2)
    SELECT @reduzierter_preis = (preis * 0.9) from Produkt
    WHERE pName LIKE 'Stirnlampe'

    INSERT INTO Bestellung
    (bNr, kNr, bestellDatum, lieferDatum, bezahlt)
    VALUES
    ('10000001', '10001000', '20.12.2017', '23.12.2017', 1)

    INSERT INTO BestellPosition
    (bNr, bpNr, pNr, anzahl, preis)
    VALUES
    ('10000001', '1', (SELECT pNr from Produkt WHERE pName LIKE 'Stirnlampe'), 1, @reduzierter_preis),
    ('10000001', '2', (SELECT pNr from Produkt WHERE pName LIKE '%AAA Batt%'), 4,(
        SELECT preis FROM Produkt WHERE pName LIKE '%AAA Batterien %'
        )
     )
END

-- Aufgabe 8:
BEGIN
    DECLARE @alte_adresse NVARCHAR(30)
    SELECT @alte_adresse = Adresse FROM Kunde
    WHERE kNr = '10001000'

    DECLARE @strasse NVARCHAR(30)
    SELECT @strasse = SUBSTRING(@alte_adresse, 1, (CharIndex('3', @alte_adresse) - 2))

    UPDATE Kunde
    SET Adresse = CONCAT(@strasse, ' ', '4')
    WHERE kNr = '10001000'
end

-- Aufgabe 9:
/*
 Aufgrund der Fremdschlüssel Bedingungen können die Tupel nicht gelöscht werden.
 */
BEGIN
    BEGIN TRY
        DELETE FROM Kunde
        WHERE kNr = '10001000'
    end try
    begin catch
        print N'Konnte Kunden nicht löschen.'
    end catch

    BEGIN TRY
        DELETE FROM Produkt
        WHERE pNr = 'Y222T123'
    END TRY
    BEGIN CATCH
        PRINT N'Konnte Produkt nicht löschen.'
    END CATCH

    BEGIN TRY
        DELETE FROM Bestellung
        WHERE bNr = '10000001'
    END TRY
    BEGIN CATCH
        PRINT N'Konnte Bestellung nicht löschen.'
    END CATCH
END