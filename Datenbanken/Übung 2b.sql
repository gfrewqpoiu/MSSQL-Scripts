-- Cleanup:
DROP TABLE IF EXISTS arbeiten;
DROP TABLE IF EXISTS mitarbeiter;
DROP TABLE IF EXISTS projekt;
DROP TABLE IF EXISTS abteilung;
-- Aufgabe 1
CREATE TABLE abteilung (
abt_nr NVARCHAR(4) NOT NULL PRIMARY KEY,
abt_name NVARCHAR(20) NOT NULL,
stadt NVARCHAR(15) NULL);
-- Alternative:
CREATE TABLE abteilung (
abt_nr NVARCHAR(4) NOT NULL,
abt_name NVARCHAR(20) NOT NULL,
stadt NVARCHAR(15) NULL,
CONSTRAINT pk_abteilung PRIMARY KEY (abt_nr)
);
-- Aufgabe 2:
CREATE TABLE projekt (
pr_nr NVARCHAR(4) NOT NULL,
pr_name NVARCHAR(25) NOT NULL,
mittel NUMERIC(14, 2) NULL,
CONSTRAINT pk_projekt PRIMARY KEY (pr_nr)
);
-- Aufgabe 3:
CREATE TABLE mitarbeiter (
m_nr INT NOT NULL CONSTRAINT pk_mitarbeiter PRIMARY KEY,
m_name NVARCHAR(20) NOT NULL,
m_vorname NVARCHAR(20) NOT NULL,
abt_nr NVARCHAR(4) NULL CONSTRAINT fk_mitarbeiter_abteilung FOREIGN KEY REFERENCES abteilung(abt_nr)
);
-- Aufgabe 4:
CREATE TABLE arbeiten (
m_nr INT NOT NULL,
pr_nr NVARCHAR(4) NOT NULL,
aufgabe NVARCHAR(15) NULL,
einst_datum DATE NULL,
CONSTRAINT pk_arbeiten PRIMARY KEY (m_nr, pr_nr),
CONSTRAINT fk_arbeiten_mitarbeiter FOREIGN KEY (m_nr) REFERENCES mitarbeiter(m_nr),
CONSTRAINT fk_arbeiten_projekt FOREIGN KEY (pr_nr) REFERENCES projekt(pr_nr)
);
-- Aufgabe 5:
DROP TABLE IF EXISTS systeme;
CREATE TABLE systeme (
sys_name NVARCHAR(15) NOT NULL CONSTRAINT pk_systeme PRIMARY KEY,
art INT NULL,
hersteller NVARCHAR(20) NULL
);
-- Aufgabe 6:
ALTER TABLE systeme
ALTER COLUMN art NVARCHAR(max) NULL;
ALTER TABLE systeme
ALTER COLUMN hersteller NVARCHAR(20) NOT NULL;
-- Aufgabe 7:
ALTER TABLE systeme
ADD ort VARCHAR(15) NULL;
-- Aufgabe 8:
DROP TABLE IF EXISTS adressen;
CREATE TABLE adressen (
name VARCHAR(15) NOT NULL,
vorname VARCHAR(15) NOT NULL,
strasse VARCHAR(20) NULL,
PLZ VARCHAR(4) NOT NULL,
stadt VARCHAR(25) NULL
);
-- Aufgabe 9:
ALTER TABLE adressen
ALTER COLUMN plz NVARCHAR(5) NOT NULL;
-- Aufgabe 10:
ALTER TABLE adressen
ADD CONSTRAINT pk_adressen PRIMARY KEY (name, vorname);
-- Aufgabe 11:
-- noinspection SqlAddNotNullColumn
ALTER TABLE adressen
ADD hausnr NVARCHAR(4) NOT NULL;
-- Aufgabe 12:
ALTER TABLE adressen
DROP COLUMN stadt;
-- Aufgabe 13:
DROP TABLE IF EXISTS adressen;
/* Prüfen geht mit:
   SELECT * FROM adressen; Wenn das keinen Fehler gibt, dann ist was schiefgelaufen.
 */
-- Aufgabe 15:
INSERT INTO abteilung
(abt_nr, abt_name, stadt)
VALUES
('a1', 'Beratung', N'München'),
('a2', 'Diagnose', N'München'),
('a3', 'Freigabe', 'Stuttgart')
;
-- Aufgabe 16:
INSERT INTO projekt
(pr_nr, pr_name, mittel)
VALUES
('p1', 'Apollo', 120000),
('p2', 'Gemini', 95000),
('p3', 'Merkur', 186500)

-- Aufgabe 17:
INSERT INTO mitarbeiter
(m_nr, m_name, m_vorname, abt_nr)
VALUES
    (25348, 'Keller', 'Hans', 'a3'),
    (10102, 'Huber', 'Petra', 'a3'),
    (18316, N'Müller', 'Gabriele', 'a1'),
    (29346, 'Probst', 'Andreas', 'a2'),
    (9031, 'Meier', 'Rainer', 'a2'),
    (2581, 'Kaufmann', 'Brigitte', 'a2'),
    (28559, 'Mozer', 'Sibille', 'a1');

-- Aufgabe 18:
INSERT INTO mitarbeiter
(m_nr, m_name, m_vorname, abt_nr)
VALUES
    (22222, 'Ott', 'Bob', 'a2');

-- Aufgabe 19:
INSERT INTO mitarbeiter
(m_nr, m_name, m_vorname, abt_nr)
VALUES
    (11111, 'Lang', 'Jutta', NULL);

-- Aufgabe 20:
UPDATE abteilung
SET stadt = N'Nürnberg'
WHERE abt_nr = 'a2';

-- Aufgabe 21:
INSERT INTO arbeiten
(m_nr, pr_nr, aufgabe, einst_datum)
VALUES
    (10102, 'p1', 'Projektleiter', '01.10.1988'),
    (10102, 'p3', 'Gruppenleiter', '01.01.1989'),
    (25348, 'p2', 'Sachbearbeiter', '15.02.1988'),
    (18316, 'p2', NULL, '01.06.1989'),
    (29346, 'p2', NULL, '15.12.1987'),
    (2581, 'p3', 'Projektleiter', '15.10.1989'),
    (9031, 'p1', 'Gruppenleiter', '14.04.1989'),
    (28559, 'p1', NULL, '01.08.1988'),
    (28559, 'p3', 'Sachbearbeiter', '01.02.1989'),
    (9031, 'p3', 'Sachbearbeiter', '15.11.1988'),
    (29346, 'p1', 'Sachbearbeiter', '01.04.1989');

/*-- Aufgabe 22:
UPDATE arbeiten
SET aufgabe = N'QA-Beauftragter'
WHERE aufgabe IS NULL;

-- Aufgabe 23:
DELETE FROM arbeiten
WHERE pr_nr = 'p3';
DELETE FROM projekt
WHERE pr_nr = 'p3';

-- Aufgabe 24:
UPDATE mitarbeiter
SET abt_nr = NULL;
DELETE FROM abteilung;

-- Aufgabe 25:
DROP TABLE IF EXISTS #person;
CREATE TABLE #person(
    nachname NVARCHAR(15) NOT NULL,
    vorname NVARCHAR(15) NOT NULL,
    strasse NVARCHAR(20) NULL
);*/