
-- Account Details
SELECT
  	ACCOUNTID   
	, DISPLAYNAME 
	, EXPERIENCE  
	, CREATEDATE  
FROM ACCOUNT
WHERE ACCOUNTID = 2

-- Pokemon in an account
SELECT
	P.PokemonId,
	P.Name AS PokemonName,
	AP.POKEMONLEVEL,
	AP.CAPTUREDATE,
	AP.NICKNAME	
FROM AccountPokemon AP
JOIN Pokemon P
	ON P.PokemonId = AP.PokemonId
WHERE AccountId = 2

-- Badges earned by account
SELECT 
	B.BadgeId,
	B.Name AS BadgeName,
	E.DateEarned
FROM Earned E
JOIN Badges B
	ON B.BadgeId = E.BadgeId
WHERE E.AccountId = 2
