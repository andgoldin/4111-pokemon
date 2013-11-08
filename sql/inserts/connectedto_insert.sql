-- pallet town to route 1 --
INSERT INTO ConnectedTo VALUES (26, 1);
-- route 1 to viridian city --
INSERT INTO ConnectedTo VALUES (1, 27);
-- viridian city to route 2 --
INSERT INTO ConnectedTo VALUES (27, 2);
-- viridian city to route 22 --
INSERT INTO ConnectedTo VALUES (27, 22); 
-- route 2 to pewter city --
INSERT INTO ConnectedTo VALUES (2, 28); 
-- route 2 to diglett's cave --
INSERT INTO ConnectedTo VALUES (2, 37); 
-- diglett's cave to route 11 --
INSERT INTO ConnectedTo VALUES (37, 11); 
-- route 22 to victory road --
INSERT INTO ConnectedTo VALUES (22, 48); 
-- victory road to route 23 --
INSERT INTO ConnectedTo VALUES (48, 23); 
-- route 23 to indigo plateau --
INSERT INTO ConnectedTo VALUES (23, 38); 
-- pewter city to route 3 --
INSERT INTO ConnectedTo VALUES (28, 3); 
-- route 3 to mt. moon --
INSERT INTO ConnectedTo VALUES (3, 39); 
-- mt. moon to route 4 --
INSERT INTO ConnectedTo VALUES (39, 4); 
-- route 4 to cerulean city --
INSERT INTO ConnectedTo VALUES (4, 29); 
-- cerulean city to route 5 --
INSERT INTO ConnectedTo VALUES (29, 5); 
-- cerulean city to route 9 --
INSERT INTO ConnectedTo VALUES (29, 9); 
-- cerulean city to route 24 --
INSERT INTO ConnectedTo VALUES (29, 24);
 -- route 24 to route 25 --
INSERT INTO ConnectedTo VALUES (24, 25);
-- route 5 to saffron city --
INSERT INTO ConnectedTo VALUES (5, 34); 
-- route 9 to route 10 --
INSERT INTO ConnectedTo VALUES (9, 10); 
 -- route 10 to power plant --
INSERT INTO ConnectedTo VALUES (10, 42);
 -- route 10 to rock tunnel --
INSERT INTO ConnectedTo VALUES (10, 43);
 -- rock tunnel to lavender town --
INSERT INTO ConnectedTo VALUES (43, 31);
-- saffron city to route 6 --
INSERT INTO ConnectedTo VALUES (34, 6); 
-- saffron city to route 7 --
INSERT INTO ConnectedTo VALUES (34, 7); 
-- saffron city to route 8 --
INSERT INTO ConnectedTo VALUES (34, 8); 
-- route 8 to lavender town --
INSERT INTO ConnectedTo VALUES (8, 31); 
-- lavender town to route 12 --
INSERT INTO ConnectedTo VALUES (31, 8); 
 -- route 11 to vermilion city --
INSERT INTO ConnectedTo VALUES (11, 30);
 -- route 11 to route 12 --
INSERT INTO ConnectedTo VALUES (11, 12);
-- route 6 to vermilion city --
INSERT INTO ConnectedTo VALUES (6, 30); 
-- route 7 to celadon city --
INSERT INTO ConnectedTo VALUES (7, 32); 
 -- route 12 to route 13 --
INSERT INTO ConnectedTo VALUES (12, 13);
 -- route 13 to route 14 --
INSERT INTO ConnectedTo VALUES (13, 14);
 -- route 14 to route 15 --
INSERT INTO ConnectedTo VALUES (14, 15);
 -- route 15 to fuschia city --
INSERT INTO ConnectedTo VALUES (15, 33);
 -- fuchsia city to route 18 --
INSERT INTO ConnectedTo VALUES (33, 18);
 -- fuchsia city to route 19 --
INSERT INTO ConnectedTo VALUES (33, 19);
 -- route 18 to route 17 --
INSERT INTO ConnectedTo VALUES (18, 17);
 -- route 17 to route 16 --
INSERT INTO ConnectedTo VALUES (17, 16);
 -- route 16 to celadon city --
INSERT INTO ConnectedTo VALUES (16, 32);
 -- route 19 to route 20 --
INSERT INTO ConnectedTo VALUES (19, 20);
 -- route 20 to cinnabar island --
INSERT INTO ConnectedTo VALUES (20, 35);
 -- cinnabar island to route 21 --
INSERT INTO ConnectedTo VALUES (35, 21);
 -- route 21 to pallet town --
INSERT INTO ConnectedTo VALUES (21, 26);
-- route 2 to viridian forest --
INSERT INTO ConnectedTo VALUES (2, 49); 
 -- route 20 to seafoam islands --
INSERT INTO ConnectedTo VALUES (20, 46);
 -- fuchsia city to safari zone --
INSERT INTO ConnectedTo VALUES (33, 45);
 -- celadon city to celadon game corner --
INSERT INTO ConnectedTo VALUES (32, 44);
 -- lavender town to pokemon tower --
INSERT INTO ConnectedTo VALUES (31, 41);
 -- cinnabar island to pokemon mansion --
INSERT INTO ConnectedTo VALUES (35, 40);
 -- cerulean city to cerulean cave (unknown dungeon) --
INSERT INTO ConnectedTo VALUES (29, 36);
COMMIT;