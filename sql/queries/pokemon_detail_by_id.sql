-- Pokemon record, for an input pokemon id

SELECT
	P.PokemonId,
	P.Name AS PokemonName,
	P.SpriteURL,
	P.Height,
	P.Weight
FROM POKEMON P
WHERE P.PokemonId = 21


-- What type(s) is it?
SELECT 
	PT.PokemonId,
	T.Name AS TypeName
FROM PokemonTypes PT
JOIN Types T
	ON PT.TypeId = T.TypeId
WHERE PT.PokemonId = 21

-- What moves can it learn? With details!
SELECT 
	CL.PokemonId,
	M.Name AS MoveName,
	T.Name AS TypeName,
	M.Category,
	M.MovePower,
	M.Accuracy,
	M.BasePP,
	M.Effect
FROM CanLearn CL
JOIN Moves M
	ON CL.MoveId = M.MoveId
JOIN Types T
	ON M.TypeId = T.TypeId
WHERE CL.PokemonId = 21

-- Where can we find the pokemon?
SELECT
	PFI.PokemonId,
	L.Name AS LocationName,
	R.Name AS RegionName
FROM PokemonFoundIn PFI
JOIN Locations L
	ON L.LocationId = PFI.LocationId
JOIN Regions R
	ON R.RegionId = L.RegionId
WHERE PFI.PokemonId = 21
