CREATE TYPE account_type AS OBJECT (
    account_id      NUMBER,
    display_name    VARCHAR2(30),
    experience      INTEGER, 
    create_date     VARCHAR2(20),
    MAP MEMBER FUNCTION get_account_id RETURN NUMBER,
    MEMBER FUNCTION get_experience (SELF IN OUT NOCOPY account_type) RETURN NUMBER
);
/

CREATE TYPE BODY account_type AS
  MAP MEMBER FUNCTION get_account_id RETURN NUMBER IS
  BEGIN
    RETURN account_id;
  END;
  
  MEMBER FUNCTION get_experience RETURN NUMBER IS
  DECLARE 
    a1 INTEGER;
    a2 account_type;
    a3 INTEGER;
    
  BEGIN
    a1 := 5;
    RETURN experience;
  END;
  
END;
/

CREATE TABLE account_type_table OF account_type;

CREATE TABLE AcctRefPokemon (
    AccountPokemonId INTEGER,
    AccountId REF account_type SCOPE IS account_type_table,
    PokemonId INTEGER,
    PokemonLevel INTEGER,
    CaptureDate VARCHAR2(20),
    Nickname VARCHAR2(30),
    PRIMARY KEY (AccountPokemonId),
    FOREIGN KEY (PokemonId)
        REFERENCES Pokemon(PokemonId)
);
