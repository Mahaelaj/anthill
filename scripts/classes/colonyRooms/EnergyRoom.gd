extends ResourceRoom

class_name EnergyRoom

func init():
	resourceRoomInit(getHorizontalTileSize(), [32, 96], [55, 103], Constants.ResourceType.ENERGY)

static func getHorizontalTileSize():
	return 2
