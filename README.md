# eddps-database-PL-
Autor: Szymon Pawłowski
	PROJEKT BAZY DANYCH 
EWIDENCJA DEKLARACJI PODATNIKÓW „EDPPS”

  Projekt bazy danych urzędu skarbowego wykonany jako samodzielny projekt w ramach zajęć uczelnianych „Bazy danych”. Pomysł zaczerpnięty po odbytych praktykach w urzędzie skarbowym. 
Celem bazy danych  jest umożliwienie pracownikom Urzędu Skarbowego szybkiego i swobodnego dostepu do danych deklaracji składanych przez podatników niezbędnego do codziennego funkcjonowania urzędu.
Założenia bazy danych EDPPS:
•	Chcemy przechowywać dane podatników (NIP, nazwa firmy, adres firmy, nr kontaktowy);
•	Chcemy przechowywać unikatowe numery deklaracji;
•	Chcemy przechowywać numery pomocnicze (mogą się powtarzać);
•	Chcemy przechowywać datę złożenia i datę wpłynięcia deklaracji;
•	Chcemy mieć możliwość wprowadzenia uwag odnośnie deklaracji;
•	Chcemy przechowywać informacje o pracownikach urzędu skarbowego;
•	Chcemy przechowywać informacje odnośnie stanowisk w urzędzie i pensjach;
•	Chcemy wiedzieć, który pracownik zajmuje się daną deklaracją i jakimi deklaracjami zajmuje się pracownik;
•	Chcemy wiedzieć czy w deklaracji jest kwota do wpłaty czy do zwrotu;
•	Chcemy przechowywać informacje o rodzaju działalności podatnika;
•	Chcemy znać decyzje wydane w sprawie podatników

Instrukcja:
Wchodzimy w link: https://apex.oracle.com/pls/apex/sql_projects/r/edpps/login?session=712604141736325
Następnie logujemy się za pomocą danych: 
   USERNAME: user
   PASSWORD: user
lub
   USERNAME: admin
   PASSWORD: admin

Plik edpps.sql zawiera cały skrypt potrzebny do zainicjowania bazy danych wraz z komentarzami.
Plik projekt_edpps_sprawozdanie.pdf jest sprawozdaniem z bazy danych, jej przeznaczenia i ilustruje sposób działania kodu.
Plik relational_edpps.png obrazuje schemat bazy danych.










