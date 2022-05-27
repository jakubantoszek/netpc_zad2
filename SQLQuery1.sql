use polishPeople

CREATE TABLE Osoba(
	PESEL varchar(11) PRIMARY KEY,
	Imie varchar(15) CHECK (LEN(Imie)>0) NOT NULL,
	Nazwisko varchar(35) CHECK (LEN(Nazwisko)>0) NOT NULL,
	Data_urodzenia date CHECK (YEAR(Data_urodzenia) > 1900) NOT NULL,
	Plec varchar(9) CHECK (Plec IN ('Kobieta', 'Mezczyzna')) NOT NULL,
	Zarobki bigint CHECK (Zarobki > 0) NOT NULL,
	PESEL_partnera varchar(11) default(NULL) REFERENCES Osoba(PESEL)
)

CREATE TABLE Przedsiebiorstwo(
	Nazwa varchar(50) PRIMARY KEY,
	PESEL_prezesa varchar(11) NOT NULL FOREIGN KEY REFERENCES Osoba(PESEL) ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE Pracownik(
	PESEL_osoby varchar(11) FOREIGN KEY REFERENCES Osoba(PESEL) ON DELETE CASCADE ON UPDATE CASCADE,
	Nazwa_przedsiebiorstwa varchar(50) FOREIGN KEY REFERENCES Przedsiebiorstwo(Nazwa),
	Rodzaj_umowy varchar(8) CHECK (Rodzaj_umowy IN ('zlecenie', 'o prace')) NOT NULL,
	PRIMARY KEY (PESEL_osoby, Nazwa_przedsiebiorstwa)
)

CREATE TABLE Rodzic(
	PESEL_dziecka varchar(11) FOREIGN KEY REFERENCES Osoba(PESEL),
	PESEL_rodzica varchar(11) FOREIGN KEY REFERENCES Osoba(PESEL),
	PRIMARY KEY(PESEL_rodzica, PESEL_dziecka)
)