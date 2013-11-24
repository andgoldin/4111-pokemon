CREATE TABLE AcctRefFriends (
    AccountId REF account_type SCOPE IS account_type_table,
    FriendAccountId REF account_type SCOPE IS account_type_table,
    SinceDate VARCHAR2(20),
    TimesBattled INTEGER,
    BattleWins INTEGER,
    BattleLosses INTEGER
);

-- account ref, friend account ref, since date, numbattles, wins, losses --

-- alex biliris and harshil gandhi --
INSERT INTO AcctRefFriends SELECT REF(a), REF(b), '1998-10-30', 5, 3, 2 FROM account_type_table a, account_type_table b WHERE a.account_id = 1 AND b.account_id = 3;
INSERT INTO AcctRefFriends SELECT REF(a), REF(b), '1998-10-30', 5, 2, 3 FROM account_type_table a, account_type_table b WHERE a.account_id = 3 AND b.account_id = 1;

-- alex biliris and ash ketchum --
INSERT INTO AcctRefFriends SELECT REF(a), REF(b), '2008-09-14', 20, 5, 15 FROM account_type_table a, account_type_table b WHERE a.account_id = 1 AND b.account_id = 11;
INSERT INTO AcctRefFriends SELECT REF(a), REF(b), '2008-09-14', 20, 15, 5 FROM account_type_table a, account_type_table b WHERE a.account_id = 11 AND b.account_id = 1;

-- bohong zhao and yufeng guo --
INSERT INTO AcctRefFriends SELECT REF(a), REF(b), '2005-04-19', 8, 4, 4 FROM account_type_table a, account_type_table b WHERE a.account_id = 2 AND b.account_id = 5;
INSERT INTO AcctRefFriends SELECT REF(a), REF(b), '2005-04-19', 8, 4, 4 FROM account_type_table a, account_type_table b WHERE a.account_id = 5 AND b.account_id = 2;

-- jason lee and ningning xia --
INSERT INTO AcctRefFriends SELECT REF(a), REF(b), '2002-11-08', 3, 3, 0 FROM account_type_table a, account_type_table b WHERE a.account_id = 4 AND b.account_id = 8;
INSERT INTO AcctRefFriends SELECT REF(a), REF(b), '2002-11-08', 3, 0, 3 FROM account_type_table a, account_type_table b WHERE a.account_id = 8 AND b.account_id = 4;

-- andrew goldin and jason lee --
INSERT INTO AcctRefFriends SELECT REF(a), REF(b), '2010-07-18', 2, 1, 1 FROM account_type_table a, account_type_table b WHERE a.account_id = 6 AND b.account_id = 4;
INSERT INTO AcctRefFriends SELECT REF(a), REF(b), '2010-07-18', 2, 1, 1 FROM account_type_table a, account_type_table b WHERE a.account_id = 4 AND b.account_id = 6;

-- liming zhang and yuedong huang --
INSERT INTO AcctRefFriends SELECT REF(a), REF(b), '2006-02-11', 5, 3, 2 FROM account_type_table a, account_type_table b WHERE a.account_id = 7 AND b.account_id = 9;
INSERT INTO AcctRefFriends SELECT REF(a), REF(b), '2006-02-11', 5, 2, 3 FROM account_type_table a, account_type_table b WHERE a.account_id = 9 AND b.account_id = 7;

-- yufeng guo and zhiling wan --
INSERT INTO AcctRefFriends SELECT REF(a), REF(b), '2007-05-15', 13, 7, 6 FROM account_type_table a, account_type_table b WHERE a.account_id = 5 AND b.account_id = 10;
INSERT INTO AcctRefFriends SELECT REF(a), REF(b), '2007-05-15', 13, 6, 7 FROM account_type_table a, account_type_table b WHERE a.account_id = 10 AND b.account_id = 5;

-- andrew goldin and ash ketchum --
INSERT INTO AcctRefFriends SELECT REF(a), REF(b), '1999-01-02', 16, 10, 6 FROM account_type_table a, account_type_table b WHERE a.account_id = 6 AND b.account_id = 11;
INSERT INTO AcctRefFriends SELECT REF(a), REF(b), '1999-01-02', 16, 10, 6 FROM account_type_table a, account_type_table b WHERE a.account_id = 11 AND b.account_id = 6;

-- bohong zhao and harshil gandhi --
INSERT INTO AcctRefFriends SELECT REF(a), REF(b), '2006-11-10', 1, 1, 0 FROM account_type_table a, account_type_table b WHERE a.account_id = 2 AND b.account_id = 3;
INSERT INTO AcctRefFriends SELECT REF(a), REF(b), '2006-11-10', 1, 0, 1 FROM account_type_table a, account_type_table b WHERE a.account_id = 3 AND b.account_id = 2;

-- alex biliris and liming zhang --
INSERT INTO AcctRefFriends SELECT REF(a), REF(b), '2010-07-18', 0, 0, 0 FROM account_type_table a, account_type_table b WHERE a.account_id = 1 AND b.account_id = 7;
INSERT INTO AcctRefFriends SELECT REF(a), REF(b), '2010-07-18', 0, 0, 0 FROM account_type_table a, account_type_table b WHERE a.account_id = 7 AND b.account_id = 1;

COMMIT;
