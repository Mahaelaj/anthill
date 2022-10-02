extends ResourceRoom

class_name FoodRoom

func init():
	resourceRoomInit(getHorizontalTileSize(), [32, 96], [55, 103], Constants.ResourceType.FOOD)
	
static func getHorizontalTileSize():
	return 2
