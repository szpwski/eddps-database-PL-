# eddps-database-PL-
Autor: Szymon Pawłowski \
PROJEKT BAZY DANYCH \ 
EWIDENCJA DEKLARACJI PODATNIKÓW „EDPPS” \

  Projekt bazy danych urzędu skarbowego wykonany jako samodzielny projekt w ramach zajęć uczelnianych „Bazy danych”. Pomysł zaczerpnięty po odbytych praktykach w urzędzie skarbowym.  \
Celem bazy danych  jest umożliwienie pracownikom Urzędu Skarbowego szybkiego i swobodnego dostepu do danych deklaracji składanych przez podatników niezbędnego do codziennego funkcjonowania urzędu. \
Założenia bazy danych EDPPS:
1. Chcemy przechowywać dane podatników (NIP, nazwa firmy, adres firmy, nr kontaktowy);
2. Chcemy przechowywać unikatowe numery deklaracji;
3. Chcemy przechowywać numery pomocnicze (mogą się powtarzać);
4. Chcemy przechowywać datę złożenia i datę wpłynięcia deklaracji;
5. Chcemy mieć możliwość wprowadzenia uwag odnośnie deklaracji;
6. Chcemy przechowywać informacje o pracownikach urzędu skarbowego;
7. Chcemy przechowywać informacje odnośnie stanowisk w urzędzie i pensjach;
8. Chcemy wiedzieć, który pracownik zajmuje się daną deklaracją i jakimi deklaracjami zajmuje się pracownik;
9. Chcemy wiedzieć czy w deklaracji jest kwota do wpłaty czy do zwrotu;
10. Chcemy przechowywać informacje o rodzaju działalności podatnika;
11. Chcemy znać decyzje wydane w sprawie podatników 

Instrukcja: \
Wchodzimy w link: https://apex.oracle.com/pls/apex/sql_projects/r/edpps/login?session=712604141736325 \
Następnie logujemy się za pomocą danych: 
* USERNAME: user
* PASSWORD: user 
lub 
* USERNAME: admin
* PASSWORD: admin 

Plik edpps.sql zawiera cały skrypt potrzebny do zainicjowania bazy danych wraz z komentarzami. \
Plik projekt_edpps_sprawozdanie.pdf jest sprawozdaniem z bazy danych, jej przeznaczenia i ilustruje sposób działania kodu. \
Plik relational_edpps.png obrazuje schemat bazy danych. 










