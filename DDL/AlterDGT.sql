use DGT
go
alter table fee drop constraint fkId1
alter table person drop constraint dni_Person
alter table fee alter column dni_Person varchar(15) not null
alter table person alter column dni_Person varchar(15) not null
alter table person add constraint dni_Person primary key (dni_Person)
alter table fee add constraint fkId1 foreign key (dni_Person) references person(dni_Person) 
