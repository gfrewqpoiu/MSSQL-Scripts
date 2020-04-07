-- Aufgabe 6
SELECT m_nr from arbeiten
WHERE aufgabe = 'Projektleiter';
-- Aufgabe 7
SELECT m_nr FROM arbeiten
WHERE pr_nr = 'p1' OR pr_nr = 'p2'
-- Aufgabe 8
SELECT m_nr from arbeiten
WHERE pr_nr = 'p1' AND aufgabe = 'Projektleiter'
-- Aufgabe 9
SELECT m_nr, aufgabe from arbeiten
WHERE NOT einst_datum <= '01.06.1989'
-- Aufgabe 10
SELECT aufgabe FROM arbeiten
WHERE m_nr IN (10102, 28559, 25348)
-- Aufgabe 11
SELECT DISTINCT aufgabe FROM arbeiten
WHERE m_nr IN (10102, 28559, 25348)
--Alternative
SELECT aufgabe FROM arbeiten
WHERE m_nr IN (10102, 28559, 25348)
GROUP BY aufgabe
-- Aufgabe 12
SELECT m.m_nr, m.m_name, m.m_vorname from mitarbeiter as m
WHERE m.m_nr >= 18316 AND m.m_nr <= 28559
-- Aufgabe 13
SELECT einst_datum from arbeiten
WHERE aufgabe IS NULL AND m_nr > 20000
-- Aufgabe 14
SELECT m_nr FROM arbeiten
WHERE aufgabe IS NOT NULL AND pr_nr = 'p1'
-- Aufgabe 15
SELECT * from projekt CROSS JOIN abteilung;
-- Variante
SELECT * FROM projekt, abteilung;
-- Aufgabe 16
SELECT aufgabe from arbeiten JOIN projekt
ON arbeiten.pr_nr = projekt.pr_nr
WHERE pr_name = 'Gemini'
-- Variante
SELECT aufgabe from arbeiten, projekt
WHERE pr_name = 'Gemini' AND arbeiten.pr_nr = projekt.pr_nr
-- Aufgabe 17
SELECT abt_name FROM abteilung JOIN mitarbeiter
ON abteilung.abt_nr = mitarbeiter.abt_nr
WHERE m_name IN ('Kaufmann', 'Meier')
-- Aufgabe 18
SELECT mitarbeiter.m_nr, m_name, m_vorname FROM mitarbeiter, arbeiten, projekt
WHERE mitarbeiter.m_nr = arbeiten.m_nr AND arbeiten.pr_nr = projekt.pr_nr AND pr_name = 'Gemini'
-- Variante
SELECT mitarbeiter.m_nr, m_name, m_vorname FROM mitarbeiter
    JOIN arbeiten on mitarbeiter.m_nr = arbeiten.m_nr
    JOIN projekt on arbeiten.pr_nr = projekt.pr_nr
WHERE pr_name = 'Gemini'
-- Aufgabe 19
SELECT p1.pr_name, p1.mittel FROM projekt p1 JOIN projekt ON p1.pr_nr != projekt.pr_nr
WHERE p1.mittel = projekt.mittel
-- Aufgabe 20
UPDATE abteilung
SET abt_name = 'Verkauf'
WHERE abt_nr = ALL (SELECT abt_nr FROM mitarbeiter WHERE m_name = 'Kaufmann')
-- Aufgabe 21
UPDATE projekt
SET mittel = mittel * 1.1
WHERE pr_nr = ANY (SELECT pr_nr FROM arbeiten WHERE m_nr = 10102 AND aufgabe = 'Projektleiter')
-- Aufgabe 22
UPDATE projekt
SET pr_name = 'Luna'
WHERE pr_nr = ANY (SELECT pr_nr FROM arbeiten JOIN mitarbeiter m on arbeiten.m_nr = m.m_nr
    WHERE m_name = 'Meier' AND arbeiten.aufgabe = 'Gruppenleiter')
-- Aufgabe 23
UPDATE arbeiten
SET einst_datum = '12.12.1991'
WHERE pr_nr = 'p1' AND m_nr IN (SELECT m_nr FROM mitarbeiter JOIN abteilung a on mitarbeiter.abt_nr = a.abt_nr
    WHERE a.abt_name = 'Verkauf')
-- Aufgabe 24
DELETE FROM arbeiten
WHERE m_nr IN (SELECT m_nr FROM mitarbeiter JOIN abteilung a on mitarbeiter.abt_nr = a.abt_nr
    WHERE a.stadt = N'München')
EXEC RESET_Haupt_Datenbanken;
