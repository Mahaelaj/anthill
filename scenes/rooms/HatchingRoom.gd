extends ColonyRoom

class_name HatchingRoom

func init():
	colonyRoominit(getHorizontalTileSize(),  [32, 96])

static func getHorizontalTileSize():
	return 2
