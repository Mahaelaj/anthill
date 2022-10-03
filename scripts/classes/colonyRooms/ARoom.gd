extends ResourceRoom

class_name ARoom

func init():
	resourceRoomInit(getHorizontalTileSize(), [32, 96], [55, 103], Constants.ResourceType.A)
	
static func getHorizontalTileSize():
	return 2
