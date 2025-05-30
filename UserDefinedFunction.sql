--create database
create database UserDefinedFun;

--use the database
use UserDefinedFun;

--Create employee table
create table Employee (
	EmpID int primary key,
	FirstName varchar(50),
	LastName varchar(50),
	Age int,
	Gender varchar(30)
);

--insert the data to employee
insert into Employee (EmpID,FirstName,LastName,Age,Gender)
values
(1,'Sabari','Raj',21, 'Male'),
(2,'Subha','Lakshmi',20, 'Female'),
(3,'Sharmila','Devi',20,'Female'),
(4,'Thamizh','Arasan',22,'Male');


--                user - defined funciton
--                1. Sclar Function
Create function dbo.GetFullName(
	@FirstName varchar(50),
	@LastName varchar(50)
)
returns varchar(101)
as
begin
return @FirstName +' '+@LastName
end

select dbo.GetFullName(FirstName, LastName) as FullName from Employee;


---------------------
alter table Employee
drop column Age;

alter table Employee
Add DateOfBirth date;

UPDATE Employee
SET DateOfBirth = CASE
    WHEN EmpID = 1 THEN '2004-06-08'
    WHEN EmpID = 2 THEN '2004-04-21'
    WHEN EmpID = 3 THEN '2004-12-13'
    WHEN EmpID = 4 THEN '2003-12-12'
    ELSE DateOfBirth
END;


select * from Employee;

---Example of Scalar Funciton
create function dbo.GetAge(
	@DateOfBirth date
)
returns int
as 
begin
	declare @Age int;
	set @Age = Datediff(year, @DateOfBirth,GETDATE());
	if(month(@DateOfBirth) > month(getdate())) or (month(@DateOfBirth) = month(getdate()) and day(@DateOfBirth) > day(getdate()))
	begin
		set @Age = @Age -1;
	end

	return @Age;

end

Select FirstName, dbo.GetAge(DateOfBirth) as Age from Employee;
