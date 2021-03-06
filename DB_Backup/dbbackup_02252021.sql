-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: localhost    Database: prolongevity
-- ------------------------------------------------------
-- Server version	8.0.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `adminpanel_activitylog`
--

DROP TABLE IF EXISTS `adminpanel_activitylog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminpanel_activitylog` (
  `ActivityLogId` int NOT NULL AUTO_INCREMENT,
  `ActivityDescription` longtext,
  `LogCreatedDate` date DEFAULT NULL,
  `ActivityType_id` int DEFAULT NULL,
  `User_id` int DEFAULT NULL,
  PRIMARY KEY (`ActivityLogId`),
  KEY `adminpanel_activityl_ActivityType_id_d61b3f27_fk_adminpane` (`ActivityType_id`),
  KEY `adminpanel_activitylog_User_id_b678acda_fk_adminpanel_user_id` (`User_id`),
  CONSTRAINT `adminpanel_activityl_ActivityType_id_d61b3f27_fk_adminpane` FOREIGN KEY (`ActivityType_id`) REFERENCES `adminpanel_activitytype` (`ActivityTypeId`),
  CONSTRAINT `adminpanel_activitylog_User_id_b678acda_fk_adminpanel_user_id` FOREIGN KEY (`User_id`) REFERENCES `adminpanel_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminpanel_activitylog`
--

LOCK TABLES `adminpanel_activitylog` WRITE;
/*!40000 ALTER TABLE `adminpanel_activitylog` DISABLE KEYS */;
INSERT INTO `adminpanel_activitylog` VALUES (3,'{\"Announcement_Id\": \"0\", \"Title1\": \"New Year Offer..!\", \"Title2\": \"We have special New Year offer.\", \"Description\": \"We have special New Year offer.\"}','2021-02-01',1,21),(4,'{\"Announcement_Id\": 7, \"Title1\": \"New Year Offer..!\", \"Title2\": \"We have special New Year offer.\", \"Description\": \"We have special New Year offer in this 2021...!!\"}','2021-02-01',2,21),(5,'{\"Announcement_Id\": 7, \"Title1\": null, \"Title2\": null, \"Description\": null}','2021-02-01',3,21),(6,'{\"Announcement_Id\": 3, \"Title1\": \"Referral Discount\", \"Title2\": \"Earn points by referring someone.\", \"Description\": \"Test Description\"}','2021-02-05',2,21),(7,'{\"Announcement_Id\": 4, \"Title1\": \"Christmas Offer...!\", \"Title2\": \"Earn some discount on this Christmas...!\", \"Description\": \"Test Desc\"}','2021-02-05',2,21);
/*!40000 ALTER TABLE `adminpanel_activitylog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adminpanel_activitytype`
--

DROP TABLE IF EXISTS `adminpanel_activitytype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminpanel_activitytype` (
  `ActivityTypeId` int NOT NULL AUTO_INCREMENT,
  `ActivityType` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ActivityTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminpanel_activitytype`
--

LOCK TABLES `adminpanel_activitytype` WRITE;
/*!40000 ALTER TABLE `adminpanel_activitytype` DISABLE KEYS */;
INSERT INTO `adminpanel_activitytype` VALUES (1,'Add'),(2,'Update'),(3,'Delete');
/*!40000 ALTER TABLE `adminpanel_activitytype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adminpanel_address`
--

DROP TABLE IF EXISTS `adminpanel_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminpanel_address` (
  `Address_Id` int NOT NULL AUTO_INCREMENT,
  `Addressline1` varchar(255) DEFAULT NULL,
  `Addressline2` varchar(255) DEFAULT NULL,
  `Addressline3` varchar(255) DEFAULT NULL,
  `City` varchar(100) DEFAULT NULL,
  `State` varchar(100) DEFAULT NULL,
  `Postal_Code` varchar(50) DEFAULT NULL,
  `Country` varchar(100) DEFAULT NULL,
  `Address_Type` varchar(1) NOT NULL,
  `User_Id` int DEFAULT NULL,
  `default` tinyint(1) NOT NULL,
  `CountryCode` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Address_Id`),
  KEY `adminpanel_address_User_Id_283b9b3c_fk_adminpanel_user_id` (`User_Id`),
  CONSTRAINT `adminpanel_address_User_Id_283b9b3c_fk_adminpanel_user_id` FOREIGN KEY (`User_Id`) REFERENCES `adminpanel_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminpanel_address`
--

LOCK TABLES `adminpanel_address` WRITE;
/*!40000 ALTER TABLE `adminpanel_address` DISABLE KEYS */;
INSERT INTO `adminpanel_address` VALUES (1,'2034  Ritter Street','Harrow',NULL,'PRAIRIE DU CHIEN','Wisconsin','53821','United Kingdom','B',3,0,'GB'),(4,'69  Walwyn Road','Guild Street',NULL,NULL,'Hertfordshire','RG26 4GJ','United Kingdom','S',3,0,'GB'),(7,'2 High Street','Wheathampstead',NULL,NULL,'N/Hertfordshire','AL4 8AA','United Kingdom','B',28,0,'GB');
/*!40000 ALTER TABLE `adminpanel_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adminpanel_announcementpost`
--

DROP TABLE IF EXISTS `adminpanel_announcementpost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminpanel_announcementpost` (
  `Announcement_Id` int NOT NULL AUTO_INCREMENT,
  `Title1` varchar(2000) DEFAULT NULL,
  `Title2` varchar(2000) DEFAULT NULL,
  `Description` mediumtext,
  `PostImage` varchar(100) DEFAULT NULL,
  `IsActive` tinyint(1),
  PRIMARY KEY (`Announcement_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminpanel_announcementpost`
--

LOCK TABLES `adminpanel_announcementpost` WRITE;
/*!40000 ALTER TABLE `adminpanel_announcementpost` DISABLE KEYS */;
INSERT INTO `adminpanel_announcementpost` VALUES (1,'Full Payment','Get 10% Flat Discount on full payment...!!','Purchase any servie and by paying Full amount in one go, get 10% FLAT Discount.','',1),(2,'One month extension','Get optional extension to any plan @ £59 per month.','Ongoing support, quarterly ProLongevity reviews and upto 4 * 2 weeks of remote blood sugar monitoring to help assess the impact of any subsequent changes to lifestyle and diet, recommend remedial action and other ways to optimise health. ','',1),(3,'Referral Discount','Earn points by referring someone.','Test Description','',1),(4,'Christmas Offer...!','Earn some discount on this Christmas...!','Test Desc','',1);
/*!40000 ALTER TABLE `adminpanel_announcementpost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adminpanel_category`
--

DROP TABLE IF EXISTS `adminpanel_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminpanel_category` (
  `Category_Id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  PRIMARY KEY (`Category_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminpanel_category`
--

LOCK TABLES `adminpanel_category` WRITE;
/*!40000 ALTER TABLE `adminpanel_category` DISABLE KEYS */;
INSERT INTO `adminpanel_category` VALUES (1,'Service'),(2,'Product');
/*!40000 ALTER TABLE `adminpanel_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adminpanel_configuration`
--

DROP TABLE IF EXISTS `adminpanel_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminpanel_configuration` (
  `ConfigurationId` int NOT NULL AUTO_INCREMENT,
  `ConfigurationName` varchar(2000) DEFAULT NULL,
  `ConfigurationValue` varchar(2000) DEFAULT NULL,
  `DisplayName` varchar(2000) DEFAULT NULL,
  `Image` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ConfigurationId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminpanel_configuration`
--

LOCK TABLES `adminpanel_configuration` WRITE;
/*!40000 ALTER TABLE `adminpanel_configuration` DISABLE KEYS */;
INSERT INTO `adminpanel_configuration` VALUES (1,'EMAIL_HOST','smtp.gmail.com','EMAIL_HOST',NULL),(2,'EMAIL_ROOT','587','EMAIL_ROOT',NULL),(3,'EMAIL_HOST_USER','prolongevity123@gmail.com','EMAIL_HOST_USER',NULL),(4,'EMAIL_HOST_PASSWORD','zaq1ZAQ!','EMAIL_HOST_PASSWORD',NULL),(5,'DASHBOARD_IMAGE','None',NULL,'dashboard.jpg');
/*!40000 ALTER TABLE `adminpanel_configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adminpanel_customer`
--

DROP TABLE IF EXISTS `adminpanel_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminpanel_customer` (
  `Customer_Id` int NOT NULL AUTO_INCREMENT,
  `Phone_No` varchar(100) DEFAULT NULL,
  `Enrolled_Date` datetime(6) DEFAULT NULL,
  `First_Name` varchar(200) DEFAULT NULL,
  `Last_Name` varchar(200) DEFAULT NULL,
  `Email` varchar(200) DEFAULT NULL,
  `Gender` varchar(100) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `Referral_id` int DEFAULT NULL,
  `SameHousehold_id` int DEFAULT NULL,
  `ReferralDiscount_id` int DEFAULT NULL,
  `PersonalDiscount` double,
  `Stripe_Id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Customer_Id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `adminpanel_customer_Referral_id_67a53477_fk_adminpane` (`Referral_id`),
  KEY `adminpanel_customer_SameHousehold_id_99236a7f_fk_adminpane` (`SameHousehold_id`),
  KEY `adminpanel_customer_ReferralDiscount_id_ae95c9a9_fk_adminpane` (`ReferralDiscount_id`),
  CONSTRAINT `adminpanel_customer_Referral_id_67a53477_fk_adminpane` FOREIGN KEY (`Referral_id`) REFERENCES `adminpanel_customer` (`Customer_Id`),
  CONSTRAINT `adminpanel_customer_ReferralDiscount_id_ae95c9a9_fk_adminpane` FOREIGN KEY (`ReferralDiscount_id`) REFERENCES `adminpanel_discounttype` (`Discount_Type_Id`),
  CONSTRAINT `adminpanel_customer_SameHousehold_id_99236a7f_fk_adminpane` FOREIGN KEY (`SameHousehold_id`) REFERENCES `adminpanel_customer` (`Customer_Id`),
  CONSTRAINT `adminpanel_customer_user_id_248e5b2d_fk_adminpanel_user_id` FOREIGN KEY (`user_id`) REFERENCES `adminpanel_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminpanel_customer`
--

LOCK TABLES `adminpanel_customer` WRITE;
/*!40000 ALTER TABLE `adminpanel_customer` DISABLE KEYS */;
INSERT INTO `adminpanel_customer` VALUES (1,'1234567890','2020-08-27 16:12:28.000000','Kinjal','Trivedi','kinju1220@gmail.com','Female',3,NULL,NULL,NULL,0,NULL),(6,'1234567890','2020-09-29 15:40:49.000000','Sara','William','sara@gmail.com','Female',8,NULL,NULL,NULL,0,NULL),(8,'8978987654','2020-10-01 18:20:58.000000','Jim','Carie','jim@gmail.com','Male',10,NULL,NULL,NULL,6,NULL),(13,NULL,'2020-10-08 19:00:53.000000','KinjalRef','TrivediRef','chaudharykinjal_1987@yahoo.com',NULL,20,1,NULL,NULL,0,NULL),(16,NULL,'2021-02-03 17:45:48.000000','Dharmik','Trivedi','dharmiktrivedi@ymail.com',NULL,27,NULL,NULL,NULL,0,NULL),(17,NULL,'2021-02-19 16:21:56.000000','Don','Cooney','don@gmail.com',NULL,28,NULL,NULL,NULL,0,NULL);
/*!40000 ALTER TABLE `adminpanel_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adminpanel_customerdiscounteligibility`
--

DROP TABLE IF EXISTS `adminpanel_customerdiscounteligibility`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminpanel_customerdiscounteligibility` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `DiscountApplicableLimit` int DEFAULT NULL,
  `Customer_id` int DEFAULT NULL,
  `DiscountType_Id` int DEFAULT NULL,
  `IsUsed` tinyint(1),
  PRIMARY KEY (`Id`),
  KEY `adminpanel_customerd_Customer_id_a1478227_fk_adminpane` (`Customer_id`),
  CONSTRAINT `adminpanel_customerd_Customer_id_a1478227_fk_adminpane` FOREIGN KEY (`Customer_id`) REFERENCES `adminpanel_customer` (`Customer_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminpanel_customerdiscounteligibility`
--

LOCK TABLES `adminpanel_customerdiscounteligibility` WRITE;
/*!40000 ALTER TABLE `adminpanel_customerdiscounteligibility` DISABLE KEYS */;
INSERT INTO `adminpanel_customerdiscounteligibility` VALUES (2,1,1,6,0),(3,1,1,4,0),(4,1,16,1,0),(5,1,16,6,0);
/*!40000 ALTER TABLE `adminpanel_customerdiscounteligibility` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adminpanel_discounttype`
--

DROP TABLE IF EXISTS `adminpanel_discounttype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminpanel_discounttype` (
  `Discount_Type_Id` int NOT NULL AUTO_INCREMENT,
  `DiscountCode` varchar(50) NOT NULL,
  `Percentage` double DEFAULT NULL,
  `DiscountFrom` date DEFAULT NULL,
  `DiscountTo` date DEFAULT NULL,
  `DiscountDescription` varchar(100) DEFAULT NULL,
  `IsReferralDiscount` tinyint(1),
  PRIMARY KEY (`Discount_Type_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminpanel_discounttype`
--

LOCK TABLES `adminpanel_discounttype` WRITE;
/*!40000 ALTER TABLE `adminpanel_discounttype` DISABLE KEYS */;
INSERT INTO `adminpanel_discounttype` VALUES (1,'GET5',5,'2020-08-01','2025-07-31',NULL,0),(2,'Other Client',8,'2020-08-01',NULL,NULL,0),(3,'Fulltime Payment',10,'2020-09-01','2021-12-14',NULL,0),(4,'GETDISC',5,'2020-10-01',NULL,'Discount is for Testing.',0),(6,'GETPRODISC',7,'2020-10-01',NULL,'Discount applies on product only.',0);
/*!40000 ALTER TABLE `adminpanel_discounttype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adminpanel_installmentdue`
--

DROP TABLE IF EXISTS `adminpanel_installmentdue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminpanel_installmentdue` (
  `Installment_Due_Id` int NOT NULL AUTO_INCREMENT,
  `Due_Installments` int DEFAULT NULL,
  `Order_id` int DEFAULT NULL,
  `Amount_Due` double DEFAULT NULL,
  `InstalmentDueDate` datetime(6),
  `InstalmentReminderDay` int,
  `PaymentRefId` int DEFAULT NULL,
  `Customer_Id` int DEFAULT NULL,
  `User_Id` int DEFAULT NULL,
  `IsInstalmentPaid` tinyint(1),
  `OrderDetail_id` int DEFAULT NULL,
  PRIMARY KEY (`Installment_Due_Id`),
  KEY `adminpanel_installme_Order_id_1060f3a8_fk_adminpane` (`Order_id`),
  KEY `adminpanel_installme_OrderDetail_id_ad3fdc93_fk_adminpane` (`OrderDetail_id`),
  CONSTRAINT `adminpanel_installme_Order_id_1060f3a8_fk_adminpane` FOREIGN KEY (`Order_id`) REFERENCES `adminpanel_order` (`Order_Id`),
  CONSTRAINT `adminpanel_installme_OrderDetail_id_ad3fdc93_fk_adminpane` FOREIGN KEY (`OrderDetail_id`) REFERENCES `adminpanel_orderdetails` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminpanel_installmentdue`
--

LOCK TABLES `adminpanel_installmentdue` WRITE;
/*!40000 ALTER TABLE `adminpanel_installmentdue` DISABLE KEYS */;
INSERT INTO `adminpanel_installmentdue` VALUES (81,1,92,295,'2020-12-18 00:00:00.000000',5,87,1,3,1,218),(82,2,92,295,'2021-01-01 00:00:00.000000',5,92,1,3,1,218),(83,1,95,295,'2020-12-24 00:00:00.000000',5,88,1,3,1,NULL),(84,2,95,295,'2021-01-07 00:00:00.000000',5,93,1,3,1,NULL),(85,1,96,159,'2020-12-25 00:00:00.000000',5,90,1,3,1,224),(86,2,96,159,'2021-01-27 00:00:00.000000',5,NULL,1,3,0,224),(87,3,96,159,'2021-02-05 00:00:00.000000',5,NULL,1,3,0,224),(88,4,96,159,'2021-03-05 00:00:00.000000',5,NULL,1,3,0,224),(89,5,96,159,'2021-04-02 00:00:00.000000',5,NULL,1,3,0,224),(90,6,96,159,'2021-04-30 00:00:00.000000',5,NULL,1,3,0,224),(91,1,119,159,'2021-02-25 00:00:00.000000',5,NULL,16,27,0,259),(92,2,119,159,'2021-03-11 00:00:00.000000',5,NULL,16,27,0,259),(93,3,119,159,'2021-04-08 00:00:00.000000',5,NULL,16,27,0,259),(94,4,119,159,'2021-05-06 00:00:00.000000',5,NULL,16,27,0,259),(95,5,119,159,'2021-06-03 00:00:00.000000',5,NULL,16,27,0,259),(96,6,119,159,'2021-07-01 00:00:00.000000',5,NULL,16,27,0,259),(97,1,123,295,'2021-03-08 00:00:00.000000',5,NULL,17,28,0,267),(98,2,123,295,'2021-03-22 00:00:00.000000',5,NULL,17,28,0,267);
/*!40000 ALTER TABLE `adminpanel_installmentdue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adminpanel_installmenttype`
--

DROP TABLE IF EXISTS `adminpanel_installmenttype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminpanel_installmenttype` (
  `Installment_Type_Id` int NOT NULL AUTO_INCREMENT,
  `Installment_Type` varchar(50) NOT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `Installment_TypeUnchanged` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Installment_Type_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminpanel_installmenttype`
--

LOCK TABLES `adminpanel_installmenttype` WRITE;
/*!40000 ALTER TABLE `adminpanel_installmenttype` DISABLE KEYS */;
INSERT INTO `adminpanel_installmenttype` VALUES (1,'ProLongevity Light','\"ProLongevity Lite\" service provides 2 months installment plan.',NULL),(2,'ProLongevity Silver','\"ProLongevity Silver\" service provides 6 months installment plan.',NULL),(3,'ProLongevity Gold','\"ProLongevity Gold\" service provides 12 months installment plan.',NULL),(4,'Full Payment','Full payment in one go.',NULL);
/*!40000 ALTER TABLE `adminpanel_installmenttype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adminpanel_invoice`
--

DROP TABLE IF EXISTS `adminpanel_invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminpanel_invoice` (
  `InvoiceId` int NOT NULL AUTO_INCREMENT,
  `InvoiceNumber` varchar(50) DEFAULT NULL,
  `Filename` varchar(2000) DEFAULT NULL,
  `CreatedBy` varchar(200) DEFAULT NULL,
  `Content` varchar(100) DEFAULT NULL,
  `Date` datetime(6) DEFAULT NULL,
  `Order_id` int DEFAULT NULL,
  PRIMARY KEY (`InvoiceId`),
  KEY `adminpanel_invoice_Order_id_236462ff_fk_adminpane` (`Order_id`),
  CONSTRAINT `adminpanel_invoice_Order_id_236462ff_fk_adminpane` FOREIGN KEY (`Order_id`) REFERENCES `adminpanel_order` (`Order_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminpanel_invoice`
--

LOCK TABLES `adminpanel_invoice` WRITE;
/*!40000 ALTER TABLE `adminpanel_invoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `adminpanel_invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adminpanel_order`
--

DROP TABLE IF EXISTS `adminpanel_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminpanel_order` (
  `Order_Id` int NOT NULL AUTO_INCREMENT,
  `Order_Date` datetime(6) DEFAULT NULL,
  `IsOrderCompleted` tinyint(1) DEFAULT NULL,
  `Transaction_Id` varchar(200) DEFAULT NULL,
  `Customer_id` int DEFAULT NULL,
  `ConditionalVAT` double DEFAULT NULL,
  `GeneralVAT` double DEFAULT NULL,
  `ProductDiscountCode` int DEFAULT NULL,
  `ProductTotalAmount` double DEFAULT NULL,
  `ServiceDiscountAmount` double DEFAULT NULL,
  `ServiceDiscountCode` int DEFAULT NULL,
  `ServiceTotalAmount` double DEFAULT NULL,
  `OrderCompletionDate` date,
  `ActualAmountToPay` double DEFAULT NULL,
  `FullPaymentDiscountAmount` double DEFAULT NULL,
  `OrderStatus_id` int DEFAULT NULL,
  PRIMARY KEY (`Order_Id`),
  KEY `adminpanel_order_Customer_id_19f4f916_fk_adminpane` (`Customer_id`),
  KEY `adminpanel_order_OrderStatus_id_fa317141_fk_adminpane` (`OrderStatus_id`),
  CONSTRAINT `adminpanel_order_Customer_id_19f4f916_fk_adminpane` FOREIGN KEY (`Customer_id`) REFERENCES `adminpanel_customer` (`Customer_Id`),
  CONSTRAINT `adminpanel_order_OrderStatus_id_fa317141_fk_adminpane` FOREIGN KEY (`OrderStatus_id`) REFERENCES `adminpanel_orderstatus` (`OrderStatusId`)
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminpanel_order`
--

LOCK TABLES `adminpanel_order` WRITE;
/*!40000 ALTER TABLE `adminpanel_order` DISABLE KEYS */;
INSERT INTO `adminpanel_order` VALUES (81,'2020-11-13 09:25:39.975835',1,'1605259798.925719',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-11-13',1249,124.9,1),(82,'2020-11-13 09:30:37.064436',1,'1606426935.532863',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-11-13',895.99,88.5,1),(83,'2020-11-26 21:59:31.265863',1,'1606477461.719903',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-11-26',964,88.5,1),(84,'2020-11-27 12:17:15.380203',1,'1606479499.637203',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-11-27',904.98,88.5,1),(85,'2020-11-30 10:46:14.914979',1,'1606733265.260012',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-11-30',894.99,88.5,1),(90,'2020-11-30 11:05:55.187994',1,'1606735499.350399',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-11-30',894.99,88.5,1),(91,'2020-12-02 18:45:43.737745',1,'1607079019.037236',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-12-02',885,88.5,1),(92,'2020-12-04 10:51:21.950236',1,'1607079191.856236',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-12-04',895.99,NULL,1),(93,'2020-12-04 10:53:35.386236',1,'1607081064.127236',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-12-04',895.99,88.5,1),(94,'2020-12-04 11:25:27.448236',1,'1607419131.076951',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-12-04',885,88.5,1),(95,'2020-12-08 09:19:57.392951',1,'1607620262.434962',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-12-08',885,NULL,1),(96,'2020-12-11 09:58:21.645282',1,'1607681320.975282',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-12-11',1259.99,NULL,1),(97,'2020-12-15 16:50:49.419077',1,'1610019260.708484',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-12-15',964,88.5,1),(98,'2021-01-13 16:59:04.941749',1,'1610557669.236749',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-13',885,88.5,1),(99,'2021-01-13 17:09:57.655749',1,'1610558688.110749',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-13',79,0,1),(100,'2021-01-13 18:09:46.467749',1,'1610562485.511749',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-13',79,0,1),(101,'2021-01-15 14:06:21.505396',1,'1610719664.672396',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-15',79,0,1),(102,'2021-01-18 10:42:33.019511',1,'1612537354.75906',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-18',964,88.5,1),(103,'2021-01-21 22:36:26.981620',1,'1611268613.781277',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-21',964,88.5,1),(104,'2021-02-03 18:22:50.473722',1,'1612527386.929362',16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-02-03',964,88.5,1),(105,'2021-02-05 12:16:29.524362',1,'1612542177.657582',16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-02-05',895.99,88.5,1),(106,'2021-02-05 15:02:36.438240',1,'1612537853.570131',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-02-05',1259.99,124.9,1),(107,'2021-02-05 15:10:55.092892',1,'1612538088.883169',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-02-05',10.99,0,1),(108,'2021-02-05 15:14:50.507494',1,'1612538385.011697',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-02-05',9.99,0,1),(109,'2021-02-05 15:19:46.963893',1,'1612538574.412135',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-02-05',9.99,0,1),(110,'2021-02-05 15:22:56.062300',1,'1612539118.500428',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-02-05',10.99,0,1),(111,'2021-02-05 15:32:00.282606',1,'1612539181.268582',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-02-05',79,0,3),(112,'2021-02-05 15:33:02.877582',1,'1612539610.326582',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-02-05',10.99,0,1),(113,'2021-02-05 15:40:12.413582',1,'1612539862.179582',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-02-05',10.99,0,2),(114,'2021-02-05 15:44:26.279582',1,'1612812942.924876',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-02-05',79,0,2),(115,'2021-02-05 16:23:01.349582',1,'1613075245.898879',16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-02-05',895.99,88.5,1),(116,'2021-02-08 19:35:44.903876',1,'1612813156.306876',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-02-08',10.99,0,3),(117,'2021-02-08 19:39:18.130876',1,'1613074737.657724',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-02-08',1445.99,143.5,1),(118,'2021-02-11 20:18:59.915949',0,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-02-11',NULL,NULL,NULL),(119,'2021-02-11 20:27:28.874177',1,'1613075448.111031',16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-02-11',1258.99,NULL,3),(120,'2021-02-11 20:30:52.699489',0,NULL,16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-02-11',NULL,NULL,NULL),(121,'2021-02-19 16:29:10.734164',1,'1613753960.200064',17,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-02-19',885,88.5,1),(122,'2021-02-19 16:59:22.239268',1,'1613990491.947872',17,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-02-19',1610,161,1),(123,'2021-02-22 10:41:34.379115',1,'1613995927.158748',17,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-02-22',964,NULL,1),(124,'2021-02-22 12:12:09.283960',0,NULL,17,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-02-22',NULL,NULL,NULL);
/*!40000 ALTER TABLE `adminpanel_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adminpanel_orderdetails`
--

DROP TABLE IF EXISTS `adminpanel_orderdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminpanel_orderdetails` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Quantity` int DEFAULT NULL,
  `Date_Added` datetime(6) DEFAULT NULL,
  `Order_Id` int DEFAULT NULL,
  `Product_Id` int DEFAULT NULL,
  `TotalNoOfPerson` int,
  PRIMARY KEY (`id`),
  KEY `adminpanel_orderdeta_Order_Id_a72b6469_fk_adminpane` (`Order_Id`),
  KEY `adminpanel_orderdeta_Product_Id_77be100b_fk_adminpane` (`Product_Id`),
  CONSTRAINT `adminpanel_orderdeta_Order_Id_a72b6469_fk_adminpane` FOREIGN KEY (`Order_Id`) REFERENCES `adminpanel_order` (`Order_Id`),
  CONSTRAINT `adminpanel_orderdeta_Product_Id_77be100b_fk_adminpane` FOREIGN KEY (`Product_Id`) REFERENCES `adminpanel_product` (`Product_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=268 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminpanel_orderdetails`
--

LOCK TABLES `adminpanel_orderdetails` WRITE;
/*!40000 ALTER TABLE `adminpanel_orderdetails` DISABLE KEYS */;
INSERT INTO `adminpanel_orderdetails` VALUES (201,1,'2020-11-13 09:25:40.253863',81,2,1),(202,1,'2020-11-13 09:30:37.202450',82,1,1),(203,1,'2020-11-26 21:16:19.666863',82,6,1),(204,1,'2020-11-27 11:09:58.713623',83,1,1),(205,1,'2020-11-27 11:43:48.835615',83,5,1),(206,2,'2020-11-27 12:17:15.488203',84,8,1),(207,1,'2020-11-27 12:17:26.420203',84,1,1),(208,1,'2020-11-30 10:46:15.136001',85,8,1),(209,1,'2020-11-30 10:46:22.510738',85,1,1),(214,1,'2020-11-30 11:05:55.303006',90,8,1),(215,1,'2020-11-30 11:06:02.612736',90,1,1),(216,1,'2020-12-02 18:45:43.824753',91,1,1),(217,1,'2020-12-04 10:51:22.090236',92,6,1),(218,1,'2020-12-04 10:51:35.924236',92,1,1),(219,1,'2020-12-04 11:22:34.965236',93,6,1),(220,1,'2020-12-04 11:23:50.028236',93,1,1),(221,1,'2020-12-04 11:25:27.526236',94,1,1),(222,1,'2020-12-08 09:19:57.471951',95,1,1),(223,1,'2020-12-11 09:58:21.804282',96,6,1),(224,1,'2020-12-11 09:58:33.249282',96,2,1),(225,1,'2020-12-15 16:50:49.651332',97,5,1),(226,1,'2021-01-07 11:14:17.153484',97,1,1),(227,1,'2021-01-13 16:59:05.186749',98,1,1),(228,1,'2021-01-13 17:09:57.911749',99,5,1),(229,1,'2021-01-13 18:09:46.549749',100,5,1),(230,1,'2021-01-15 14:06:21.670396',101,5,1),(231,1,'2021-01-18 10:42:33.996511',102,5,1),(232,1,'2021-01-21 22:36:27.210643',103,5,1),(233,1,'2021-01-21 22:36:33.185237',103,1,1),(234,1,'2021-02-03 18:22:51.442819',104,5,1),(235,1,'2021-02-03 18:23:06.297273',104,1,1),(236,1,'2021-02-05 15:01:54.505362',102,1,1),(237,1,'2021-02-05 15:10:01.102960',106,6,1),(238,1,'2021-02-05 15:10:12.801807',106,2,1),(239,1,'2021-02-05 15:14:17.708986',107,6,1),(240,1,'2021-02-05 15:19:16.199884',108,8,1),(241,1,'2021-02-05 15:22:27.811542',109,8,1),(242,1,'2021-02-05 15:29:41.107454',110,6,1),(243,1,'2021-02-05 15:32:33.309582',111,5,1),(244,1,'2021-02-05 15:39:47.131582',112,6,1),(245,1,'2021-02-05 15:43:57.216582',113,6,1),(246,1,'2021-02-05 15:47:22.213582',105,6,1),(247,1,'2021-02-05 15:50:22.394582',105,1,1),(248,1,'2021-02-08 11:04:10.595508',115,6,1),(249,1,'2021-02-08 11:18:20.459508',115,1,1),(250,1,'2021-02-08 18:04:58.242876',114,5,1),(251,1,'2021-02-08 19:38:25.905876',116,6,1),(256,1,'2021-02-11 20:18:26.592635',117,6,1),(257,1,'2021-02-11 20:18:35.665542',117,3,1),(258,1,'2021-02-11 20:28:12.271922',119,8,1),(259,1,'2021-02-11 20:28:19.311626',119,2,1),(260,1,'2021-02-12 15:05:46.662413',118,6,1),(262,1,'2021-02-19 16:38:31.691673',121,1,1),(265,1,'2021-02-22 10:19:51.160928',122,1,2),(266,1,'2021-02-22 11:18:41.907936',123,5,1),(267,1,'2021-02-22 11:20:00.247391',123,1,1);
/*!40000 ALTER TABLE `adminpanel_orderdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adminpanel_orderdiscount`
--

DROP TABLE IF EXISTS `adminpanel_orderdiscount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminpanel_orderdiscount` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Order_id` int DEFAULT NULL,
  `DiscountType_Id` int DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `adminpanel_orderdisc_Order_id_55d8d812_fk_adminpane` (`Order_id`),
  CONSTRAINT `adminpanel_orderdisc_Order_id_55d8d812_fk_adminpane` FOREIGN KEY (`Order_id`) REFERENCES `adminpanel_order` (`Order_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminpanel_orderdiscount`
--

LOCK TABLES `adminpanel_orderdiscount` WRITE;
/*!40000 ALTER TABLE `adminpanel_orderdiscount` DISABLE KEYS */;
/*!40000 ALTER TABLE `adminpanel_orderdiscount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adminpanel_orderstatus`
--

DROP TABLE IF EXISTS `adminpanel_orderstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminpanel_orderstatus` (
  `OrderStatusId` int NOT NULL AUTO_INCREMENT,
  `OrderStatusType` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`OrderStatusId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminpanel_orderstatus`
--

LOCK TABLES `adminpanel_orderstatus` WRITE;
/*!40000 ALTER TABLE `adminpanel_orderstatus` DISABLE KEYS */;
INSERT INTO `adminpanel_orderstatus` VALUES (1,'Placed'),(2,'Processed'),(3,'Shipped'),(4,'Canceled');
/*!40000 ALTER TABLE `adminpanel_orderstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adminpanel_payment`
--

DROP TABLE IF EXISTS `adminpanel_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminpanel_payment` (
  `Payment_Id` int NOT NULL AUTO_INCREMENT,
  `Payment_Type` varchar(50) DEFAULT NULL,
  `Amount` double DEFAULT NULL,
  `Date` datetime(6) DEFAULT NULL,
  `Is_Invoice_Sent` tinyint(1) DEFAULT NULL,
  `Discount_Type_id` int DEFAULT NULL,
  `Installment_Type_id` int DEFAULT NULL,
  `Order_id` int DEFAULT NULL,
  `Stripe_Payment_Id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Payment_Id`),
  KEY `adminpanel_payment_Discount_Type_id_963aa1a4_fk_adminpane` (`Discount_Type_id`),
  KEY `adminpanel_payment_Installment_Type_id_e2fd720f_fk_adminpane` (`Installment_Type_id`),
  KEY `adminpanel_payment_Order_id_9eb1a056_fk_adminpane` (`Order_id`),
  CONSTRAINT `adminpanel_payment_Discount_Type_id_963aa1a4_fk_adminpane` FOREIGN KEY (`Discount_Type_id`) REFERENCES `adminpanel_discounttype` (`Discount_Type_Id`),
  CONSTRAINT `adminpanel_payment_Installment_Type_id_e2fd720f_fk_adminpane` FOREIGN KEY (`Installment_Type_id`) REFERENCES `adminpanel_installmenttype` (`Installment_Type_Id`),
  CONSTRAINT `adminpanel_payment_Order_id_9eb1a056_fk_adminpane` FOREIGN KEY (`Order_id`) REFERENCES `adminpanel_order` (`Order_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminpanel_payment`
--

LOCK TABLES `adminpanel_payment` WRITE;
/*!40000 ALTER TABLE `adminpanel_payment` DISABLE KEYS */;
INSERT INTO `adminpanel_payment` VALUES (67,'Card',1124.1,'2020-11-13 09:29:59.000726',1,NULL,NULL,81,NULL),(68,'Card',807.49,'2020-11-16 15:23:12.215909',1,NULL,NULL,82,NULL),(69,'Card',875.5,'2020-11-27 11:10:32.027954',1,NULL,NULL,83,NULL),(70,'Card',816.48,'2020-11-27 12:18:19.709203',1,NULL,NULL,84,NULL),(71,'Card',806.49,'2020-11-30 10:47:45.346021',1,NULL,NULL,85,NULL),(76,'Card',806.49,'2020-11-30 11:24:59.393403',1,NULL,NULL,90,NULL),(77,'Card',796.5,'2020-12-02 18:47:57.355105',1,NULL,NULL,91,NULL),(78,'Card',295,'2020-12-10 00:00:00.000000',1,NULL,NULL,92,'ch_1HwtKSEawDj2LGF8QmXZPCWl'),(79,'Card',807.49,'2020-12-04 11:24:24.200236',1,NULL,NULL,93,NULL),(80,'Card',796.5,'2020-12-08 09:18:51.106951',1,NULL,NULL,94,NULL),(81,'Card',295,'2020-12-10 17:11:02.526962',1,NULL,NULL,95,'ch_1HwsfVEawDj2LGF845zztJ8e'),(87,'Card',295,'2020-12-10 00:00:00.000000',1,NULL,NULL,92,'ch_1HwutDEawDj2LGF8te1r81ca'),(88,'Card',295,'2020-12-11 00:00:00.000000',1,NULL,NULL,95,'ch_1Hx8MVEawDj2LGF8icYz9vjm'),(89,'Card',305.99,'2020-12-11 10:08:41.052282',1,NULL,NULL,96,'ch_1Hx8YKEawDj2LGF8wEfYtORY'),(90,'Card',159,'2020-12-11 00:00:00.000000',1,NULL,NULL,96,'ch_1Hx8mHEawDj2LGF8fCS5x5HP'),(92,'Card',295,'2020-12-11 00:00:00.000000',1,NULL,NULL,92,'ch_1Hx8zREawDj2LGF8rlfOjBu2'),(93,'Card',295,'2020-12-11 00:00:00.000000',1,NULL,NULL,95,'ch_1Hx9WHEawDj2LGF8C39nS9zs'),(94,'Card',875.5,'2021-01-07 11:34:20.770484',1,NULL,NULL,97,'ch_1I6wkzEawDj2LGF8uO2bCHRv'),(95,'Card',796.5,'2021-01-13 17:07:49.442749',1,NULL,NULL,98,'ch_1I9Cp0EawDj2LGF8Ion9C8ct'),(96,'Card',79,'2021-01-13 17:10:17.079749',1,NULL,NULL,99,'ch_1I9D5QEawDj2LGF8ONtsYu2O'),(97,'Card',79,'2021-01-13 18:28:05.608749',1,NULL,NULL,100,'ch_1I9E4gEawDj2LGF8rnp94Dih'),(98,'Card',79,'2021-01-15 14:07:44.697396',1,NULL,NULL,101,'ch_1I9sxqEawDj2LGF8Z2jdx3CD'),(99,'Card',875.5,'2021-01-21 22:36:54.461345',1,NULL,NULL,103,'ch_1ICBlsEawDj2LGF8GIo7S55v'),(100,'Card',875.5,'2021-02-05 12:16:26.969362',1,NULL,NULL,104,'ch_1IHTEeEawDj2LGF8HV4DpTS6'),(101,'Card',875.5,'2021-02-05 15:02:34.782090',1,NULL,NULL,102,'ch_1IHVpPEawDj2LGF8kXGhwDmu'),(102,'Card',1135.09,'2021-02-05 15:10:53.615153',1,NULL,NULL,106,'ch_1IHVxSEawDj2LGF8MNHq25lY'),(103,'Card',10.99,'2021-02-05 15:14:48.908174',1,NULL,NULL,107,'ch_1IHW1FEawDj2LGF8eG47iC02'),(104,'Card',9.99,'2021-02-05 15:19:45.043701',1,NULL,NULL,108,'ch_1IHW61EawDj2LGF8FrDqCh8j'),(105,'Card',9.99,'2021-02-05 15:22:54.457139',1,NULL,NULL,109,'ch_1IHW94EawDj2LGF8pW2TXBsD'),(106,'Card',10.99,'2021-02-05 15:31:58.559434',1,NULL,NULL,110,'ch_1IHWHrEawDj2LGF8s09BZkFM'),(107,'Card',79,'2021-02-05 15:33:01.291582',1,NULL,NULL,111,'ch_1IHWIrEawDj2LGF8Zpo6zLct'),(108,'Card',10.99,'2021-02-05 15:40:10.387582',1,NULL,NULL,112,'ch_1IHWPmEawDj2LGF8gdyDHGXw'),(109,'Card',10.99,'2021-02-05 15:44:22.220582',1,NULL,NULL,113,'ch_1IHWTqEawDj2LGF8YnK1rvMv'),(110,'Card',807.49,'2021-02-05 16:22:57.714582',1,NULL,NULL,105,'ch_1IHX5CEawDj2LGF8f2LeEkEY'),(111,'Card',79,'2021-02-08 19:19:34.789876',0,NULL,NULL,114,NULL),(112,'Card',10.99,'2021-02-08 19:39:16.365876',0,NULL,NULL,116,NULL),(113,'Card',1302.49,'2021-02-11 20:18:57.713729',0,NULL,NULL,117,NULL),(114,'Card',807.49,'2021-02-11 20:21:28.585824',0,NULL,NULL,115,NULL),(115,'Card',304.99,'2021-02-11 20:30:48.136033',0,NULL,NULL,119,NULL),(116,'Card',796.5,'2021-02-19 16:59:20.275071',0,NULL,NULL,121,NULL),(117,'Card',1449,'2021-02-22 10:41:32.005877',0,NULL,NULL,122,NULL),(118,'Card',374,'2021-02-22 12:12:07.216753',0,NULL,NULL,123,NULL);
/*!40000 ALTER TABLE `adminpanel_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adminpanel_product`
--

DROP TABLE IF EXISTS `adminpanel_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminpanel_product` (
  `Product_Id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Code` varchar(255) NOT NULL,
  `Description` varchar(2000) NOT NULL,
  `Price` double DEFAULT '0',
  `Image` varchar(100) DEFAULT NULL,
  `InitialSetupCharge` double DEFAULT '0',
  `IsProduct` tinyint(1),
  `NoOfInstallmentMonths` int DEFAULT '0',
  `IsDiscountable` tinyint(1),
  `DiscountPercentage` double DEFAULT NULL,
  `AdditionalMemberPrice` double,
  `slug` varchar(50) DEFAULT NULL,
  `DetailDescription` longtext,
  `Category_id` int DEFAULT NULL,
  `StockLevel` int,
  `Threshold` int,
  PRIMARY KEY (`Product_Id`),
  KEY `adminpanel_product_slug_3d965bc3` (`slug`),
  KEY `adminpanel_product_Category_id_5f0a2ac4_fk_adminpane` (`Category_id`),
  CONSTRAINT `adminpanel_product_Category_id_5f0a2ac4_fk_adminpane` FOREIGN KEY (`Category_id`) REFERENCES `adminpanel_category` (`Category_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminpanel_product`
--

LOCK TABLES `adminpanel_product` WRITE;
/*!40000 ALTER TABLE `adminpanel_product` DISABLE KEYS */;
INSERT INTO `adminpanel_product` VALUES (1,'ProLongevity Lite Service','PR101','ProLongevity Light Service',295,'Product1_1.png',295,0,2,1,0,215,'proLongevity-lite-service','',NULL,1,10),(2,'ProLongevity Silver Service','PR102','ProLongevity Silver Service',159,'Product2_1.png',295,0,6,1,0,129,'proLongevity-silver-service','',NULL,1,10),(3,'ProLongevity Gold Service','PR103','ProLongevity Gold Service',95,'Product3_1.png',295,0,12,1,0,69,'proLongevity-gold-service','',NULL,1,10),(5,'Symprove (4 Week Pack)','SYM01','Symprove Original Formula helps to support the gut microbiome and balance gut bacteria. It is a water-based formulation that contains four unique strains of live activated bacteria.',79,'symprove_1.png',0,1,1,0,0,0,'symprove','None',NULL,91,10),(6,'MagCitra','MC01','HealthAid MagCitra Tablets contains Magnesium Citrate, which is one of the most absorbable forms of Magnesium. It is an essential mineral that plays a key role in supporting cardiovascular health, and maintaining healthy muscle contraction, and easing cramps. Magnesium encourages the development and maintenance of healthy bones and teeth, making it especially essential during pregnancy, breastfeeding, and for postmenopausal women. It also helps provide support to women during their menstrual cycles.',10.99,'MagCitra_1.png',0,1,1,0,0,0,'magcitra','None',NULL,65,10),(8,'Vitamin D + K2 Oral Spray','VITAMINK2-001','Vitamin K2 Oral Spray is an optimal strength daily vitamin K2 supplement. This unique formulation provides fast and effective absorption of this vital nutrient, supporting normal blood clotting and bone health.',9.99,'D.png',0,1,1,0,0,0,'vitamin-k2-oral-spray','None',NULL,17,10),(9,'Sensor & Reader','S01','Sensor',59.5,'Sensor.png',0,1,1,0,7.57,0,'sensor','None',NULL,30,10);
/*!40000 ALTER TABLE `adminpanel_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adminpanel_productspecification`
--

DROP TABLE IF EXISTS `adminpanel_productspecification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminpanel_productspecification` (
  `ProductSpec_Id` int NOT NULL AUTO_INCREMENT,
  `SpecificationName` varchar(2000) DEFAULT NULL,
  `SpecificationValue` varchar(2000) DEFAULT NULL,
  `Product_Id` int DEFAULT NULL,
  PRIMARY KEY (`ProductSpec_Id`),
  KEY `adminpanel_productsp_Product_Id_7e5eef41_fk_adminpane` (`Product_Id`),
  CONSTRAINT `adminpanel_productsp_Product_Id_7e5eef41_fk_adminpane` FOREIGN KEY (`Product_Id`) REFERENCES `adminpanel_product` (`Product_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminpanel_productspecification`
--

LOCK TABLES `adminpanel_productspecification` WRITE;
/*!40000 ALTER TABLE `adminpanel_productspecification` DISABLE KEYS */;
/*!40000 ALTER TABLE `adminpanel_productspecification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adminpanel_user`
--

DROP TABLE IF EXISTS `adminpanel_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminpanel_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `user_type_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `adminpanel_user_user_type_id_1d698fde_fk_adminpane` (`user_type_id`),
  CONSTRAINT `adminpanel_user_user_type_id_1d698fde_fk_adminpane` FOREIGN KEY (`user_type_id`) REFERENCES `adminpanel_usertype` (`UserTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminpanel_user`
--

LOCK TABLES `adminpanel_user` WRITE;
/*!40000 ALTER TABLE `adminpanel_user` DISABLE KEYS */;
INSERT INTO `adminpanel_user` VALUES (1,'pbkdf2_sha256$180000$5DxKDq66AJAz$+8OvfKcf29cZ817GtK7349auoldUn7tnjcfLcz/Ytso=','2021-02-24 11:52:05.777946',1,'superadmin','','','superadmin@gmail.com',1,1,'2020-08-27 14:54:25.630958',5),(3,'pbkdf2_sha256$180000$Ht8vYvRNBXBR$Lkd8HQ6LZbQLNRDIm+uZo31y0+uA4OXyLS97ibLz6L0=','2021-02-24 10:57:37.509946',0,'Kinjal777','Kinjal','Trivedi','kinju1220@gmail.com',0,1,'2020-08-27 16:12:28.000000',4),(8,'pbkdf2_sha256$180000$xMjIf3WB38lu$dCgF/2l0jhKTJsvReJUGeyae8g5erCb8HJx7+77XXhw=',NULL,0,'Sara','Sara','William','sara@gmail.com',0,1,'2020-09-29 15:40:49.000000',4),(9,'pbkdf2_sha256$180000$TbQ9NKyvnIto$S4AiZAhPAw5r9Sm3CnwTQ3Vy1Q4KlaGIhtf/kzITCXo=','2021-01-21 22:36:19.777940',0,'Thomas','Thomas','Greco','tom@gmail.com',0,1,'2020-09-29 15:45:17.000000',4),(10,'pbkdf2_sha256$180000$tPgtt27hLm0M$hTPlga/pgxXZKvL9HBR0jhYxeJClBTlHW7KB7xJVt88=','2020-10-05 15:21:32.008256',0,'Jim','Jim','Carie','jim@gmail.com',0,1,'2020-10-01 18:20:58.000000',4),(20,'pbkdf2_sha256$180000$2eDXQrHJT8Ek$lOcD9QrbErfsKVIdQNF9gDGlOtqMHiqBedfCLhJ1wgQ=','2020-10-08 19:21:26.792373',0,'KinjalRef','KinjalRef','TrivediRef','chaudharykinjal_1987@yahoo.com',0,1,'2020-10-08 19:00:53.000000',4),(21,'pbkdf2_sha256$180000$JQNulIvqBfde$P3T7nPtkQW4WoZ6SSSMdsyavcsyrnpDhBD/rZCozltY=','2021-02-19 09:15:05.519236',0,'adminone','Admin','One','adminone@gmail.com',1,1,'2021-01-04 11:52:54.827283',1),(22,'pbkdf2_sha256$180000$bCUac6s8Gmgo$HMhX7mTEDFFK5w54PGABC3Z/nz2ovZwSK5G2sjLiLmg=',NULL,0,'admintwo','Admin','Two','admintwo@gmail.com',1,1,'2021-01-04 11:53:55.461678',1),(26,'pbkdf2_sha256$180000$5dFJ3MhAb1fq$SF21mq70wYrJOOvwgPrIMxTRyn5Y5OFuTwzueuhzRf8=',NULL,1,'admin','','','admin@gmail.com',1,1,'2021-02-01 14:13:53.262598',NULL),(27,'pbkdf2_sha256$180000$MBExpWP9ZMSu$org+zzbUH0AOUanAerOrDCrrPPvUISF9lxkqfIj78js=','2021-02-11 20:20:25.165900',0,'Dharmik','Dharmik','Trivedi','dharmiktrivedi@ymail.com',0,1,'2021-02-03 17:45:48.000000',4),(28,'pbkdf2_sha256$180000$JCY0PMNQJYqx$BbzO2+axjHJYE8UCa4kQgT/rjYaqasrCFkWXeW4X3Q4=','2021-02-22 09:56:04.930815',0,'Don','Don','Cooney','don@gmail.com',0,1,'2021-02-19 16:21:56.000000',4);
/*!40000 ALTER TABLE `adminpanel_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adminpanel_user_groups`
--

DROP TABLE IF EXISTS `adminpanel_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminpanel_user_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `adminpanel_user_groups_user_id_group_id_9bb8a942_uniq` (`user_id`,`group_id`),
  KEY `adminpanel_user_groups_group_id_542dd1ec_fk_auth_group_id` (`group_id`),
  CONSTRAINT `adminpanel_user_groups_group_id_542dd1ec_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `adminpanel_user_groups_user_id_7fb95b73_fk_adminpanel_user_id` FOREIGN KEY (`user_id`) REFERENCES `adminpanel_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminpanel_user_groups`
--

LOCK TABLES `adminpanel_user_groups` WRITE;
/*!40000 ALTER TABLE `adminpanel_user_groups` DISABLE KEYS */;
INSERT INTO `adminpanel_user_groups` VALUES (14,1,5),(2,3,4),(8,8,4),(9,9,4),(10,10,4),(13,20,4),(15,21,1),(16,22,1),(18,27,4),(19,28,4);
/*!40000 ALTER TABLE `adminpanel_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adminpanel_user_user_permissions`
--

DROP TABLE IF EXISTS `adminpanel_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminpanel_user_user_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `adminpanel_user_user_per_user_id_permission_id_4946b25d_uniq` (`user_id`,`permission_id`),
  KEY `adminpanel_user_user_permission_id_c7072229_fk_auth_perm` (`permission_id`),
  CONSTRAINT `adminpanel_user_user_permission_id_c7072229_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `adminpanel_user_user_user_id_6aec919c_fk_adminpane` FOREIGN KEY (`user_id`) REFERENCES `adminpanel_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminpanel_user_user_permissions`
--

LOCK TABLES `adminpanel_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `adminpanel_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `adminpanel_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adminpanel_usertype`
--

DROP TABLE IF EXISTS `adminpanel_usertype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminpanel_usertype` (
  `UserTypeId` int NOT NULL AUTO_INCREMENT,
  `Type` varchar(100) NOT NULL,
  `UserTypeUnchanged` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`UserTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminpanel_usertype`
--

LOCK TABLES `adminpanel_usertype` WRITE;
/*!40000 ALTER TABLE `adminpanel_usertype` DISABLE KEYS */;
INSERT INTO `adminpanel_usertype` VALUES (1,'Admin','Admin'),(2,'Practitioner','Practitioner'),(3,'Consultant','Consultant'),(4,'Client','Client'),(5,'Super Admin','SuperAdmin');
/*!40000 ALTER TABLE `adminpanel_usertype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (1,'Admin'),(4,'Client'),(3,'Consultant'),(2,'Practitioner'),(5,'Super Admin');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (1,5,1),(2,5,2),(3,5,3),(4,5,4),(5,5,5),(6,5,6),(7,5,7),(8,5,8),(9,5,9),(10,5,10),(11,5,11),(12,5,12),(13,5,13),(14,5,14),(15,5,15),(16,5,16),(17,5,17),(18,5,18),(19,5,19),(20,5,20),(21,5,21),(22,5,22),(23,5,23),(24,5,24),(25,5,25),(26,5,26),(27,5,27),(28,5,28),(29,5,29),(30,5,30),(31,5,31),(32,5,32),(33,5,33),(34,5,34),(35,5,35),(36,5,36),(37,5,37),(38,5,38),(39,5,39),(40,5,40),(41,5,41),(42,5,42),(43,5,43),(44,5,44),(45,5,45),(46,5,46),(47,5,47),(48,5,48),(49,5,49),(50,5,50),(51,5,51),(52,5,52),(53,5,53),(54,5,54),(55,5,55),(56,5,56),(57,5,57),(58,5,58),(59,5,59),(60,5,60),(61,5,61),(62,5,62),(63,5,63),(64,5,64),(65,5,65),(66,5,66),(67,5,67),(68,5,68),(69,5,69),(70,5,70),(71,5,71),(72,5,72),(73,5,73),(74,5,74),(75,5,75),(76,5,76),(77,5,77),(78,5,78),(79,5,79),(80,5,80),(81,5,81),(82,5,82),(83,5,83),(84,5,84),(85,5,85),(86,5,86),(87,5,87),(88,5,88),(89,5,89),(90,5,90),(91,5,91),(92,5,92),(93,5,93),(94,5,94),(95,5,95),(96,5,96),(97,5,97),(98,5,98),(99,5,99),(100,5,100),(101,5,101),(102,5,102),(103,5,103),(104,5,104),(105,5,105),(106,5,106),(107,5,107),(108,5,108),(109,5,109),(110,5,110),(111,5,111),(112,5,112);
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add user',6,'add_user'),(22,'Can change user',6,'change_user'),(23,'Can delete user',6,'delete_user'),(24,'Can view user',6,'view_user'),(25,'Can add customer',7,'add_customer'),(26,'Can change customer',7,'change_customer'),(27,'Can delete customer',7,'delete_customer'),(28,'Can view customer',7,'view_customer'),(29,'Can add discount type',8,'add_discounttype'),(30,'Can change discount type',8,'change_discounttype'),(31,'Can delete discount type',8,'delete_discounttype'),(32,'Can view discount type',8,'view_discounttype'),(33,'Can add installment type',9,'add_installmenttype'),(34,'Can change installment type',9,'change_installmenttype'),(35,'Can delete installment type',9,'delete_installmenttype'),(36,'Can view installment type',9,'view_installmenttype'),(37,'Can add order',10,'add_order'),(38,'Can change order',10,'change_order'),(39,'Can delete order',10,'delete_order'),(40,'Can view order',10,'view_order'),(41,'Can add product',11,'add_product'),(42,'Can change product',11,'change_product'),(43,'Can delete product',11,'delete_product'),(44,'Can view product',11,'view_product'),(45,'Can add user type',12,'add_usertype'),(46,'Can change user type',12,'change_usertype'),(47,'Can delete user type',12,'delete_usertype'),(48,'Can view user type',12,'view_usertype'),(49,'Can add payment',13,'add_payment'),(50,'Can change payment',13,'change_payment'),(51,'Can delete payment',13,'delete_payment'),(52,'Can view payment',13,'view_payment'),(53,'Can add order details',14,'add_orderdetails'),(54,'Can change order details',14,'change_orderdetails'),(55,'Can delete order details',14,'delete_orderdetails'),(56,'Can view order details',14,'view_orderdetails'),(57,'Can add installment due',15,'add_installmentdue'),(58,'Can change installment due',15,'change_installmentdue'),(59,'Can delete installment due',15,'delete_installmentdue'),(60,'Can view installment due',15,'view_installmentdue'),(61,'Can add address',16,'add_address'),(62,'Can change address',16,'change_address'),(63,'Can delete address',16,'delete_address'),(64,'Can view address',16,'view_address'),(65,'Can add invoice',17,'add_invoice'),(66,'Can change invoice',17,'change_invoice'),(67,'Can delete invoice',17,'delete_invoice'),(68,'Can view invoice',17,'view_invoice'),(69,'Can add merchant',18,'add_merchant'),(70,'Can change merchant',18,'change_merchant'),(71,'Can delete merchant',18,'delete_merchant'),(72,'Can view merchant',18,'view_merchant'),(73,'Can add site',19,'add_site'),(74,'Can change site',19,'change_site'),(75,'Can delete site',19,'delete_site'),(76,'Can view site',19,'view_site'),(77,'Can add activity log',20,'add_activitylog'),(78,'Can change activity log',20,'change_activitylog'),(79,'Can delete activity log',20,'delete_activitylog'),(80,'Can view activity log',20,'view_activitylog'),(81,'Can add activity type',21,'add_activitytype'),(82,'Can change activity type',21,'change_activitytype'),(83,'Can delete activity type',21,'delete_activitytype'),(84,'Can view activity type',21,'view_activitytype'),(85,'Can add category',22,'add_category'),(86,'Can change category',22,'change_category'),(87,'Can delete category',22,'delete_category'),(88,'Can view category',22,'view_category'),(89,'Can add order discount',23,'add_orderdiscount'),(90,'Can change order discount',23,'change_orderdiscount'),(91,'Can delete order discount',23,'delete_orderdiscount'),(92,'Can view order discount',23,'view_orderdiscount'),(93,'Can add customer discount eligibility',24,'add_customerdiscounteligibility'),(94,'Can change customer discount eligibility',24,'change_customerdiscounteligibility'),(95,'Can delete customer discount eligibility',24,'delete_customerdiscounteligibility'),(96,'Can view customer discount eligibility',24,'view_customerdiscounteligibility'),(97,'Can add configuration',25,'add_configuration'),(98,'Can change configuration',25,'change_configuration'),(99,'Can delete configuration',25,'delete_configuration'),(100,'Can view configuration',25,'view_configuration'),(101,'Can add announcement post',26,'add_announcementpost'),(102,'Can change announcement post',26,'change_announcementpost'),(103,'Can delete announcement post',26,'delete_announcementpost'),(104,'Can view announcement post',26,'view_announcementpost'),(105,'Can add order status',27,'add_orderstatus'),(106,'Can change order status',27,'change_orderstatus'),(107,'Can delete order status',27,'delete_orderstatus'),(108,'Can view order status',27,'view_orderstatus'),(109,'Can add product specification',28,'add_productspecification'),(110,'Can change product specification',28,'change_productspecification'),(111,'Can delete product specification',28,'delete_productspecification'),(112,'Can view product specification',28,'view_productspecification'),(113,'Can add log',29,'add_log'),(114,'Can change log',29,'change_log'),(115,'Can delete log',29,'delete_log'),(116,'Can view log',29,'view_log');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_adminpanel_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_adminpanel_user_id` FOREIGN KEY (`user_id`) REFERENCES `adminpanel_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2020-08-27 16:05:30.546011','1','admin',2,'[{\"changed\": {\"fields\": [\"User type\", \"Groups\"]}}]',6,1),(2,'2020-08-27 17:40:44.431511','1','admin',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',6,1),(3,'2020-09-23 11:25:51.589073','1','Payzon-3664359',1,'[{\"added\": {}}]',18,1),(4,'2020-12-14 10:41:46.577622','5','Super Admin',1,'[{\"added\": {}}]',3,1),(5,'2020-12-14 10:42:17.679622','1','admin',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',6,1),(6,'2020-12-14 10:44:27.493622','1','admin',2,'[{\"changed\": {\"fields\": [\"User type\"]}}]',6,1),(7,'2021-01-04 11:52:54.971283','21','adminone',1,'[{\"added\": {}}]',6,1),(8,'2021-01-04 11:53:28.039283','21','adminone',2,'[{\"changed\": {\"fields\": [\"Email address\", \"First name\", \"Last name\", \"User type\", \"Groups\"]}}]',6,1),(9,'2021-01-04 11:53:55.611693','22','admintwo',1,'[{\"added\": {}}]',6,1),(10,'2021-01-04 11:54:24.669597','22','admintwo',2,'[{\"changed\": {\"fields\": [\"Email address\", \"First name\", \"Last name\", \"User type\", \"Groups\"]}}]',6,1),(11,'2021-01-05 17:35:15.675099','21','adminone',2,'[{\"changed\": {\"fields\": [\"Staff status\"]}}]',6,1),(12,'2021-01-05 17:35:24.158099','22','admintwo',2,'[{\"changed\": {\"fields\": [\"Staff status\"]}}]',6,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(20,'adminpanel','activitylog'),(21,'adminpanel','activitytype'),(16,'adminpanel','address'),(26,'adminpanel','announcementpost'),(22,'adminpanel','category'),(25,'adminpanel','configuration'),(7,'adminpanel','customer'),(24,'adminpanel','customerdiscounteligibility'),(8,'adminpanel','discounttype'),(15,'adminpanel','installmentdue'),(9,'adminpanel','installmenttype'),(17,'adminpanel','invoice'),(10,'adminpanel','order'),(14,'adminpanel','orderdetails'),(23,'adminpanel','orderdiscount'),(27,'adminpanel','orderstatus'),(13,'adminpanel','payment'),(11,'adminpanel','product'),(28,'adminpanel','productspecification'),(6,'adminpanel','user'),(12,'adminpanel','usertype'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(29,'eventlog','log'),(18,'gateway','merchant'),(5,'sessions','session'),(19,'sites','site');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2020-08-27 14:52:33.885458'),(2,'contenttypes','0002_remove_content_type_name','2020-08-27 14:52:35.426458'),(3,'auth','0001_initial','2020-08-27 14:52:36.529458'),(4,'auth','0002_alter_permission_name_max_length','2020-08-27 14:52:46.636458'),(5,'auth','0003_alter_user_email_max_length','2020-08-27 14:52:47.025458'),(6,'auth','0004_alter_user_username_opts','2020-08-27 14:52:47.324458'),(7,'auth','0005_alter_user_last_login_null','2020-08-27 14:52:47.533458'),(8,'auth','0006_require_contenttypes_0002','2020-08-27 14:52:47.685458'),(9,'auth','0007_alter_validators_add_error_messages','2020-08-27 14:52:48.082458'),(10,'auth','0008_alter_user_username_max_length','2020-08-27 14:52:48.206458'),(11,'auth','0009_alter_user_last_name_max_length','2020-08-27 14:52:48.396458'),(12,'auth','0010_alter_group_name_max_length','2020-08-27 14:52:49.097458'),(13,'auth','0011_update_proxy_permissions','2020-08-27 14:52:49.172458'),(14,'adminpanel','0001_initial','2020-08-27 14:53:02.187458'),(15,'ManorPharmacy','0001_initial','2020-08-27 14:53:55.288458'),(16,'ManorPharmacy','0002_auto_20200720_1247','2020-08-27 14:54:09.293958'),(17,'admin','0001_initial','2020-08-27 14:54:11.590958'),(18,'admin','0002_logentry_remove_auto_add','2020-08-27 14:54:23.053958'),(19,'admin','0003_logentry_add_action_flag_choices','2020-08-27 14:54:23.229958'),(20,'sessions','0001_initial','2020-08-27 14:54:24.126958'),(21,'adminpanel','0002_auto_20200907_0956','2020-09-07 09:56:48.401830'),(22,'adminpanel','0003_auto_20200908_0956','2020-09-08 09:56:43.838635'),(23,'adminpanel','0004_product_noofinstallmentmonths','2020-09-08 14:56:43.168598'),(24,'adminpanel','0005_auto_20200916_1443','2020-09-16 14:44:29.369830'),(25,'adminpanel','0006_auto_20200916_1732','2020-09-16 17:33:04.572917'),(26,'adminpanel','0007_auto_20200917_1736','2020-09-17 17:37:23.923837'),(27,'adminpanel','0008_auto_20200923_1056','2020-09-23 10:56:24.867573'),(28,'gateway','0001_initial','2020-09-23 10:56:27.953573'),(29,'gateway','0002_auto_20190624_1357','2020-09-23 10:56:30.423573'),(30,'gateway','0003_auto_20190710_1208','2020-09-23 10:56:31.891073'),(31,'gateway','0004_auto_20190715_1401','2020-09-23 10:56:32.583573'),(32,'gateway','0005_auto_20190719_1615','2020-09-23 10:56:32.831073'),(33,'gateway','0006_auto_20190802_1453','2020-09-23 10:56:34.562073'),(34,'gateway','0007_auto_20190819_1258','2020-09-23 10:56:35.264573'),(35,'adminpanel','0009_auto_20200928_1640','2020-09-28 16:40:38.794082'),(36,'adminpanel','0010_auto_20200930_1439','2020-09-30 14:39:09.523692'),(37,'adminpanel','0011_product_discountpercentage','2020-10-01 11:43:10.533357'),(38,'adminpanel','0012_auto_20201001_1150','2020-10-01 11:50:29.196357'),(39,'adminpanel','0013_customer_referraldiscount','2020-10-01 15:30:18.859372'),(40,'adminpanel','0014_customer_personaldiscount','2020-10-01 18:35:49.734519'),(41,'adminpanel','0015_auto_20201002_1701','2020-10-02 17:01:40.620375'),(42,'sites','0001_initial','2020-10-05 10:24:30.648459'),(43,'sites','0002_alter_domain_unique','2020-10-05 10:24:32.558650'),(44,'adminpanel','0016_product_additionalmemberprice','2020-10-06 12:03:00.866328'),(45,'adminpanel','0017_auto_20201006_1547','2020-10-06 15:47:35.526828'),(46,'adminpanel','0018_activitylog_activitytype','2020-10-12 16:19:54.475213'),(47,'adminpanel','0019_product_slug','2020-10-14 16:46:35.085208'),(48,'adminpanel','0020_auto_20201014_1707','2020-10-14 17:07:44.329208'),(49,'adminpanel','0021_auto_20201015_1048','2020-10-15 10:49:32.874902'),(50,'adminpanel','0022_product_detaildescription','2020-10-15 11:23:57.266722'),(51,'adminpanel','0023_auto_20201020_1216','2020-10-20 12:17:18.225501'),(52,'adminpanel','0024_auto_20201022_1030','2020-10-22 10:31:13.986875'),(53,'adminpanel','0025_auto_20201022_1630','2020-10-22 16:30:29.556309'),(54,'adminpanel','0026_auto_20201023_1254','2020-10-23 12:55:14.314970'),(55,'adminpanel','0027_announcementpost','2020-10-23 13:25:04.822501'),(56,'adminpanel','0028_auto_20201029_1655','2020-10-29 16:56:12.777860'),(57,'adminpanel','0029_auto_20201029_1657','2020-10-29 16:57:51.686749'),(58,'adminpanel','0030_order_actualamounttopay','2020-10-29 18:05:31.056646'),(59,'adminpanel','0031_order_fullpaymentdiscountamount','2020-10-29 18:27:27.476275'),(60,'adminpanel','0032_auto_20201029_1910','2020-10-29 19:11:04.045905'),(61,'adminpanel','0033_auto_20201029_1918','2020-10-29 19:18:47.340230'),(62,'adminpanel','0034_auto_20201029_1933','2020-10-29 19:33:38.864374'),(63,'adminpanel','0035_configuration_displayname','2020-11-16 17:45:58.544534'),(64,'adminpanel','0036_configuration_image','2020-11-17 16:43:54.636506'),(65,'adminpanel','0037_announcementpost_isactive','2020-11-18 10:18:30.010821'),(66,'adminpanel','0038_auto_20201120_0949','2020-11-20 09:49:44.441233'),(67,'adminpanel','0039_auto_20201120_1442','2020-11-20 14:42:58.791198'),(68,'adminpanel','0040_auto_20201202_1842','2020-12-02 18:44:37.536125'),(69,'adminpanel','0041_installmentdue_isinstalmentpaid','2020-12-10 11:48:48.137962'),(70,'adminpanel','0042_payment_stripe_payment_id','2020-12-10 15:55:16.562962'),(71,'adminpanel','0043_payment_orderdetail','2020-12-10 18:37:17.272493'),(72,'adminpanel','0044_auto_20201210_1844','2020-12-10 18:44:32.424106'),(73,'adminpanel','0045_auto_20210107_1451','2021-01-07 14:52:12.208484'),(74,'adminpanel','0046_auto_20210201_1413','2021-02-01 14:13:52.925565'),(75,'adminpanel','0047_auto_20210201_1806','2021-02-01 18:06:42.762042'),(76,'eventlog','0001_initial','2021-02-01 18:06:43.783144'),(77,'eventlog','0002_auto_20150113_1450','2021-02-01 18:06:57.892519'),(78,'adminpanel','0048_auto_20210201_2007','2021-02-01 20:07:19.266272'),(79,'adminpanel','0049_auto_20210201_2020','2021-02-01 20:20:46.913736'),(80,'adminpanel','0050_address_countrycode','2021-02-08 19:52:08.931876');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('33m35ujg48b5rj4xathhhliigo5ixlvx','MWNkODc1ZDVhZmJkZjMwYmIyMTdlNzQ1MmQ3NGYxNDhhMmRjZjNhYjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYWRtaW5wYW5lbC5DdXN0b21Vc2VyRGVjb3JhdG9yLkN1c3RvbURlY29yYXRvciIsIl9hdXRoX3VzZXJfaGFzaCI6IjA3YzE3MDVjMWI5YjljMGU3ODAxZjA2MjViY2JkNmRkYWYwYzU3YzIifQ==','2020-10-27 13:55:03.016594'),('3v538c5urum114q6e5euehx32ey3bt20','MTJhM2UwMjllNGRmMjE3ODZmYTU5NmMyNmMyNTQ2YzkyMDczMDdjYzp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYWRtaW5wYW5lbC5DdXN0b21Vc2VyRGVjb3JhdG9yLkN1c3RvbURlY29yYXRvciIsIl9hdXRoX3VzZXJfaGFzaCI6ImZhMDAzMzllOWM4OTExNDZmNjM1OTgzZTAyYzVlNWI1YTc0MjQ3N2EifQ==','2020-12-10 16:56:43.242345'),('5ueybb6wr0ln84wgp9cpexrtbojm8o6g','MWNkODc1ZDVhZmJkZjMwYmIyMTdlNzQ1MmQ3NGYxNDhhMmRjZjNhYjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYWRtaW5wYW5lbC5DdXN0b21Vc2VyRGVjb3JhdG9yLkN1c3RvbURlY29yYXRvciIsIl9hdXRoX3VzZXJfaGFzaCI6IjA3YzE3MDVjMWI5YjljMGU3ODAxZjA2MjViY2JkNmRkYWYwYzU3YzIifQ==','2020-12-28 19:03:32.864741'),('6ue134c45khzeau4ejc0whizi0mtklw6','MTJhM2UwMjllNGRmMjE3ODZmYTU5NmMyNmMyNTQ2YzkyMDczMDdjYzp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYWRtaW5wYW5lbC5DdXN0b21Vc2VyRGVjb3JhdG9yLkN1c3RvbURlY29yYXRvciIsIl9hdXRoX3VzZXJfaGFzaCI6ImZhMDAzMzllOWM4OTExNDZmNjM1OTgzZTAyYzVlNWI1YTc0MjQ3N2EifQ==','2020-12-04 09:11:57.544566'),('af0e12ec9ub82kqbr6yfxz90h6o8ur4x','MWNkODc1ZDVhZmJkZjMwYmIyMTdlNzQ1MmQ3NGYxNDhhMmRjZjNhYjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYWRtaW5wYW5lbC5DdXN0b21Vc2VyRGVjb3JhdG9yLkN1c3RvbURlY29yYXRvciIsIl9hdXRoX3VzZXJfaGFzaCI6IjA3YzE3MDVjMWI5YjljMGU3ODAxZjA2MjViY2JkNmRkYWYwYzU3YzIifQ==','2021-03-10 11:52:05.853946'),('evvr4qofrj8ug6qq3fdh0zpnqnjidu8u','MTJhM2UwMjllNGRmMjE3ODZmYTU5NmMyNmMyNTQ2YzkyMDczMDdjYzp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYWRtaW5wYW5lbC5DdXN0b21Vc2VyRGVjb3JhdG9yLkN1c3RvbURlY29yYXRvciIsIl9hdXRoX3VzZXJfaGFzaCI6ImZhMDAzMzllOWM4OTExNDZmNjM1OTgzZTAyYzVlNWI1YTc0MjQ3N2EifQ==','2020-12-04 09:14:48.715681'),('iiytht16bfgbephd1gvi44hxkinktjqd','MWNkODc1ZDVhZmJkZjMwYmIyMTdlNzQ1MmQ3NGYxNDhhMmRjZjNhYjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYWRtaW5wYW5lbC5DdXN0b21Vc2VyRGVjb3JhdG9yLkN1c3RvbURlY29yYXRvciIsIl9hdXRoX3VzZXJfaGFzaCI6IjA3YzE3MDVjMWI5YjljMGU3ODAxZjA2MjViY2JkNmRkYWYwYzU3YzIifQ==','2021-02-01 11:36:54.852511'),('iw29ablq0fqa0bomscq0n7x5kz64y5yh','MWNkODc1ZDVhZmJkZjMwYmIyMTdlNzQ1MmQ3NGYxNDhhMmRjZjNhYjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYWRtaW5wYW5lbC5DdXN0b21Vc2VyRGVjb3JhdG9yLkN1c3RvbURlY29yYXRvciIsIl9hdXRoX3VzZXJfaGFzaCI6IjA3YzE3MDVjMWI5YjljMGU3ODAxZjA2MjViY2JkNmRkYWYwYzU3YzIifQ==','2020-09-22 10:36:25.337835'),('olw00s199d3lr3faqu102sprjf2ozsdi','MWNkODc1ZDVhZmJkZjMwYmIyMTdlNzQ1MmQ3NGYxNDhhMmRjZjNhYjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYWRtaW5wYW5lbC5DdXN0b21Vc2VyRGVjb3JhdG9yLkN1c3RvbURlY29yYXRvciIsIl9hdXRoX3VzZXJfaGFzaCI6IjA3YzE3MDVjMWI5YjljMGU3ODAxZjA2MjViY2JkNmRkYWYwYzU3YzIifQ==','2020-12-25 11:56:39.408282'),('q7kwdwprqiyomx0z25t76s6pslbgov47','MWNkODc1ZDVhZmJkZjMwYmIyMTdlNzQ1MmQ3NGYxNDhhMmRjZjNhYjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYWRtaW5wYW5lbC5DdXN0b21Vc2VyRGVjb3JhdG9yLkN1c3RvbURlY29yYXRvciIsIl9hdXRoX3VzZXJfaGFzaCI6IjA3YzE3MDVjMWI5YjljMGU3ODAxZjA2MjViY2JkNmRkYWYwYzU3YzIifQ==','2020-10-15 19:43:08.671738'),('ryqo1cchem7k5qu6s6k33hx7rubmfmck','MTJhM2UwMjllNGRmMjE3ODZmYTU5NmMyNmMyNTQ2YzkyMDczMDdjYzp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYWRtaW5wYW5lbC5DdXN0b21Vc2VyRGVjb3JhdG9yLkN1c3RvbURlY29yYXRvciIsIl9hdXRoX3VzZXJfaGFzaCI6ImZhMDAzMzllOWM4OTExNDZmNjM1OTgzZTAyYzVlNWI1YTc0MjQ3N2EifQ==','2020-09-24 10:19:01.091836'),('s0yx9ebplq336nocsmbsd42xah6q5iwe','MDI5ZTBkZDY1MTRjM2IzM2VmOTNlNWM3MWNjMjg3NGFkYmQxYmM2Mzp7Il9hdXRoX3VzZXJfaWQiOiI5IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYWRtaW5wYW5lbC5DdXN0b21Vc2VyRGVjb3JhdG9yLkN1c3RvbURlY29yYXRvciIsIl9hdXRoX3VzZXJfaGFzaCI6ImI5N2RmNmU4YzIzYTUxMWNhMWNkNmNlZDRmNWQzMjI1ZDgzYjRjY2EifQ==','2020-10-13 15:56:59.698156'),('s5vlmemadty4jrellc9qoi10wutkgl2f','MTJhM2UwMjllNGRmMjE3ODZmYTU5NmMyNmMyNTQ2YzkyMDczMDdjYzp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYWRtaW5wYW5lbC5DdXN0b21Vc2VyRGVjb3JhdG9yLkN1c3RvbURlY29yYXRvciIsIl9hdXRoX3VzZXJfaGFzaCI6ImZhMDAzMzllOWM4OTExNDZmNjM1OTgzZTAyYzVlNWI1YTc0MjQ3N2EifQ==','2020-12-04 09:31:39.082708'),('xm8snd2898ew1chwiyl9bc9f6y7jdxn1','MWNkODc1ZDVhZmJkZjMwYmIyMTdlNzQ1MmQ3NGYxNDhhMmRjZjNhYjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYWRtaW5wYW5lbC5DdXN0b21Vc2VyRGVjb3JhdG9yLkN1c3RvbURlY29yYXRvciIsIl9hdXRoX3VzZXJfaGFzaCI6IjA3YzE3MDVjMWI5YjljMGU3ODAxZjA2MjViY2JkNmRkYWYwYzU3YzIifQ==','2020-10-23 18:54:02.568233');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_site` (
  `id` int NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'http://127.0.0.1:8000/','http://127.0.0.1:8000/');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gateway_merchant`
--

DROP TABLE IF EXISTS `gateway_merchant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gateway_merchant` (
  `id` int NOT NULL AUTO_INCREMENT,
  `MID` varchar(14) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `Preshared` varchar(50) NOT NULL,
  `HashMethod` varchar(50) NOT NULL,
  `ResultDeliveryMethod` varchar(50) NOT NULL,
  `TransactionType` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gateway_merchant`
--

LOCK TABLES `gateway_merchant` WRITE;
/*!40000 ALTER TABLE `gateway_merchant` DISABLE KEYS */;
INSERT INTO `gateway_merchant` VALUES (1,'Payzon-3664359','Aomw5aTom512','xnQsrguFdNwLEiixOTV','SHA1','POST','SALE');
/*!40000 ALTER TABLE `gateway_merchant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'prolongevity'
--
/*!50003 DROP PROCEDURE IF EXISTS `GetActivityLogList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetActivityLogList`()
BEGIN
	SELECT AC.ActivityType_id, AC.ActivityDescription, A.ActivityType, U.Username, AC.LogCreatedDate
		FROM adminpanel_activitylog AC 
        LEFT JOIN adminpanel_activitytype A ON AC.ActivityType_id = A.ActivityTypeId
        LEFT JOIN prolongevity.adminpanel_user U ON AC.User_id = U.id
        ORDER BY AC.ActivityLogId DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAnnouncementList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAnnouncementList`()
BEGIN
	SELECT * FROM adminpanel_announcementpost;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAnnouncementPostById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAnnouncementPostById`(IN id int)
BEGIN
	SELECT * FROM adminpanel_announcementpost WHERE Announcement_Id = id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetClientOrderDetailsById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetClientOrderDetailsById`(IN id int)
BEGIN
	SELECT O.Order_Id, O.OrderCompletionDate, IFNULL(O.ActualAmountToPay,0) AS 'AmountPaid', 
		O.FullPaymentDiscountAmount AS 'DiscountForFullPayment' ,
		OD.Quantity, OD.TotalNoOfPerson AS 'FamilyMemberCount', P.Name AS 'ProductName',
        CONCAT(C.First_Name, ' ' ,C.Last_Name) as CustName
	FROM prolongevity.adminpanel_order O
		LEFT JOIN prolongevity.adminpanel_orderdetails OD ON O.Order_Id = OD.Order_Id
		LEFT JOIN prolongevity.adminpanel_product P ON P.Product_Id = OD.Product_Id
		LEFT JOIN prolongevity.adminpanel_customer C ON C.Customer_Id = O.Customer_Id

	WHERE O.Order_Id = id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetClientOrderDetailsList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetClientOrderDetailsList`()
BEGIN
		SELECT O.Order_Id, O.OrderCompletionDate, 
        CONCAT(C.First_Name, ' ' ,C.Last_Name) as CustName,
        IFNULL(O.ActualAmountToPay,0) AS 'AmountPaid', 
        P.Name AS 'ProductName', OD.Quantity,
        OD.TotalNoOfPerson AS 'FamilyMemberCount',
		O.FullPaymentDiscountAmount AS 'DiscountForFullPayment' 
		
	FROM prolongevity.adminpanel_order O
		LEFT JOIN prolongevity.adminpanel_orderdetails OD ON O.Order_Id = OD.Order_Id
		LEFT JOIN prolongevity.adminpanel_product P ON P.Product_Id = OD.Product_Id
		LEFT JOIN prolongevity.adminpanel_customer C ON C.Customer_Id = O.Customer_Id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetConfigurationById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetConfigurationById`(IN id int)
BEGIN
	SELECT * FROM adminpanel_configuration WHERE ConfigurationId = id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetConfigurationList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetConfigurationList`()
BEGIN
	SELECT * FROM adminpanel_configuration;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetCurrentPlacedAndProcessedOrders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCurrentPlacedAndProcessedOrders`()
BEGIN
	SELECT O.Order_Id, O.Order_Date, O.OrderCompletionDate, 
		CONCAT(C.First_Name, ' ' ,C.Last_Name) as CustName, O.OrderStatus_id AS OrderId,
        OS.OrderStatusType, 
        (SELECT GROUP_CONCAT(' ',P.Name) FROM adminpanel_orderdetails OD 
			LEFT JOIN adminpanel_product P ON OD.Product_Id = P.Product_Id
			WHERE O.Order_Id = OD.Order_Id
		) AS Items,
        A.Postal_Code
        		
        FROM prolongevity.adminpanel_order O
			LEFT JOIN adminpanel_Customer C ON O.Customer_id = C.Customer_Id
            LEFT JOIN adminpanel_OrderStatus OS ON O.OrderStatus_id = OS.OrderStatusId
            LEFT JOIN adminpanel_address A ON C.user_id = A.User_Id AND A.Address_Type = 'B'
		WHERE O.IsOrderCompleted = 1 AND (O.OrderStatus_id = 1 OR O.OrderStatus_id = 2)
			ORDER BY O.OrderCompletionDate DESC, O.Order_Id DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetCustomerDetailsById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCustomerDetailsById`(IN id int)
BEGIN
	SELECT C.Customer_Id, C.First_Name, C.Last_Name, C.Email, C.Phone_No, 
		C.Gender, A.Addressline1, A.Addressline2, A.City, A.Postal_Code,
        A.Country
		FROM adminpanel_customer C 
			LEFT JOIN adminpanel_address A ON C.user_id = A.User_Id
			
		WHERE C.Customer_Id = id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetCustomerDetailsByUserId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCustomerDetailsByUserId`(IN id int)
BEGIN
	SELECT C.Customer_Id, IFNULL(C.First_Name,'') as First_Name, IFNULL(C.Last_Name,'') AS Last_Name, 
		IFNULL(C.Email,'') AS Email, IFNULL(C.Phone_No,'') AS Phone_No, IFNULL(C.Gender,'') AS Gender, 
        IFNULL(A.Addressline1,'') AS Addressline1, IFNULL(A.Addressline2,'') AS Addressline2, 
        IFNULL(A.City,'') AS City, IFNULL(A.State,'') AS State, IFNULL(A.Postal_Code,'') AS Postal_Code, 
        IFNULL(A.Country,'') AS Country, IFNULL(A.CountryCode,'') AS CountryCode, 
        C.SameHousehold_Id, C.Referral_Id, C.ReferralDiscount_Id,
        IFNULL(C.PersonalDiscount,0) AS PersonalDiscount
		FROM adminpanel_customer C 
			LEFT JOIN adminpanel_address A ON C.User_Id = A.User_Id
			
		WHERE C.user_id = id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetCustomerList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCustomerList`()
BEGIN
	SELECT C.Customer_Id, C.Last_Name, C.First_Name, C.Email, 
		IFNULL(C.Phone_No,'') AS Phone_No, IFNULL(C.Gender,'') AS Gender,
        CONCAT(C.First_Name, ' ' ,C.Last_Name) AS Name, A.Postal_Code
	FROM adminpanel_customer C 
        LEFT JOIN adminpanel_user U ON U.Id = C.user_id
        LEFT JOIN adminpanel_address A ON C.user_id = A.User_Id AND A.Address_Type = 'B'
	WHERE (U.user_type_id = 4 OR C.user_id is null)
        ORDER BY C.Last_Name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetDiscountByName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetDiscountByName`(IN str nvarchar(50), IN id int)
BEGIN
		SELECT D.Discount_Type_Id,D.DiscountCode, D.Percentage FROM adminpanel_discounttype D 
		LEFT JOIN adminpanel_customerdiscounteligibility CD ON D.Discount_Type_Id = CD.DiscountType_Id
		WHERE  TRIM(LOWER(D.DiscountCode)) = str 
		AND (CASE WHEN id > 0 THEN CD.Customer_Id = id AND CD.IsUsed = 0 ELSE TRUE END)
		AND ((DATE(NOW()) BETWEEN DATE(D.DiscountFrom) AND DATE(D.DiscountTo)) OR 
		(DATE(D.DiscountFrom) <= DATE(NOW()) AND DATE(D.DiscountTo) IS NULL));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetDiscountTypeById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetDiscountTypeById`(IN id int)
BEGIN
	SELECT Discount_Type_Id, DiscountCode, Percentage, DATE_FORMAT(DiscountFrom,'%d/%m/%Y') AS DiscountFrom, 
		IFNULL(DATE_FORMAT(DiscountTo,'%d/%m/%Y'),"") AS DiscountTo,
        IFNULL(DiscountDescription,"") AS DiscountDescription, IsReferralDiscount
    FROM adminpanel_discounttype WHERE Discount_Type_Id = id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetDiscountTypeList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetDiscountTypeList`()
BEGIN
	SELECT Discount_Type_Id, DiscountCode, Percentage, DATE_FORMAT(DiscountFrom,'%d/%m/%Y') AS DiscountFrom, 
		IFNULL(DATE_FORMAT(DiscountTo,'%d/%m/%Y'),"") AS DiscountTo, 
        IFNULL(DiscountDescription,"") AS DiscountDescription, IsReferralDiscount
    FROM adminpanel_discounttype;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetInstallmentType` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetInstallmentType`()
BEGIN
	SELECT * FROM adminpanel_installmenttype;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetInstallmentTypeById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetInstallmentTypeById`(IN id int)
BEGIN
	SELECT * FROM adminpanel_installmenttype WHERE Installment_Type_Id = id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetLatestOrders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetLatestOrders`()
BEGIN
	SELECT O.Order_Id, O.Order_Date, O.OrderCompletionDate, 
		CONCAT(C.First_Name, ' ' ,C.Last_Name) as CustName, O.OrderStatus_id AS OrderId,
        OS.OrderStatusType
		
        FROM prolongevity.adminpanel_order O
			LEFT JOIN adminpanel_Customer C ON O.Customer_id = C.Customer_Id
            LEFT JOIN adminpanel_OrderStatus OS ON O.OrderStatus_id = OS.OrderStatusId
		WHERE O.IsOrderCompleted = 1
        ORDER BY O.OrderCompletionDate DESC, O.Order_Id DESC LIMIT 10;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetOrderDetailsReportByClientResult` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetOrderDetailsReportByClientResult`(IN clientName VARCHAR(100))
BEGIN
	SELECT  CONCAT(C.First_Name, ' ' ,C.Last_Name) as CustName, 
		O.OrderCompletionDate AS "PurchaseDate",
        IFNULL(O.ActualAmountToPay,0) AS "ActualAmountToPay", 
        (SELECT  SUM(P.Amount) FROM prolongevity.adminpanel_payment P  where O.Order_Id = P.Order_Id) as AmountPaid,
		IFNULL(O.FullPaymentDiscountAmount,0) AS "FullPaymentDiscountAmount",
        CASE WHEN IFNULL(O.FullPaymentDiscountAmount,0) = 0 THEN 'Instalment' 
        ELSE 'Full Payment' END AS PaymentMethod,
		IFNULL(O.ServiceTotalAmount,0) AS "ServiceTotalAmount", O.Order_Id
    
	FROM prolongevity.adminpanel_customer C
		LEFT JOIN prolongevity.adminpanel_order O ON C.Customer_Id = O.Customer_Id
	WHERE O.IsOrderCompleted = 1 AND O.ActualAmountToPay > 0
		AND (C.First_Name LIKE CONCAT('%', clientName , '%') OR C.Last_Name LIKE CONCAT('%', clientName , '%'));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetOrderDetailsReportByProductResult` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetOrderDetailsReportByProductResult`(IN id int)
BEGIN

	SELECT  CONCAT(C.First_Name, ' ' ,C.Last_Name) as CustName, 
		O.OrderCompletionDate AS "PurchaseDate",  PR.Name,
        IFNULL(O.ActualAmountToPay,0) AS "ActualAmountToPay", 
        IFNULL(P.Amount,0) AS "AmountPaid",
		IFNULL(O.FullPaymentDiscountAmount,0) AS "FullPaymentDiscountAmount",
        CASE WHEN IFNULL(O.FullPaymentDiscountAmount,0) = 0 THEN 'Instalment' 
        ELSE 'Full Payment' END AS PaymentMethod,
		IFNULL(O.ServiceTotalAmount,0) AS "ServiceTotalAmount", O.Order_Id, 
        OD.Quantity
    
FROM prolongevity.adminpanel_customer C
	LEFT JOIN prolongevity.adminpanel_order O ON C.Customer_Id = O.Customer_Id
	LEFT JOIN prolongevity.adminpanel_orderdetails OD ON O.Order_Id = OD.Order_Id
	LEFT JOIN prolongevity.adminpanel_payment P ON O.Order_Id = P.Order_Id
	LEFT JOIN prolongevity.adminpanel_product PR ON OD.Product_Id = PR.Product_Id

	WHERE O.IsOrderCompleted = 1 AND P.Amount > 0 AND O.ActualAmountToPay > 0 AND PR.Product_Id = id
    ORDER BY O.Order_Id DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetOrderDetailsReportResult` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetOrderDetailsReportResult`()
BEGIN
	
	SELECT  CONCAT(C.First_Name, ' ' ,C.Last_Name) as CustName, 
		O.OrderCompletionDate AS "PurchaseDate",
        IFNULL(O.ActualAmountToPay,0) AS "ActualAmountToPay", 
        (SELECT  SUM(P.Amount) FROM prolongevity.adminpanel_payment P  where O.Order_Id = P.Order_Id) as AmountPaid,
		IFNULL(O.FullPaymentDiscountAmount,0) AS "FullPaymentDiscountAmount",
        CASE WHEN IFNULL(O.FullPaymentDiscountAmount,0) = 0 THEN 'Instalment' 
        ELSE 'Full Payment' END AS PaymentMethod,
		IFNULL(O.ServiceTotalAmount,0) AS "ServiceTotalAmount", O.Order_Id
    
	FROM prolongevity.adminpanel_customer C
		LEFT JOIN prolongevity.adminpanel_order O ON C.Customer_Id = O.Customer_Id
	WHERE O.IsOrderCompleted = 1 AND O.ActualAmountToPay > 0
	ORDER BY O.Order_Id DESC;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetOrderDetailsSearchResult` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetOrderDetailsSearchResult`(IN fromDate date, IN toDate date)
BEGIN
	IF (toDate IS NULL) THEN
	SELECT  CONCAT(C.First_Name, ' ' ,C.Last_Name) as CustName, 
		O.OrderCompletionDate AS "PurchaseDate",
        IFNULL(O.ActualAmountToPay,0) AS "ActualAmountToPay", 
        (SELECT  SUM(P.Amount) FROM prolongevity.adminpanel_payment P  where O.Order_Id = P.Order_Id) as AmountPaid,
		IFNULL(O.FullPaymentDiscountAmount,0) AS "FullPaymentDiscountAmount",
        CASE WHEN IFNULL(O.FullPaymentDiscountAmount,0) = 0 THEN 'Instalment' 
        ELSE 'Full Payment' END AS PaymentMethod,
		IFNULL(O.ServiceTotalAmount,0) AS "ServiceTotalAmount", O.Order_Id
    
	FROM prolongevity.adminpanel_customer C
		LEFT JOIN prolongevity.adminpanel_order O ON C.Customer_Id = O.Customer_Id
	WHERE O.IsOrderCompleted = 1 AND O.ActualAmountToPay > 0
		AND O.OrderCompletionDate >= fromDate
	ORDER BY O.Order_Id DESC;	
	else
			SELECT  CONCAT(C.First_Name, ' ' ,C.Last_Name) as CustName, 
		O.OrderCompletionDate AS "PurchaseDate",
        IFNULL(O.ActualAmountToPay,0) AS "ActualAmountToPay", 
        (SELECT  SUM(P.Amount) FROM prolongevity.adminpanel_payment P  where O.Order_Id = P.Order_Id) as AmountPaid,
		IFNULL(O.FullPaymentDiscountAmount,0) AS "FullPaymentDiscountAmount",
        CASE WHEN IFNULL(O.FullPaymentDiscountAmount,0) = 0 THEN 'Instalment' 
        ELSE 'Full Payment' END AS PaymentMethod,
		IFNULL(O.ServiceTotalAmount,0) AS "ServiceTotalAmount", O.Order_Id
    
	FROM prolongevity.adminpanel_customer C
		LEFT JOIN prolongevity.adminpanel_order O ON C.Customer_Id = O.Customer_Id
	WHERE O.IsOrderCompleted = 1 AND O.ActualAmountToPay > 0
     AND (O.OrderCompletionDate >= fromDate AND O.OrderCompletionDate <= toDate)
	ORDER BY O.Order_Id DESC;	
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetPaymentOrderSummary` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPaymentOrderSummary`()
BEGIN
	SELECT  CONCAT(C.First_Name, ' ' ,C.Last_Name) as CustName, 
		O.OrderCompletionDate AS "PurchaseDate",  PR.Name,
        IFNULL(O.ActualAmountToPay,0) AS "ActualAmountToPay", 
        IFNULL(P.Amount,0) AS "AmountPaid",
		IFNULL(O.FullPaymentDiscountAmount,0) AS "FullPaymentDiscountAmount",
        CASE WHEN IFNULL(O.FullPaymentDiscountAmount,0) = 0 THEN 'Instalment' 
        ELSE 'Full Payment' END AS PaymentMethod,
		IFNULL(O.ServiceTotalAmount,0) AS "ServiceTotalAmount", O.Order_Id, 
        OD.Quantity
    
FROM prolongevity.adminpanel_customer C
	LEFT JOIN prolongevity.adminpanel_order O ON C.Customer_Id = O.Customer_Id
	LEFT JOIN prolongevity.adminpanel_orderdetails OD ON O.Order_Id = OD.Order_Id
	LEFT JOIN prolongevity.adminpanel_payment P ON O.Order_Id = P.Order_Id
	LEFT JOIN prolongevity.adminpanel_product PR ON OD.Product_Id = PR.Product_Id

	WHERE O.IsOrderCompleted = 1 AND P.Amount > 0 AND O.ActualAmountToPay > 0
    ORDER BY O.Order_Id DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetPlanListByCustomerId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPlanListByCustomerId`(IN id int)
BEGIN
	SELECT distinct O.Order_Id,O.OrderCompletionDate, O.ActualAmountToPay, 
			IFNULL(O.FullPaymentDiscountAmount,0) AS FullPaymentDiscountAmount,
	
    CASE WHEN FullPaymentDiscountAmount > 0 THEN 'Full Payment' 
					ELSE 'Instalment Payment' END AS PaymentMethod,
	CASE WHEN
		(SELECT COUNT(Installment_Due_Id) FROM prolongevity.adminpanel_installmentdue 
			WHERE Order_id = O.Order_Id AND IsInstalmentPaid = 0) > 0 
	THEN 'Payment Pending'
    ELSE 'Payment Completed' END AS PaymentStatus
    
    FROM prolongevity.adminpanel_order O
		LEFT JOIN prolongevity.adminpanel_payment P ON O.Order_Id = P.Order_Id
        WHERE O.Customer_Id = id AND O.ActualAmountToPay > 0
        ORDER BY O.OrderCompletionDate DESC, O.Order_Id DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetProductById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetProductById`(IN id int)
BEGIN
	SELECT * FROM adminpanel_product WHERE Product_Id = id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetProductDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetProductDetails`()
BEGIN
	SELECT * FROM adminpanel_product WHERE IsProduct = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetProductServiceDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetProductServiceDetails`(IN str nvarchar(50))
BEGIN
	SELECT * FROM adminpanel_product WHERE Name LIKE CONCAT('%', str , '%') OR Description LIKE CONCAT('%', str , '%');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetProductStockDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetProductStockDetails`()
BEGIN
	SELECT Product_Id, Name, StockLevel, Threshold, Image  FROM adminpanel_product P
		WHERE P.IsProduct = 1 ORDER BY P.StockLevel;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetPurchaseHistoryByCustomerId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPurchaseHistoryByCustomerId`(IN id int)
BEGIN
	SELECT distinct O.Order_Id,O.OrderCompletionDate, O.ActualAmountToPay, 
			IFNULL(O.FullPaymentDiscountAmount,0) AS FullPaymentDiscountAmount,
	
    CASE WHEN FullPaymentDiscountAmount > 0 THEN 'Full Payment' 
					ELSE 'Instalment Payment' END AS PaymentMethod,
	CASE WHEN
		(SELECT COUNT(Installment_Due_Id) FROM prolongevity.adminpanel_installmentdue 
			WHERE Order_id = O.Order_Id AND IsInstalmentPaid = 0) > 0 
	THEN 'Payment Pending'
    ELSE 'Payment Completed' END AS PaymentStatus,
    OS.OrderStatusType, OS.OrderStatusId
    
    FROM prolongevity.adminpanel_order O
		LEFT JOIN prolongevity.adminpanel_payment P ON O.Order_Id = P.Order_Id
        LEFT JOIN prolongevity.adminpanel_orderstatus OS ON O.OrderStatus_id = OS.OrderStatusId
        WHERE O.Customer_Id = id AND O.ActualAmountToPay > 0
        ORDER BY O.OrderCompletionDate DESC, O.Order_Id DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetReferralDiscountCode` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetReferralDiscountCode`()
BEGIN
	SELECT Discount_Type_Id,DiscountCode, Percentage FROM adminpanel_discounttype 
    WHERE  IsReferralDiscount = 1
    AND ((DATE(NOW()) BETWEEN DATE(DiscountFrom) AND DATE(DiscountTo)) OR 
    (DATE(DiscountFrom) <= DATE(NOW()) AND DATE(DiscountTo) IS NULL));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetServiceDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetServiceDetails`()
BEGIN
	SELECT * FROM adminpanel_product WHERE IsProduct = 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetShippedOrders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetShippedOrders`()
BEGIN
	SELECT O.Order_Id, O.Order_Date, O.OrderCompletionDate, 
		CONCAT(C.First_Name, ' ' ,C.Last_Name) as CustName, O.OrderStatus_id AS OrderId,
        OS.OrderStatusType, 
        (SELECT GROUP_CONCAT(' ',P.Name) FROM adminpanel_orderdetails OD 
			LEFT JOIN adminpanel_product P ON OD.Product_Id = P.Product_Id
			WHERE O.Order_Id = OD.Order_Id
		) AS Items, A.Postal_Code
		
        FROM prolongevity.adminpanel_order O
			LEFT JOIN adminpanel_Customer C ON O.Customer_id = C.Customer_Id
            LEFT JOIN adminpanel_OrderStatus OS ON O.OrderStatus_id = OS.OrderStatusId
            LEFT JOIN adminpanel_address A ON C.user_id = A.User_Id AND A.Address_Type = 'B'
		WHERE O.IsOrderCompleted = 1 AND (O.OrderStatus_id = 3)
			ORDER BY O.OrderCompletionDate DESC, O.Order_Id DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetUserType` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUserType`()
BEGIN
	SELECT * FROM adminpanel_usertype;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetUserTypeById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUserTypeById`(IN id int)
BEGIN
	SELECT * FROM adminpanel_usertype WHERE UserTypeId = id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertUpdateActivityLog` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertUpdateActivityLog`(
	IN data nvarchar(20000), IN activityid int, IN userid int
    )
BEGIN
		INSERT INTO adminpanel_activitylog
		(
			ActivityDescription, LogCreatedDate, ActivityType_id, User_id
		) 
		VALUES 
		(
			data, now(), activityid, userid
		);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertUserCustomerRegistrationDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertUserCustomerRegistrationDetails`(
	IN firstname nvarchar(100), IN username nvarchar(100), IN lastname nvarchar(100),
    IN password1 nvarchar(200), IN email nvarchar(100),
    IN referralCustomerId int
 )
BEGIN
	
	Declare userid int;
    Declare groupid int;
	INSERT INTO adminpanel_user
    (
		username, first_name, last_name, password, email,is_staff, is_active, is_superuser, 
        date_joined, user_type_id
	) 
    VALUES 
    (
    username, firstname, lastname, password1, email, 0, 1, 0, now(), 4
    );
    SET @userid := (SELECT LAST_INSERT_ID());
    
    INSERT INTO adminpanel_customer(First_Name, Last_Name, Email, user_id, Enrolled_Date, Referral_Id,
    PersonalDiscount) 
    VALUES 
    (firstname, lastname, email, @userid, now(),
    CASE WHEN referralCustomerId > 0 THEN referralCustomerId END, 0
    );
    
    SET @groupid := (SELECT id FROM auth_group WHERE name='Client');
    
    INSERT INTO adminpanel_user_groups(user_id, group_id) 
    VALUES 
    (@userid, @groupid);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-02-25 19:11:36
