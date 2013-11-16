/*

******** README **********

Each section contains raw sql as well as java-ready sql. I've done what I could to add the quotes and + signs.
The raw sql is for testing, while the java-ready sql is for copy-paste. Some of the results are "too long" in that we may 
only want to show the top X number of results. These queries return the full ranked list (since we don't have _that_ many)

******** ******* **********
*/


-- top 5 collectors (Most pokemon by count). Use a for-loop. Only display 5 results (or however many looks good).


SELECT 
	A.DisplayName AS AccountDisplayName,
	AP.AccountId, 
	COUNT(AP.PokemonId) AS TotalPokemon
FROM ACCOUNTPOKEMON AP 
JOIN ACCOUNT A
	ON A.AccountId = AP.AccountId
GROUP BY AP.AccountId, A.DisplayName
ORDER BY COUNT(AP.PokemonId) DESC


" SELECT                                 " +
" 	A.DisplayName AS AccountDisplayName, " +
" 	AP.AccountId,                        " +
" 	COUNT(AP.PokemonId) AS TotalPokemon  " +
" FROM ACCOUNTPOKEMON AP                 " +
" JOIN ACCOUNT A                         " +
" 	ON A.AccountId = AP.AccountId        " +
" GROUP BY AP.AccountId, A.DisplayName   " +
" ORDER BY COUNT(AP.PokemonId) DESC      " +




-- top 5 badgers (Most badges earned). Use a for-loop. Only display 5 results (or however many looks good).

SELECT 
	A.DisplayName AS AccountDisplayName,
	AP.AccountId, 
	COUNT(AP.BADGEID) AS TotalBadges
FROM EARNED AP 
JOIN ACCOUNT A
	ON A.AccountId = AP.AccountId
GROUP BY AP.AccountId, A.DisplayName
ORDER BY COUNT(AP.BADGEID) DESC

" SELECT                                   " +
" 	A.DisplayName AS AccountDisplayName,   " +
" 	AP.AccountId,                          " +
" 	COUNT(AP.BADGEID) AS TotalBadges       " +
" FROM EARNED AP                           " +
" JOIN ACCOUNT A                           " +
" 	ON A.AccountId = AP.AccountId          " +
" GROUP BY AP.AccountId, A.DisplayName     " +
" ORDER BY COUNT(AP.BADGEID) DESC          " 





-- which pokemon can learn the most moves ? Use a for-loop, and pick the top X results

SELECT
	P.Name AS PokemonName, 
	CL.PokemonId,
	COUNT(CL.MoveId) AS TotalMoves
FROM CanLearn CL
JOIN Pokemon P
	ON P.PokemonId = CL.PokemonId
GROUP BY CL.PokemonId
ORDER BY COUNT(CL.MoveId) DESC


" SELECT                           " +
" 	P.Name AS PokemonName,         " +
" 	CL.PokemonId,                  " +
" 	COUNT(CL.MoveId) AS TotalMoves " +
" FROM CanLearn CL                 " +
" JOIN Pokemon P                   " +
" 	ON P.PokemonId = CL.PokemonId  " +
" GROUP BY CL.PokemonId            " +
" ORDER BY COUNT(CL.MoveId) DESC   " 






-- Which moves are most commonly learned? (aka which move as the highest count of pokemon learning it?)

SELECT
	M.Name AS MoveName, 
	CL.MoveId,
	COUNT(CL.PokemonId) AS TotalMoves
FROM CanLearn CL
JOIN Moves M
	ON M.MoveId = CL.MoveId
GROUP BY CL.MoveId
ORDER BY COUNT(CL.PokemonId) DESC

" SELECT                                 " +
" 	M.Name AS MoveName,                  " +
" 	CL.MoveId,                           " +
" 	COUNT(CL.PokemonId) AS TotalMoves    " +
" FROM CanLearn CL                       " +
" JOIN Moves M                           " +
" 	ON M.MoveId = CL.MoveId              " +
" GROUP BY CL.MoveId                     " +
" ORDER BY COUNT(CL.PokemonId) DESC      " 





-- how many accounts have this pokemon? Good for the pokemon record page.

SELECT COUNT(AP.AccountId)
FROM AccountPokemon AP
WHERE AP.PokemonId = 3

"SELECT COUNT(AP.AccountId) " +
"FROM AccountPokemon AP     " +
"WHERE AP.PokemonId = 3     " 


