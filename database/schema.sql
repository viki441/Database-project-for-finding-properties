CREATE TABLE Users
(
    username VARCHAR(50) NOT NULL PRIMARY KEY,
    -- CONSTRAINT checkUsername CHECK (LENGTH(username) > 3 AND username NOT LIKE '%[^a-zA-Z0-9_]%'),

    names VARCHAR(100) NOT NULL,

    phoneNumber CHAR(10) NOT NULL , --phoneNumber NOT LIKE '%[^0-9]%' AND

    email VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT checkEmail CHECK (email LIKE '%@%._%'),--email LIKE '[A-Za-z0-9._%+-]%@%.[A-Za-z]%'

    password VARCHAR(20) NOT NULL,
    CONSTRAINT  checkPassword CHECK( LENGTH(password) > 9),--AND password LIKE '%[a-z]%' AND password LIKE '%[A-Z]%' AND password LIKE '%[0-9]%'

    userType VARCHAR(20) NOT NULL,
    CONSTRAINT checkUserType CHECK(userType IN ('agency', 'user'))
);
CREATE TABLE Agencies
  (
      username VARCHAR(50) NOT NULL PRIMARY KEY,
      address VARCHAR(100) NOT NULL,
      website VARCHAR(50) NOT NULL,
      CONSTRAINT checkWebsite CHECK (website LIKE '%._%'), --AND website NOT LIKE '%[^A-Za-z0-9.-]%'

      FOREIGN KEY (username) REFERENCES Users(username)
  );
drop table offers;
CREATE TABLE Offers
(
    offerID VARCHAR(20) NOT NULL PRIMARY KEY,
    --CONSTRAINT checkOferID CHECK (offerID NOT LIKE '%[^a-zA-Z0-9_]%'),
    heading VARCHAR(50) NOT NULL,
    status BOOLEAN NOT NULL,
    offerType VARCHAR(20) NOT NULL,
    CONSTRAINT checkOFFERTYPE CHECK(offerType IN ('rent', 'buy')),
    publishDate DATE NOT NULL,
    --CONSTRAINT checkPublishDate CHECK (publishDate <= CURRENT_DATE AND checkPublishDate >= DATE('2000-01-01')),

    amount DECIMAL(12,2) NOT NULL, -- FROM THE CONNECTION 'PUBLISHES'
    propertyID VARCHAR(20) NOT NULL,
    username VARCHAR(50) NOT NULL,

    FOREIGN KEY (propertyID) REFERENCES PROPERTIES(propertyID),
    FOREIGN KEY (username) REFERENCES USERS(username)

);
DROP TABLE OFFERS;
CREATE TABLE Properties
(
    propertyID VARCHAR(20) NOT NULL PRIMARY KEY,
   -- CONSTRAINT checkPropertyId CHECK(propertyID NOT LIKE '%[^a-zA-Z0-9_]%'),
    floor INTEGER NOT NULL,
    CONSTRAINT checkFloor CHECK (floor NOT LIKE '%[^0-9]%'),
    roomCount INTEGER NOT NULL,
    CONSTRAINT checkRoomCount CHECK (roomCount > 0),
    area DECIMAL(12,2) NOT NULL,
    CONSTRAINT checkArea CHECK (area > 0),
    description VARCHAR(100) NOT NULL,
    locationID VARCHAR(20) NOT NULL,

    FOREIGN KEY (locationID) REFERENCES LOCATIONS(locationID)
);
CREATE TABLE Apartments(
    propertyID VARCHAR(20) NOT NULL PRIMARY KEY,
    hasElevator BOOLEAN,

    FOREIGN KEY (propertyID) REFERENCES Properties(propertyID)
);
CREATE TABLE Houses(
    propertyID VARCHAR(20) NOT NULL PRIMARY KEY,
    hasYard BOOLEAN,

    FOREIGN KEY (propertyID) REFERENCES Properties(propertyID)
);
CREATE TABLE Images (
    imageID VARCHAR(20) NOT NULL,
    offerID VARCHAR(20) NOT NULL,
    linkToServer VARCHAR(100) NOT NULL,
    fileType VARCHAR(10) NOT NULL,


    PRIMARY KEY (imageID, offerID),
    FOREIGN KEY (offerID) REFERENCES OFFERS(offerID)
);
CREATE TABLE Locations(
    locationID VARCHAR(20) PRIMARY KEY NOT NULL,
    region VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    street VARCHAR(100) NOT NULL
);

---------------------------------LOCATIONS
/*
INSERT INTO LOCATIONS (locationID, region, city, street) VALUES ('1', 'Sofia-Grad', 'Sofia', 'Vitosha Blvd 15');
INSERT INTO LOCATIONS (locationID, region, city, street) VALUES ('2', 'Plovdiv', 'Plovdiv', 'Tsar Boris III Obedinitel 42');
INSERT INTO LOCATIONS (locationID, region, city, street) VALUES ('3', 'Varna', 'Varna', 'Knyaz Boris I Blvd 101');
INSERT INTO LOCATIONS (locationID, region, city, street) VALUES ('4', 'Burgas', 'Burgas', 'Aleksandrovska St 67');
INSERT INTO LOCATIONS (locationID, region, city, street) VALUES ('5', 'Stara Zagora', 'Stara Zagora', 'General Stoletov St 23');
INSERT INTO LOCATIONS (locationID, region, city, street) VALUES ('6', 'Ruse', 'Ruse', 'Aleksandrovska St 88');
INSERT INTO LOCATIONS (locationID, region, city, street) VALUES ('7', 'Pleven', 'Pleven', 'Bulgaria Blvd 12');
INSERT INTO LOCATIONS (locationID, region, city, street) VALUES ('8', 'Sliven', 'Sliven', 'Hadji Dimitar Sq 5');
INSERT INTO LOCATIONS (locationID, region, city, street) VALUES ('9', 'Dobrich', 'Dobrich', '25th September Blvd 34');
INSERT INTO LOCATIONS (locationID, region, city, street) VALUES ('10', 'Shumen', 'Shumen', 'Slavyanski Blvd 19');
INSERT INTO LOCATIONS (locationID, region, city, street) VALUES ('11', 'Pernik', 'Pernik', 'Republic Blvd 55');
INSERT INTO LOCATIONS (locationID, region, city, street) VALUES ('12', 'Haskovo', 'Haskovo', 'Vasil Levski Blvd 73');
INSERT INTO LOCATIONS (locationID, region, city, street) VALUES ('13', 'Yambol', 'Yambol', 'Georgi Rakovski St 9');
INSERT INTO LOCATIONS (locationID, region, city, street) VALUES ('14', 'Blagoevgrad', 'Blagoevgrad', 'Todor Alexandrov Blvd 27');
INSERT INTO LOCATIONS (locationID, region, city, street) VALUES ('15', 'Veliko Tarnovo', 'Veliko Tarnovo', 'Nikola Pikolo St 14');
INSERT INTO LOCATIONS (locationID, region, city, street) VALUES ('16', 'Vratsa', 'Vratsa', 'Hristo Botev Blvd 61');
INSERT INTO LOCATIONS (locationID, region, city, street) VALUES ('17', 'Gabrovo', 'Gabrovo', 'Bryanska St 44');
INSERT INTO LOCATIONS (locationID, region, city, street) VALUES ('18', 'Stara Zagora', 'Kazanlak', 'Iskra St 18');
INSERT INTO LOCATIONS (locationID, region, city, street) VALUES ('19', 'Kyustendil', 'Kyustendil', 'Tsar Osvoboditel St 31');
INSERT INTO LOCATIONS (locationID, region, city, street) VALUES ('20', 'Montana', 'Montana', 'Treti Mart Blvd 22');
INSERT INTO LOCATIONS (locationID, region, city, street) VALUES ('21', 'Sofia-Grad', 'Sofia', 'Cherni Vrah Blvd 78');
INSERT INTO LOCATIONS (locationID, region, city, street) VALUES ('22', 'Varna', 'Varna', 'Primorski Blvd 15');
INSERT INTO LOCATIONS (locationID, region, city, street) VALUES ('23', 'Plovdiv', 'Plovdiv', 'Kapitan Raycho St 33');
INSERT INTO LOCATIONS (locationID, region, city, street) VALUES ('24', 'Burgas', 'Burgas', 'Transportna St 12');
INSERT INTO LOCATIONS (locationID, region, city, street) VALUES ('25', 'Sofia-Grad', 'Sofia', 'Bulgaria Blvd 201');
*/


-------------------------------------USERS
/*
INSERT INTO USERS(username, names, phoneNumber, email, password, userType)
VALUES('c00lDude', 'Ivan Ivanov Ivanov', '0895365762', 'cool_dude@gmail.com', 'coolPassword123', 'user');

INSERT INTO USERS(username, names, phoneNumber, email, password, userType)
VALUES('houseSellerrr433', 'Simona Dimitrova', '0886743987','s_dimitrova@abv.bg', '123456789simona', 'user');

INSERT INTO USERS(username, names, phoneNumber, email, password, userType)
VALUES('tiredWorker007', 'Veronika Simova', '0890045644','real_agency@gmail.com', 'iHateMyJob345', 'agency');

INSERT INTO USERS(username, names, phoneNumber, email, password, userType)
VALUES('fastRunner99', 'Georgi Petrov', '0888123456', 'g.petrov99@gmail.com', 'runFast123', 'user');

INSERT INTO USERS(username, names, phoneNumber, email, password, userType)
VALUES('homeFinderBG', 'Nikolay Georgiev', '0899123456', 'nikolay.geo@abv.bg', 'findHome456', 'user');

INSERT INTO USERS(username, names, phoneNumber, email, password, userType)
VALUES('luxEstatePro', 'Desislava Ivanova', '0877123456', 'd.ivanova@lux.bg', 'luxuryHomes789', 'agency');

INSERT INTO USERS(username, names, phoneNumber, email, password, userType)
VALUES('cityExplorer22', 'Petar Dimitrov', '0889234567', 'p.dimitrov22@gmail.com', 'exploreCity22', 'user');

INSERT INTO USERS(username, names, phoneNumber, email, password, userType)
VALUES('realEstateKing', 'Hristo Kolev', '0898345678', 'h.kolev@estate.bg', 'kingEstate321', 'agency');

INSERT INTO USERS(username, names, phoneNumber, email, password, userType)
VALUES('sunnyHomes', 'Elena Stoyanova', '0878234567', 'elena.sunny@gmail.com', 'sunshineHome55', 'user');

INSERT INTO USERS(username, names, phoneNumber, email, password, userType)
VALUES('bgPropertyHub', 'Martin Vasilev', '0887345678', 'martin.vasilev@hub.bg', 'hubAccess999', 'agency');

INSERT INTO USERS(username, names, phoneNumber, email, password, userType)
VALUES('cozyLiving', 'Radoslav Angelov', '0897456789', 'r.angelov@gmail.com', 'cozyLife777', 'user');

INSERT INTO USERS(username, names, phoneNumber, email, password, userType)
VALUES('dreamHouseBG', 'Teodora Petrova', '0888567890', 'teodora.p@dream.bg', 'dreamBig888', 'user');

INSERT INTO USERS(username, names, phoneNumber, email, password, userType)
VALUES('estateExpert77', 'Ivaylo Todorov', '0878678901', 'i.todorov@expert.bg', 'expertLevel77', 'agency');

INSERT INTO USERS(username, names, phoneNumber, email, password, userType)
VALUES('quickDealsBG', 'Kalina Georgieva', '0899789012', 'kalina.g@gmail.com', 'quickDeal123', 'user');

INSERT INTO USERS(username, names, phoneNumber, email, password, userType)
VALUES('urbanLivingPro', 'Daniel Hristov', '0889890123', 'daniel.h@urban.bg', 'urbanStyle456', 'agency');

INSERT INTO USERS(username, names, phoneNumber, email, password, userType)
VALUES('happyTenant', 'Miglena Ivanova', '0878901234', 'm.ivanova@gmail.com', 'happyRent999', 'user');

INSERT INTO USERS(username, names, phoneNumber, email, password, userType)
VALUES('propertyScout', 'Borislav Nikolov', '0898012345', 'b.nikolov@scout.bg', 'scoutIt321', 'user');

INSERT INTO USERS(username, names, phoneNumber, email, password, userType)
VALUES('eliteEstates', 'Kristina Dimitrova', '0888123987', 'k.dimitrova@elite.bg', 'eliteHomes555', 'agency');

INSERT INTO USERS(username, names, phoneNumber, email, password, userType)
VALUES('budgetBuyer', 'Anton Petrov', '0878234987', 'anton.petrov@gmail.com', 'budgetBuy111', 'user');

INSERT INTO USERS(username, names, phoneNumber, email, password, userType)
VALUES('rentMasterBG', 'Viktor Stoyanov', '0898345987', 'v.stoyanov@rent.bg', 'rentMaster222', 'agency');

*/
--------------------------------------AGENCIES
/*

INSERT INTO AGENCIES(USERNAME, ADDRESS, WEBSITE)
VALUES('tiredWorker007', 'S.shose 45 vhod a', 'https://real-agency.com');

INSERT INTO AGENCIES(USERNAME, ADDRESS, WEBSITE)
VALUES('luxEstatePro', 'Vitosha Blvd 120, floor 3', 'https://luxestate.bg');

INSERT INTO AGENCIES(USERNAME, ADDRESS, WEBSITE)
VALUES('realEstateKing', 'Tsarigradsko Shose 215, office 10', 'https://realestateking.bg');

INSERT INTO AGENCIES(USERNAME, ADDRESS, WEBSITE)
VALUES('bgPropertyHub', 'Bulgaria Blvd 55, entrance B', 'https://bgpropertyhub.com');

INSERT INTO AGENCIES(USERNAME, ADDRESS, WEBSITE)
VALUES('estateExpert77', 'Cherni Vrah Blvd 89, office 5', 'https://estateexpert.bg');

INSERT INTO AGENCIES(USERNAME, ADDRESS, WEBSITE)
VALUES('urbanLivingPro', 'Aleksandar Malinov Blvd 31, floor 2', 'https://urbanliving.bg');

INSERT INTO AGENCIES(USERNAME, ADDRESS, WEBSITE)
VALUES('eliteEstates', 'Nikola Vaptsarov Blvd 51, office 8', 'https://eliteestates.bg');

INSERT INTO AGENCIES(USERNAME, ADDRESS, WEBSITE)
VALUES('rentMasterBG', 'Hristo Botev Blvd 102, entrance A', 'https://rentmaster.bg');



*/
--------------------------------------PROPERTIES
/*
INSERT INTO PROPERTIES(propertyID, floor, roomCount, area, description, locationID)
VALUES('1', '3', '2', '65', 'Cozy apartment near city center', '1');

INSERT INTO PROPERTIES(propertyID, floor, roomCount, area, description, locationID)
VALUES('2', '5', '3', '90', 'Spacious flat with modern interior', '2');

INSERT INTO PROPERTIES(propertyID, floor, roomCount, area, description, locationID)
VALUES('3', '2', '1', '45', 'Compact studio close to the sea', '3');

INSERT INTO PROPERTIES(propertyID, floor, roomCount, area, description, locationID)
VALUES('4', '4', '2', '70', 'Renovated apartment in central area', '4');

INSERT INTO PROPERTIES(propertyID, floor, roomCount, area, description, locationID)
VALUES('5', '1', '3', '85', 'Ground floor apartment with yard access', '5');

INSERT INTO PROPERTIES(propertyID, floor, roomCount, area, description, locationID)
VALUES('6', '6', '4', '120', 'Large family apartment with great view', '6');

INSERT INTO PROPERTIES(propertyID, floor, roomCount, area, description, locationID)
VALUES('7', '2', '2', '68', 'Comfortable apartment near park', '7');

INSERT INTO PROPERTIES(propertyID, floor, roomCount, area, description, locationID)
VALUES('8', '3', '1', '50', 'Small apartment ideal for singles', '8');

INSERT INTO PROPERTIES(propertyID, floor, roomCount, area, description, locationID)
VALUES('9', '7', '3', '95', 'High-floor apartment with panoramic view', '9');

INSERT INTO PROPERTIES(propertyID, floor, roomCount, area, description, locationID)
VALUES('10', '5', '2', '75', 'Modern apartment in quiet neighborhood', '10');

INSERT INTO PROPERTIES(propertyID, floor, roomCount, area, description, locationID)
VALUES('11', '4', '3', '88', 'Well-lit apartment with balcony', '11');

INSERT INTO PROPERTIES(propertyID, floor, roomCount, area, description, locationID)
VALUES('12', '2', '2', '60', 'Cozy home near public transport', '12');

INSERT INTO PROPERTIES(propertyID, floor, roomCount, area, description, locationID)
VALUES('13', '1', '1', '40', 'Affordable studio apartment', '13');

INSERT INTO PROPERTIES(propertyID, floor, roomCount, area, description, locationID)
VALUES('14', '6', '4', '130', 'Luxury apartment with spacious rooms', '14');

INSERT INTO PROPERTIES(propertyID, floor, roomCount, area, description, locationID)
VALUES('15', '3', '2', '72', 'Charming apartment in historic area', '15');

INSERT INTO PROPERTIES(propertyID, floor, roomCount, area, description, locationID)
VALUES('16', '5', '3', '100', 'Recently renovated with new furniture', '16');

INSERT INTO PROPERTIES(propertyID, floor, roomCount, area, description, locationID)
VALUES('17', '2', '2', '66', 'Quiet apartment with garden view', '17');

INSERT INTO PROPERTIES(propertyID, floor, roomCount, area, description, locationID)
VALUES('18', '4', '3', '92', 'Spacious home in peaceful neighborhood', '18');

INSERT INTO PROPERTIES(propertyID, floor, roomCount, area, description, locationID)
VALUES('19', '3', '2', '70', 'Comfortable apartment close to amenities', '19');

INSERT INTO PROPERTIES(propertyID, floor, roomCount, area, description, locationID)
VALUES('20', '8', '4', '140', 'Top-floor penthouse with great view', '20');

INSERT INTO PROPERTIES(propertyID, floor, roomCount, area, description, locationID)
VALUES('21', '4', '3', '95', 'Modern apartment near business park', '21');

INSERT INTO PROPERTIES(propertyID, floor, roomCount, area, description, locationID)
VALUES('22', '2', '2', '70', 'Apartment close to the sea', '22');

INSERT INTO PROPERTIES(propertyID, floor, roomCount, area, description, locationID)
VALUES('23', '1', '4', '140', 'Large family house with garage', '23');

INSERT INTO PROPERTIES(propertyID, floor, roomCount, area, description, locationID)
VALUES('24', '6', '3', '110', 'Luxury apartment with city view', '24');

INSERT INTO PROPERTIES(propertyID, floor, roomCount, area, description, locationID)
VALUES('25', '8', '5', '180', 'Penthouse with spacious terrace', '25');

*/

-------------------------------------------------OFFERS
/*
INSERT INTO OFFERS(OFFERID, HEADING, STATUS, OFFERTYPE, PUBLISHDATE, AMOUNT, PROPERTYID, USERNAME)
VALUES('1', 'Cozy apartment in Sofia center', true, 'rent', '2026-04-01', 800, '1', 'c00lDude');

INSERT INTO OFFERS(OFFERID, HEADING, STATUS, OFFERTYPE, PUBLISHDATE, AMOUNT, PROPERTYID, USERNAME)
VALUES('2', 'Spacious flat in Plovdiv', true, 'buy', '2026-04-02', '120000', '2', 'houseSellerrr433');

INSERT INTO OFFERS(OFFERID, HEADING, STATUS, OFFERTYPE, PUBLISHDATE, AMOUNT, PROPERTYID, USERNAME)
VALUES('3', 'Studio near Varna beach', true, 'rent', '2026-04-03', '500', '3', 'sunnyHomes');

INSERT INTO OFFERS(OFFERID, HEADING, STATUS, OFFERTYPE, PUBLISHDATE, AMOUNT, PROPERTYID, USERNAME)
VALUES('4', 'Renovated apartment in Burgas', false, 'buy', '2026-04-04', '95000', '4', 'luxEstatePro');

INSERT INTO OFFERS(OFFERID, HEADING, STATUS, OFFERTYPE, PUBLISHDATE, AMOUNT, PROPERTYID, USERNAME)
VALUES('5', 'Ground floor home Stara Zagora', true, 'rent', '2026-04-05', '600', '5', 'cityExplorer22');

INSERT INTO OFFERS(OFFERID, HEADING, STATUS, OFFERTYPE, PUBLISHDATE, AMOUNT, PROPERTYID, USERNAME)
VALUES('6', 'Large family apartment Ruse', true, 'buy', '2026-04-06', '150000', '6', 'realEstateKing');

INSERT INTO OFFERS(OFFERID, HEADING, STATUS, OFFERTYPE, PUBLISHDATE, AMOUNT, PROPERTYID, USERNAME)
VALUES('7', 'Apartment near park Pleven', true, 'rent', '2026-04-07', '550', '7', 'cozyLiving');

INSERT INTO OFFERS(OFFERID, HEADING, STATUS, OFFERTYPE, PUBLISHDATE, AMOUNT, PROPERTYID, USERNAME)
VALUES('8', 'Small apartment Sliven center', false, 'buy', '2026-04-08', '70000', '8', 'bgPropertyHub');

INSERT INTO OFFERS(OFFERID, HEADING, STATUS, OFFERTYPE, PUBLISHDATE, AMOUNT, PROPERTYID, USERNAME)
VALUES('9', 'Panoramic view Dobrich', true, 'buy', '2026-04-09', '110000', '9', 'dreamHouseBG');

INSERT INTO OFFERS(OFFERID, HEADING, STATUS, OFFERTYPE, PUBLISHDATE, AMOUNT, PROPERTYID, USERNAME)
VALUES('10', 'Quiet area Shumen apartment', true, 'rent', '2026-04-10', '520', '10', 'fastRunner99');

INSERT INTO OFFERS(OFFERID, HEADING, STATUS, OFFERTYPE, PUBLISHDATE, AMOUNT, PROPERTYID, USERNAME)
VALUES('11', 'Bright apartment Pernik', true, 'buy', '2026-04-11', '98000', '11', 'estateExpert77');

INSERT INTO OFFERS(OFFERID, HEADING, STATUS, OFFERTYPE, PUBLISHDATE, AMOUNT, PROPERTYID, USERNAME)
VALUES('12', 'Cozy home Haskovo', false, 'rent', '2026-04-12', '480', '12', 'happyTenant');

INSERT INTO OFFERS(OFFERID, HEADING, STATUS, OFFERTYPE, PUBLISHDATE, AMOUNT, PROPERTYID, USERNAME)
VALUES('13', 'Affordable studio Yambol', true, 'buy', '2026-04-13', '60000', '13', 'budgetBuyer');

INSERT INTO OFFERS(OFFERID, HEADING, STATUS, OFFERTYPE, PUBLISHDATE, AMOUNT, PROPERTYID, USERNAME)
VALUES('14', 'Luxury apartment Blagoevgrad', true, 'buy', '2026-04-14', '200000', '14', 'eliteEstates');

INSERT INTO OFFERS(OFFERID, HEADING, STATUS, OFFERTYPE, PUBLISHDATE, AMOUNT, PROPERTYID, USERNAME)
VALUES('15', 'Historic area Veliko Tarnovo', true, 'rent', '2026-04-15', '650', '15', 'propertyScout');

INSERT INTO OFFERS(OFFERID, HEADING, STATUS, OFFERTYPE, PUBLISHDATE, AMOUNT, PROPERTYID, USERNAME)
VALUES('16', 'Renovated Vratsa apartment', false, 'buy', '2026-04-16', '87000', '16', 'urbanLivingPro');

INSERT INTO OFFERS(OFFERID, HEADING, STATUS, OFFERTYPE, PUBLISHDATE, AMOUNT, PROPERTYID, USERNAME)
VALUES('17', 'Quiet Gabrovo home', true, 'rent', '2026-04-17', '530', '17', 'quickDealsBG');

INSERT INTO OFFERS(OFFERID, HEADING, STATUS, OFFERTYPE, PUBLISHDATE, AMOUNT, PROPERTYID, USERNAME)
VALUES('18', 'Spacious Kazanlak apartment', true, 'buy', '2026-04-18', '105000', '18', 'rentMasterBG');

INSERT INTO OFFERS(OFFERID, HEADING, STATUS, OFFERTYPE, PUBLISHDATE, AMOUNT, PROPERTYID, USERNAME)
VALUES('19', 'Close to amenities Kyustendil', false, 'rent', '2026-04-19', '500', '19', 'homeFinderBG');

INSERT INTO OFFERS(OFFERID, HEADING, STATUS, OFFERTYPE, PUBLISHDATE, AMOUNT, PROPERTYID, USERNAME)
VALUES('20', 'Penthouse in Montana', true, 'buy', '2026-04-20', '220000', '20', 'tiredWorker007');

INSERT INTO OFFERS(OFFERID, HEADING, STATUS, OFFERTYPE, PUBLISHDATE, AMOUNT, PROPERTYID, USERNAME)
VALUES('21', 'Modern apartment in Sofia', true, 'buy', '2026-05-01', '165000', '21', 'luxEstatePro');

INSERT INTO OFFERS(OFFERID, HEADING, STATUS, OFFERTYPE, PUBLISHDATE, AMOUNT, PROPERTYID, USERNAME)
VALUES('22', 'Sea view apartment Varna', true, 'rent', '2026-05-03', '850', '22', 'sunnyHomes');

INSERT INTO OFFERS(OFFERID, HEADING, STATUS, OFFERTYPE, PUBLISHDATE, AMOUNT, PROPERTYID, USERNAME)
VALUES('23', 'Family house in Plovdiv', true, 'buy', '2026-05-05', '245000', '23', 'realEstateKing');

INSERT INTO OFFERS(OFFERID, HEADING, STATUS, OFFERTYPE, PUBLISHDATE, AMOUNT, PROPERTYID, USERNAME)
VALUES('24', 'Luxury apartment Burgas', true, 'buy', '2026-05-07', '190000', '24', 'eliteEstates');

INSERT INTO OFFERS(OFFERID, HEADING, STATUS, OFFERTYPE, PUBLISHDATE, AMOUNT, PROPERTYID, USERNAME)
VALUES('25', 'Penthouse in Sofia', true, 'buy', '2026-05-10', '350000', '25', 'tiredWorker007');
*/

------------------------------------------------------------------------------------HOUSES
/*
INSERT INTO HOUSES(PROPERTYID, HASYARD) VALUES('1', true);
INSERT INTO HOUSES(PROPERTYID, HASYARD) VALUES('2', false);
INSERT INTO HOUSES(PROPERTYID, HASYARD) VALUES('3', true);
INSERT INTO HOUSES(PROPERTYID, HASYARD) VALUES('4', true);
INSERT INTO HOUSES(PROPERTYID, HASYARD) VALUES('5', true);
INSERT INTO HOUSES(PROPERTYID, HASYARD) VALUES('6', true);
INSERT INTO HOUSES(PROPERTYID, HASYARD) VALUES('7', false);
INSERT INTO HOUSES(PROPERTYID, HASYARD) VALUES('8', false);
INSERT INTO HOUSES(PROPERTYID, HASYARD) VALUES('9', false);
INSERT INTO HOUSES(PROPERTYID, HASYARD) VALUES('10', false);
INSERT INTO HOUSES(PROPERTYID, HASYARD) VALUES('23', 'yes');
*/

-------------------------------------------------------------------------------------------APARTMENTS
/*
INSERT INTO APARTMENTS(PROPERTYID, HASELEVATOR) VALUES('11', true);
INSERT INTO APARTMENTS(PROPERTYID, HASELEVATOR) VALUES('12', false);
INSERT INTO APARTMENTS(PROPERTYID, HASELEVATOR) VALUES('13', false);
INSERT INTO APARTMENTS(PROPERTYID, HASELEVATOR) VALUES('14', true);
INSERT INTO APARTMENTS(PROPERTYID, HASELEVATOR) VALUES('15', false);
INSERT INTO APARTMENTS(PROPERTYID, HASELEVATOR) VALUES('16', false);
INSERT INTO APARTMENTS(PROPERTYID, HASELEVATOR) VALUES('17', false);
INSERT INTO APARTMENTS(PROPERTYID, HASELEVATOR) VALUES('18', true);
INSERT INTO APARTMENTS(PROPERTYID, HASELEVATOR) VALUES('19', true);
INSERT INTO APARTMENTS(PROPERTYID, HASELEVATOR) VALUES('20', true);
INSERT INTO APARTMENTS(PROPERTYID, HASELEVATOR) VALUES('21', 'yes');
INSERT INTO APARTMENTS(PROPERTYID, HASELEVATOR) VALUES('22', 'no');
INSERT INTO APARTMENTS(PROPERTYID, HASELEVATOR) VALUES('24', 'yes');
INSERT INTO APARTMENTS(PROPERTYID, HASELEVATOR) VALUES('25', 'yes');
*/

-----------------------------------------------------------------------------------IMAGES
/*
INSERT INTO IMAGES(IMAGEID, OFFERID, LINKTOSERVER, FILETYPE)
VALUES('1', '1', 'https://img.server.com/property1_1.jpg', 'jpg');

INSERT INTO IMAGES(IMAGEID, OFFERID, LINKTOSERVER, FILETYPE)
VALUES('2', '2', 'https://img.server.com/property2_1.jpg', 'jpg');

INSERT INTO IMAGES(IMAGEID, OFFERID, LINKTOSERVER, FILETYPE)
VALUES('3', '3', 'https://img.server.com/property3_1.png', 'png');

INSERT INTO IMAGES(IMAGEID, OFFERID, LINKTOSERVER, FILETYPE)
VALUES('4', '4', 'https://img.server.com/property4_1.jpg', 'jpg');

INSERT INTO IMAGES(IMAGEID, OFFERID, LINKTOSERVER, FILETYPE)
VALUES('5', '5', 'https://img.server.com/property5_1.jpeg', 'jpeg');

INSERT INTO IMAGES(IMAGEID, OFFERID, LINKTOSERVER, FILETYPE)
VALUES('6', '6', 'https://img.server.com/property6_1.jpg', 'jpg');

INSERT INTO IMAGES(IMAGEID, OFFERID, LINKTOSERVER, FILETYPE)
VALUES('7', '7', 'https://img.server.com/property7_1.png', 'png');

INSERT INTO IMAGES(IMAGEID, OFFERID, LINKTOSERVER, FILETYPE)
VALUES('8', '8', 'https://img.server.com/property8_1.jpg', 'jpg');

INSERT INTO IMAGES(IMAGEID, OFFERID, LINKTOSERVER, FILETYPE)
VALUES('9', '9', 'https://img.server.com/property9_1.jpeg', 'jpeg');

INSERT INTO IMAGES(IMAGEID, OFFERID, LINKTOSERVER, FILETYPE)
VALUES('10', '10', 'https://img.server.com/property10_1.jpg', 'jpg');

INSERT INTO IMAGES(IMAGEID, OFFERID, LINKTOSERVER, FILETYPE)
VALUES('11', '11', 'https://img.server.com/property11_1.png', 'png');

INSERT INTO IMAGES(IMAGEID, OFFERID, LINKTOSERVER, FILETYPE)
VALUES('12', '12', 'https://img.server.com/property12_1.jpg', 'jpg');

INSERT INTO IMAGES(IMAGEID, OFFERID, LINKTOSERVER, FILETYPE)
VALUES('13', '13', 'https://img.server.com/property13_1.jpeg', 'jpeg');

INSERT INTO IMAGES(IMAGEID, OFFERID, LINKTOSERVER, FILETYPE)
VALUES('14', '14', 'https://img.server.com/property14_1.jpg', 'jpg');

INSERT INTO IMAGES(IMAGEID, OFFERID, LINKTOSERVER, FILETYPE)
VALUES('15', '15', 'https://img.server.com/property15_1.png', 'png');

INSERT INTO IMAGES(IMAGEID, OFFERID, LINKTOSERVER, FILETYPE)
VALUES('16', '16', 'https://img.server.com/property16_1.jpg', 'jpg');

INSERT INTO IMAGES(IMAGEID, OFFERID, LINKTOSERVER, FILETYPE)
VALUES('17', '17', 'https://img.server.com/property17_1.jpeg', 'jpeg');

INSERT INTO IMAGES(IMAGEID, OFFERID, LINKTOSERVER, FILETYPE)
VALUES('18', '18', 'https://img.server.com/property18_1.jpg', 'jpg');

INSERT INTO IMAGES(IMAGEID, OFFERID, LINKTOSERVER, FILETYPE)
VALUES('19', '19', 'https://img.server.com/property19_1.png', 'png');

INSERT INTO IMAGES(IMAGEID, OFFERID, LINKTOSERVER, FILETYPE)
VALUES('20', '20', 'https://img.server.com/property20_1.jpg', 'jpg');

INSERT INTO IMAGES(IMAGEID, OFFERID, LINKTOSERVER, FILETYPE)
VALUES('21', '21', 'https://img.server.com/property21_1.jpg', 'jpg');

INSERT INTO IMAGES(IMAGEID, OFFERID, LINKTOSERVER, FILETYPE)
VALUES('22', '22', 'https://img.server.com/property22_1.jpg', 'jpg');

INSERT INTO IMAGES(IMAGEID, OFFERID, LINKTOSERVER, FILETYPE)
VALUES('23', '23', 'https://img.server.com/property23_1.jpg', 'jpg');

INSERT INTO IMAGES(IMAGEID, OFFERID, LINKTOSERVER, FILETYPE)
VALUES('24', '24', 'https://img.server.com/property24_1.jpg', 'jpg');

INSERT INTO IMAGES(IMAGEID, OFFERID, LINKTOSERVER, FILETYPE)
VALUES('25', '25', 'https://img.server.com/property25_1.jpg', 'jpg');

*/




