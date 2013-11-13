
-- Single Type view
-- Gets the info for a single type. Includes a list of pokemon of the type, Moves of the type, and effectiveness (both as attacker and receiver)

SELECT 
	T.TypeId,
	T.Name AS TypeName
FROM Types T
WHERE T.TypeId = 5

	-- Pokemon of a type
SELECT
	P.PokemonId,
	P.Name AS PokemonName,
	P.SpriteURL,
	P.Height,
	P.Weight
FROM Pokemon P
JOIN PokemonTypes PT
	ON P.PokemonId = PT.PokemonId
JOIN Types T
	ON PT.TypeId = T.TypeId
WHERE T.TypeId = 5

	--Moves of a type
SELECT 
	M.MoveId,
	M.Name AS MoveName,
FROM Moves M
JOIN Types T
	ON M.TypeId = T.TypeId
WHERE T.TypeId = 5


	-- Type Effectiveness for a type
	-- As an attacker
SELECT 
	E.AttackerId AS AttackerTypeId,
	T.Name AS AttackerTypeName,
	E.ReceiverId AS ReceiverTypeId,
	T2.Name AS ReceiverTypeName,
	E.Effectiveness
FROM TYPES T
JOIN Effectiveness E
	ON T.TypeId = E.AttackerId
JOIN Types T2
	ON T2.TypeId = E.ReceiverId
WHERE T.TypeId = 5


	-- As a receiver
SELECT 
	E.AttackerId AS AttackerTypeId,
	T2.Name AS AttackerTypeName,
	E.ReceiverId AS ReceiverTypeId,
	T.Name AS ReceiverTypeName,
	E.Effectiveness
FROM TYPES T
JOIN Effectiveness E
	ON T.TypeId = E.ReceiverId
JOIN Types T2
	ON T2.TypeId = E.AttackerId
WHERE T.TypeId = 5
