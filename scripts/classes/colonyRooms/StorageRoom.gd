extends ColonyRoom

class_name StorageRoom

func init():
	var astarPos = addAstarPosition(AStarPosition.StandingType.ELEVATOR, Vector2(15, 0))
	colonyRoominit(getHorizontalTileSize(), [32, 96])

static func getHorizontalTileSize():
	return 2
