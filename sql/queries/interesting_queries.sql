-- Lists the location name and the Pokemon name of every Pokemon
-- found in each location adjacent to Cerulean City, Route 10,
-- Fuchsia City, and Viridian City.

SELECT 
    L2.Name as Location, 
    P2.name as PokemonName
FROM Locations L1
JOIN ConnectedTo C
    ON C.StartRouteId = L1.LocationId
JOIN Locations L2 -- Things that are connected to L1
    ON C.LocationId = L2.LocationId
JOIN PokemonFoundIn PFI2 -- Pokemon at the connected sites
    ON PFI2.LocationId = L2.LocationId 
JOIN Pokemon P2
    ON PFI2.PokemonId = P2.PokemonId
WHERE L1.Name IN ('Cerulean City', 'Route 10', 'Fuchsia City', 'Viridian City');



-- Lists the Pokemon name, move ID, move name, move category, and base PP
-- of the moves the three starter Pokemon (Bulbasaur, Charmander, Squirtle)
-- can learn that have the same type(s) as those Pokemon.

SELECT 
    P.name AS PokemonName,
    M.MoveId, 
    M.name AS MoveName, 
    T.name AS TypeName,  
    M.category AS AttackCategory, 
    M.BasePP
FROM Pokemon P
JOIN CanLearn CL
    ON CL.PokemonId = P.PokemonId
JOIN Moves M
    ON M.MoveId = CL.MoveId
JOIN PokemonTypes PT
    ON P.PokemonId = PT.PokemonId
JOIN Types T
    ON PT.TypeId = T.TypeId
WHERE M.TypeId = T.TypeId
AND P.name IN ('Bulbasaur', 'Squirtle', 'Charmander');
    


-- Lists the account ID, display name, number of badges, and number of evolved
-- Pokemon of all accounts that have at least one Pokemon of an evolved form.

SELECT AA.AccountId, AA.DisplayName, AA.BadgeCount, COUNT(AP.PokemonId) AS EvolvedPokemonCount
 FROM (
    SELECT A.AccountId, A.DisplayName, COUNT(E.BadgeId) AS BadgeCount
    FROM Account A
    LEFT JOIN Earned E
        ON A.AccountId = E.AccountId
    GROUP BY A.AccountId, A.DisplayName
    ) AA
    LEFT JOIN AccountPokemon AP
        ON AP.AccountId = AA.AccountId
    WHERE EXISTS (
        SELECT * 
        FROM Evolves E
        WHERE E.EvolvedPokemonId = AP.PokemonId
        )
    GROUP BY AA.AccountId, AA.DisplayName, AA.BadgeCount;