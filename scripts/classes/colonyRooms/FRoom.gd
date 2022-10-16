extends ResourceRoom

class_name FRoom

func init():
	resourceRoomInit(getHorizontalTileSize(), [32, 96], [55, 103], Constants.ResourceType.F, 180)
	
static func getHorizontalTileSize():
	return 2
