extends ResourceRoom

class_name CRoom

func init():
	resourceRoomInit(getHorizontalTileSize(), [32, 96], [55, 103], Constants.ResourceType.C)
	
static func getHorizontalTileSize():
	return 2