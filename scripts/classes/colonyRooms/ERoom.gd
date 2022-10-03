extends ResourceRoom

class_name ERoom

func init():
	resourceRoomInit(getHorizontalTileSize(), [32, 96], [55, 103], Constants.ResourceType.E)
	
static func getHorizontalTileSize():
	return 2
