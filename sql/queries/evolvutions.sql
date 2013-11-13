-- Evolves into what
SELECT 
    E.EVOLVEDPOKEMONID,
	P.Name AS PokemonName,
	P.SpriteURL,
	E.EvolutionLevel
FROM Evolves E
JOIN Pokemon P
	ON E.EVOLVEDPOKEMONID = P.PokemonId
WHERE E.BASEPOKEMONID = 2

-- Evolves From what
SELECT 
    E.BASEPOKEMONID,
	P.Name AS PokemonName,
	P.SpriteURL,
	E.EvolutionLevel
FROM Evolves E
JOIN Pokemon P
	ON E.BASEPOKEMONID = P.PokemonId
WHERE E.EVOLVEDPOKEMONID = 2
