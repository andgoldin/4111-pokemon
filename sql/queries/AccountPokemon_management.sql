-- new accounts and account management
-- inputting account info. Needs <AccountPokemonId>, <AccountId>, <PokemonId>, <PokemonLevel>, <capture date>, <nickname>
-- adding and removing pokemon from an account

	-- Get next ID value
SELECT MAX(AccountId)
FROM Account
	
	-- Server adds one to the ID value returned, and sends it to the insert

INSERT INTO Account VALUES (12, '', 0, '2013-11-14');

-- DELETE FROM Account WHERE AccountId = 12;

	-- update display name
UPDATE ACCOUNT SET DisplayName = 'BillyBob' WHERE AccountId = 12;

	-- update experience when needed
UPDATE ACCOUNT SET Experience = 10 WHERE AccountId = 12;	


-- Add pokemon
-- Need all this info in order to insert!!
-- In particular, need the AccountPokemonId from the db before you make the request...
-- <AccountPokemonId>, <AccountId>, <PokemonId>, <PokemonLevel>, <capture date>, <nickname>

-- Get max. Then add one.
SELECT MAX(AccountPokemonId)
FROM ACCOUNTPOKEMON

-- sample inserts
INSERT INTO AccountPokemon VALUES (34, 12, 87, 63, '2004-10-01', 'Gong');
INSERT INTO AccountPokemon VALUES (11, 4, 26, 41, '2006-07-14', 'Rai');
INSERT INTO AccountPokemon VALUES (12, 4, 15, 33, '2007-12-02', 'Drill');


-- Delete pokemon

DELETE FROM ACCOUNTPOKEMON
WHERE AccountId = 12
AND PokemonId = 87
