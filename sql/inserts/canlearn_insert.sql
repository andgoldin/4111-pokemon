-- bulbasaur --
INSERT INTO CanLearn VALUES (1, 53);
INSERT INTO CanLearn VALUES (1, 54);
INSERT INTO CanLearn VALUES (1, 73);
INSERT INTO CanLearn VALUES (1, 95);
INSERT INTO CanLearn VALUES (1, 102);
INSERT INTO CanLearn VALUES (1, 122);
INSERT INTO CanLearn VALUES (1, 127);
INSERT INTO CanLearn VALUES (1, 144);
INSERT INTO CanLearn VALUES (1, 159);
-- ivysaur --
INSERT INTO CanLearn VALUES (2, 53);
INSERT INTO CanLearn VALUES (2, 54);
INSERT INTO CanLearn VALUES (2, 73);
INSERT INTO CanLearn VALUES (2, 95);
INSERT INTO CanLearn VALUES (2, 102);
INSERT INTO CanLearn VALUES (2, 122);
INSERT INTO CanLearn VALUES (2, 127);
INSERT INTO CanLearn VALUES (2, 144);
INSERT INTO CanLearn VALUES (2, 159);
-- venusaur --
INSERT INTO CanLearn VALUES (3, 53);
INSERT INTO CanLearn VALUES (3, 54);
INSERT INTO CanLearn VALUES (3, 73);
INSERT INTO CanLearn VALUES (3, 95);
INSERT INTO CanLearn VALUES (3, 102);
INSERT INTO CanLearn VALUES (3, 122);
INSERT INTO CanLearn VALUES (3, 127);
INSERT INTO CanLearn VALUES (3, 144);
INSERT INTO CanLearn VALUES (3, 159);
-- charmander --
INSERT INTO CanLearn VALUES (4, 40);
INSERT INTO CanLearn VALUES (4, 44);
INSERT INTO CanLearn VALUES (4, 46);
INSERT INTO CanLearn VALUES (4, 53);
INSERT INTO CanLearn VALUES (4, 74);
INSERT INTO CanLearn VALUES (4, 101);
INSERT INTO CanLearn VALUES (4, 112);
INSERT INTO CanLearn VALUES (4, 121);
-- charmeleon --
INSERT INTO CanLearn VALUES (5, 40);
INSERT INTO CanLearn VALUES (5, 44);
INSERT INTO CanLearn VALUES (5, 46);
INSERT INTO CanLearn VALUES (5, 53);
INSERT INTO CanLearn VALUES (5, 74);
INSERT INTO CanLearn VALUES (5, 101);
INSERT INTO CanLearn VALUES (5, 112);
INSERT INTO CanLearn VALUES (5, 121);
-- charizard --
INSERT INTO CanLearn VALUES (6, 40);
INSERT INTO CanLearn VALUES (6, 44);
INSERT INTO CanLearn VALUES (6, 46);
INSERT INTO CanLearn VALUES (6, 53);
INSERT INTO CanLearn VALUES (6, 74);
INSERT INTO CanLearn VALUES (6, 101);
INSERT INTO CanLearn VALUES (6, 112);
INSERT INTO CanLearn VALUES (6, 121);
-- squirtle --
INSERT INTO CanLearn SELECT 7, MoveId FROM Moves M WHERE M.Name IN ('Tackle', 'Tail Whip', 'Bubble', 'Water Gun', 'Bite', 'Withdraw', 'Skull Bash', 'Hydro Pump');
-- wartortle --
INSERT INTO CanLearn SELECT 8, MoveId FROM Moves M WHERE M.Name IN ('Tackle', 'Tail Whip', 'Bubble', 'Water Gun', 'Bite', 'Withdraw', 'Skull Bash', 'Hydro Pump');
-- blastoise --
INSERT INTO CanLearn SELECT 9, MoveId FROM Moves M WHERE M.Name IN ('Tackle', 'Tail Whip', 'Bubble', 'Water Gun', 'Bite', 'Withdraw', 'Skull Bash', 'Hydro Pump');
-- weedle --
INSERT INTO CanLearn SELECT 13, MoveId FROM Moves M WHERE M.Name IN ('Poison Sting', 'String Shot');
-- kakuna --
INSERT INTO CanLearn SELECT 14, MoveId FROM Moves M WHERE M.Name IN ('Harden');
-- beedrill --
INSERT INTO CanLearn SELECT 15, MoveId FROM Moves M WHERE M.Name IN ('Fury Attack', 'Focus Energy', 'Twineedle', 'Rage', 'Pin Missile', 'Agility');
-- rattata --
INSERT INTO CanLearn SELECT 19, MoveId FROM Moves M WHERE M.Name IN ('Tackle', 'Tail Whip', 'Quick Attack', 'Hyper Fang', 'Focus Energy', 'Super Fang');
-- raticate --
INSERT INTO CanLearn SELECT 20, MoveId FROM Moves M WHERE M.Name IN ('Tackle', 'Tail Whip', 'Quick Attack', 'Hyper Fang', 'Focus Energy', 'Super Fang');
-- spearow --
INSERT INTO CanLearn SELECT 21, MoveId FROM Moves M WHERE M.Name IN ('Peck', 'Growl', 'Leer', 'Fury Attack', 'Mirror Move', 'Drill Peck', 'Agility');
-- fearow --
INSERT INTO CanLearn SELECT 22, MoveId FROM Moves M WHERE M.Name IN ('Peck', 'Growl', 'Leer', 'Fury Attack', 'Mirror Move', 'Drill Peck', 'Agility');
-- pikachu --
INSERT INTO CanLearn SELECT 25, MoveId FROM Moves M WHERE M.Name IN ('ThunderShock', 'Growl', 'Thunder Wave', 'Quick Attack', 'Swift', 'Agility', 'Thunder');
-- raichu --
INSERT INTO CanLearn SELECT 26, MoveId FROM Moves M WHERE M.Name IN ('ThunderShock', 'Growl', 'Thunder Wave');
-- nidoran --
INSERT INTO CanLearn SELECT 29, MoveId FROM Moves M WHERE M.Name IN ('Growl', 'Tackle', 'Scratch', 'Poison Sting', 'Tail Whip', 'Bite', 'Fury Swipes', 'Double Kick');
-- nidorina --
INSERT INTO CanLearn SELECT 30, MoveId FROM Moves M WHERE M.Name IN ('Growl', 'Tackle', 'Scratch', 'Poison Sting', 'Tail Whip', 'Bite', 'Fury Swipes', 'Double Kick');
-- nidoqueen --
INSERT INTO CanLearn SELECT 31, MoveId FROM Moves M WHERE M.Name IN ('Tackle', 'Scratch', 'Tail Whip', 'Body Slam', 'Scratch', 'Poison Sting');
-- clefairy --
INSERT INTO CanLearn SELECT 35, MoveId FROM Moves M WHERE M.Name IN ('Pound', 'Growl', 'Sing', 'DoubleSlap', 'Minimize', 'Metronome', 'Defense Curl', 'Light Screen');
-- clefable --
INSERT INTO CanLearn SELECT 36, MoveId FROM Moves M WHERE M.Name IN ('Sing', 'DoubleSlap', 'Minimize', 'Metronome');
COMMIT;