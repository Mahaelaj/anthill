extends Node

var emptyLoiteringPositions = []

func getEmptyLoiteringPosition() -> AStarPosition:
	return emptyLoiteringPositions.pop_back()

func addEmptyLoiteringPositionAndShuffle(aStarPosition: AStarPosition): 
	emptyLoiteringPositions.append(aStarPosition)
	randomize()
	emptyLoiteringPositions.shuffle()
