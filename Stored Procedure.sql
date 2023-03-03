--E�er daha �nce de tur satt��� bir turistse, bu bilgileri tekrar girmemeli ve turisti sistemden bulup eklemelidir.
CREATE PROCEDURE sp_AddSaleTable (@ToursID INT, @TouristID INT, @Gu�desID INT, @Date DATE, @PlacesToVisit NVARCHAR(90),@ArrivalDate DATE)
AS
BEGIN
IF NOT EXISTS (SELECT * FROM Tours WHERE ToursID = @ToursID)
BEGIN
RAISERROR('Invalid ToursID.', 16, 1)
RETURN
END
IF NOT EXISTS (SELECT * FROM Tourists WHERE TouristID = @TouristID)
BEGIN
RAISERROR('Invalid TouristID.', 16, 1)
RETURN
END
IF NOT EXISTS (SELECT * FROM Gu�des WHERE Gu�desID = @Gu�desID)
BEGIN
RAISERROR('Invalid Gu�desID.', 16, 1)
RETURN
END
INSERT INTO Sales(ToursID, TouristID, Gu�desID, Date, PlacesToVisit,ArrivalDate )
VALUES (@ToursID, @TouristID, @Gu�desID, @Date, @PlacesToVisit, @ArrivalDate)
END

EXEC sp_AddSaleTable 1, 10, 1, '2022-01-08' ,'Ayasofya,K�z Kulesi,PierreLoti' ,'2022-01-08'

