--Fatura indirimi ve c�reti hesaplayan trigger
CREATE TRIGGER tr_Sales_�nvoices
ON sales
AFTER INSERT
AS
BEGIN
    DECLARE @TouristID INT, @ToursID INT, @Gu�desID INT, @ArrivalDate DATE, @InvociesPrice MONEY

    SELECT @TouristID = i.TouristID, @ToursID = i.ToursID, @Gu�desID = i.Gu�desID, @ArrivalDate = i.ArrivalDate
    FROM inserted i

    SELECT @InvociesPrice = SUM(Tours.TourPrice)
    FROM Tours
    WHERE ToursID = @ToursID

    -- 60 ya� �zeri olanlar i�in indirim uygulan�r
    IF EXISTS (SELECT 1 FROM Tourists WHERE TouristID = @TouristID AND DATEDIFF(YEAR, Birth, @ArrivalDate) > 60)
    BEGIN
        SET @InvociesPrice = @InvociesPrice - (@InvociesPrice * 0.15)
    END

    INSERT INTO Invoices( TouristID, InvoicePrice)
    VALUES ( @TouristID, @InvociesPrice)
END

--test random birisi
insert into dbo.Sales values('Ey�p Sultan Camii,Ortak�y Camii',NULL,6,7,'10-04-2017',21,3,'Ahmet �im�ek',12341,21,'Oliveer Red','Male','02-12-1950','England','Italy','10-04-2017')
