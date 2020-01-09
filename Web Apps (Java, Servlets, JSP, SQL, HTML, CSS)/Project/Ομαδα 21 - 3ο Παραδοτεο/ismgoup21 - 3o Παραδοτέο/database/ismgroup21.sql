-- MySQL dump 10.13  Distrib 5.6.23, for Win64 (x86_64)
--
-- Host: 195.251.249.131    Database: ismgroup21
-- ------------------------------------------------------
-- Server version	5.6.21-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `activity`
--

DROP TABLE IF EXISTS `activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity` (
  `title` char(100) NOT NULL,
  `type1` char(50) NOT NULL,
  `type2` char(50) DEFAULT NULL,
  `location` varchar(150) NOT NULL,
  `age` varchar(45) NOT NULL,
  `sex` varchar(45) NOT NULL,
  `price` varchar(45) NOT NULL,
  `tickets` varchar(45) NOT NULL,
  `short_description` varchar(400) NOT NULL,
  `description` varchar(600) NOT NULL,
  `date` varchar(100) DEFAULT NULL,
  `image` varchar(200) DEFAULT NULL,
  `activity_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`activity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity`
--

LOCK TABLES `activity` WRITE;
/*!40000 ALTER TABLE `activity` DISABLE KEYS */;
INSERT INTO `activity` VALUES ('ΑΘΛΗΤΙΚΟ ΦΕΣΤΙΒΑΛ','Αθλητισμός','Εκπαίδευση','Νίκου Ζέρβα 56, Γλυφάδα','1-3 ετών','Αγόρι','3','150','Καλοκαιρινός αγώνας με ποδήλατα ισορροπίας για μικρά παιδιά, με σκοπό κάθε παιδί να παίξει, να τρέξει και να νικήσει, μαθαίνοντας ότι στην ζωή η αγάπη πάντα θα νικάει. ','Κάθε μικρός ποδηλάτης θα έχει την ευκαιρία να «τρέξει» με ένα ποδήλατο ισορροπίας στην ειδικά διαμορφωμένη πίστα που θα κατασκευαστεί στο μέσο του γηπέδου, να διασκεδάσει με τους ανιματέρ, να σκαρφαλώσει και να συμμετέχει σε εκπαιδευτικά παιχνίδια και ζωντανές εκδηλώσεις. Το παιδί δεν χρειάζεται να ξέρει ποδήλατο για να πάρει μέρος αφού το ποδήλατο ισορροπίας δεν έχει πετάλια. Είναι εκπαιδευτικό και χρησιμοποιείται ως περπατούρα για την εκμάθηση της ισορροπίας.','25/2/2019','/ismgroup21/images/race.jpg',1),('ΚΑΛΟΚΑΙΡΙΝΗ ΝΥΧΤΑ','Θέατρο','Εκπαίδευση','Παπαδιαμαντοπούλου 4, Ιλίσια','12-18 ετών','Αγόρια & Κορίτσια','6','50','Ο Πουκ, το λατρεμένο ξωτικό των παιδιών, ο γκαφατζής θίασος των μαστόρων, τα ζευγάρια των νέων ερωτευμένων, η Βασίλισσα των ξωτικών Τιτάνια με τον αγαπημένο της γάιδαρο, όλοι, άνθρωποι και ξωτικά, περιπλέκονται σε μια από τις πιο αστείες ιστορίες που έχουν γραφτεί ποτέ.','Ο Πουκ , το λατρεμένο ξωτικό των παιδιών, ο γκαφατζής θίασος των μαστόρων ,τα ζευγάρια των νέων ερωτευμένων ,η Βασίλισσα των ξωτικών Τιτάνια με τον αγαπημένο της γάιδαρο ,όλοι , άνθρωποι και ξωτικά , περιπλέκονται σε μια από τις πιο αστείες ιστορίες που έχουν γραφτεί ποτέ. Με μια ολοκαίνουρια διασκευή , καινούρια σκηνικά και κοστούμια, καινούριες χορογραφίες αλλά και τα μοναδικά τραγούδια που Ελισαβετιανοί συνθέτες επιστρατεύτηκαν την εποχή του Σαίξπηρ να συνθέσουν για τα έργα του, διασκευασμένα ειδικά για τις ανάγκες της παράστασης.','2/3/2019','/ismgroup21/images/summer.jpg',2),('ΛΙΟΝΤΑΡΙ ΚΑΙ ΠΟΝΤΙΚΙ','Εκπαίδευση',NULL,'Πειραιώς 254, Αθήνα 177 78','3-5 ετών','Κορίτσι','5','50','Ο δυνατός και ο αδύναμος, ο μεγάλος και ο μικρός. Δύο ήρωες τόσο διαφορετικοί συναντιούνται σε έναν μύθο του Αισώπου και μας δείχνουν πόσο χρειάζεται ο ένας τον άλλο! Πώς κατάφερε ένας μικρούλης ποντικός να σώσει το δυνατό λιοντάρι; Ακριβώς έτσι κι εμείς, πότε μικροί και πότε μεγάλοι, ανακαλύπτουμε τη «δύναμή» μας μέσα από παιχνίδια έκφρασης και ρόλων.','Ο δυνατός και ο αδύναμος, ο μεγάλος και ο μικρός. Δύο ήρωες τόσο διαφορετικοί συναντιούνται σε έναν μύθο του Αισώπου και μας δείχνουν πόσο χρειάζεται ο ένας τον άλλο! Πώς κατάφερε ένας μικρούλης ποντικός να σώσει το δυνατό λιοντάρι; Ακριβώς έτσι κι εμείς, πότε μικροί και πότε μεγάλοι, ανακαλύπτουμε τη «δύναμή» μας μέσα από παιχνίδια έκφρασης και ρόλων. Με ερέθισμα την αφήγηση του μύθου παιδιά και γονείς δημιουργούν και ξεκινούν ένα ταξίδι στο μύθο μέσω της δραματοποίησης του μύθου.','12/3/2019','/ismgroup21/images/lion.jpg',3),('ΜΟΥΣΙΚΗ ΓΙΑ ΠΑΙΔΙΑ','Θέατρο','Μουσική','Αλκμήνης 8, Αθήνα, 118 54','5-12 ετών','Αγόρια & Κορίτσια','16','100','Το Jazz for kids είναι μια μοναδική μουσικοχορευτική παράσταση για παιδιά που έρχεται να ευαισθητοποιήσει και να ψυχαγωγήσει τους μικρούς μας φίλους, μέσα από ήχους της Jazz φέρνοντας τα σε επαφή με την ιστορία της και την εξέλιξη της μέχρι τις μέρες μας.','Το Jazz for kids για παιδιά είναι μια μοναδική μουσικοχορευτική παράσταση για παιδιά που έρχεται να ευαισθητοποιήσει και να ψυχαγωγήσει  τους μικρούς μας φίλους,  μέσα από γνωστούς ήχους της Jazz φέρνοντας τα σε επαφή με την ιστορία της και την εξέλιξη της μέχρι τις μέρες μας. Οι ήχοι παρασύρουν τα παιδιά στον ρυθμό, προσκαλώντας τα παράλληλα σε μια σειρά μουσικών βιωματικών παιχνιδιών με τη χρήση απλών ανακυκλώσιμων  υλικών  με στόχο να απογειώσουν την ελεύθερη έκφραση και την φαντασία τους.','21/3/2019','/ismgroup21/images/jazz.jpg',4),('ΝΕΟΣ ΠΑΙΔΟΤΟΠΟΣ','Παιδότοποι','','Θεομήτορος 48, Άγιος Δημήτριος','1-3 ετών','Αγόρια & Κορίτσια','8','25','Με ξεχωριστές δραστηριότητες που θα κρατήσουν τα παιδιά απασχολημένα για ώρα, ο παιδότοπος υπόσχεται ότι θα εξάψει τη δημιουργικότητα και τη φαντασία τους, χωρίς να βαρεθούν ούτε λεπτό.','Με ξεχωριστές δραστηριότητες που θα κρατήσουν τα παιδιά απασχολημένα για ώρα, ο παιδότοπος υπόσχεται ότι θα εξάψει τη δημιουργικότητα και τη φαντασία τους, χωρίς να βαρεθούν ούτε λεπτό. Ενδεικτικά, η δημιουργική απασχόληση περιλαμβάνει ξεχωριστές κατασκευές, παιχνίδια, ζωγραφική, μουσική, ακόμα και πειράματα τόσο στα πρωινά όσο και στα απογευματινά εργαστήρια.','6/4/2019','/ismgroup21/images/img6.jpg',5),('Ο ΓΥΡΟΣ ΤΟΥ ΚΟΣΜΟΥ','Εκπαίδευση','Καλλιτεχνικά','Πειραιώς 254, Αθήνα 177 78','5-12 ετών','Κορίτσι','20','40','Θα ήθελες να κάνεις τον Γύρο του Κόσμου; Να δεις πώς ζουν τα παιδιά από τη μία άκρη της γης έως την άλλη! Φαντάσου πώς είναι η ζωή στην έρημο, στη ζούγκλα και στους πάγους. Υπάρχουν τόσα διαφορετικά μέρη! Εσένα, πού θα σου άρεσε να ζεις; Έλα να διαλέξεις, αφού ανακαλύψεις μικρά μυστικά κάθε τόπου μέσα από το παιχνίδι!','Θα ήθελες να κάνεις τον Γύρο του Κόσμου; Να δεις πώς ζουν τα παιδιά από τη μία άκρη της γης έως την άλλη! Φαντάσου πώς είναι η ζωή στην έρημο, στη ζούγκλα και στους πάγους. Υπάρχουν τόσα διαφορετικά μέρη! Εσένα, πού θα σου άρεσε να ζεις; Έλα να διαλέξεις, αφού ανακαλύψεις μικρά μυστικά κάθε τόπου μέσα από το παιχνίδι! Ένα μαγικό χαλί μας ταξιδεύει σε κάθε γωνιά της γης. Ένα ταξίδι στις πέντε ηπείρους για να ανακαλύψουμε στοιχεία πολιτισμού, πανίδας και χλωρίδας. Ένα ταξίδι γεμάτο παιχνίδι, χορό, εικόνες και δημιουργία!','18/3/2019','/ismgroup21/images/world.jpg',6),('ΠΡΩΤΑΘΛΗΜΑ ΤΕΝΙΣ','Αθλητισμός',NULL,'Καστρίτσας 61, Νεά Ερυθραία','12-18 ετών','Αγόρι','10','100','Η Ακαδημία Αντισφαίρισης του Sunny Sports Club σε συνεργασία με την ομάδα γυμναστών του Ομίλου διοργανώνουν το δεύτερο μαραθώνιο event της χρονιάς για όλα τα παιδιά της Ακαδημίας.','Κατά την διάρκεια του διημέρου τα παιδιά θα αγωνιστούν σε κατηγορίες ανάλογα την ηλικία και το βαθμό εξοικείωσης τους με το άθλημα και θα έχουν την ευκαιρία να παίξουν αγώνες τένις, να αναμετρηθούν με τους συναθλητές τους και τον εαυτό τους, αλλά και να καταλάβουν γιατί το τένις μπορεί να είναι ένα τόσο διασκεδαστικό άθλημα!','26/2/2019','/ismgroup21/images/tennis.jpg',7),('ΡΟΜΠΕΝ ΤΩΝ ΔΑΣΩΝ','Θέατρο','Εκπαίδευση','Φρυνίχου 14, Πλάκα','5-12 ετών','Αγόρια & Κορίτσια','10','120','Ο πασίγνωστος και αγαπημένος μύθος του «Ρομπέν των Δασών» σε μια διασκευή που γράφτηκε ειδικά για την παράσταση του Θέατρου Τέχνης. Μια περιπέτεια εποχής, γεμάτη χιούμορ και ανατροπές.','Ο πασίγνωστος και αγαπημένος μύθος του «Ρομπέν των Δασών» σε μια διασκευή που γράφτηκε ειδικά για την παράσταση του Θέατρου Τέχνης. Μια περιπέτεια εποχής, γεμάτη χιούμορ και ανατροπές. Μια υπέροχη ιστορία που μιλά για τη δύναμη του καλού, τη δικαιοσύνη, τη φιλία, την αλληλεγγύη.','7/4/2019','/ismgroup21/images/roben.jpg',8),('ΤΑΙΝΙΑ ΠΑΝΤΙΝΓΚΤΟΝ','Κινηματογράφος',NULL,'Ανδρέα Παπανδρέου 35, Μαρούσι 151 22','3-5 ετών','Αγόρια & Κορίτσια','8','60','Το αρκουδάκι Πάντινγκτον ταξιδεύει από τα βάθη της ζούγκλας του σκοτεινού Περού στο downtown του Λονδίνου. Την ίδια στιγμή όμως που το ατσούμπαλο τετράποδο δυσκολεύεται να προσαρμοστεί στους αστικούς κανόνες ζωής, μια σατανική ταριχεύτρια έχει βάλει σκοπό να παγώσει το αρκουδίσιο χαμόγελό του μια και καλή…','Ο Πάντινγκτον, ο πιο αγαπημένος αρκούδος στον κόσμο, επιστρέφει σε μία ξεκαρδιστική και γεμάτη δράση ταινία. Ο Πάντινγκτον ζει πλέον ευτυχισμένος με την καινούρια του οικογένεια, τους Μπράουν, στο Ουίνζντορ Γκάρντενς. Κι ενώ ψάχνει να βρει το τέλειο δώρο για την θεία του τη Λούση, που κλείνει τα 100 της χρόνια, ο Πάντινγκτον εντοπίζει ένα μοναδικό pop-up βιβλίο στην αντικερί του κ. Γκρούμπεν. Όταν όμως το βιβλίο εξαφανίζεται, ο Πάντινγκτον και οι Μπράουν ξεκινάνε ένα απίστευτο περιπετειώδες ταξίδι προκειμένου να λύσουν το μυστήριο.','15/3/2019','/ismgroup21/images/bear.jpg',9),('ΤΑΙΝΙΑ ΤΟ ΓΑΤΟΞΟΡΚΙ','Κινηματογράφος',NULL,'Λεωφ. Βασιλίσσης Σοφίας 124, Αθήνα 115 26','5-12 ετών','Αγόρια & Κορίτσια','7','70','Ένας διασκεδαστής σε παιδικά πάρτι, που φοράει στολή γάτου, αποφασίζει να αλλάξει τη ζωή του με τη βοήθεια ενός μάγου. Εκείνος όμως τον μεταμορφώνει σε αληθινό γάτο και στη συνέχεια προσπαθεί να λύσει το ξόρκι του.','Πρόκειται για μια περιπέτεια κινουμένων σχεδίων που έρχεται από τη Βραζιλία, δια χειρός Rafael Ribas. Ο Λίνο είναι ένας διασκεδαστής σε παιδικά πάρτι που δεν αντέχει άλλο τη ρουτίνα του και το γάτο-κοστούμι του. Αποφασίζει έτσι να ζητήσει βοήθεια από έναν όχι και τόσο ταλαντούχο μάγο που τον μεταμορφώνει σε αυτό που μισεί περισσότερο: το κοστούμι του.','30/3/2019','/ismgroup21/images/cat.jpg',10),('ΕΝΑ ΤΡΕΝΟ ΠΑΕΙ ΒΟΛΤΑ','Θέατρο','','γγγγγγγγγγ','3-5 ετών','Αγόρια','1','2','xxxxxxxxxxxxxxxxx','vvvvvvvvvvvvvvvvvvvv','τρρρρρρρρρρρρρρρρρ','/ismgroup21/images/a',40),('ΠΟΝΤΙΚΟΜΙΚΡΟΥΛΗΣ','Θέατρο','','asssssssssssssssssssswqqwq','1-3 ετών','Αγόρια & Κορίτσια','1','3','aaaaaaaaaaaaaa','asassssssssssssssssss','τρρρρρρρρρρρρρρρρρ','/ismgroup21/images/',41);
/*!40000 ALTER TABLE `activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organizer`
--

DROP TABLE IF EXISTS `organizer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organizer` (
  `company_name` char(100) COLLATE utf8_unicode_ci NOT NULL,
  `afm` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `surname` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`company_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organizer`
--

LOCK TABLES `organizer` WRITE;
/*!40000 ALTER TABLE `organizer` DISABLE KEYS */;
INSERT INTO `organizer` VALUES ('Αθλητικός Όμιλος','123456127','sport@gmail.com','2106823578','Γιάννης','Παπαθανασίου','sport24','12345678'),('Κινηματογράφος','345128759','cinema@gmail.com','2109832517','Μαρία','Κωσταντοπούλου','cinemax','cinema123'),('Μουσικός Αυλός','567812350','music@gmail.com','2108912670','Κώστας','Αντωνιάδης','music123','music123');
/*!40000 ALTER TABLE `organizer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `name` char(50) COLLATE utf8_unicode_ci NOT NULL,
  `surname` char(50) COLLATE utf8_unicode_ci NOT NULL,
  `email` char(50) COLLATE utf8_unicode_ci NOT NULL,
  `username` char(100) COLLATE utf8_unicode_ci NOT NULL,
  `password` char(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('goneasonoma','goneasepitheto','goneas@goneas.gr','goneas','goneas'),('giannis','kostopoulos','johnkostopoulos@gmail.com','john2000','10293847'),('kostas','papadopoulos','kostas@gmail.com','kostas90','abcdefg'),('manos','spanakis','manosspanakis@gmail.com','manosspanakis','qwerty'),('maria','soulioti','maria@gmail.com','maria1993','mariasoulioti'),('nikos','perrakis','nickperrakis@gmail.com','nickperrakis','123456'),('tasos','papaloukas','tasos@gmail.com','tasos789','0000000');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_2018_ex3_8100170`
--

DROP TABLE IF EXISTS `users_2018_ex3_8100170`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_2018_ex3_8100170` (
  `username` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `surname` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_2018_ex3_8100170`
--

LOCK TABLES `users_2018_ex3_8100170` WRITE;
/*!40000 ALTER TABLE `users_2018_ex3_8100170` DISABLE KEYS */;
INSERT INTO `users_2018_ex3_8100170` VALUES ('jdoe','John','Doe','jdoe@example.com','1111'),('joken','Jim','Oken','joken@somewhere.gr','1111'),('mpampis','manos','spanakis','man@man.gr','12345'),('msmith','Mary','Smith','msmith@example.com','1111');
/*!40000 ALTER TABLE `users_2018_ex3_8100170` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_2018_ex3_8110111`
--

DROP TABLE IF EXISTS `users_2018_ex3_8110111`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_2018_ex3_8110111` (
  `username` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `surname` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_2018_ex3_8110111`
--

LOCK TABLES `users_2018_ex3_8110111` WRITE;
/*!40000 ALTER TABLE `users_2018_ex3_8110111` DISABLE KEYS */;
INSERT INTO `users_2018_ex3_8110111` VALUES ('aaabbb','sasa','fdfdfd','fdfd@dfd','asdfg'),('cdcdcdcd','dsdsa','sasasas','ds@dsd','asdfg'),('jdoe','John','Doe','jdoe@example.com','1111'),('joken','Jim','Oken','joken@somewhere.gr','1111'),('kostas','sasa','fdfdfd','fdfd@dfd','qazwsx'),('msmith','Mary','Smith','msmith@example.com','1111'),('nikos','dsd','fdfdfd','ds@dsd','asdfg'),('popopo','sasa','dsd','fdfd@dfd','qwert'),('qqaazz','sasa','fdfdfd','fdfd@dfd','qwert'),('sssss','dssasa','sasasa','fdfd@dfd','qwert'),('ssssswq','dssasa','sasasa','fdfd@dfd','qwert'),('zzxxcc','sasa','fdfdfd','fdfd@dfd','qwert');
/*!40000 ALTER TABLE `users_2018_ex3_8110111` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-01-15 23:23:50
