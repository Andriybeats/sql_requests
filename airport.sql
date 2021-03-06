====================CREATE===================
create database airport;

CREATE TABLE models (
	"id" serial NOT NULL PRIMARY KEY,
	"seats" integer NOT NULL,
	"capacity" FLOAT NOT NULL
);

CREATE TABLE planes (
	"id" serial NOT NULL  PRIMARY KEY,
	"model_id" integer NOT NULL,
FOREIGN KEY(model_id) 
REFERENCES models(id),
	"work_hours" FLOAT NOT NULL
);

CREATE TABLE positions(
	"id" serial NOT NULL PRIMARY KEY,
	"name" VARCHAR(55) NOT NULL
);

CREATE TABLE persons (
	"id" serial NOT NULL PRIMARY KEY,
	"surname" VARCHAR(255) NOT NULL,
	"birthday" DATE NOT NULL,
	"address" VARCHAR(255) NOT NULL,
	"last_flight" DATE DEFAULT NULL,
	"position_id" INTEGER NOT NULL, 
	FOREIGN KEY(position_id)
	REFERENCES positions(id)
);

CREATE TABLE crews (
	"id" serial NOT NULL PRIMARY KEY,
	"stewardess1_id" integer NOT NULL,
	FOREIGN KEY(stewardess1_id) 
REFERENCES persons(id),
	"stewardess2_id" integer NOT NULL,
	FOREIGN KEY(stewardess2_id) 
REFERENCES persons(id),
	"commander_id" integer NOT NULL,
	FOREIGN KEY(commander_id) 
REFERENCES persons(id),
	"pilot2_id" integer NOT NULL,
	FOREIGN KEY(pilot2_id) 
REFERENCES persons(id)
);

CREATE TABLE flights (
	"id" serial NOT NULL,
	"departure" VARCHAR(255) NOT NULL,
	"destination" VARCHAR(255) NOT NULL,
	"time_departure" TIME NOT NULL,
	"plane_id" integer NOT NULL,
	FOREIGN KEY(plane_id) 
REFERENCES planes(id),
	"time_arraving" TIME NOT NULL,
	"crew_id" integer NOT NULL,
FOREIGN KEY(crew_id) 
REFERENCES crews(id)
);

CREATE TABLE tickets (
	"id" serial NOT NULL PRIMARY KEY,
	"count" INTEGER NOT NULL,
	"count_sold" INTEGER DEFAULT NULL,
	"flight_id" INTEGER NOT NULL, 
	FOREIGN KEY(flight_id)
	REFERENCES flights(id)
);

CREATE TABLE avaliable_models (
	"avaliable_model_id" serial NOT NULL PRIMARY KEY,
	"model_id" integer NOT NULL,
	FOREIGN KEY(model_id) 
REFERENCES models(id),
	"person_id" integer NOT NULL,
	FOREIGN KEY(person_id) 
REFERENCES persons(id)
);
=========================INSERT INTO=========================
insert into positions (name) VALUES ('pilot'), ('stewardess');
insert into models (seats, capacity) VALUES (45, 45.6), (25, 25.6);

INSERT INTO planes (model_id, work_hours) (SELECT id, 21.5 FROM models WHERE id = 1);
insert into persons (surname, birthday, address, last_flight, position_id) VALUES ('Surname1','1999-01-02', 'SF','2019-01-02',1), ('Surname2','1998-01-02','SF','2019-01-02',1), ('Surname3','1999-01-02', 'SF','2019-01-02',2), ('Surname4','1998-01-02','SF','2019-01-02',2);

insert into crews  (stewardess1_id, stewardess2_id, commander_id, pilot2_id) VALUES (3,4,5,6),(3,4,5,6);
insert into avaliable_models (model_id, person_id) VALUES (1,5), (1,6); 

insert into flights (departure, destination, time_departure, plane_id, time_arrcount, count_sold, flight_id)aving, crew_id) values ('lviv','SF','22:00:00', 1,23,5);

INSERT INTO tickets ( (SELECT 21,2, id FROM flights WHERE id = 2);

//(SELECT 'lviv', 'SF','02:03:04', plane_id, '22:00:00', crew_id FROM //planes, crews WHERE planes.plane_id = 1 and crews.crew_id = 1);


=========================ALTER TABLE==========================

ALTER TABLE flights ADD PRIMARY KEY (id);

ALTER TABLE Crews
DROP COLUMN stewardess1_id;
ALTER TABLE stewardesses ALTER COLUMN stewardess_id TYPE serial;
ALTER TABLE crews
ADD COLUMN stewardess1_id integer,
ADD COLUMN stewardess2_id integer;
ALTER TABLE persons ALTER COLUMN last_flight SET DEFAULT NULL;

ALTER TABLE "models" ADD CONSTRAINT "models_fk0" FOREIGN KEY ("id_model") REFERENCES "Planes"("model_id");

ALTER TABLE "Flights" ADD CONSTRAINT "Flights_fk0" FOREIGN KEY ("plane_id") REFERENCES "Planes"("plane_id");
ALTER TABLE "Flights" ADD CONSTRAINT "Flights_fk1" FOREIGN KEY ("crew_id") REFERENCES "Crews"("crew_id");


ALTER TABLE "Tickets" ADD CONSTRAINT "Tickets_fk0" FOREIGN KEY ("id_flight") REFERENCES "Flights"("id_flight");

ALTER TABLE crews ADD CONSTRAINT "Crews_fk0" FOREIGN KEY ("stewardess1_id") REFERENCES stewardesses("stewardess_id");
ALTER TABLE crews ADD CONSTRAINT "Crews_fk1" FOREIGN KEY ("stewardess2_id") REFERENCES stewardesses("stewardess_id");
ALTER TABLE "Crews" ADD CONSTRAINT "Crews_fk2" FOREIGN KEY ("commander_id") REFERENCES "Pilots"("pilot_id");
ALTER TABLE "Crews" ADD CONSTRAINT "Crews_fk3" FOREIGN KEY ("pilot2_id") REFERENCES "Pilots"("pilot_id");

ALTER TABLE "Stewardesses" ADD CONSTRAINT "Stewardesses_fk0" FOREIGN KEY ("person_id") REFERENCES "Persons"("person_id");

ALTER TABLE "Pilots" ADD CONSTRAINT "Pilots_fk0" FOREIGN KEY ("person_id") REFERENCES "Persons"("person_id");

ALTER TABLE "avaliable_models" ADD CONSTRAINT "avaliable_models_fk0" FOREIGN KEY ("model_id") REFERENCES "models"("id_model");
ALTER TABLE "avaliable_models" ADD CONSTRAINT "avaliable_models_fk1" FOREIGN KEY ("pilot_id") REFERENCES "Pilots"("pilot_id");

=========================DELETE===============================
delete from flights;
delete from avaliable_models;
delete from crews;
delete from persons;
delete from planes;
delete from models;
delete from positions;
==========================DROP================================
drop from positions;
drop table flights;
drop table avaliable_models;
drop table crews;
drop table persons;
drop table planes;
drop table models;

==========================SELECT=================================

select 
models.id, 
persons.surname
from models INNER JOIN avaliable_models ON models.id = avaliable_models.model_id inner join persons on avaliable_ models.person_id = persons.id inner join positions on persons.position_id = positions.id
WHERE models.id = 1 AND positions.name = 'pilot';

select flights.id, flights.departure, flights.destination, flights.time_departure, planes.id,  planes.model_id, tickets.count, SUM (tickets.count -
tickets.count_sold) AS tickets_left
from planes inner join flights on planes.id = flights.id inner join tickets on tickets.flight_id = flights.id
where planes.id = 1
group by flights.id, planes.id, tickets.id;

select persons.id, persons.surname, persons.birthday, persons.address
from persons inner join positions on persons.position_id = positions.id
where positions.name = 'stewardess';

select count, count_sold, flight_id, sum(count - count_sold) as sum from tickets group by id;
select persons.id, persons.surname, crews.id  from persons left join crews on persons.id = crews.commander_id ;

select crews.id, crews.commander_id, flights.id, flights.departure  from crews right join flights on crews.id = flights.crew_id ;

select models.id, planes.id from models full join planes on models.id = planes.id;

select models.id, planes.id from models full outer join planes on models.id = planes.id UNION
select persons.id, positions.id from persons join positions on positions.id = persons.position_id;

SELECT
COUNT (birthday)
FROM
persons;


SELECT
flight_id,
SUM (count)
FROM
tickets
GROUP BY
id
HAVING
SUM (count) >10;

