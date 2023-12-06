USE CarRental
GO
--_________________________/Insert data in manufacturers using procedure spInsertManufacturer\____________________
DECLARE @id INT
EXEC spInsertManufacturer'Audi', 'Made in Germany', @id OUTPUT
SELECT @id as 'inserted with id'
EXEC spInsertManufacturer'Marcedes', 'Made in Germany', @id OUTPUT
SELECT @id as 'inserted with id'
EXEC spInsertManufacturer'BMW', 'Made in Germany', @id OUTPUT
SELECT @id as 'inserted with id'
EXEC spInsertManufacturer'Range Rover', 'Owning this company Jaguar Land', @id OUTPUT
SELECT @id as 'inserted with id'
EXEC spInsertManufacturer'Toyota', 'Made in Japan', @id OUTPUT
SELECT @id as 'inserted with id'
EXEC spInsertManufacturer'Hyundai', 'Made in South Korea', @id OUTPUT
SELECT @id as 'inserted with id'
EXEC spInsertManufacturer'Ford', 'Made in USA', @id OUTPUT
SELECT @id as 'inserted with id'
EXEC spInsertManufacturer'tesla', 'Made in USA', @id OUTPUT
SELECT @id as 'inserted with id'
GO
SELECT * FROM manufacturers
GO
--_________________________/-Update Data in manufacturer using  Procedure spUpdateManufacturer\____________________
EXEC spUpdateManufacturer @manufacturer_id=1, @manufacturer_name = 'Bentley'
EXEC spUpdateManufacturer @manufacturer_id=4, @manufacturer_name = 'Volvo'
EXEC spUpdateManufacturer @manufacturer_id=5, @manufacturer_name = 'Mclaren'
GO
SELECT * FROM manufacturers
GO
--_________________________/Insert models data using procedure spInsertModels\____________________
DECLARE @id INT
EXEC spInsertModels 'AX1 ', 1, @id OUTPUT
SELECT @id as 'inserted with id'
EXEC spInsertModels 'MDS-01',2, @id OUTPUT
SELECT @id as 'inserted with id'
EXEC spInsertModels 'b-01', 3, @id OUTPUT
SELECT @id as 'inserted with id'
EXEC spInsertModels 'RV-1', 4, @id OUTPUT
SELECT @id as 'inserted with id'
EXEC spInsertModels 'TT-01',5, @id OUTPUT
SELECT @id as 'inserted with id'
EXEC spInsertModels 'H-06',6, @id OUTPUT
SELECT @id as 'inserted with id'
EXEC spInsertModels 'Ford-1', 7, @id OUTPUT
SELECT @id as 'inserted with id'
EXEC spInsertModels 'T-S1', 8, @id OUTPUT
SELECT @id as 'inserted with id'
GO
SELECT * FROM models
GO
--_________________________/ Insert customers data using procedure spInsertCustomers\____________________
EXEC spInsertCustomers	
								@customer_name ='Rahat' ,
								@customer_email ='rahat@mm.com',
								@customer_phone ='01710111111',
								@customer_address ='gazipur'
EXEC spInsertCustomers	
								@customer_name ='Sagor' ,
								@customer_email ='sagor@mm.com',
								@customer_phone ='01810111111',
								@customer_address ='dhaka'
EXEC spInsertCustomers	
								@customer_name ='Mitul' ,
								@customer_email ='mitul@mm.com',
								@customer_phone ='01610111111',
								@customer_address ='dhaka'
EXEC spInsertCustomers	
								@customer_name ='Hanif' ,
								@customer_email ='hanif@mm.com',
								@customer_phone ='01910111111',
								@customer_address ='dhaka'
GO
select * from customers
go
--_________________________/ Insert in bookingstatus using procedure spInsertBookingstatus\____________________
DECLARE @id INT
exec spInsertBookingstatus 'available',@id  OUTPUT
SELECT @id as 'inserted with id'
exec spInsertBookingstatus 'hired',@id  OUTPUT
SELECT @id as 'inserted with id'
exec spInsertBookingstatus 'not available',@id  OUTPUT
SELECT @id as 'inserted with id'
go
select * from bookingstatus
GO
--_________________________/Insert in vehicle_catagory using procedure spInsertVrhicleCategories\____________________
exec spInsertVrhicleCategories	'Luxary'
exec spInsertVrhicleCategories	'Regular'
exec spInsertVrhicleCategories	'Microbus'
exec spInsertVrhicleCategories	'Family car'
go
select * from vehicle_categories
GO
--_________________________/Insert in vehicles using procedure spInsertVehicles\____________________
DECLARE @id INT
exec spInsertVehicles 27000, 3000.00, 2100, 2, 1, @id output
exec spInsertVehicles 21000, 2700.00, 2100, 2, 1, @id output
exec spInsertVehicles 27000, 3000.00, 4500, 1, 2, @id output
exec spInsertVehicles 1500, 8000.00, 2100, 1, 1, @id output
go
select * from vehicles
go
--_________________________/Insert in bookings using procedure spInsertBookings\____________________
exec spInsertBookings	
								@date_from ='2022-01-07' ,
								@date_to ='2022-01-10',
								@payment_recieved_on ='2022-01-09',
								@customer_id =1,
								@vehicle_id =1
--will fail for trigger
--since vehicle_id 1 is booked in the same time range
exec spInsertBookings	
								@date_from ='2022-01-09' ,
								@date_to ='2022-01-13',
								@payment_recieved_on ='2022-01-09',
								@customer_id =2,
								@vehicle_id =1
--ok
exec spInsertBookings	
								@date_from ='2022-01-09' ,
								@date_to ='2022-01-13',
								@payment_recieved_on ='2022-01-09',
								@customer_id =2,
								@vehicle_id =2
--ok
--views

select * from vehiclelist
go
select * from vBookingCurrentMonth
go
select * from bookingofvehcle_date_range(1, '2022-01-01', '2022-01-31')
GO

 --_________________________/Queries Added\____________________


---_________________________/  1 inner join\____________________
 
SELECT        
		vc.category_name, 
		m.model_name, 
		v.vehicle_id, 
		v.current_milage, 
		v.hire_rate, 
		v.engine_size, 
		c.customer_name,
		c.customer_email,
		c.customer_phone
FROM  vehicle_categories AS vc 
INNER JOIN   models AS m 
INNER JOIN   vehicles AS v ON m.model_id = v.model_id 
INNER JOIN   manufacturers AS mfg ON m.manufacturer_id = mfg.manufacturer_id ON vc.category_id = v.category_id 
INNER JOIN   customers AS c 
INNER JOIN    bookings AS b ON c.customer_id = b.customer_id ON v.vehicle_id = b.vehicle_id
GO
--_________________________/2 inner + filter\____________________
 
SELECT        
		vc.category_name,
		m.model_name,
		v.vehicle_id, 
		v.current_milage, 
		v.hire_rate, 
		v.engine_size, 
		c.customer_name, 
		c.customer_email, 
		c.customer_phone
FROM   vehicle_categories AS vc 
INNER JOIN   models AS m 
INNER JOIN   vehicles AS v ON m.model_id = v.model_id 
INNER JOIN   manufacturers AS mfg ON m.manufacturer_id = mfg.manufacturer_id ON vc.category_id = v.category_id 
INNER JOIN   customers AS c 
INNER JOIN   bookings AS b ON c.customer_id = b.customer_id ON v.vehicle_id = b.vehicle_id
WHERE vc.category_name ='Regular'
GO


--_________________________/ 3 inner + filter\____________________
 
SELECT      
		vc.category_name, 
		m.model_name, 
		v.vehicle_id, 
		v.current_milage,
		v.hire_rate, 
		v.engine_size, 
		c.customer_name, 
		c.customer_email,
		c.customer_phone
FROM  vehicle_categories AS vc 
INNER JOIN   models AS m 
INNER JOIN  vehicles AS v ON m.model_id = v.model_id 
INNER JOIN  manufacturers AS mfg ON m.manufacturer_id = mfg.manufacturer_id ON vc.category_id = v.category_id 
INNER JOIN  customers AS c 
INNER JOIN  bookings AS b ON c.customer_id = b.customer_id ON v.vehicle_id = b.vehicle_id
WHERE m.model_name ='AX1'
GO

--_________________________/4 Left+Right outer\____________________
 

SELECT   vc.category_name,
		m.model_name, 
		v.vehicle_id,
		v.current_milage,
		v.hire_rate,
		v.engine_size, 
		c.customer_name, 
		c.customer_email,
		c.customer_phone
FROM   customers AS c 
INNER JOIN			 bookings AS b ON c.customer_id = b.customer_id 
LEFT OUTER JOIN      models AS m 
INNER JOIN			 vehicles AS v ON m.model_id = v.model_id 
INNER JOIN			 manufacturers AS mfg ON m.manufacturer_id = mfg.manufacturer_id ON b.vehicle_id = v.vehicle_id 
RIGHT OUTER JOIN     vehicle_categories AS vc ON v.category_id = vc.category_id
GO
--_________________________/ 5 CTE (4 cahnged)\____________________

WITH vcte AS
(
SELECT        
			vc.category_id,
			vc.category_name, 
			m.model_id,m.model_name,
			v.vehicle_id,
			v.current_milage, 
			v.hire_rate, 
			v.engine_size,
			b.customer_id
                       
FROM   bookings AS b 
LEFT OUTER JOIN  models AS m 
INNER JOIN  vehicles AS v ON m.model_id = v.model_id 
INNER JOIN  manufacturers AS mfg ON m.manufacturer_id = mfg.manufacturer_id ON b.vehicle_id = v.vehicle_id 
RIGHT OUTER JOIN vehicle_categories AS vc ON v.category_id = vc.category_id
)
SELECT  vcte.category_name, 
		vcte.model_name, 
		vcte.vehicle_id, 
		vcte.current_milage,
		vcte.hire_rate, 
		vcte.engine_size,
		c.customer_name, 
		c.customer_email,
		c.customer_phone
FROM customers AS c 
LEFT JOIN	vcte ON c.customer_id = vcte.customer_id
GO

 --_________________________/6 not matched\____________________

SELECT        vc.category_name,
				m.model_name,
				v.vehicle_id,
				v.current_milage,
				v.hire_rate, 
				v.engine_size, 
				c.customer_name,
				c.customer_email,
				c.customer_phone
FROM  customers AS c 
INNER JOIN		 bookings AS b ON c.customer_id = b.customer_id 
LEFT OUTER JOIN  models AS m 
INNER JOIN		vehicles AS v ON m.model_id = v.model_id 
INNER JOIN      manufacturers AS mfg ON m.manufacturer_id = mfg.manufacturer_id ON b.vehicle_id = v.vehicle_id 
RIGHT OUTER JOIN vehicle_categories AS vc ON v.category_id = vc.category_id
WHERE m.model_id IS NULL

--_________________________/ 7 change 6 to sub-query\____________________

SELECT vc.category_name,
		m.model_name,
		v.vehicle_id, 
		v.current_milage,
		v.hire_rate, 
		v.engine_size,
		c.customer_name, 
		c.customer_email, 
		c.customer_phone
FROM   customers AS c 
INNER JOIN  bookings AS b ON c.customer_id = b.customer_id 
LEFT OUTER JOIN  models AS m 
INNER JOIN  vehicles AS v ON m.model_id = v.model_id 
INNER JOIN   manufacturers AS mfg ON m.manufacturer_id = mfg.manufacturer_id ON b.vehicle_id = v.vehicle_id 
RIGHT OUTER JOIN   vehicle_categories AS vc ON v.category_id = vc.category_id
WHERE m.model_id IS NULL OR m.model_id NOT IN (select model_id from models)
GO
--_________________________/Summary aggregate\____________________
SELECT m.model_name, vc.category_name, COUNT(v.vehicle_id) 'numberofveghicles'
FROM  vehicle_categories vc
INNER JOIN  vehicles v ON vc.category_id = v.category_id 
INNER JOIN   models m ON v.model_id = m.model_id
GROUP BY  m.model_name, vc.category_name
GO

 --_________________________/ 9 Summary aggregate + having\____________________

SELECT  m.model_name, 
		vc.category_name, 
		COUNT(v.vehicle_id) 'numberofveghicles'
FROM   vehicle_categories vc
INNER JOIN  vehicles v ON vc.category_id = v.category_id 
INNER JOIN   models m ON v.model_id = m.model_id
GROUP BY  m.model_name, vc.category_name
HAVING m.model_name ='AX1'
GO
--_________________________/ 10 Ranking\____________________

SELECT        m.model_name, 
COUNT(v.vehicle_id) OVER(ORDER BY m.model_id) 'numberofveghicles',
ROW_NUMBER() OVER(ORDER BY m.model_id) 'rownumber',
RANK() OVER(ORDER BY m.model_id) 'rank',
DENSE_RANK() OVER(ORDER BY m.model_id) 'dense',
NTILE(2) OVER(ORDER BY m.model_id) 'ntile_2'
FROM  vehicle_categories vc
INNER JOIN  vehicles v ON vc.category_id = v.category_id 
INNER JOIN   models m ON v.model_id = m.model_id
GO


--_________________________/  11 CASE\____________________

SELECT  vc.category_name,
		m.model_name, 
		mfg.manufacturer_name,
		v.current_milage, 
		v.hire_rate, 
		v.engine_size,
CASE 
	WHEN vc.category_name='Luxary' THEN 'Not for 2 days'
	ELSE ''
END 'Comment'
FROM    vehicle_categories vc

INNER JOIN vehicles v ON vc.category_id = v.category_id 
INNER JOIN models m ON v.model_id = m.model_id 
INNER JOIN manufacturers mfg ON m.manufacturer_id = mfg.manufacturer_id
GO
