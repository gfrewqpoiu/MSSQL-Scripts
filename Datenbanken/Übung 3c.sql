-- Aufgabe 4
SELECT einst_datum from arbeiten JOIN mitarbeiter m on arbeiten.m_nr = m.m_nr
WHERE m.abt_nr IN ('a1', 'a2')
-- Aufgabe 5
SELECT aufgabe FROM arbeiten
    JOIN mitarbeiter m on arbeiten.m_nr = m.m_nr
    JOIN abteilung a on m.abt_nr = a.abt_nr
    WHERE a.stadt = N'München' AND m.abt_nr IS NOT NULL
-- Aufgabe 6
SELECT DISTINCT abt_name FROM abteilung
    JOIN mitarbeiter m on abteilung.abt_nr = m.abt_nr
    JOIN arbeiten a on m.m_nr = a.m_nr
    WHERE pr_nr = 'p3'
-- Aufgabe 7
SELECT arbeiten.m_nr FROM arbeiten
    JOIN arbeiten a2 ON arbeiten.m_nr != a2.m_nr
    WHERE arbeiten.einst_datum = a2.einst_datum
-- Aufgabe 8
CREATE TABLE alte_mitarbeiter (
    m_nr INT NOT NULL FOREIGN KEY REFERENCES mitarbeiter(m_nr),
    CONSTRAINT pk_alte_mitarbeiter PRIMARY KEY (m_nr)
)
INSERT INTO alte_mitarbeiter
SELECT m_nr from mitarbeiter WHERE m_nr BETWEEN 1000 AND 9999;