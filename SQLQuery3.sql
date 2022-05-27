use polishPeople;

-- Zapytanie A.
GO
CREATE VIEW Rodzice AS 
	SELECT Rodzic.PESEL_rodzica FROM Rodzic
GO

GO
CREATE VIEW Dziadkowie AS
	SELECT Rodzice.PESEL_rodzica, Osoba.Imie, Osoba.Nazwisko FROM Rodzice, Rodzic, Osoba 
		WHERE Rodzice.PESEL_rodzica = Rodzic.PESEL_dziecka AND Osoba.PESEL = Rodzic.PESEL_rodzica
GO

SELECT TOP 1 Dziadkowie.Imie, Dziadkowie.Nazwisko FROM Dziadkowie
	INNER JOIN Rodzic ON Rodzic.PESEL_rodzica = Dziadkowie.PESEL_rodzica
		INNER JOIN Osoba ON Osoba.PESEL = Rodzic.PESEL_dziecka
			WHERE Osoba.Plec = 'kobieta' GROUP BY Dziadkowie.Imie, Dziadkowie.Nazwisko 
				ORDER BY Count(*) DESC 

-- Zapytanie B.
SELECT Rodzaj_umowy, CONVERT(DECIMAL(10,2), CAST(COUNT(Pracownik.Nazwa_przedsiebiorstwa) as float) / 
	CAST(COUNT(DISTINCT Przedsiebiorstwo.Nazwa) as float)) AS 'Œrednia liczba pracowników', 
		AVG(Osoba.Zarobki) AS 'Œrednie zarobki' FROM Pracownik, Przedsiebiorstwo, Osoba 
			WHERE Pracownik.Nazwa_przedsiebiorstwa = Przedsiebiorstwo.Nazwa AND Pracownik.PESEL_osoby = Osoba.PESEL
				GROUP BY Pracownik.Rodzaj_umowy