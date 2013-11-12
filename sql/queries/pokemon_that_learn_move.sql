-- Who can learn this move?
SELECT 
	CL.PokemonId,
	P.Name as PokemonName,
	M.Name AS MoveName	
FROM CanLearn CL
JOIN Moves M
	ON CL.MoveId = M.MoveId
JOIN Pokemon P
	ON P.PokemonId = CL.PokemonId
WHERE M.MoveId = 160;
