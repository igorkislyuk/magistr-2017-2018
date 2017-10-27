CREATE TABLE Address
(
id CHAR(36) NOT NULL,
postcode VARCHAR2(2000),
city VARCHAR2(2000),
street VARCHAR2(2000),
street_number VARCHAR2(2000),
district VARCHAR2(2000),
building VARCHAR2(2000),
appartment VARCHAR2(2000)
);

ALTER TABLE Address ADD CONSTRAINT Address_PK PRIMARY KEY (id);



CREATE TABLE Appeal
(
id CHAR(36) NOT NULL,
user_id CHAR(36),
type Number(10),
description VARCHAR2(2000),
rating NUMBER(10),
created_date TIMESTAMP(3),
Object_code CHAR(36) NOT NULL
);

ALTER TABLE Appeal ADD CONSTRAINT Appeal_PK PRIMARY KEY (id);



CREATE TABLE Car
(
id CHAR(36) NOT NULL,
car_number VARCHAR2(2000),
capacity VARCHAR2(2000),
start_using_date TIMESTAMP(3),
end_using_date TIMESTAMP(3)
);

ALTER TABLE Car ADD CONSTRAINT Car_PK PRIMARY KEY (id);



CREATE TABLE DeliveryAttributes
(
id CHAR(36) NOT NULL,
check_number VARCHAR2(2000),
Summary_id CHAR(36) NOT NULL
);

ALTER TABLE DeliveryAttributes ADD CONSTRAINT DeliveryAttributes_PK PRIMARY KEY (id);



CREATE TABLE Exchange
(
id CHAR(36) NOT NULL ,
amount NUMBER (28) ,
ordered_times NUMBER(10) ,
Nominals_id CHAR(36) NOT NULL
);

ALTER TABLE Exchange ADD CONSTRAINT Exchange_PK PRIMARY KEY (id);



CREATE TABLE ManRouteTimestampRelation
(
User_id CHAR(36) NOT NULL ,
RouteTimestamp_id CHAR(36) NOT NULL
);



CREATE TABLE Nominals
(
id CHAR(36) NOT NULL ,
multiply_index NUMBER (28) ,
description VARCHAR2(2000) ,
type Number(10) ,
weight NUMBER(19) ,
total NUMBER (28)
);

ALTER TABLE Nominals ADD CONSTRAINT Nominals_PK PRIMARY KEY (id);



CREATE TABLE Object
(
code CHAR(36) NOT NULL ,
state Number(10) ,
object_type Number(10) ,
description VARCHAR2(2000) ,
pass VARCHAR2(2000) ,
Address_id CHAR(36) NOT NULL
);

ALTER TABLE Object ADD CONSTRAINT Object_PK PRIMARY KEY (code);



CREATE TABLE ObjectAmountRelation
(
summary_id CHAR(36) NOT NULL ,
object_date TIMESTAMP(3) NOT NULL ,
object_code CHAR(36) NOT NULL
);

CREATE TABLE "Order"
(
id CHAR(36) NOT NULL ,
name VARCHAR2(2000) ,
phone_number VARCHAR2(2000) ,
order_date TIMESTAMP(3) ,
description VARCHAR2(2000) ,
Object_code CHAR(36) NOT NULL ,
User_id CHAR(36) NOT NULL ,
DeliveryAttributes_id CHAR(36) NOT NULL
);

ALTER TABLE "Order" ADD CONSTRAINT Order_PK PRIMARY KEY (id);



CREATE TABLE RouteTimestamp
(
id CHAR(36) NOT NULL ,
TIME TIMESTAMP(3) NOT NULL ,
Car_id CHAR(36) NOT NULL ,
Address_id CHAR(36) NOT NULL
);

ALTER TABLE RouteTimestamp ADD CONSTRAINT RouteTimestamp_PK PRIMARY KEY (id);



CREATE TABLE "Session"
(
id CHAR(36) NOT NULL ,
system_type Number(10) ,
start_time  TIMESTAMP(3) ,
last_active TIMESTAMP(3) ,
terminated NUMBER(1) ,
User_id CHAR(36) NOT NULL
);

ALTER TABLE "Session" ADD CONSTRAINT Session_PK PRIMARY KEY (id);



CREATE TABLE Settings
(
id CHAR(36) NOT NULL ,
session_id CHAR(36) ,
push_enabled CHAR(36) ,
show_closed_object NUMBER(1)
);

ALTER TABLE Settings ADD CONSTRAINT Settings_PK PRIMARY KEY (id);



CREATE TABLE Summary
(
id CHAR(36) NOT NULL ,
total_amount NUMBER (28)
);

ALTER TABLE Summary ADD CONSTRAINT Summary_PK PRIMARY KEY (id);



CREATE TABLE SummaryExchangeRelation
(
Summary_id CHAR(36) NOT NULL ,
Exchange_id CHAR(36) NOT NULL
);



CREATE TABLE "User"
(
id CHAR(36) NOT NULL ,
name VARCHAR2(2000) ,
surname VARCHAR2(2000) ,
passport VARCHAR2(2000) ,
birthday TIMESTAMP(3) ,
phone_number VARCHAR2(2000) ,
email VARCHAR2(2000) ,
pass_hash VARCHAR2(2000) ,
user_type Number(10)
);

ALTER TABLE "User" ADD CONSTRAINT User_PK PRIMARY KEY (id);



CREATE TABLE UserObjectRelation
(
user_display_name VARCHAR2(2000) NOT NULL ,
User_id CHAR(36) NOT NULL ,
Object_code CHAR(36) NOT NULL
);

ALTER TABLE UserObjectRelation ADD CONSTRAINT UserObjectRelation_PK PRIMARY KEY (User_id, Object_code);





ALTER TABLE Appeal ADD CONSTRAINT Appeal_Object_FK FOREIGN KEY
(Object_code)
REFERENCES Object
(code);


ALTER TABLE DeliveryAttributes
ADD CONSTRAINT DeliveryAttributes_Summary_FK FOREIGN KEY
(Summary_id)
REFERENCES Summary
(id);


ALTER TABLE Exchange
ADD CONSTRAINT Exchange_Nominals_FK FOREIGN KEY
(Nominals_id)
REFERENCES Nominals
(id);


ALTER TABLE ManRouteTimestampRelation
ADD CONSTRAINT MRTR_RouteTimestamp_FK FOREIGN KEY
(RouteTimestamp_id)
REFERENCES RouteTimestamp
(id);


ALTER TABLE ManRouteTimestampRelation
ADD CONSTRAINT MRTR_User_FK FOREIGN KEY
(User_id)
REFERENCES "User"
(id);


ALTER TABLE ObjectAmountRelation
ADD CONSTRAINT ObjectAmountRelation_Object_FK FOREIGN KEY
(Object_code)
REFERENCES Object
(code);


ALTER TABLE ObjectAmountRelation
ADD CONSTRAINT OAR_Summary_FK FOREIGN KEY
(Summary_id)
REFERENCES Summary
(id);


ALTER TABLE Object
ADD CONSTRAINT Object_Address_FK FOREIGN KEY
(Address_id)
REFERENCES Address
(id);


ALTER TABLE "Order"
ADD CONSTRAINT Order_DeliveryAttributes_FK FOREIGN KEY
(DeliveryAttributes_id)
REFERENCES DeliveryAttributes
(id);


ALTER TABLE "Order"
ADD CONSTRAINT Order_Object_FK FOREIGN KEY
(Object_code)
REFERENCES Object
(code);


ALTER TABLE "Order"
ADD CONSTRAINT Order_User_FK FOREIGN KEY
(User_id)
REFERENCES "User"
(id);


ALTER TABLE RouteTimestamp
ADD CONSTRAINT RouteTimestamp_Address_FK FOREIGN KEY
(Address_id)
REFERENCES Address
(id);


ALTER TABLE RouteTimestamp
ADD CONSTRAINT RouteTimestamp_Car_FK FOREIGN KEY
(Car_id)
REFERENCES Car
(id);


ALTER TABLE "Session"
ADD CONSTRAINT Session_User_FK FOREIGN KEY
(User_id)
REFERENCES "User"
(id);


ALTER TABLE Settings
ADD CONSTRAINT Settings_Session_FK FOREIGN KEY
(session_id)
REFERENCES "Session"
(id);


ALTER TABLE SummaryExchangeRelation
ADD CONSTRAINT SER_Exchange_FK FOREIGN KEY
(Exchange_id)
REFERENCES Exchange
(id);


ALTER TABLE SummaryExchangeRelation
ADD CONSTRAINT SER_Summary_FK FOREIGN KEY
(Summary_id)
REFERENCES Summary
(id);


ALTER TABLE UserObjectRelation
ADD CONSTRAINT UserObjectRelation_Object_FK FOREIGN KEY
(Object_code)
REFERENCES Object
(code);


ALTER TABLE UserObjectRelation
ADD CONSTRAINT UserObjectRelation_User_FK FOREIGN KEY
(User_id)
REFERENCES "User"
(id);


-- Data insertion

-- Users

INSERT INTO "User" (ID, NAME, SURNAME, PASSPORT, BIRTHDAY, PHONE_NUMBER, EMAIL, PASS_HASH, USER_TYPE)
VALUES ('uuid1', 'User 1', 'Surname 1', '12345678', TO_TIMESTAMP('1996-06-24', 'YYYY-MM-DD') , '123', 'email1@mail.com', 'pass_hash', '1');

INSERT INTO "User" (ID, NAME, SURNAME, PASSPORT, BIRTHDAY, PHONE_NUMBER, EMAIL, PASS_HASH, USER_TYPE)
VALUES ('uuid2', 'User 2', 'Surname 2', '12345678', TO_TIMESTAMP('1975-04-29', 'YYYY-MM-DD') , '123', 'email2@mail.com', 'pass_hash', '2');

INSERT INTO "User" (ID, NAME, SURNAME, PASSPORT, BIRTHDAY, PHONE_NUMBER, EMAIL, PASS_HASH, USER_TYPE)
VALUES ('uuid3', 'User 3', 'Surname 3', '12345678', TO_TIMESTAMP('1987-04-14', 'YYYY-MM-DD') , '123', 'email3@mail.com', 'pass_hash', '3');

-- Addresses

INSERT INTO "ADDRESS" (ID, POSTCODE, CITY, STREET, STREET_NUMBER, DISTRICT, BUILDING, APPARTMENT)
VALUES ('uuid1', '123', 'SPb', 'Street 1', '12', null, '34', '56');

INSERT INTO "ADDRESS" (ID, POSTCODE, CITY, STREET, STREET_NUMBER, DISTRICT, BUILDING, APPARTMENT)
VALUES ('uuid2', '123', 'MSK', 'Street 4', '45', null, '109a', '9');

INSERT INTO "ADDRESS" (ID, POSTCODE, CITY, STREET, STREET_NUMBER, DISTRICT, BUILDING, APPARTMENT)
VALUES ('uuid3', '123', 'SPb', 'Street 2', '87', null, '31a', '77');

-- Objects

INSERT INTO "OBJECT" (CODE, STATE, OBJECT_TYPE, DESCRIPTION, PASS, ADDRESS_ID)
VALUES ('uuid1', '1', '1', 'Bank 1', '123', 'uuid1');

INSERT INTO "OBJECT" (CODE, STATE, OBJECT_TYPE, DESCRIPTION, PASS, ADDRESS_ID)
VALUES ('uuid2', '0', '3', 'Shop 1', '123', 'uuid2');

INSERT INTO "OBJECT" (CODE, STATE, OBJECT_TYPE, DESCRIPTION, PASS, ADDRESS_ID)
VALUES ('uuid3', '1', '2', 'Terminal 2', '123', 'uuid3');

-- Appeals

INSERT INTO "APPEAL" (ID, USER_ID, TYPE, DESCRIPTION, RATING, OBJECT_CODE)
VALUES ('uuid1', 'uuid1', '1', 'Description 1', '3', 'uuid1');

INSERT INTO "APPEAL" (ID, USER_ID, TYPE, DESCRIPTION, RATING, OBJECT_CODE)
VALUES ('uuid2', 'uuid2', '1', 'Description 2.1', null, 'uuid1');

INSERT INTO "APPEAL" (ID, USER_ID, TYPE, DESCRIPTION, RATING, OBJECT_CODE)
VALUES ('uuid3', 'uuid2', '0', 'Description 2.2', '1', 'uuid2');

-- Session

INSERT INTO "Session" (ID, SYSTEM_TYPE, START_TIME, LAST_ACTIVE, TERMINATED, USER_ID)
VALUES ('uuid1', '1', TO_TIMESTAMP('2017-10-22', 'YYYY-MM-DD'), TO_TIMESTAMP('2017-10-28', 'YYYY-MM-DD'), '1', 'uuid1');

INSERT INTO "Session" (ID, SYSTEM_TYPE, START_TIME, LAST_ACTIVE, TERMINATED, USER_ID)
VALUES ('uuid2', '1', TO_TIMESTAMP('2017-08-22', 'YYYY-MM-DD'), TO_TIMESTAMP('2017-09-28', 'YYYY-MM-DD'), '0', 'uuid2');

INSERT INTO "Session" (ID, SYSTEM_TYPE, START_TIME, LAST_ACTIVE, TERMINATED, USER_ID)
VALUES ('uuid3', '2', TO_TIMESTAMP('2017-09-12', 'YYYY-MM-DD'), TO_TIMESTAMP('2017-10-10', 'YYYY-MM-DD'), '0', 'uuid3');

INSERT INTO "Session" (ID, SYSTEM_TYPE, START_TIME, LAST_ACTIVE, TERMINATED, USER_ID)
VALUES ('uuid4', '3', TO_TIMESTAMP('2017-08-12', 'YYYY-MM-DD'), TO_TIMESTAMP('2017-09-25', 'YYYY-MM-DD'), '0', 'uuid3');

-- Cars

INSERT INTO "CAR" (ID, CAR_NUMBER, CAPACITY, START_USING_DATE)
VALUES ('uuid1', '123456', '130', TO_TIMESTAMP('2017-10-22', 'YYYY-MM-DD'));

INSERT INTO "CAR" (ID, CAR_NUMBER, CAPACITY, START_USING_DATE)
VALUES ('uuid2', '654321', '160', TO_TIMESTAMP('2017-09-22', 'YYYY-MM-DD'));

INSERT INTO "CAR" (ID, CAR_NUMBER, CAPACITY, START_USING_DATE)
VALUES ('uuid3', '123456', '240', TO_TIMESTAMP('2017-10-12', 'YYYY-MM-DD'));

-- Nominals

INSERT INTO "NOMINALS" (ID, MULTIPLY_INDEX, DESCRIPTION, TYPE, WEIGHT, TOTAL)
VALUES ('uuid1', '1', '10 Rubles', '0', '0.05', '10');

INSERT INTO "NOMINALS" (ID, MULTIPLY_INDEX, DESCRIPTION, TYPE, WEIGHT, TOTAL)
VALUES ('uuid2', '2', '5000 Rubles', '1', '0.01', '10000');

INSERT INTO "NOMINALS" (ID, MULTIPLY_INDEX, DESCRIPTION, TYPE, WEIGHT, TOTAL)
VALUES ('uuid3', '100', '1 Coin', '0', '0.5', '1');

-- Exchange

INSERT INTO "EXCHANGE" (ID, AMOUNT, ORDERED_TIMES, NOMINALS_ID) VALUES ('uuid1', '20', '1', 'uuid1');
INSERT INTO "EXCHANGE" (ID, AMOUNT, ORDERED_TIMES, NOMINALS_ID) VALUES ('uuid2', '1', '12', 'uuid2');
INSERT INTO "EXCHANGE" (ID, AMOUNT, ORDERED_TIMES, NOMINALS_ID) VALUES ('uuid3', '10', '2', 'uuid3');

-- Summary

INSERT INTO "SUMMARY" (ID, TOTAL_AMOUNT) VALUES ('uuid1', '10200');
INSERT INTO "SUMMARY" (ID, TOTAL_AMOUNT) VALUES ('uuid2', '10');
INSERT INTO "SUMMARY" (ID, TOTAL_AMOUNT) VALUES ('uuid3', '10');

-- Summary Exchange Relation

INSERT INTO "SUMMARYEXCHANGERELATION" (SUMMARY_ID, EXCHANGE_ID) VALUES ('uuid1', 'uuid1');
INSERT INTO "SUMMARYEXCHANGERELATION" (SUMMARY_ID, EXCHANGE_ID) VALUES ('uuid1', 'uuid2');
INSERT INTO "SUMMARYEXCHANGERELATION" (SUMMARY_ID, EXCHANGE_ID) VALUES ('uuid2', 'uuid3');
INSERT INTO "SUMMARYEXCHANGERELATION" (SUMMARY_ID, EXCHANGE_ID) VALUES ('uuid3', 'uuid3');

-- Delivery attributes

INSERT INTO "DELIVERYATTRIBUTES" (ID, CHECK_NUMBER, SUMMARY_ID) VALUES ('uuid1', '123456fa', 'uuid1');
INSERT INTO "DELIVERYATTRIBUTES" (ID, CHECK_NUMBER, SUMMARY_ID) VALUES ('uuid2', 'of654321', 'uuid2');
INSERT INTO "DELIVERYATTRIBUTES" (ID, CHECK_NUMBER, SUMMARY_ID) VALUES ('uuid3', 'oi9900as', 'uuid3');

-- Orders

INSERT INTO "Order" (ID, NAME, PHONE_NUMBER, ORDER_DATE, DESCRIPTION, OBJECT_CODE, USER_ID, DELIVERYATTRIBUTES_ID)
VALUES ('uuid1', 'User 1', '123456', TO_TIMESTAMP('2017-10-26', 'YYYY-MM-DD'), 'Order #1', 'uuid1', 'uuid1', 'uuid1');

INSERT INTO "Order" (ID, NAME, PHONE_NUMBER, ORDER_DATE, DESCRIPTION, OBJECT_CODE, USER_ID, DELIVERYATTRIBUTES_ID)
VALUES ('uuid2', 'User 1', '654321', TO_TIMESTAMP('2017-09-22', 'YYYY-MM-DD'), 'Order #2', 'uuid2', 'uuid1', 'uuid2');

INSERT INTO "Order" (ID, NAME, PHONE_NUMBER, ORDER_DATE, DESCRIPTION, OBJECT_CODE, USER_ID, DELIVERYATTRIBUTES_ID)
VALUES ('uuid3', 'User 2', '123456', TO_TIMESTAMP('2017-10-01', 'YYYY-MM-DD'), 'Order #3', 'uuid3', 'uuid2', 'uuid3');

-- User Object Relation

INSERT INTO "USEROBJECTRELATION" (USER_DISPLAY_NAME, USER_ID, OBJECT_CODE)
VALUES ('Object 1 for User 1', 'uuid1', 'uuid1');

INSERT INTO "USEROBJECTRELATION" (USER_DISPLAY_NAME, USER_ID, OBJECT_CODE)
VALUES ('Object 2 for User 1', 'uuid1', 'uuid2');

INSERT INTO "USEROBJECTRELATION" (USER_DISPLAY_NAME, USER_ID, OBJECT_CODE)
VALUES ('Object 3 for User 1', 'uuid1', 'uuid3');

INSERT INTO "USEROBJECTRELATION" (USER_DISPLAY_NAME, USER_ID, OBJECT_CODE)
VALUES ('Object 2 for User 2', 'uuid2', 'uuid2');

-- Settings

INSERT INTO "SETTINGS" (ID, SESSION_ID, PUSH_ENABLED, SHOW_CLOSED_OBJECT) VALUES ('uuid1', 'uuid1', '1', '0');

INSERT INTO "SETTINGS" (ID, SESSION_ID, PUSH_ENABLED, SHOW_CLOSED_OBJECT) VALUES ('uuid2', 'uuid2', '0', '0');

INSERT INTO "SETTINGS" (ID, SESSION_ID, PUSH_ENABLED, SHOW_CLOSED_OBJECT) VALUES ('uuid3', 'uuid3', '1', '1');

-- Route Timestamp

INSERT INTO "ROUTETIMESTAMP" (ID, TIME, CAR_ID, ADDRESS_ID)
VALUES ('uuid1', TO_TIMESTAMP('2017-10-25', 'YYYY-MM-DD'), 'uuid1', 'uuid1');

INSERT INTO "ROUTETIMESTAMP" (ID, TIME, CAR_ID, ADDRESS_ID)
VALUES ('uuid2', TO_TIMESTAMP('2017-10-26', 'YYYY-MM-DD'), 'uuid1', 'uuid2');

INSERT INTO "ROUTETIMESTAMP" (ID, TIME, CAR_ID, ADDRESS_ID)
VALUES ('uuid3', TO_TIMESTAMP('2017-09-24', 'YYYY-MM-DD'), 'uuid2', 'uuid3');

-- Man Route Timestamp relation

INSERT INTO "MANROUTETIMESTAMPRELATION" (USER_ID, ROUTETIMESTAMP_ID) VALUES ('uuid3', 'uuid1');
INSERT INTO "MANROUTETIMESTAMPRELATION" (USER_ID, ROUTETIMESTAMP_ID) VALUES ('uuid3', 'uuid2');
INSERT INTO "MANROUTETIMESTAMPRELATION" (USER_ID, ROUTETIMESTAMP_ID) VALUES ('uuid3', 'uuid3');

-- Object amount relation

INSERT INTO "OBJECTAMOUNTRELATION" (SUMMARY_ID, OBJECT_DATE, OBJECT_CODE)
VALUES ('uuid1', TO_TIMESTAMP('2017-10-24', 'YYYY-MM-DD'), 'uuid1');

INSERT INTO "OBJECTAMOUNTRELATION" (SUMMARY_ID, OBJECT_DATE, OBJECT_CODE)
VALUES ('uuid2', TO_TIMESTAMP('2017-10-10', 'YYYY-MM-DD'), 'uuid2');

INSERT INTO "OBJECTAMOUNTRELATION" (SUMMARY_ID, OBJECT_DATE, OBJECT_CODE)
VALUES ('uuid3', TO_TIMESTAMP('2017-10-25', 'YYYY-MM-DD'), 'uuid1');