-- All moves 
SELECT 
	M.Name AS MoveName,
	T.Name AS TypeName,
	M.Category,
	M.MovePower,
	M.Accuracy,
	M.BasePP,
	M.Effect
FROM Moves M
JOIN Types T
	ON M.TypeId = T.TypeId
	
