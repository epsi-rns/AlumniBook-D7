DROP TABLE IF EXISTS `Alumni`;
CREATE TABLE `Alumni` (
  `AID`			int(11)		NOT NULL auto_increment,
  `Name`		varchar(50)	NOT NULL,
  `Prefix`		varchar(15)	default NULL,
  `Suffix`		varchar(10)	default NULL,
  `ShowTitle`		char(1)	default 'F',
  `EntryDate`		datetime		default NULL,
  `Last_Update`		datetime		default NULL,
  `JobTypeID`		int(11)		default NULL,
  `BirthPlace`		varchar(15)	default NULL,  
  `BirthDate`		date	default NULL,
  `Gender`		char(1)	default NULL,  
  `ReligionID`		tinyint(1)	default NULL,
  PRIMARY KEY  (`AID`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `Organization`;
CREATE TABLE `Organization` (
  `OID`			int(11)		NOT NULL auto_increment,
  `Organization`	varchar(50)	NOT NULL,
  `EntryDate`		datetime		default NULL,
  `Last_Update`		datetime	default NULL,
  `JobTypeID`		int(11)		default NULL,
  `HasBranch`		char(1)	default NULL,
  `ParentID`		int(11)		default NULL,
  `Product`		varchar(60)	default NULL,
  PRIMARY KEY  (`OID`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `AOMap`;
CREATE TABLE `AOMap` (
  `MID`			int(11)		NOT NULL auto_increment,
  `AID`			int(11),
  `OID`			int(11),
  `Last_Update`		datetime	default NULL,
  `Department`		varchar(60)	default NULL,
  `JobPositionID`		int(11)		default NULL,
  `Description`		varchar(40)	default NULL,
  `Struktural`		varchar(50)	default NULL,
  `Fungsional`		varchar(50)	default NULL,
  PRIMARY KEY  (`MID`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `Contacts`;
CREATE TABLE `Contacts` (
  `DID`			int(11)		NOT NULL auto_increment,
  `LID`			int(11),
  `LinkType`		varchar(1)	NOT NULL,
  `CTID`		int(11),
  `Contact`		varchar(50)	default NULL,
  PRIMARY KEY  (`DID`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `Address`;
CREATE TABLE `Address` (
  `DID`			int(11)		NOT NULL auto_increment,
  `LID`			int(11),
  `LinkType`		varchar(1)	NOT NULL,
  `Kawasan`		varchar(50)	default NULL,
  `Gedung`		varchar(50)	default NULL,
  `Jalan`		varchar(50)	default NULL,
  `Postalcode`		varchar(7)	default NULL,
  `NegaraID`		int(11)		default 99,
  `PropinsiID`		int(11)		default NULL,
  `WilayahID`		int(11)		default NULL,
  `Address`		varchar(175)	default NULL,
  `Region`		varchar(110)	default NULL,  
  PRIMARY KEY  (`DID`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `OFields`;
CREATE TABLE `OFields` (
  `DID`			int(11)		NOT NULL auto_increment,
  `OID`			int(11),
  `FieldID`		int(11),
  `Description`		varchar(35)	default NULL,
  PRIMARY KEY  (`DID`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `ACommunities`;
CREATE TABLE `ACommunities` (
  `DID`			int(11)		NOT NULL auto_increment,
  `AID`			int(11),
  `CID`			int(11),
  `Angkatan`		int(4),
  `Khusus`		varchar(15)	default NULL,
  `Community`	varchar(70)	default NULL,   
  `DepartmentID`	int(11) default NULL,
  `ProgramID`		int(11)	default NULL,   
  PRIMARY KEY  (`DID`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `ACompetencies`;
CREATE TABLE `ACompetencies` (
  `DID`			int(11)		NOT NULL auto_increment,
  `AID`			int(11),
  `CompetencyID`			int(11),
  `Description`		varchar(35)	default NULL,
  PRIMARY KEY  (`DID`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `ACertifications`;
CREATE TABLE `ACertifications` (
  `DID`			int(11)		NOT NULL auto_increment,
  `AID`			int(11),
  `Certification`	varchar(50)	NOT NULL,
  `Institution`		varchar(50)	default NULL,
  PRIMARY KEY  (`DID`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `AExperiences`;
CREATE TABLE `AExperiences` (
  `DID`			int(11)		NOT NULL auto_increment,
  `AID`			int(11),
  `Organization`	varchar(35)	NOT NULL,
  PRIMARY KEY  (`DID`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `ContactType`;
CREATE TABLE `ContactType` (
  `CTID`		int(11)		NOT NULL auto_increment,
  `ContactType`		varchar(25)	NOT NULL,
  PRIMARY KEY  (`CTID`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `Field`;
CREATE TABLE `Field` (
  `FieldID`		int(11)		NOT NULL auto_increment,
  `Field`		varchar(35)	NOT NULL,
  PRIMARY KEY  (`FieldID`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `JobType`;
CREATE TABLE `JobType` (
  `JobTypeID`		int(11)	,
  `JobType`		VARCHAR(40)	NOT NULL,
  PRIMARY KEY  (`JobTypeID`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `JobPosition`;
CREATE TABLE `JobPosition` (
  `JobPositionID`	int(11)		NOT NULL auto_increment,
  `JobPosition`		VARCHAR(40)	NOT NULL,
  PRIMARY KEY  (`JobPositionID`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `Religion`;
CREATE TABLE `Religion` (
  `ReligionID`		int(11)		NOT NULL auto_increment,
  `Religion`		VARCHAR(20)	NOT NULL,
  PRIMARY KEY  (`ReligionID`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `Competency`;
CREATE TABLE `Competency` (
  `CompetencyID`	int(11)		NOT NULL auto_increment,
  `Competency`		VARCHAR(30)	NOT NULL,
  PRIMARY KEY  (`CompetencyID`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `Community`;
CREATE TABLE `Community` (
  `CID`			int(11)		NOT NULL auto_increment,
  `Community`		VARCHAR(50)	NOT NULL,
  `DepartmentID`	int(11)		NOT NULL,
  `ProgramID`		int(11)		NOT NULL,
  PRIMARY KEY  (`CID`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `Department`;
CREATE TABLE `Department` (
  `DepartmentID`	int(11)		NOT NULL auto_increment,
  `Department`		VARCHAR(25)	NOT NULL,
  PRIMARY KEY  (`DepartmentID`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `Program`;
CREATE TABLE `Program` (
  `ProgramID`		int(11)		NOT NULL auto_increment,
  `Program`		VARCHAR(15)	NOT NULL,
  PRIMARY KEY  (`ProgramID`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `Propinsi`;
CREATE TABLE `Propinsi` (
  `PropinsiID`		int(11)	,
  `Propinsi`		VARCHAR(30)	NOT NULL,
  PRIMARY KEY  (`PropinsiID`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `Wilayah`;
CREATE TABLE `Wilayah` (
  `WilayahID`		int(11)	,
  `PropinsiID`		int(11)		NOT NULL,
  `Wilayah`		VARCHAR(30)	NOT NULL,
  PRIMARY KEY  (`WilayahID`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `Negara`;
CREATE TABLE `Negara` (
  `NegaraID`		int(11)	,
  `Negara`		VARCHAR(35)	NOT NULL,
  PRIMARY KEY  (`NegaraID`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `ViewContacts`;
CREATE TABLE `ViewContacts` (
  `DID`			int(11)		NOT NULL auto_increment,
  `LID`			int(11),
  `LinkType`	varchar(1)	NOT NULL,  
  `HP`		varchar(100)	default NULL,
  `Phone`	varchar(100)	default NULL,
  `Fax`		varchar(100)	default NULL,
  `email`	varchar(100)	default NULL,
  `website`	varchar(100)	default NULL,        
  PRIMARY KEY  (`DID`)
) ENGINE=MyISAM;
