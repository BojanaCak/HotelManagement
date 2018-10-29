 
CREATE TABLE angazovanje (
  ang_id int NOT NULL,
  radnik_id int NOT NULL,
  rm_id int NOT NULL,
  datumod date NOT NULL,
  datumdo date DEFAULT NULL,
   PRIMARY KEY (ang_id) 
);

CREATE TABLE klasa (
  klasa_id int NOT NULL,
  opis varchar(756) DEFAULT NULL,
  cena float NOT NULL,
  PRIMARY KEY (klasa_id)
);


CREATE TABLE tip_sobe (
  ts_id int NOT NULL,
  ts_naziv varchar(30) NOT NULL,
  pusaci varchar(10) NOT NULL,
  br_lezaja int NOT NULL,
  klasa_id int NOT NULL,
  PRIMARY KEY (ts_id),
  FOREIGN KEY (klasa_id) REFERENCES klasa (klasa_id)
);

CREATE TABLE soba (
  soba_id int NOT NULL,
  ts_id int NOT NULL,
  status varchar(10) NOT NULL,
  sprat int NOT NULL,
  PRIMARY KEY (soba_id),
  FOREIGN KEY (ts_id) REFERENCES tip_sobe (ts_id)
);

CREATE TABLE gost (
  gost_id int NOT NULL,
  gsot_ime varchar(30) NOT NULL,
  gost_tel varchar(30) NOT NULL,
  gost_adresa varchar(50) NOT NULL,
  sp_id int DEFAULT NULL,
  sifra_popusta int DEFAULT NULL,
  PRIMARY KEY (gost_id)
);

CREATE TABLE check_in (
  ci_id int NOT NULL,
  soba_id int NOT NULL,
  datum_ci date NOT NULL,
  gost_id int NOT NULL,
  PRIMARY KEY (ci_id),
  FOREIGN KEY (soba_id) REFERENCES soba (soba_id),
  FOREIGN KEY (gost_id) REFERENCES gost (gost_id)
);

CREATE TABLE check_out (
  co_id int NOT NULL,
  ci_id int NOT NULL,
  datum_co date NOT NULL,
   PRIMARY KEY (co_id),
   FOREIGN KEY (ci_id) REFERENCES check_in (ci_id)
);

CREATE TABLE radno_mesto (
  rm_id int NOT NULL,
  naziv varchar(30) NOT NULL,
  PRIMARY KEY (rm_id)
);

CREATE TABLE radnik (
  radnik_id int NOT NULL,
  ime varchar(30) NOT NULL,
  pol varchar(10) NOT NULL,
  plata float NOT NULL,
  rm_id int NOT NULL,
  PRIMARY KEY (radnik_id),
  FOREIGN KEY (rm_id) REFERENCES radno_mesto (rm_id)
)

CREATE TABLE nacin_placanja (
  np_id int NOT NULL,
  np_naziv varchar(30) NOT NULL,
  PRIMARY KEY (np_id)
);

CREATE TABLE popust (
  sifra_popusta int NOT NULL,
  naziv_usluge varchar(30) NOT NULL,
  cena_usluge float NOT NULL,
  PRIMARY KEY (sifra_popusta)
);

CREATE TABLE usluga (
  usluga_id int NOT NULL,
  naziv varchar(30) DEFAULT NULL,
  cena float NOT NULL,
  sifra_popusta int DEFAULT NULL,
  radnik_id int DEFAULT NULL,
  PRIMARY KEY (usluga_id),
  FOREIGN KEY (radnik_id) REFERENCES radnik (radnik_id)
);

CREATE TABLE rezervacija (
  rez_id int NOT NULL,
  gost_id int NOT NULL,
  soba_id int NOT NULL,
  radnik_id int NOT NULL,
  datum_od date NOT NULL,
  datum_do date NOT NULL,
  usluga_id int DEFAULT NULL,
  PRIMARY KEY (rez_id),
  FOREIGN KEY (gost_id) REFERENCES gost (gost_id),
  FOREIGN KEY (soba_id) REFERENCES soba (soba_id),
  FOREIGN KEY (radnik_id) REFERENCES radnik (radnik_id),
  FOREIGN KEY (usluga_id) REFERENCES usluga (usluga_id)
);

CREATE TABLE racun (
  racun_id int NOT NULL,
  gost_id int NOT NULL,
  rez_id int NOT NULL,
  usluga_id int NOT NULL,
  np_id int DEFAULT NULL,
  ukupno int DEFAULT NULL,
  sa_popust int DEFAULT NULL,
  PRIMARY KEY (racun_id),
  FOREIGN KEY (gost_id) REFERENCES gost (gost_id),
  FOREIGN KEY (rez_id) REFERENCES rezervacija (rez_id),
  FOREIGN KEY (usluga_id) REFERENCES usluga (usluga_id),
  FOREIGN KEY (np_id) REFERENCES nacin_placanja (np_id)
);

CREATE TABLE detalji_usluge (
  du_id int NOT NULL,
  racun_id int NOT NULL,
  radnik_id int NOT NULL,
  usluga_id int DEFAULT NULL,
  PRIMARY KEY (du_id),
  FOREIGN KEY (racun_id) REFERENCES racun (racun_id),
  FOREIGN KEY (radnik_id) REFERENCES radnik (radnik_id),
  FOREIGN KEY (usluga_id) REFERENCES usluga (usluga_id)
);





INSERT INTO gost (gost_id, gsot_ime, gost_tel, gost_adresa, sp_id, sifra_popusta) VALUES
(1, 'Marko Markovic', '0663 256 3369', 'Grad Ulica 1', NULL, 111),
(2, 'Ivan Ivanovic', '0662 2556 266', 'Beograd Kralja Petra 31', NULL, NULL),
(3, 'Filip Filipovic', '0653 1966 258', 'Subotica Glavna 13', NULL, 222),
(6, 'Janko Jankovic', '0622 659 3799', 'Nis Makedonska 6', NULL, NULL),
(7, 'Milos Milosevic', '035 256 6988', 'Jagodina Palma 26', NULL, 111),
(8, 'Petar Petrovic', '025 5656 9995', 'Kragujevac Simiceva 30', NULL, NULL);


INSERT INTO klasa (klasa_id, opis, cena) VALUES
(1, 'Premium', 90),
(2, 'Standard', 50);

INSERT INTO tip_sobe (ts_id, ts_naziv, pusaci, br_lezaja, klasa_id) VALUES
(1, 'Dvokrevetna', 'da', 2, 2),
(2, 'Trokrevetna + 1 premium', 'ne', 4, 1);

INSERT INTO soba (soba_id, ts_id, status, sprat) VALUES
(1, 1, 'slobodna', 1),
(2, 1, 'zauzeta', 2),
(3, 2, 'slobodna', 1),
(4, 2, 'slobodna', 1);


INSERT INTO angazovanje (ang_id, radnik_id, rm_id, datumod, datumdo) VALUES
(1, 1, 1, '2016-01-01', NULL),
(2, 2, 1, '2016-07-01', '2017-02-28'),
(3, 3, 2, '2014-03-03', NULL),
(4, 4, 4, '2015-04-25', NULL),
(5, 5, 5, '2016-08-07', '2017-07-31'),
(6, 6, 3, '2016-07-03', '2017-05-31'),
(7, 7, 3, '2015-04-01', NULL),
(8, 8, 6, '2017-02-01', NULL);

INSERT INTO radno_mesto (rm_id, naziv) VALUES
(1, 'Kuhinja'),
(2, 'Restoran'),
(3, 'Ciscenje'),
(4, 'wellness'),
(5, 'roomservice'),
(6, 'Rezervacija');

INSERT INTO radnik (radnik_id, ime, pol, plata, rm_id) VALUES
(1, 'Danijel Savic', 'm', 35000, 1),
(2, 'Marija Djordjevic', 'z', 35000, 1),
(3, 'Srdjan Anic', 'm', 40000, 2),
(4, 'Stefan Stevanovic', 'm', 50000, 4),
(5, 'Marija Jankovic', 'z', 41000, 5),
(6, 'Milica Popovic', 'z', 25000, 3),
(7, 'Petar Stanic', 'm', 26000, 3),
(8, 'Marjan Marjanovic', 'm', 39000, 6);

INSERT INTO popust (sifra_popusta, naziv_usluge, cena_usluge) VALUES
(2534, 'Masaza', 2500),
(2536, 'Rucak', 1500);

INSERT INTO usluga (usluga_id, naziv, cena, sifra_popusta, radnik_id) VALUES
(1, 'Dorucak', 2000, NULL, NULL),
(2, 'Dorucak', 2000, NULL, NULL),
(3, 'Rucak', 3000, NULL, NULL),
(4, 'Dostava room service', 1000, NULL, NULL),
(5, 'Wellnes masaza', 4000, NULL, NULL),
(6, 'Ciscenje sobe', 2000, NULL, NULL);

INSERT INTO rezervacija (rez_id, gost_id, soba_id, radnik_id, datum_od, datum_do, usluga_id) VALUES
(1, 1, 2, 8, '2017-02-10', '2017-02-17', NULL),
(2, 2, 4, 8, '2017-04-01', '2017-04-15', NULL);

INSERT INTO nacin_placanja (np_id, np_naziv) VALUES
(1, 'Kes'),
(2, 'Kreditna kartica'),
(3, 'Debit Master'),
(4, 'Debit Visa');

INSERT INTO racun (racun_id, gost_id, rez_id, usluga_id, np_id, ukupno, sa_popust) VALUES
(1, 1, 1, 1, 1, NULL, NULL),
(2, 1, 1, 5, 1, NULL, 2536);


INSERT INTO detalji_usluge (du_id, racun_id, radnik_id, usluga_id) VALUES
(1, 1, 8, 1);
--



























