--Construirea bazei de date – tabele ?i restric?ii de integritate
--1. S? se creeze tabelul Furnizori
CREATE TABLE Furnizori
(
Id_furnizor NUMBER(5) PRIMARY KEY,
Denumire_furnizor VARCHAR2(50) NOT NULL,
Adresa_furnizor VARCHAR2(50), 
Banca VARCHAR2(50),
Cont VARCHAR2(50),
Email_furnizor VARCHAR2(50) UNIQUE
)

--2. S? se creeze tabelul Facturi
CREATE TABLE Facturi
(
Id_factura NUMBER(5) CONSTRAINT Id_fact_pk PRIMARY KEY,
Data_factura DATE,
Id_furnizor NUMBER(5) CONSTRAINT fk_id_fz REFERENCES Furnizori(Id_furnizor)
);

--3. S? se creeze tabelul Materiale
CREATE TABLE Materiale
(
Id_material NUMBER(5) CONSTRAINT id_material_pk PRIMARY KEY,
Denumire_materiale VARCHAR2(50) NOT NULL,
Unitate_de_masura NUMBER(3)
);

--4. S? se creeze tabelul Continut_factura
CREATE TABLE Continut_factura
(
Id_factura NUMBER(5) CONSTRAINT fk_id_fact REFERENCES Facturi(Id_factura),
Id_material NUMBER(5) CONSTRAINT fk_id_mat REFERENCES Materiale(Id_material),
Cantitate_intrata NUMBER(5)
);

--5. S? se adauge o cheie primar? compus?, format? din Id_factura ?i Id_material, pentru tabelul Continut_factura:
ALTER TABLE Continut_factura
ADD CONSTRAINT id_fact_id_mat_pr PRIMARY KEY(Id_factura, Id_material);

--6. S? se creeze tabelul Angaja?i
CREATE TABLE Angajati
(
Id_angajat NUMBER(5) CONSTRAINT id_angajat_pk PRIMARY KEY,
Salariu_angajat NUMBER(5),
Nume_angajat VARCHAR2(50),
Data_angajare DATE
)

--7. S? se creeze tabelul Depozite
CREATE TABLE Depozite
(
Id_depozit NUMBER(5) CONSTRAINT id_depozit_pk PRIMARY KEY,
Denumire_depozit VARCHAR2(50) NOT NULL,
Id_angajat NUMBER(5) CONSTRAINT fk_id_ang REFERENCES Angajati(Id_angajat)
);

--8. S? se creeze tabelul Bonuri
CREATE TABLE Bonuri
(
Id_bon NUMBER(3) CONSTRAINT id_bon_pk PRIMARY KEY,
Data_bon DATE,
Id_depozit NUMBER(5) CONSTRAINT id_mag_fk REFERENCES Depozit(Id_depozit)
);

--9. S? se creeze tabelul Continut_bon cu cheie primar? compus?, format? din Id_bon ?i Id_material
CREATE TABLE Continut_bon
(
Id_bon NUMBER(3) CONSTRAINT fk_id_bon REFERENCES Bonuri(Id_bon),
Id_material NUMBER(5) CONSTRAINT fk_id_mat_1 REFERENCES Materiale(Id_material),
Cantitate_iesita NUMBER(5)
);
ALTER TABLE Continut_bon
ADD CONSTRAINT nr_bon_id_mat_1_pk PRIMARY KEY(Id_bon, Id_material);

--10. Ad?uga?i coloana „CNP_ANGAJAT” în tabela „Angaja?i”, cu tipul VARCHAR2(13) ?i apoi ?terge?i-o.
ALTER TABLE Angajati ADD (CNP_ANGAJAT VARCHAR2(13));
ALTER TABLE Angajati DROP COLUMN CNP_ANGAJAT;

--11. Modifica?i tabela „Furnizori” astfel încât câmpul „Email_furnizor” s? fie de tipul mihai_adrian@yahoo.com, lucian_dumitru@outlook.com, andreicojocaru@gmail.com  etc.
ALTER TABLE Furnizori ADD CONSTRAINT verif_mail CHECK (Email_furnizor LIKE '%@%.%');

--12. În tabela „Con?inut_factur?” ad?uga?i restric?ia de integritate „verif_cantintrata”, astfel încât numerele introduse în câmpul „Cantitate_intrat?” s? fie cuprinse între 5 ?i 500.
ALTER TABLE Continut_factura ADD CONSTRAINTS verif_cantintrata CHECK (Cantitate_intrata BETWEEN 5 AND 500);

--13. Modifica?i tabela „Angajati” astfel încât câmpul „Nume_angajat” s? fie de tipul VARCHAR2(60).
ALTER TABLE Angajati MODIFY (Nume_angajat VARCHAR2(60));

--14. În tabela „DepozitE” ad?uga?i câmpul „Adresa_depozit” de tip VARCHAR2(50).
ALTER TABLE Depozite ADD (adresa_depozit VARCHAR2(50));

--15. ?terge?i câmpul „adresa_depozit”.
ALTER TABLE Depozite DROP COLUMN adresa_depozit;




--Opera?ii de actualizare a datelor
--1. Insera?i date în tabelul Furnizori
INSERT INTO Furnizori
VALUES (21, 'Iorga Cristian', 'Bucuresti', 'BCR', 338765,'iorga_cristian@yahoo.com');

INSERT INTO Furnizori
VALUES(33, 'Mircea Daniela', 'Constanta', 'BRD', 764521,'mircead@gmail.com');

INSERT INTO Furnizori
VALUES(14, 'Bucataru Mihaela', 'Baia-Mare', 'BT', 237634, 'mihaelabuc@yahoo.com');

INSERT INTO Furnizori
VALUES(23, 'Pavel Cosmin', 'Iasi', 'BCR', 567234,'pavel_cosmin@yahoo.com');

INSERT INTO Furnizori
VALUES(29, 'Dumitru Ion', 'Hunedoara', 'BRD', 743129, 'dumitrui@gmail.com');

INSERT INTO Furnizori (id_furnizor, denumire_furnizor, adresa_furnizor, email_furnizor)
VALUES(17, 'Gherghina Matei', 'Targoviste', 'gherghinamatei@gmail.com');

INSERT INTO Furnizori (id_furnizor, denumire_furnizor, adresa_furnizor, email_furnizor)
VALUES(44, 'Simion Corina', 'Slobozia', 'corinasimion@gmail.com');

INSERT INTO Furnizori (id_furnizor, denumire_furnizor, adresa_furnizor, email_furnizor)
VALUES(64, 'Marin Stelian', 'Bucuresti', 'stelianmarin@yahoo.com');

INSERT INTO Furnizori
VALUES(12, 'Popa Flavia', 'Iasi', 'BCR', 123456, 'popaf@yahoo.com');

INSERT INTO Furnizori
VALUES(13, 'Fintoiu Damian', 'Bucuresti', 'BRD', 876546, 'fintoiud@yahoo.com');

INSERT INTO Furnizori
VALUES(203, 'Costin Violeta', 'Constanta', 'BT', 590231, 'costin_violeta@gmail.com');
COMMIT;

--2. Insera?i date în tabelul Angaja?i
INSERT INTO Angajati
Values(20,3000, 'Br?nescu Viorel', to_date('18-05-1987', 'dd-mm-yyyy'));

INSERT INTO Angajati
Values(110, 2500, 'Anton Mircea', to_date('02-11-1995', 'dd-mm-yyyy'));

INSERT INTO Angajati
Values(130, 1900, 'Popovici Raluca', to_date('22-01-1999', 'dd-mm-yyyy'));

INSERT INTO Angajati
Values(114, 2600, 'Munteanu Cristian', to_date('14-03-1993', 'dd-mm-yyyy'));

INSERT INTO Angajati
Values(818, 1700, 'Cristescu Valeriu', to_date('23-07-1986', 'dd-mm-yyyy'));

INSERT INTO Angajati
Values(333, 9999, 'Br?g?rea Theodor', to_date('18-08-2002', 'dd-mm-yyyy'));
COMMIT;
 

--3. Insera?i date în tabelul Facturi
INSERT INTO Facturi
VALUES(20, to_date('14-08-2019', 'dd-mm-yyyy'), 21);

INSERT INTO Facturi
VALUES(30, to_date('21-07-2019', 'dd-mm-yyyy'), 14);

INSERT INTO Facturi
VALUES(40, to_date('29-09-2021', 'dd-mm-yyyy'), 23);

INSERT INTO Facturi
VALUES(50, to_date('23-10-2020', 'dd-mm-yyyy'), 12);

INSERT INTO Facturi
VALUES(60, to_date('18-01-2021', 'dd-mm-yyyy'), 13);

INSERT INTO Facturi
VALUES(70, to_date('15-06-2020', 'dd-mm-yyyy'), 29);

INSERT INTO Facturi
VALUES(80, to_date('07-07-2021', 'dd-mm-yyyy'), 33);

INSERT INTO Facturi
VALUES(90, to_date('24-05-2019', 'dd-mm-yyyy'), 203);

INSERT INTO Facturi
VALUES(100, to_date('19-06-2020', 'dd-mm-yyyy'), 14);

INSERT INTO Facturi
VALUES(130, to_date('10-10-2021', 'dd-mm-yyyy'), 23);
COMMIT;

--4. Insera?i date în tabelul Depozite
INSERT INTO Depozite
Values(100, 'Depozit_1',20);

INSERT INTO Depozite
Values(200, 'Depozit_2',110);

INSERT INTO Depozite
Values(300, 'Depozit_3',130);

INSERT INTO Depozite
Values(400, 'Depozit_4',114);

INSERT INTO Depozite
Values(500, 'Depozit_5',818);
COMMIT;

--5. Insera?i date în tabelul Bonuri
INSERT INTO Bonuri
VALUES(1, to_date('19-09-2019', 'dd-mm-yyyy'),100);

INSERT INTO Bonuri
VALUES(2, to_date('16-07-2019', 'dd-mm-yyyy'), 200);

INSERT INTO Bonuri
VALUES(3, to_date('15-08-2021', 'dd-mm-yyyy'), 300);

INSERT INTO Bonuri
VALUES(4, to_date('23-06-2022', 'dd-mm-yyyy'), 200);

INSERT INTO Bonuri
VALUES(5, to_date('02-06-2021', 'dd-mm-yyyy'), 400);

INSERT INTO Bonuri
VALUES(6, to_date('06-11-2020', 'dd-mm-yyyy'), 500);

INSERT INTO Bonuri
VALUES(7, to_date('14-11-2019', 'dd-mm-yyyy'), 200);

INSERT INTO Bonuri
VALUES(8, to_date('28-01-2019', 'dd-mm-yyyy'), 100);

INSERT INTO Bonuri
VALUES(9, to_date('19-10-2021', 'dd-mm-yyyy'), 200);

INSERT INTO Bonuri
VALUES(10, to_date('22.02.2019', 'dd-mm-yyyy'), 500);
COMMIT;

--6. Insera?i date în tabelul Materiale
ALTER TABLE Materiale MODIFY  (unitate_de_masura VARCHAR2(50));

INSERT INTO Materiale
Values(100, 'Rigips', 'kg');

INSERT INTO Materiale
Values(200, 'Folie aluminiu', 'mm');

INSERT INTO Materiale
Values(300, 'Adeziv structurali', 'g');

INSERT INTO Materiale
Values(400, 'Ciment', 'm^3');

INSERT INTO Materiale
Values(500, 'Caramida', 'm^2');

INSERT INTO Materiale
Values(600, 'Nisip', 'm^3');

INSERT INTO Materiale
Values(700, 'Boltzari', 'm^2');

INSERT INTO Materiale
VALUES(800, 'Tigla acoperis', 'm^2');

INSERT INTO Materiale
Values(900, 'Polistiren', 'mm');

INSERT INTO Materiale
Values(1000, ‘Glet’, 'kg');
COMMIT;

--7. Insera?i date în tabelul Con?inut_factur?
INSERT INTO Continut_factura
VALUES(20, 200, 150);

INSERT INTO Continut_factura
VALUES(30, 100, 200);

INSERT INTO Continut_factura
VALUES(40, 200, 50);

INSERT INTO Continut_factura
VALUES(50, 300, 170);

INSERT INTO Continut_factura
VALUES(60, 400, 100);

INSERT INTO Continut_factura
VALUES(70, 500, 120);

INSERT INTO Continut_factura
VALUES(80, 600, 130);

INSERT INTO Continut_factura
VALUES(90, 700, 80);

INSERT INTO Continut_factura
VALUES(100, 800, 60);

INSERT INTO Continut_factura
VALUES(130, 900, 80);
COMMIT;


--8. Insera?i date în tabelul Con?inut_bon
INSERT INTO CONTINUT_BON
VALUES(1, 200, 153);

INSERT INTO Continut_bon
Values(2, 300, 133);

INSERT INTO Continut_bon
VALUES(3, 600, 44);

INSERT INTO Continut_bon
VALUES(4, 800, 170 );

INSERT INTO Continut_bon
VALUES(5, 100, 79);

INSERT INTO Continut_bon
VALUES(6, 300, 123);

INSERT INTO Continut_bon
VALUES(7, 400, 143);

INSERT INTO Continut_bon
VALUES(8, 500, 80);

INSERT INTO Continut_bon
VALUES(9, 700, 55);

INSERT INTO Continut_bon
VALUES(10, 900, 77);
COMMIT;

--9. S? se m?reasc? cu 30% salariul angaja?ilor al c?ror nume începe cu litera B.
UPDATE Angajati
SET salariu_angajat=1.3*salariu_angajat
WHERE nume_angajat like 'B%';

--10. S? se modifice adresa furnizorului cu id 14 astfel  încât s? fie aceea?i cu adresa furnizorului cu ID-ul 23.
UPDATE furnizori
SET adresa_furnizor=(SELECT  adresa_furnizor 
FROM furnizori 
WHERE id_furnizor=23)
WHERE id_furnizor=14;

--11. S? se ?tearg? materialul din tabela Materiale cu ID-ul cea mai mare valoare numeric?.
DELETE FROM Materiale 
WHERE id_material = (SELECT MAX(id_material) FROM Materiale);



-- Exemple de interog?ri
--1. Afi?a?i cantitatea total? intrat?, denumirea materialului ?i unitatea de m?sur? pentru materialele cu o cantitate total? mai mare sau egal? cu 80 de unit??i.
SELECT denumire_materiale, unitate_de_masura, SUM(cantitate_intrata)
FROM Continut_factura a JOIN Materiale b ON a.id_material=b.id_material
GROUP BY denumire_materiale, unitate_de_masura
HAVING SUM (cantitate_intrata)>70
ORDER BY denumire_materiale;


--2. S? se afi?eze to?i angajatii care au fost angaja?i în 1993 ?i au salariul mai mare de 2000.
SELECT * 
FROM angajati 
WHERE data_angajare BETWEEN TO_DATE('01-01-1993','dd-mm-yyyy') AND TO_DATE('31-12-1993', 'dd-mm-yyyy') 
INTERSECT
SELECT * FROM angajati WHERE salariu_angajat>2000;

--3. Calcula?i bonusul angaja?ilor în func?ie de salariul lor:
---7% din salariul dac? salariul >3000
--3% din salariul dac? salariul între 2000 ?i 3000
--2% din salariul dac? salariul între 1600 ?i 2000.
-- pentru celelalte, nu va exista bonus.
SELECT nume_angajat, salariu _angajat,
CASE WHEN salariu_ _angajat>3000 THEN 0.07*salariu_angajat
WHEN salariu_angajat BETWEEN 2000 AND 3000 THEN 0.03*salariu_angajat
WHEN salariu _angajat BETWEEN 1600 AND 2000 THEN 0.02*salariu_angajat
ELSE 0 END Bonus
FROM Angajati;

--4. Calcula?i media cu 2 zecimale a salariilor angaja?ilor.
SELECT ROUND(AVG (salariu_angajat),2) Salariu_Mediu
FROM Depozit;

--5. S? se afi?eze  ID-urile ?i data eliber?rii pentru bonurile eliberate în 2021.
SELECT id_bon, data_bon
FROM Bonuri
WHERE EXTRACT(YEAR FROM data_bon)=2021;

--6. S? se afi?eze data facturilor ?i furnizorii corespunz?tori pentru facturile create în 2020.
SELECT data_factura, denumire_furnizor
FROM facturi a JOIN furnizori b ON a.id_furnizor=b.id_furnizor
WHERE TO_CHAR(data_factura, 'yyyy')='2020';

--7. Afi?a?i numele ?i salariul angajatilor care au salariul între 1500 ?i 2000 ?i ordona?i-i alfabetic dup? nume.
SELECT nume_angajat, salariu_angajat
FROM angajati
WHERE salariu_angajat >= 1500 AND salariu_angajat<=2000
ORDER BY nume_angajat ASC;

--8. S? se afi?eze angaja?ii care au salariul între 1500 ?i 3000, f?r? cei care au salariul 1800 ?i 2000.
SELECT nume_angajat, salariu_angajat
FROM Angajati
WHERE salariu_angajat BETWEEN 1500 AND 3000
MINUS
SELECT nume_angajat, salariu_angajat
FROM Angajati
WHERE salariu_angajat IN (1800, 2000);

--9. S? se afi?eze numele ?i adresa furnizorilor care nu au emis facturi în al?i ani în afar? de anul 2021.
SELECT denumire_furnizor, adresa_furnizor
FROM Furnizori
WHERE id_furnizor NOT IN (SELECT id_furnizor 
FROM Facturi
WHERE EXTRACT(YEAR FROM data_factura)!=2021);
 
(Screenshot 3/5)

--10. Afi?a?i num?rul total de angaja?i, pentru fiecare dintre cele 3 nivele salariale: 
--- primul nivel cei care au salariul între 1000 ?i 1999
--- al doilea nivel cei cu salariul între 2000 ?i 2999
--- nivelul al treilea cu salariul între 3000 ?i 3999.
SELECT 'niv1 sal' AS Niv_sal, COUNT(nume_angajat) Nr_nume_angajati
FROM Depozit
WHERE salariu_angajat BETWEEN 1000 AND 1999
UNION
SELECT 'niv2 sal' AS Niv_sal, COUNT(nume_angajat) Nr_nume_angajati
FROM Depozit
WHERE salariu_angajat BETWEEN 2000 AND 2999
UNION 
SELECT 'niv3 sal' AS Niv_sal, COUNT(nume_angajat) Nr_nume_angajati
FROM Depozit
WHERE salariu_angajat BETWEEN 3000 AND 3999;

--11. S? se afi?eze depozitele al c?ror ID se termin? cu cifra 0.
SELECT * FROM Depozite
WHERE (substr(id_depozit, length(id_depozit),1))='0';

--12. S? se realizeze o tabel? virtual? care s? con?in? materialele care au ca unitate de m?sur? m2. Tabela virtual? nu va putea fi actualizat?.
CREATE VIEW tabv_mat_m2
AS
SELECT * FROM Materiale
WHERE unitate_de_masura LIKE 'm^2'
WITH READ ONLY;

--13. S? se creeze un index pentru facilitarea accesului mai rapid la cantitatea ie?it? de materiale pe baza bonurilor.
CREATE INDEX idx_cant_out ON Continut_bon(cantitate_iesita);

--14. S? se creeze un sinonim ”magazii” pentru tabela depozite. S? se interogheze aceast? tabel? folosind sinonimul dat.
CREATE SYNONYM magazii FOR depozite;
SELECT * FROM magazii;

--15. S? se creeze o secven?? care s? aib? valoarea de început egal? cu 300, s? se incrementeze cu pasul 3, s? aib? o valoare maxim? de 400, f?r? a cicla.
CREATE SEQUENCE secv1
START WITH 300
INCREMENT BY 3
MAXVALUE 400
NOCYCLE;

--16. S? se afi?eze numele, banca ?i contul bancar pentru to?i furnizorii. Pentru cazurile în care datele contului bancar sunt inexistente, se va afi?a ‘Nu a fost introdus? banca/contul’ ?i se va ad?uga expresia ‘De actualizat’ în locul spa?iului null.
SELECT denumire_furnizor, NVL(banca,'Nu a fost introdus? banca.') Banca, NVL(cont, 'Nu a fost introdus contul.') Cont
FROM furnizori
ORDER BY denumire_furnizor ASC;

UPDATE furnizori
SET banca='De actualizat'
WHERE banca IS NULL;

UPDATE furnizori
SET cont='De actualizat'
WHERE cont IS NULL;

SELECT denumire_furnizor, banca, cont
FROM furnizori;
 


--17. Conform datelor BNR, topul celor trei institu?ii de credit, în func?ie de valoarea activelor, sunt, în ordinea aceasta: Banca Transilvania, BCR ?i BRD. S? se determine ?i s? se afi?eze num?rul b?ncii din top la care au cont fiecare dintre furnizori, în func?ie de banca la care sunt înscri?i, excluzând furnizorii pentru care datele bancare trebuie actualizate. (ex: dac? banca este BT, atunci se va afi?a Numarul #1.)
SELECT denumire_furnizor, Banca, DECODE(UPPER(banca), 'BT', 'Numarul #1', 
'BCR', 'Numarul #2', 
'BRD', 'Numarul #3', 
'Nu este in Top 3') Top_Banca 
FROM Furnizori
MINUS
SELECT denumire_furnizor, Banca, DECODE(UPPER(banca), 'BT', 'Numarul #1', 
'BCR', 'Numarul #2', 
'BRD', 'Numarul #3', 
'Nu este in Top 3') Top_Banca 
FROM furnizori
WHERE Banca LIKE 'De actualizat'
ORDER BY Top_Banca ASC;
 


--18. S? se afi?eze ultima zi a lunii urm?toare de la data factur?rii ?i câte luni au trecut de la data factur?rii.
SELECT data_factura, LAST_DAY(ADD_MONTHS(data_factura, 1)) as Ultima_zi, TRUNC(MONTHS_BETWEEN(SYSDATE,data_factura)) as Nr_luni_trecute
FROM Facturi;



--19. Ad?uga?i coloana „id_manager” în tabela „Angaja?i” ?i face?i angajatul cu cel mai mare salariu Manager. S? se afi?eze nivelul ierarhic al angaja?ilor în urma modific?rilor realizate.
ALTER TABLE Angajati ADD (id_manager NUMBER(5));
UPDATE Angajati
SET id_manager=(SELECT id_angajat
FROM angajati
WHERE salariu_angajat = (SELECT MAX(salariu_angajat)
FROM angajati));
UPDATE Angajati
SET id_manager=NULL
WHERE salariu_angajat = (SELECT MAX(salariu_angajat)
FROM angajati);

SELECT id_angajat, nume_angajat, id_manager, LEVEL FROM angajati
CONNECT BY PRIOR id_angajat= id_manager
START WITH id_angajat = 333
ORDER BY LEVEL;

--20. S? se afi?eze numele angaja?ilor ?i, acolo unde este cazul, denumirea depozitului de care sunt responsabili.
SELECT a.nume_angajat, b.denumire_depozit
FROM Angajati a LEFT JOIN Depozite b
ON (a.id_angajat=b.id_angajat);
