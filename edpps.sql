--Autor: Szymon Pawłowski
--EWIDENCJA DEKLARACJI PODATNIKÓW "EDPPS"
--Projekt bazy danych urzędu skarbowego wykonany jako samodzielny projekt w ramach zajęć uczelnianych „Bazy danych”.
--Pomysł zaczerpnięty po odbytych praktykach w urzędzie skarbowym. 

CREATE TABLE git_DECYZJE (
    nr_d     INTEGER NOT NULL,
    decyzja  VARCHAR2(100) DEFAULT 'BRAK' NOT NULL
);

COMMENT ON TABLE git_DECYZJE IS
    'Tabela zawiera informacje o decyzjach ws. podatnikow';

ALTER TABLE git_DECYZJE ADD CONSTRAINT git_DECYZJE_PK PRIMARY KEY ( nr_d );

CREATE TABLE git_DZIALALNOSC (
    id_d                 INTEGER NOT NULL,
    typ                  VARCHAR2(30) DEFAULT 'BRAK_TYPU' NOT NULL,
    rodzaj_dzialalnosci  VARCHAR2(100)
);

COMMENT ON TABLE git_DZIALALNOSC IS
    'Tabela zawiera informacje o dzialalnosci podatnika';

ALTER TABLE git_DZIALALNOSC ADD CONSTRAINT git_DZIALALNOSC_PK PRIMARY KEY ( id_d );

ALTER TABLE git_DZIALALNOSC ADD CONSTRAINT git_DZIALALNOSC__UN UNIQUE ( typ );

CREATE TABLE git_FORMULARZ (
    nr                      NUMBER(9) DEFAULT 123456789 NOT NULL,
    nr_pomocniczy           NUMBER(11) DEFAULT 12345 NOT NULL,
    data_wplyniecia         DATE,
    data_zlozenia           DATE,
    rok                     NUMBER(4) DEFAULT 1960 NOT NULL,
    miesiac                 NUMBER(2) DEFAULT 01 NOT NULL,
    uwagi                   VARCHAR2(100),
    git_RODZAJE_ID_R   INTEGER NOT NULL,
    git_PODATNIK_ID_P  INTEGER NOT NULL,
    git_KWOTA_ID_KW    INTEGER NOT NULL
);

COMMENT ON TABLE git_FORMULARZ IS
    'Tabela przechowuje informacje o formularzach';

ALTER TABLE git_FORMULARZ ADD CONSTRAINT git_FORMULARZ_PK PRIMARY KEY ( nr );

CREATE TABLE git_KWOTA (
    id_kw         INTEGER NOT NULL,
    rodzaj_kwoty  VARCHAR2(15) DEFAULT 'BRAK' NOT NULL,
    kwota         NUMBER(20, 2) DEFAULT 0 NOT NULL
);

COMMENT ON TABLE git_KWOTA IS
    'Tabela zawiera informacje o rodzaju kwoty';

ALTER TABLE git_KWOTA ADD CONSTRAINT git_KWOTA_PK PRIMARY KEY ( id_kw );

CREATE TABLE git_MIASTA (
    kod     VARCHAR2(6) NOT NULL,
    miasto  VARCHAR2(40) NOT NULL
);

COMMENT ON TABLE git_MIASTA IS
    'Tabela podporzadkowuje kody do miast';

ALTER TABLE git_MIASTA ADD CONSTRAINT git_MIASTA_PK PRIMARY KEY ( kod );

CREATE TABLE git_PODATNIK (
    id_p                       INTEGER NOT NULL,
    nazwa                      VARCHAR2(50) DEFAULT 'BRAK_NAZWY' NOT NULL,
    nip                        NUMBER(11) DEFAULT 00000000000 NOT NULL,
    git_MIASTA_KOD        VARCHAR2(6) NOT NULL,
    ulica                      VARCHAR2(50),
    nr                         VARCHAR2(10),
    telefon                    VARCHAR2(9) DEFAULT '111222333' NOT NULL,
    git_DZIALALNOSC_ID_D  INTEGER NOT NULL
);

COMMENT ON TABLE git_PODATNIK IS
    'Tabela przechowuje informacje o podatnikach';

ALTER TABLE git_PODATNIK ADD CONSTRAINT git_PODATNIK_PK PRIMARY KEY ( id_p );

ALTER TABLE git_PODATNIK ADD CONSTRAINT git_PODATNIK__UN UNIQUE ( telefon,
                                                                            nip );

CREATE TABLE git_POZYCJE (
    git_URZEDNIK_ID_U  INTEGER NOT NULL,
    git_FORMULARZ_NR   NUMBER(9) NOT NULL
);

COMMENT ON TABLE git_POZYCJE IS
    'Tabela przypisuje urzednikom deklaracje';

ALTER TABLE git_POZYCJE ADD CONSTRAINT git_POZYCJE_PK PRIMARY KEY ( git_URZEDNIK_ID_U,
                                                                              git_FORMULARZ_NR );

CREATE TABLE git_PRZYPISANIE (
    git_PODATNIK_ID_P  INTEGER NOT NULL,
    git_DECYZJE_NR_D   INTEGER NOT NULL
);

COMMENT ON TABLE git_PRZYPISANIE IS
    'Tabela przypisuje deklaracje podatnikom';

ALTER TABLE git_PRZYPISANIE ADD CONSTRAINT git_PRZYPISANIE_PK PRIMARY KEY ( git_PODATNIK_ID_P,
                                                                                      git_DECYZJE_NR_D );

CREATE TABLE git_RODZAJE (
    id_r   INTEGER NOT NULL,
    nazwa  VARCHAR2(8) DEFAULT 'BRAK' NOT NULL
);

COMMENT ON TABLE git_RODZAJE IS
    'Tabela zawiera informacje o rodzaju formularzu
';

ALTER TABLE git_RODZAJE ADD CONSTRAINT git_RODZAJE_PK PRIMARY KEY ( id_r );

CREATE TABLE git_STANOWISKO (
    id_stan     INTEGER NOT NULL,
    stanowisko  VARCHAR2(15) DEFAULT 'BRAK' NOT NULL,
    pensja      NUMBER(12, 2) DEFAULT 0 NOT NULL,
    opis        VARCHAR2(100)
);

COMMENT ON TABLE git_STANOWISKO IS
    'Tabela zawiera informacje o stanowiskach pracownikow';

ALTER TABLE git_STANOWISKO ADD CONSTRAINT git_STANOWISKO_PK PRIMARY KEY ( id_stan );

CREATE TABLE git_URZEDNIK (
    id_u                         INTEGER NOT NULL,
    imie                         VARCHAR2(15) DEFAULT 'BRAK' NOT NULL,
    nazwisko                     VARCHAR2(25) DEFAULT 'BRAK' NOT NULL,
    git_MIASTA_KOD          VARCHAR2(6) NOT NULL,
    ulica                        VARCHAR2(30) DEFAULT 'BRAK' NOT NULL,
    nr                           VARCHAR2(10),
    telefon                      VARCHAR2(9) DEFAULT '111222333' NOT NULL,
    git_STANOWISKO_ID_STAN  INTEGER NOT NULL
);

COMMENT ON TABLE git_URZEDNIK IS
    'Tabela przechowuje informacje o urzednikach
';

ALTER TABLE git_URZEDNIK ADD CONSTRAINT git_URZEDNIK_PK PRIMARY KEY ( id_u );

ALTER TABLE git_URZEDNIK ADD CONSTRAINT git_URZEDNIK__UN UNIQUE ( telefon );

ALTER TABLE git_FORMULARZ
    ADD CONSTRAINT git_FORMULARZ_KWOTA_FK FOREIGN KEY ( git_KWOTA_ID_KW )
        REFERENCES git_KWOTA ( id_kw );

ALTER TABLE git_FORMULARZ
    ADD CONSTRAINT git_FORMULARZ_PODATNIK_FK FOREIGN KEY ( git_PODATNIK_ID_P )
        REFERENCES git_PODATNIK ( id_p );

ALTER TABLE git_FORMULARZ
    ADD CONSTRAINT git_FORMULARZ_RODZAJE_FK FOREIGN KEY ( git_RODZAJE_ID_R )
        REFERENCES git_RODZAJE ( id_r );

ALTER TABLE git_PODATNIK
    ADD CONSTRAINT git_PODATNIK_DZIALALNOSC_FK FOREIGN KEY ( git_DZIALALNOSC_ID_D )
        REFERENCES git_DZIALALNOSC ( id_d );

ALTER TABLE git_PODATNIK
    ADD CONSTRAINT git_PODATNIK_MIASTA_FK FOREIGN KEY ( git_MIASTA_KOD )
        REFERENCES git_MIASTA ( kod );

ALTER TABLE git_POZYCJE
    ADD CONSTRAINT git_POZYCJE_FORMULARZ_FK FOREIGN KEY ( git_FORMULARZ_NR )
        REFERENCES git_FORMULARZ ( nr );

ALTER TABLE git_POZYCJE
    ADD CONSTRAINT git_POZYCJE_URZEDNIK_FK FOREIGN KEY ( git_URZEDNIK_ID_U )
        REFERENCES git_URZEDNIK ( id_u );

ALTER TABLE git_PRZYPISANIE
    ADD CONSTRAINT git_PRZYPISANIE_DECYZJE_FK FOREIGN KEY ( git_DECYZJE_NR_D )
        REFERENCES git_DECYZJE ( nr_d );

ALTER TABLE git_PRZYPISANIE
    ADD CONSTRAINT git_PRZYPISANIE_PODATNIK_FK FOREIGN KEY ( git_PODATNIK_ID_P )
        REFERENCES git_PODATNIK ( id_p );

ALTER TABLE git_URZEDNIK
    ADD CONSTRAINT git_URZEDNIK_MIASTA_FK FOREIGN KEY ( git_MIASTA_KOD )
        REFERENCES git_MIASTA ( kod );

ALTER TABLE git_URZEDNIK
    ADD CONSTRAINT git_URZEDNIK_STANOWISKO_FK FOREIGN KEY ( git_STANOWISKO_ID_STAN )
        REFERENCES git_STANOWISKO ( id_stan );

CREATE SEQUENCE git_DECYZJE_NR_D_SEQ START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER git_DECYZJE_NR_D_TRG BEFORE
    INSERT ON git_DECYZJE
    FOR EACH ROW
    WHEN ( new.nr_d IS NULL )
BEGIN
    :new.nr_d := git_DECYZJE_NR_D_SEQ.nextval;
END;
/

CREATE SEQUENCE git_DZIALALNOSC_ID_D_SEQ START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER git_DZIALALNOSC_ID_D_TRG BEFORE
    INSERT ON git_DZIALALNOSC
    FOR EACH ROW
    WHEN ( new.id_d IS NULL )
BEGIN
    :new.id_d := git_DZIALALNOSC_ID_D_SEQ.nextval;
END;
/

CREATE SEQUENCE git_FORMULARZ_NR_SEQ START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER git_FORMULARZ_NR_TRG BEFORE
    INSERT ON git_FORMULARZ
    FOR EACH ROW
    WHEN ( new.nr IS NULL )
BEGIN
    :new.nr := git_FORMULARZ_NR_SEQ.nextval;
END;
/

CREATE SEQUENCE git_KWOTA_ID_KW_SEQ START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER git_KWOTA_ID_KW_TRG BEFORE
    INSERT ON git_KWOTA
    FOR EACH ROW
    WHEN ( new.id_kw IS NULL )
BEGIN
    :new.id_kw := git_KWOTA_ID_KW_SEQ.nextval;
END;
/

CREATE SEQUENCE git_MIASTA_KOD_SEQ START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER git_MIASTA_KOD_TRG BEFORE
    INSERT ON git_MIASTA
    FOR EACH ROW
    WHEN ( new.kod IS NULL )
BEGIN
    :new.kod := git_MIASTA_KOD_SEQ.nextval;
END;
/

CREATE SEQUENCE git_PODATNIK_ID_P_SEQ START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER git_PODATNIK_ID_P_TRG BEFORE
    INSERT ON git_PODATNIK
    FOR EACH ROW
    WHEN ( new.id_p IS NULL )
BEGIN
    :new.id_p := git_PODATNIK_ID_P_SEQ.nextval;
END;
/

CREATE SEQUENCE git_POZYCJE_git_URZEDNIK START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER git_POZYCJE_git_URZEDNIK BEFORE
    INSERT ON git_POZYCJE
    FOR EACH ROW
    WHEN ( new.git_URZEDNIK_ID_U IS NULL )
BEGIN
    :new.git_URZEDNIK_ID_U := git_POZYCJE_git_URZEDNIK.nextval;
END;
/

CREATE SEQUENCE git_POZYCJE_git_FORMULAR START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER git_POZYCJE_git_FORMULAR BEFORE
    INSERT ON git_POZYCJE
    FOR EACH ROW
    WHEN ( new.git_FORMULARZ_NR IS NULL )
BEGIN
    :new.git_FORMULARZ_NR := git_POZYCJE_git_FORMULAR.nextval;
END;
/

CREATE SEQUENCE git_PRZYPISANIE_git_PODA START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER git_PRZYPISANIE_git_PODA BEFORE
    INSERT ON git_PRZYPISANIE
    FOR EACH ROW
    WHEN ( new.git_PODATNIK_ID_P IS NULL )
BEGIN
    :new.git_PODATNIK_ID_P := git_PRZYPISANIE_git_PODA.nextval;
END;
/

CREATE SEQUENCE git_PRZYPISANIE_git_DECY START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER git_PRZYPISANIE_git_DECY BEFORE
    INSERT ON git_PRZYPISANIE
    FOR EACH ROW
    WHEN ( new.git_DECYZJE_NR_D IS NULL )
BEGIN
    :new.git_DECYZJE_NR_D := git_PRZYPISANIE_git_DECY.nextval;
END;
/

CREATE SEQUENCE git_RODZAJE_ID_R_SEQ START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER git_RODZAJE_ID_R_TRG BEFORE
    INSERT ON git_RODZAJE
    FOR EACH ROW
    WHEN ( new.id_r IS NULL )
BEGIN
    :new.id_r := git_RODZAJE_ID_R_SEQ.nextval;
END;
/

CREATE SEQUENCE git_STANOWISKO_ID_STAN_SEQ START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER git_STANOWISKO_ID_STAN_TRG BEFORE
    INSERT ON git_STANOWISKO
    FOR EACH ROW
    WHEN ( new.id_stan IS NULL )
BEGIN
    :new.id_stan := git_STANOWISKO_ID_STAN_SEQ.nextval;
END;
/

CREATE SEQUENCE git_URZEDNIK_ID_U_SEQ START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER git_URZEDNIK_ID_U_TRG BEFORE
    INSERT ON git_URZEDNIK
    FOR EACH ROW
    WHEN ( new.id_u IS NULL )
BEGIN
    :new.id_u := git_URZEDNIK_ID_U_SEQ.nextval;
END;
/

--------------------------------------------------------------------

--Tabela DECYZJA
Insert into git_DECYZJE (NR_D,DECYZJA) values (0,'BRAK DECYZJI');
Insert into git_DECYZJE (NR_D,DECYZJA) values (1,'ZAWIADOMIENIE');
Insert into git_DECYZJE (NR_D,DECYZJA) values (2,'PONAGLENIE');
Insert into git_DECYZJE (NR_D,DECYZJA) values (3,'WEZWANIE');
Insert into git_DECYZJE (NR_D,DECYZJA) values (4,'WYKREŚLENIE');
Insert into git_DECYZJE (NR_D,DECYZJA) values (5,'PRZYWRÓCENIE');
Insert into git_DECYZJE (NR_D,DECYZJA) values (6,'INFORMACJA');
Insert into git_DECYZJE (NR_D,DECYZJA) values (7,'SPRAWDZENIE');
Insert into git_DECYZJE (NR_D,DECYZJA) values (8,'ANALIZA');
Insert into git_DECYZJE (NR_D,DECYZJA) values (9,'OBSERWACJA');
--
--Tabela DZIALALNOSC
Insert into git_DZIALALNOSC (ID_D,TYP,RODZAJ_DZIALALNOSCI) values (1,'HANDLOWA','SP. Z O. O');
Insert into git_DZIALALNOSC (ID_D,TYP,RODZAJ_DZIALALNOSCI) values (2,'GOSPODARCZA','SP. Z O. O');
Insert into git_DZIALALNOSC (ID_D,TYP,RODZAJ_DZIALALNOSCI) values (3,'BUDOWLANA','S. A.');
Insert into git_DZIALALNOSC (ID_D,TYP,RODZAJ_DZIALALNOSCI) values (4,'PRODUKCYJNA','SP. Z O. O');
Insert into git_DZIALALNOSC (ID_D,TYP,RODZAJ_DZIALALNOSCI) values (5,'TRANSPORTOWA','SP. Z O. O');
Insert into git_DZIALALNOSC (ID_D,TYP,RODZAJ_DZIALALNOSCI) values (6,'USŁUGOWA','S. A.');
Insert into git_DZIALALNOSC (ID_D,TYP,RODZAJ_DZIALALNOSCI) values (7,'PRZEWOZOWA','SP. Z O. O');
Insert into git_DZIALALNOSC (ID_D,TYP,RODZAJ_DZIALALNOSCI) values (8,'WYTWÓRCZA','SP. Z O. O');
--
--Tabela KWOTA
Insert into git_KWOTA (ID_KW,RODZAJ_KWOTY,KWOTA) values (-4,'ZWROT',1000000);
Insert into git_KWOTA (ID_KW,RODZAJ_KWOTY,KWOTA) values (-3,'ZWROT',500000);
Insert into git_KWOTA (ID_KW,RODZAJ_KWOTY,KWOTA) values (-2,'ZWROT',100000);
Insert into git_KWOTA (ID_KW,RODZAJ_KWOTY,KWOTA) values (-1,'ZWROT',10000);
Insert into git_KWOTA (ID_KW,RODZAJ_KWOTY,KWOTA) values (1,'WPŁATA',10000);
Insert into git_KWOTA (ID_KW,RODZAJ_KWOTY,KWOTA) values (2,'WPŁATA',100000);
Insert into git_KWOTA (ID_KW,RODZAJ_KWOTY,KWOTA) values (3,'WPŁATA',500000);
Insert into git_KWOTA (ID_KW,RODZAJ_KWOTY,KWOTA) values (4,'WPŁATA',1000000);
Insert into git_KWOTA (ID_KW,RODZAJ_KWOTY,KWOTA) values (0,'BRAK',0);
--
--Tabela MIASTA
Insert into git_MIASTA (KOD,MIASTO) values ('00-000','Warszawa');
Insert into git_MIASTA (KOD,MIASTO) values ('30-000','Kraków');
Insert into git_MIASTA (KOD,MIASTO) values ('90-000','Łódź');
Insert into git_MIASTA (KOD,MIASTO) values ('50-000','Wrocław');
Insert into git_MIASTA (KOD,MIASTO) values ('60-000','Poznań');
Insert into git_MIASTA (KOD,MIASTO) values ('80-000','Gdańsk');
Insert into git_MIASTA (KOD,MIASTO) values ('70-000','Szczecin');
Insert into git_MIASTA (KOD,MIASTO) values ('85-000','Bydgoszcz');
Insert into git_MIASTA (KOD,MIASTO) values ('20-000','Lublin');
Insert into git_MIASTA (KOD,MIASTO) values ('15-000','Białystok');
--
--Tabela RODZAJE
Insert into git_RODZAJE (ID_R,NAZWA) values (11,'VAT-7');
Insert into git_RODZAJE (ID_R,NAZWA) values (12,'VAT-7K');
Insert into git_RODZAJE (ID_R,NAZWA) values (21,'CIT-8');
Insert into git_RODZAJE (ID_R,NAZWA) values (22,'CIT-8/O');
Insert into git_RODZAJE (ID_R,NAZWA) values (23,'CIT-5');
Insert into git_RODZAJE (ID_R,NAZWA) values (24,'CIT-7');
Insert into git_RODZAJE (ID_R,NAZWA) values (31,'NIP-1');
Insert into git_RODZAJE (ID_R,NAZWA) values (32,'NIP-2');
Insert into git_RODZAJE (ID_R,NAZWA) values (33,'NIP-5');
Insert into git_RODZAJE (ID_R,NAZWA) values (34,'ZAP-3');
--
--Tabela STANOWISKO
Insert into git_STANOWISKO (ID_STAN,STANOWISKO,PENSJA,OPIS) values (100,'Naczelnik',5000,'Naczelnik urzędu skarbowego');
Insert into git_STANOWISKO (ID_STAN,STANOWISKO,PENSJA,OPIS) values (101,'Zastępca',4000,'Zastępca naczelnika urzędu skarbowego');
Insert into git_STANOWISKO (ID_STAN,STANOWISKO,PENSJA,OPIS) values (102,'Kierownik',3500,'Kierownik działu / referatu');
Insert into git_STANOWISKO (ID_STAN,STANOWISKO,PENSJA,OPIS) values (103,'Informatyk',3500,'Informatyk urzędu skarbowego');
Insert into git_STANOWISKO (ID_STAN,STANOWISKO,PENSJA,OPIS) values (104,'Kontroler',3300,'Kontroler rozliczeń');
Insert into git_STANOWISKO (ID_STAN,STANOWISKO,PENSJA,OPIS) values (105,'Referent',2900,'Starszy referent ');
Insert into git_STANOWISKO (ID_STAN,STANOWISKO,PENSJA,OPIS) values (106,'Księgowy',2900,'Starszy księgowy');
Insert into git_STANOWISKO (ID_STAN,STANOWISKO,PENSJA,OPIS) values (107,'Radca',3800,'Radca prawny');
Insert into git_STANOWISKO (ID_STAN,STANOWISKO,PENSJA,OPIS) values (108,'Komornik',3000,null);
Insert into git_STANOWISKO (ID_STAN,STANOWISKO,PENSJA,OPIS) values (109,'Inspektor',2800,'Inspektor ds. bezpieczeństwa');
--
--Tabela PODATNIK
Insert into git_PODATNIK (ID_P,NAZWA,NIP,git_MIASTA_KOD,ULICA,NR,TELEFON,git_DZIALALNOSC_ID_D) values (999,'GREGAM',10001234567,'00-000','Tkaczyka','12','111222333',1);
Insert into git_PODATNIK (ID_P,NAZWA,NIP,git_MIASTA_KOD,ULICA,NR,TELEFON,git_DZIALALNOSC_ID_D) values (998,'FASTA',20001234567,'15-000','Perefa','43','222333444',5);
Insert into git_PODATNIK (ID_P,NAZWA,NIP,git_MIASTA_KOD,ULICA,NR,TELEFON,git_DZIALALNOSC_ID_D) values (997,'POLBRAK',30001234567,'80-000','Kopalniana','1','333444555',3);
Insert into git_PODATNIK (ID_P,NAZWA,NIP,git_MIASTA_KOD,ULICA,NR,TELEFON,git_DZIALALNOSC_ID_D) values (996,'DSSTUDIO',40001234567,'20-000','Ogródkowa','24','444555666',4);
Insert into git_PODATNIK (ID_P,NAZWA,NIP,git_MIASTA_KOD,ULICA,NR,TELEFON,git_DZIALALNOSC_ID_D) values (995,'AREC',50001234567,'85-000','Piaskowa','64','555666777',2);
Insert into git_PODATNIK (ID_P,NAZWA,NIP,git_MIASTA_KOD,ULICA,NR,TELEFON,git_DZIALALNOSC_ID_D) values (994,'VITALI',60001234567,'70-000','Kopenhage','23','666777888',7);
Insert into git_PODATNIK (ID_P,NAZWA,NIP,git_MIASTA_KOD,ULICA,NR,TELEFON,git_DZIALALNOSC_ID_D) values (993,'FORTUNA',70001234567,'60-000','Amelii','122','777888999',7);
Insert into git_PODATNIK (ID_P,NAZWA,NIP,git_MIASTA_KOD,ULICA,NR,TELEFON,git_DZIALALNOSC_ID_D) values (992,'PARAFKA',80001234567,'50-000','Franczka','34','888999111',8);
Insert into git_PODATNIK (ID_P,NAZWA,NIP,git_MIASTA_KOD,ULICA,NR,TELEFON,git_DZIALALNOSC_ID_D) values (991,'KOPEC',90001234567,'90-000','Portowa','25','999111222',1);
Insert into git_PODATNIK (ID_P,NAZWA,NIP,git_MIASTA_KOD,ULICA,NR,TELEFON,git_DZIALALNOSC_ID_D) values (990,'KAPA',10011234567,'30-000','Długa','2','111999111',6);
--
--Tabela URZEDNIK
Insert into git_URZEDNIK (ID_U,IMIE,NAZWISKO,git_MIASTA_KOD,ULICA,NR,TELEFON,git_STANOWISKO_ID_STAN) values (1,'Jan','Kopasiuk','50-000','Długa','2','987654321',100);
Insert into git_URZEDNIK (ID_U,IMIE,NAZWISKO,git_MIASTA_KOD,ULICA,NR,TELEFON,git_STANOWISKO_ID_STAN) values (2,'Jerzy','Tereczek','50-000','Kopalniana','15','987321654',101);
Insert into git_URZEDNIK (ID_U,IMIE,NAZWISKO,git_MIASTA_KOD,ULICA,NR,TELEFON,git_STANOWISKO_ID_STAN) values (3,'Władysław','Derda','50-000','Florenca','32','987987987',105);
Insert into git_URZEDNIK (ID_U,IMIE,NAZWISKO,git_MIASTA_KOD,ULICA,NR,TELEFON,git_STANOWISKO_ID_STAN) values (4,'Artur','Pomaska','50-000','Kwiatkowa','12','741852963',106);
Insert into git_URZEDNIK (ID_U,IMIE,NAZWISKO,git_MIASTA_KOD,ULICA,NR,TELEFON,git_STANOWISKO_ID_STAN) values (5,'Emilia','Recław','50-000','Akacjowa','3','741963852',102);
Insert into git_URZEDNIK (ID_U,IMIE,NAZWISKO,git_MIASTA_KOD,ULICA,NR,TELEFON,git_STANOWISKO_ID_STAN) values (6,'Maria','Parka','50-000','Kaszubska','5','741741741',101);
Insert into git_URZEDNIK (ID_U,IMIE,NAZWISKO,git_MIASTA_KOD,ULICA,NR,TELEFON,git_STANOWISKO_ID_STAN) values (7,'Lucyna','Stencel','50-000','Osiedlowa','38','963852741',105);
Insert into git_URZEDNIK (ID_U,IMIE,NAZWISKO,git_MIASTA_KOD,ULICA,NR,TELEFON,git_STANOWISKO_ID_STAN) values (8,'Elżbieta','Duda','50-000','Portowa','43','963741852',103);
Insert into git_URZEDNIK (ID_U,IMIE,NAZWISKO,git_MIASTA_KOD,ULICA,NR,TELEFON,git_STANOWISKO_ID_STAN) values (9,'Martyna','Labuda','50-000','Tkacka','5','963963963',105);
Insert into git_URZEDNIK (ID_U,IMIE,NAZWISKO,git_MIASTA_KOD,ULICA,NR,TELEFON,git_STANOWISKO_ID_STAN) values (10,'Szymon','Opierski','50-000','Świętopełka','9','852963741',105);
Insert into git_URZEDNIK (ID_U,IMIE,NAZWISKO,git_MIASTA_KOD,ULICA,NR,TELEFON,git_STANOWISKO_ID_STAN) values (11,'Tomasz','Nastały','50-000','Mickiewicza','84','852741963',105);
Insert into git_URZEDNIK (ID_U,IMIE,NAZWISKO,git_MIASTA_KOD,ULICA,NR,TELEFON,git_STANOWISKO_ID_STAN) values (12,'Kamil','Rolbiecki','50-000','Słoneczna','52','852852852',105);
Insert into git_URZEDNIK (ID_U,IMIE,NAZWISKO,git_MIASTA_KOD,ULICA,NR,TELEFON,git_STANOWISKO_ID_STAN) values (13,'Agnieszka','Szulc','50-000','Słowackiego','3','753421869',106);
Insert into git_URZEDNIK (ID_U,IMIE,NAZWISKO,git_MIASTA_KOD,ULICA,NR,TELEFON,git_STANOWISKO_ID_STAN) values (14,'Joanna','Raca','50-000','Rogali','4','869571324',107);
Insert into git_URZEDNIK (ID_U,IMIE,NAZWISKO,git_MIASTA_KOD,ULICA,NR,TELEFON,git_STANOWISKO_ID_STAN) values (15,'Patrycja','Kołodziejczyk','50-000','Strzelecka','6','623951847',106);
--
--Tabela FORMULARZ
Insert into git_FORMULARZ (NR,NR_POMOCNICZY,DATA_WPLYNIECIA,DATA_ZLOZENIA,ROK,MIESIAC,UWAGI,git_RODZAJE_ID_R,git_PODATNIK_ID_P,git_KWOTA_ID_KW) values (200510111,20200510111,to_date('05-MAY-20','DD-MON-RR'),to_date('04-MAY-20','DD-MON-RR'),2020,4,null,11,999,-1);
Insert into git_FORMULARZ (NR,NR_POMOCNICZY,DATA_WPLYNIECIA,DATA_ZLOZENIA,ROK,MIESIAC,UWAGI,git_RODZAJE_ID_R,git_PODATNIK_ID_P,git_KWOTA_ID_KW) values (200510222,20200510222,to_date('05-MAY-20','DD-MON-RR'),to_date('04-MAY-20','DD-MON-RR'),2020,4,null,11,998,-4);
Insert into git_FORMULARZ (NR,NR_POMOCNICZY,DATA_WPLYNIECIA,DATA_ZLOZENIA,ROK,MIESIAC,UWAGI,git_RODZAJE_ID_R,git_PODATNIK_ID_P,git_KWOTA_ID_KW) values (200510333,20200510333,to_date('05-MAY-20','DD-MON-RR'),to_date('04-MAY-20','DD-MON-RR'),2020,4,null,12,997,2);
Insert into git_FORMULARZ (NR,NR_POMOCNICZY,DATA_WPLYNIECIA,DATA_ZLOZENIA,ROK,MIESIAC,UWAGI,git_RODZAJE_ID_R,git_PODATNIK_ID_P,git_KWOTA_ID_KW) values (200215111,20200215111,to_date('11-FEB-20','DD-MON-RR'),to_date('04-FEB-20','DD-MON-RR'),2020,1,null,21,996,0);
Insert into git_FORMULARZ (NR,NR_POMOCNICZY,DATA_WPLYNIECIA,DATA_ZLOZENIA,ROK,MIESIAC,UWAGI,git_RODZAJE_ID_R,git_PODATNIK_ID_P,git_KWOTA_ID_KW) values (200215222,20200215222,to_date('11-FEB-20','DD-MON-RR'),to_date('04-FEB-20','DD-MON-RR'),2020,1,null,21,995,0);
Insert into git_FORMULARZ (NR,NR_POMOCNICZY,DATA_WPLYNIECIA,DATA_ZLOZENIA,ROK,MIESIAC,UWAGI,git_RODZAJE_ID_R,git_PODATNIK_ID_P,git_KWOTA_ID_KW) values (200215333,20200215333,to_date('11-FEB-20','DD-MON-RR'),to_date('04-FEB-20','DD-MON-RR'),2020,1,null,21,994,0);
Insert into git_FORMULARZ (NR,NR_POMOCNICZY,DATA_WPLYNIECIA,DATA_ZLOZENIA,ROK,MIESIAC,UWAGI,git_RODZAJE_ID_R,git_PODATNIK_ID_P,git_KWOTA_ID_KW) values (191205111,20191205111,to_date('02-DEC-19','DD-MON-RR'),to_date('29-NOV-19','DD-MON-RR'),2019,11,null,11,993,4);
Insert into git_FORMULARZ (NR,NR_POMOCNICZY,DATA_WPLYNIECIA,DATA_ZLOZENIA,ROK,MIESIAC,UWAGI,git_RODZAJE_ID_R,git_PODATNIK_ID_P,git_KWOTA_ID_KW) values (191205222,20191205222,to_date('02-DEC-19','DD-MON-RR'),to_date('29-NOV-19','DD-MON-RR'),2019,11,null,12,992,3);
Insert into git_FORMULARZ (NR,NR_POMOCNICZY,DATA_WPLYNIECIA,DATA_ZLOZENIA,ROK,MIESIAC,UWAGI,git_RODZAJE_ID_R,git_PODATNIK_ID_P,git_KWOTA_ID_KW) values (191205333,20191205333,to_date('02-DEC-19','DD-MON-RR'),to_date('29-NOV-19','DD-MON-RR'),2019,11,null,11,991,-2);
Insert into git_FORMULARZ (NR,NR_POMOCNICZY,DATA_WPLYNIECIA,DATA_ZLOZENIA,ROK,MIESIAC,UWAGI,git_RODZAJE_ID_R,git_PODATNIK_ID_P,git_KWOTA_ID_KW) values (191111111,20191111111,to_date('07-NOV-19','DD-MON-RR'),to_date('05-NOV-19','DD-MON-RR'),2019,10,null,11,994,3);
Insert into git_FORMULARZ (NR,NR_POMOCNICZY,DATA_WPLYNIECIA,DATA_ZLOZENIA,ROK,MIESIAC,UWAGI,git_RODZAJE_ID_R,git_PODATNIK_ID_P,git_KWOTA_ID_KW) values (191111222,20191111222,to_date('07-NOV-19','DD-MON-RR'),to_date('05-NOV-19','DD-MON-RR'),2019,10,null,12,995,3);
Insert into git_FORMULARZ (NR,NR_POMOCNICZY,DATA_WPLYNIECIA,DATA_ZLOZENIA,ROK,MIESIAC,UWAGI,git_RODZAJE_ID_R,git_PODATNIK_ID_P,git_KWOTA_ID_KW) values (191111333,20191111333,to_date('07-NOV-19','DD-MON-RR'),to_date('05-NOV-19','DD-MON-RR'),2019,10,null,11,998,-3);
Insert into git_FORMULARZ (NR,NR_POMOCNICZY,DATA_WPLYNIECIA,DATA_ZLOZENIA,ROK,MIESIAC,UWAGI,git_RODZAJE_ID_R,git_PODATNIK_ID_P,git_KWOTA_ID_KW) values (200412111,20200412111,to_date('08-APR-20','DD-MON-RR'),to_date('02-APR-20','DD-MON-RR'),2020,3,null,21,990,0);
Insert into git_FORMULARZ (NR,NR_POMOCNICZY,DATA_WPLYNIECIA,DATA_ZLOZENIA,ROK,MIESIAC,UWAGI,git_RODZAJE_ID_R,git_PODATNIK_ID_P,git_KWOTA_ID_KW) values (191205444,20191205444,to_date('02-DEC-19','DD-MON-RR'),to_date('29-NOV-19','DD-MON-RR'),2019,11,null,31,990,0);
Insert into git_FORMULARZ (NR,NR_POMOCNICZY,DATA_WPLYNIECIA,DATA_ZLOZENIA,ROK,MIESIAC,UWAGI,git_RODZAJE_ID_R,git_PODATNIK_ID_P,git_KWOTA_ID_KW) values (200412222,20200412111,to_date('08-APR-20','DD-MON-RR'),to_date('02-APR-20','DD-MON-RR'),2020,3,null,32,999,0);
--
--Tabela POZYCJE
Insert into git_POZYCJE (git_URZEDNIK_ID_U,git_FORMULARZ_NR) values (4,200215111);
Insert into git_POZYCJE (git_URZEDNIK_ID_U,git_FORMULARZ_NR) values (4,200215222);
Insert into git_POZYCJE (git_URZEDNIK_ID_U,git_FORMULARZ_NR) values (5,191205444);
Insert into git_POZYCJE (git_URZEDNIK_ID_U,git_FORMULARZ_NR) values (5,200412222);
Insert into git_POZYCJE (git_URZEDNIK_ID_U,git_FORMULARZ_NR) values (7,191111222);
Insert into git_POZYCJE (git_URZEDNIK_ID_U,git_FORMULARZ_NR) values (9,200510111);
Insert into git_POZYCJE (git_URZEDNIK_ID_U,git_FORMULARZ_NR) values (9,200510222);
Insert into git_POZYCJE (git_URZEDNIK_ID_U,git_FORMULARZ_NR) values (10,200510333);
Insert into git_POZYCJE (git_URZEDNIK_ID_U,git_FORMULARZ_NR) values (11,191111111);
Insert into git_POZYCJE (git_URZEDNIK_ID_U,git_FORMULARZ_NR) values (11,191205111);
Insert into git_POZYCJE (git_URZEDNIK_ID_U,git_FORMULARZ_NR) values (11,191205333);
Insert into git_POZYCJE (git_URZEDNIK_ID_U,git_FORMULARZ_NR) values (12,191111333);
Insert into git_POZYCJE (git_URZEDNIK_ID_U,git_FORMULARZ_NR) values (12,191205222);
Insert into git_POZYCJE (git_URZEDNIK_ID_U,git_FORMULARZ_NR) values (13,200215333);
Insert into git_POZYCJE (git_URZEDNIK_ID_U,git_FORMULARZ_NR) values (15,200412111);
--
--Tabela PRZYPISANIE
Insert into git_PRZYPISANIE (git_PODATNIK_ID_P,git_DECYZJE_NR_D) values (990,9);
Insert into git_PRZYPISANIE (git_PODATNIK_ID_P,git_DECYZJE_NR_D) values (991,2);
Insert into git_PRZYPISANIE (git_PODATNIK_ID_P,git_DECYZJE_NR_D) values (992,3);
Insert into git_PRZYPISANIE (git_PODATNIK_ID_P,git_DECYZJE_NR_D) values (993,6);
Insert into git_PRZYPISANIE (git_PODATNIK_ID_P,git_DECYZJE_NR_D) values (994,6);
Insert into git_PRZYPISANIE (git_PODATNIK_ID_P,git_DECYZJE_NR_D) values (995,1);
Insert into git_PRZYPISANIE (git_PODATNIK_ID_P,git_DECYZJE_NR_D) values (996,1);
Insert into git_PRZYPISANIE (git_PODATNIK_ID_P,git_DECYZJE_NR_D) values (997,0);
Insert into git_PRZYPISANIE (git_PODATNIK_ID_P,git_DECYZJE_NR_D) values (998,0);
Insert into git_PRZYPISANIE (git_PODATNIK_ID_P,git_DECYZJE_NR_D) values (999,0);
--

--Sprawdzenie ilości rekordów w poszczególnych tabelach
select
(select count(*) from git_DECYZJE) as "DECYZJE",
(select count(*) from git_DZIALALNOSC) as "DZIALANOSC",
(select count(*) from git_FORMULARZ) as "FORMULARZ",
(select count(*) from git_KWOTA) as "KWOTA",
(select count(*) from git_MIASTA) as "MIASTA",
(select count(*) from git_PODATNIK) as "PODATNIK",
(select count(*) from git_POZYCJE) as "POZYCJE",
(select count(*) from git_PRZYPISANIE) as "PRZYPISANIE",
(select count(*) from git_RODZAJE) as "RODZAJE",
(select count(*) from git_STANOWISKO) as "STANOWISKO",
(select count(*) from git_URZEDNIK) as "URZEDNIK"
from dual;

select * from git_DECYZJE;
select * from git_DZIALALNOSC;
select * from git_FORMULARZ;
select * from git_KWOTA;
select * from git_MIASTA;
select * from git_PODATNIK;
select * from git_POZYCJE;
select * from git_PRZYPISANIE;
select * from git_RODZAJE;
select * from git_STANOWISKO;
select * from git_URZEDNIK;



--Stworzymy widok przedstawiający ile miesięcy upłynęło od czasu złożenia deklaracji.
create or replace view ile_miesiecy as
select DATA_ZLOZENIA, SYSDATE as DATA, 
FLOOR(MONTHS_BETWEEN(SYSDATE, DATA_ZLOZENIA)) as MIESIACE
from git_FORMULARZ
order by miesiace desc;
select * from ile_miesiecy;

--Stworzymy widok prezentujący ilość pracowników obejmujących dane stanowiska.
create or replace view ile_stanowisk as
select git_STANOWISKO_ID_STAN as nr_stanowiska, count(*) as ilosc
from git_URZEDNIK
group by git_STANOWISKO_ID_STAN
order by ilosc desc;
select * from ile_stanowisk;
--
--Stworzymy widok zawierający informacje o pensjach pracowników 
--(tj. jaka jest minimalna, maksymalna, średnia oraz ile łącznie pieniędzy przeznaczane jest na pensje).
create or replace view pensje_informacje as
select 
    min(pensja) as pensja_min, max(pensja) as pensja_max,
    sum(pensja) as suma_pensji, trunc(avg(pensja),2) as pensja_srednia
from git_STANOWISKO
order by pensja_max;
select * from pensje_informacje;
--
--Stworzymy widok ukazujący ilość deklaracji danego rodzaju w bazie danych.
create or replace view ile_rodzaj as
select
substr(nazwa,1,3) as RODZAJ,
count(*) as ILOSC
from git_RODZAJE
group by substr(nazwa,1,3)
order by ILOSC desc;
select * from ile_rodzaj;
--
--Stworzymy widok prezentujący stanowiska, które zajmują się formularzami (podaj ilość),a których pensja jest niższa od średniej.
create or replace view jakie_stan as
select st.stanowisko, st.pensja, count(fr.nr)as ilosc 
from git_FORMULARZ fr left join git_POZYCJE pz 
on fr.nr=pz.git_FORMULARZ_NR left join
git_URZEDNIK ur on pz.git_URZEDNIK_ID_U=ur.ID_U left join
git_STANOWISKO st on ur.git_STANOWISKO_ID_STAN=st.ID_STAN
group by stanowisko, pensja
having pensja<(select avg(pensja) from git_STANOWISKO);
select * from jakie_stan;
--
--Stworzymy widok przedstawiający podatników o maksymalnej kwocie w deklaracji.
create or replace view jacy_pod as
select fr.nr, nazwa, kwota 
from git_PODATNIK pd right join git_FORMULARZ fr 
on pd.id_p=fr.git_PODATNIK_ID_P left join
git_KWOTA kw on fr.git_KWOTA_ID_KW=kw.ID_KW
group by fr.nr, id_p, nazwa, kwota
having kwota=(select max(kwota) from git_KWOTA);
select * from jacy_pod;
--
--Stworzymy widok przedstawiający podatników, którymi zajmują się urzędniczki o pensjach niższych niż średnia pensji.
create or replace view urz_pod as
select ur.imie, st.pensja, pd.nazwa as ilosc 
from git_PODATNIK pd right join git_FORMULARZ fr on
pd.ID_P=fr.git_PODATNIK_ID_P left join git_POZYCJE pz 
on fr.nr=pz.git_FORMULARZ_NR left join
git_URZEDNIK ur on pz.git_URZEDNIK_ID_U=ur.ID_U left join
git_STANOWISKO st on ur.git_STANOWISKO_ID_STAN=st.ID_STAN
group by imie, pensja, pd.nazwa
having substr(imie,-1,1)='a' and pensja<(select avg(pensja) from git_STANOWISKO);
select * from urz_pod;
--
--Stworzymy widok prezentujący nie kwartalne deklaracje VAT-7 podatników wraz z numerami tych deklaracji, które zostały złożone w 2019 roku.
create or replace view deklaracje as
select pd.nazwa as podatnik, fr.nr, rd.nazwa as deklaracja, 
extract(year from DATA_ZLOZENIA) as rok
from git_PODATNIK pd right join git_FORMULARZ fr on
pd.ID_P=fr.git_PODATNIK_ID_P left join git_RODZAJE rd 
on fr.git_RODZAJE_ID_R=rd.ID_R
group by pd.nazwa, fr.nr, rd.nazwa, extract(year from DATA_ZLOZENIA)
having substr(rd.nazwa,1,3)='VAT' and substr(rd.nazwa,-1,1)!='K' and
extract(year from DATA_ZLOZENIA)=2019;
select * from deklaracje;

------------------------------------------------------------------------------------------------
--Tworzymy funkcję sprawdzająca poprawność numerów NIP zawartych w bazie danych
--Algorytm sprawdzający opiera się na tym ogólnie stosowanym z wyjatkiem liczby cyfr z mała modyfikacja

create or replace type tablica_cyfr is table of number;

create or replace function sprawdz_nip (nip number:=00000000000) return varchar2 as
poprawny varchar2(3);
cyfry_nip tablica_cyfr := tablica_cyfr();
pomnozone_cyfry tablica_cyfr := tablica_cyfr();
suma number:=0;
begin
   for i in 1..11 loop cyfry_nip.extend; 
    cyfry_nip(i):=(mod(NIP,power(10,12-i))-mod(NIP,power(10,11-i)))/power(10,11-i);
   end loop;
 pomnozone_cyfry.extend(9);
 pomnozone_cyfry(1):=cyfry_nip(1)*6;
 pomnozone_cyfry(2):=cyfry_nip(2)*5;
 pomnozone_cyfry(3):=cyfry_nip(3)*7;
 pomnozone_cyfry(4):=cyfry_nip(4)*2;
 pomnozone_cyfry(5):=cyfry_nip(5)*3;
 pomnozone_cyfry(6):=cyfry_nip(6)*4;
 pomnozone_cyfry(7):=cyfry_nip(7)*5;
 pomnozone_cyfry(8):=cyfry_nip(8)*6;
 pomnozone_cyfry(9):=cyfry_nip(9)*7;
  for i in 1..9 loop
    suma:=suma+pomnozone_cyfry(i)+cyfry_nip(10)+cyfry_nip(11);
  end loop; if mod(suma,11)=10 then poprawny:='NIE';
 else poprawny:='TAK'; end if;
 return poprawny;
end sprawdz_nip;

select NAZWA, NIP, sprawdz_nip(NIP) as Czy_poprawny from git_PODATNIK;

--Utworzmy widok pracownicy_info zawierajacy informacje na temat plci,
--pensji oraz ilosci obslugiwanych dokumentow
--Korzystajac z utworzonego widoku oraz z wczesniejszego odnosnie
--informacji o pensjach stworzymy funkcje, ktora bedzie przypisywala
--odpowiednia kwote podwyzki zalezna od plci, ilosci dokumentow
--oraz wysokosci dotychczasowej pensji

create or replace view pracownicy_info as select imie,
case when substr(imie,-1,1)='a' then 'K'
else 'M' end as plec, pensja,
count(fr.nr) as ilosc
from git_FORMULARZ fr left join git_POZYCJE pz on
fr.nr=pz.git_FORMULARZ_NR left join git_URZEDNIK ur on 
pz.git_URZEDNIK_ID_U=ur.ID_U left join git_STANOWISKO st
on ur.git_STANOWISKO_ID_STAN=st.ID_STAN
group by imie, pensja;

create or replace function podwyzki (
plec varchar2,
ilosc int,
pensja number,
pensja_srednia number
) return number as
podwyzka number;
begin
if plec='K' and ilosc >5 and pensja<pensja_srednia then podwyzka:=pensja;
elsif plec='K' and (ilosc >5 or pensja<pensja_srednia) then podwyzka:=0.5*pensja;
elsif plec='K' and ilosc<=5 and pensja>pensja_srednia then podwyzka:=0.2*pensja;
elsif plec='M' and ilosc >5 and pensja<pensja_srednia then podwyzka:=0.9*pensja;
elsif plec='M' and (ilosc >5 or pensja<pensja_srednia) then podwyzka:=0.4*pensja;
elsif plec='M' and ilosc<=5 and pensja>pensja_srednia then podwyzka:=0.1*pensja;
end if;
return podwyzka;
end podwyzki;

select distinct imie, plec, pensja, ilosc, pensja_srednia,
podwyzki(plec, ilosc, pensja, pensja_srednia) as podwyzka
from pracownicy_info, pensje_informacje;



--Tworzymy widok urzednik_dane zawierający dane urzednikow z tabeli posortowane po id
--Stworzymy procedure, ktora doda podane w argumencie dane do widoku uwczesnie sprawdzajac dopasowanie do kluczy obcych

create or replace view urzednik_dane as select id_u,imie,
nazwisko, git_MIASTA_KOD, ulica, nr, telefon, git_STANOWISKO_ID_STAN
from git_URZEDNIK
order by id_u;

create or replace procedure dodaj_urzednika(id int,imie varchar2,
nazwisko varchar2, kod varchar2,ulica varchar2, nr varchar2, telefon varchar2,
id_stan int) as
begin
if (id>15) and (id_stan in (100,101,102,103,104,105,106,107)) and (length(telefon)=9) and (kod in ('00-000',
'30-000','90-000','50-000','60-000','80-000','70-000','85-000','20-000','15-000')) then
insert into urzednik_dane values (id, upper(substr(imie,1,1))||lower(substr(imie,2,length(imie)-1)),
upper(substr(nazwisko,1,1))||lower(substr(nazwisko,2,length(nazwisko)-1)), 
kod, upper(substr(ulica,1,1))||lower(substr(ulica,2,length(ulica)-1)), nr, telefon, id_stan);
end if;
end;

execute dodaj_urzednika(16,'Marek','Kopera','50-000','Koperka','23','159857128',105);
execute dodaj_urzednika(17,'ARKADIUSZ','Gorora','50-000','akacjOwa','25','258753951',105);
execute dodaj_urzednika(18,'WikTOR','WitKOWSKI','50-000','bAbeLKOwa','2','148625975',105);
select * from urzednik_dane;

--Stworzymy wyzwalacz, ktory przed dodaniem nowego podatnika sprawdzi czy
--podany kod miasta i dzialalnosci jest prawidlowy
--a jezeli nie jest to doda nowe miejsce w odpowiedniej tabeli

create or replace trigger dodaj_podatnika before insert on git_PODATNIK
for each row
declare
kod varchar2(6):= :new.git_MIASTA_KOD;
id_d int:= :new.git_DZIALALNOSC_ID_D;
tel varchar2(9):= :new.telefon;
begin
if kod not in ('00-000','30-000','90-000','50-000','60-000'
,'80-000','70-000','85-000','20-000','15-000') then
insert into git_MIASTA values (kod,'MIASTO');
elsif id_d not in (1,2,3,4,5,6,7,8) then 
insert into git_DZIALALNOSC values (id_d, 'TYP','OPIS');
elsif length(kod) != 6 then raise_application_error(-205402, 'Kod musi miec 6 znakow!');
elsif length(tel) != 9 then raise_application_error(-250430, 'Numer telefonów musi mieć 9 znaków!');
end if;
end;

insert into git_PODATNIK values (1000,'Arla',10021234567,'80-405','Kosia','23','123147159',8);
insert into git_PODATNIK values (1001,'Groham',10031234567,'80-000','Lasia','123','123447119',9);
select * from git_MIASTA;
select * from git_DZIALALNOSC;

--Stworzymy tabele logi_zmian, ktora zawiera informacje o zmianach dokonanych w tabeli PODATNIK 
--oraz wyzwalacz, który będzie w niej zapisywał odpowiednie informacji przy danych działaniach

create sequence logi_seq_id start with 1 increment by 1 nomaxvalue;
create table logi_zmian(id int,stara_wartosc varchar2(50), 
zmiana varchar2(15), nowa_wartosc varchar2(50), data_modyfikacji date);

create or replace trigger log_zmian after insert or update or delete on git_PODATNIK for each row
declare
s_podatnik varchar2(50):= :old.nazwa;
n_podatnik varchar2(50):= :new.nazwa;
begin
if inserting then insert into logi_zmian values (logi_seq_id.nextval,
s_podatnik,'INSERT', n_podatnik, trunc(sysdate));
elsif updating then insert into logi_zmian values (logi_seq_id.nextval,
s_podatnik,'UPDATE', n_podatnik, trunc(sysdate));
elsif deleting then insert into logi_zmian values (logi_seq_id.nextval,
s_podatnik,'DELETE', n_podatnik, trunc(sysdate));
end if;
end;

insert into git_PODATNIK values (1002,'Passaka',10041234567,'50-000','Kochanowskiego','123','765447119',4);
update git_PODATNIK set nazwa='BEP' where id_p=1001;
delete from git_PODATNIK where id_p=1002;
select * from logi_zmian;

--Stworz wyzwalacz, który podczas dodawania rekordów do widoku urzednik_dane_szcz
--stworzonego poniżej doda odpowiednie wartosci do rzeczywistych tabel

create or replace view urzednik_dane_szcz as select id_u,imie,
nazwisko, kod,miasto, ulica, nr, telefon, id_stan, stanowisko, pensja
from git_MIASTA mi right join git_URZEDNIK ur on mi.kod=ur.git_MIASTA_KOD left join
git_STANOWISKO st on ur.git_STANOWISKO_ID_STAN=st.ID_STAN
order by id_u;

create or replace trigger po_urzedniku instead of insert on urzednik_dane_szcz for each row
begin
insert into git_MIASTA values (:new.kod, upper(substr(:new.miasto,1,1))||lower(substr(:new.miasto,2,length(:new.miasto)-1)));
insert into git_STANOWISKO values (:new.id_stan, upper(substr(:new.stanowisko,1,1))||lower(substr(:new.stanowisko,2,length(:new.stanowisko)-1)),
:new.pensja,'OPIS');
insert into git_URZEDNIK values (:new.id_u, 
upper(substr(:new.imie,1,1))||lower(substr(:new.imie,2,length(:new.imie)-1)),
upper(substr(:new.nazwisko,1,1))||lower(substr(:new.nazwisko,2,length(:new.nazwisko)-1)), 
:new.kod, upper(substr(:new.ulica,1,1))||lower(substr(:new.ulica,2,length(:new.ulica)-1)),
:new.nr, :new.telefon, :new.id_stan);
end;

insert into urzednik_dane_szcz values(19,'Andzela','Kazera','55-000','Amsterdam','Korka','3','198757128',115,'Stanowisko1',2500);
insert into urzednik_dane_szcz values(20,'MAGda','Grerora','23-000','Londyn','acjOwa','5','681753951',120,'stanowisko2',3000);
insert into urzednik_dane_szcz values(21,'HoracjA','WiaWSKA','50-123','WaszyngtoN','beLKOwa','2','175925975',134,'stanoWISKO3',3200);

select * from git_MIASTA;
select * from git_STANOWISKO;
select * from git_URZEDNIK;
select * from urzednik_dane_szcz;


