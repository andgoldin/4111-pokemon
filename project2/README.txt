COMS W4444 - Introduction to Databases
Project 2: Object-Relational Schema Design
Yufeng Guo (yg2346) and Andrew Goldin (adg2160)
Monday, November 25, 2013

Files submitted:
 - expdat.dmp: file representing the transcript of our database schema.
 - queries.txt: file containing a handful of interesting queries using our new OR features, with brief descriptions and results.
 - README.txt: this file, explains our new features and design decisions.

Oracle account used: yg2346@ADB

For this project, we updated our "Accounts" entity in our Pokemon database. To do this, we created a new object type called account_type, which contains as attributes the account's ID, the display name, the create date, a map member function to return the ID and a member function to calculate and return the user's experience level (between 0 and 100) based on the number of badges they have and the skill level of their Pokemon. In our previous design, user experience was an attribute of the Account entity. We realized that it would be more natural to represent accounts as object types, so that values like experience level could be computed dynamically and on-demand, and did not have to be stored as an attribute. We also created a table called Account_Type_Table which holds the account object types. The SQL for this new type looks like this:


	CREATE OR REPLACE TYPE account_type AS OBJECT (
		account_id      NUMBER,
		display_name    VARCHAR2(30),
		create_date     VARCHAR2(20),
		MAP MEMBER FUNCTION get_account_id RETURN NUMBER,
		MEMBER FUNCTION get_experience  RETURN NUMBER
	);
	/

	CREATE OR REPLACE TYPE BODY account_type AS
		MAP MEMBER FUNCTION get_account_id RETURN NUMBER IS
		BEGIN
			RETURN account_id;
		END;
  
		MEMBER FUNCTION get_experience RETURN NUMBER IS 
		exper NUMBER;
		BEGIN
			DECLARE 
				badgesEarned INTEGER;
				levelSum INTEGER;
			BEGIN
				SELECT COUNT(E.BadgeId) into badgesEarned
				FROM Earned E
				WHERE E.AccountId = account_id;

				SELECT SUM(AP.PokemonLevel) INTO levelSum
				FROM AccountPokemon AP
				WHERE AP.AccountId = account_id;

				return FLOOR (100* (badgesEarned/8 + levelSum/600 ) / 2);
			END;
		END;
	END;  
	/
	
	CREATE TABLE account_type_table OF account_type;


For a new relation that uses our new types, we decided to implement a "friends" relation, in which two accounts can be listed as friends, and contains interesting data associated with their friendship. To do this, we created a relation table called AcctRefFriends, which contains as attributes a FriendId (which serves as the primary key), a scoped REF to each account involved in the friend relation, the date the relationship was created, the number of battles the two users have had, and the number of battle wins and losses. Each friend relation has two tuples in the table in order to make it easy to represent the table as an undirected graph, hence making it easier to perform certain types of queries (we go into more detail with this in queries.txt). The SQL for this table is as follows:


	CREATE TABLE AcctRefFriends (
		FriendId INTEGER,
		AccountId REF account_type SCOPE IS account_type_table,
		FriendAccountId REF account_type SCOPE IS account_type_table,
		SinceDate VARCHAR2(20),
		TimesBattled INTEGER,
		BattleWins INTEGER,
		BattleLosses INTEGER,
		PRIMARY KEY (FriendId)
	);
	
	
This design makes use of three of the OR features listed in the project description: (1) object types, with the new account_type object type, (2) object methods, with the get_account_id() and get_experience() methods of account_type, and (3) references (REF/DEREF), with making use of references in our new relation.
