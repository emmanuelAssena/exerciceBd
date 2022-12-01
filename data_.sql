--
-- CREATION DE LA TABLE PATIENT
--
CREATE TABLE Patient (
  Mat_Pat TEXT NOT NULL,
  nom TEXT,
  prenom TEXT,
  date_Naiss date NOT NULL ,
  Groupe_Sanguin TEXT NOT NULL,
  Poids float(10) NOT NULL,
  Taille float(10) NOT NULL,
  Sexe TEXT NOT NULL
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- CREATION DE LA TABLE MALADIE
--
CREATE TABLE Maladies (
  Code_Mal TEXT NOT NULL,
  designation TEXT NOT NULL
  
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- CREATION DE LA TABLE CONSULTATION
--
CREATE TABLE Consultation (
  N° int(11),
  Mat_Pat TEXT NOT NULL,
  Date_consul date NOT NULL ,
  Heure_consul time NOT NULL,
  type_consul TEXT NOT NULL
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


--
-- CREATION DE LA TABLE SUIVI
--
CREATE TABLE Suivi (
  Mat_Pat TEXT NOT NULL,
  Code_Mal TEXT NOT NULL
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 3. Ajout du champ adresse a la table Patient
--

--
-- ALTER TABLE Patient ADD adresse TEXT NOT NULL;
--
--
-- Le groupe sanguin doit etre dans ('O-','O+','A-','A+','B-','B+','AB-','AB+')
--
ALTER TABLE Patient 
MODIFY COLUMN Groupe_Sanguin ENUM('O-','O+','A-','A+','B-','B+','AB-','AB+');

--
-- 4. Modification du champ Type_Cons pour qu'il soit de type varchar(30)
--
ALTER TABLE Consultation
MODIFY type_consul varchar(30);

--
-- AJOUT DES CONTRAINTES 
--

--
-- clé primaire et clé etrangere au table
--

--
-- Table Maladie
--
ALTER TABLE Maladies
ADD PRIMARY KEY (Code_Mal);

--
-- Table Patient
--
ALTER TABLE Patient
ADD PRIMARY KEY (Mat_Pat);

--
-- Contrainte Table Consultation
--
ALTER TABLE Consultation
ADD PRIMARY KEY (N°) NOT NULL AUTO_INCREMENT, FOREIGN KEY (Mat_Pat) REFERENCES Patient (Mat_Pat);

--
-- Contrainte Table Suivi
--
ALTER TABLE Suivi
ADD FOREIGN KEY Mat_Pat REFERENCES Patient (Mat_Pat), FOREIGN KEY Code_Mal REFERENCES Maladie (Code_Mal);

--
-- Le nom et le prenom doivent etre non null
--
ALTER TABLE Patient
ADD nom NOT NULL, prenom NOT NULL;

--
-- Le sexe doit etre dans (F,M)
--
ALTER TABLE Patient 
MODIFY COLUMN Sexe ENUM('M','F');

--
-- La consultation doit etre dans ('Normale','Contrôle','Domicile')
--
ALTER TABLE Consultation MODIFY COLUMN type_consul ENUM('Normale','Contrôle','Domicile');

















INSERT INTO Patient VALUES ('120001','ABDI','Sami','1960-07-01','A+',60,1.6,'M'),
('120002','BEN KHALED','aHLEM','1980-04-24','B+',50,1.55,'F'),
('120003','BEN SLIMANE','Abdelkerim','1980-05-16','O-',68,1.7,'M'),
('120004','GHARBI','Isam','1975-06-03','O+',88,1.75,'M'),
('120005','MELKI','Raoudla','1968-12-15','A+',54,1.45,'F'),
('120006','SELMI','Ali','1952-11-13','A-',60,1.55,'M');


INSERT INTO Maladies VALUES('150001','Fièvre'),('150002','GRIPPE')
,('150003','Asthme'),('150001','Diabète');

INSERT INTO Consultation
VALUES(1,'120003','2004-04-12','08:30','Normale'),(2,'120003','2004-05-12','15:00','Contrôle')
,(3,'120002','2004-04-12','20:20','Domicile'),(4,'120001','2004-04-20','15:30','Normale');

INSERT INTO Suivi
VALUES('120003','150002'),('120002','150003'),('120005','150003'),('120001','150004');




--
-- Tous les patients
--

select nom from Patient;

--
-- Tous les patients qui ont comme groupe sanguin A+
--
select *  from Patient where Groupe_Sanguin='A+';

--
-- les femmes qui ont un groupe sanguin A+ ou A- et dont le poids ne depasse pas 70kg
-- 
select * from Patient where Sexe='F' and (Groupe_Sanguin='O+' or Groupe_Sanguin='O-') and Poids<=70;

--
-- Les patients ayant un poids sup a 62 et un taille sup à 1.6
-- 
select * from Patient where Taille > 1.6 and Poids > 62;

--
-- les patients nés entre 1975 et 1985
--
select nom from Patient where date_Naiss BETWEEN 1975 and 1985;

--
-- les patients dont le nom contient S
--
select * from Patient where nom LIKE '%S%';

--
-- Les patients dont le 2e caractere du nom est E
--
select * from Patient where nom LIKE '_E%';

--
-- les patients sont le nom de commence ni pas S ni pas A
--
select * from Patient where nom NOT LIKE 'S%' or 'A%';


select * from 'Patient' ORDER BY Poids ;


select * from 'Patient' where Poids = 100*Taille;


select * from 'Consultation' where type_consul= 'Normale' and Heure_consul >12:00;

COMMIT;








