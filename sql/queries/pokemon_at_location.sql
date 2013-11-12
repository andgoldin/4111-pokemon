-- Gets all the pokemon located at an input location
SELECT 
	P.PokemonId,
	P.Name AS PokemonName
FROM Locations L1
JOIN PokemonFoundIn PFI 
    ON PFI.LocationId = L1.LocationId 
JOIN Pokemon P
	ON P.PokemonId = PFI.PokemonId
WHERE L1.Name = 'Pallet Town';
