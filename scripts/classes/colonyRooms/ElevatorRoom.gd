extends ColonyRoom

class_name ElevatorRoom

func init():
	var astarPos = addAstarPosition(AStarPosition.StandingType.ELEVATOR, Vector2(15, 0))
	colonyRoominit(getHorizontalTileSize(), [])

static func getHorizontalTileSize():
	return 1
