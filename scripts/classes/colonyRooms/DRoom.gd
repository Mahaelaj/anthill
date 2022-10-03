extends ResourceRoom

class_name DRoom

func init():
	resourceRoomInit(getHorizontalTileSize(), [32, 96], [55, 103], Constants.ResourceType.D)
	
static func getHorizontalTileSize():
	return 2
