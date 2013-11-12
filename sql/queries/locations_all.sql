
-- all Locations

SELECT 
	L.Name AS LocationName,
	R.Name AS RegionName
FROM Locations L
JOIN Regions R
	ON R.RegionId = L.RegionId 
