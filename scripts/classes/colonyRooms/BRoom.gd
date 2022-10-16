extends ResourceRoom

class_name BRoom

func init():
	resourceRoomInit(getHorizontalTileSize(), [32, 96], [55, 103], Constants.ResourceType.B, 180)
	
static func getHorizontalTileSize():
	return 2
