--Single badge info, with counts of how many others have it

SELECT
	B.BadgeId,
	B.Name as BadgeName,
	B.Gymleadername,
	L.Name as LocationName,
	COUNT(E.AccountId) AS TotalAccountsWhoEarned
FROM Badges B
JOIN Locations L
	ON B.LocationId = L.LocationId
JOIN Earned E
	ON B.BadgeId = E.BadgeId
WHERE B.BadgeId = 4
GROUP BY B.BadgeId,
	B.Name,
	B.Gymleadername,
	L.Name
