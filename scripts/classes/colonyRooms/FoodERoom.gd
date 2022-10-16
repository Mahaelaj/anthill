extends ResourceRoom

class_name FoodERoom

func init():
	resourceRoomInit(getHorizontalTileSize(), [32, 96], [55, 103], Constants.ResourceType.FOOD_E, 180)
	
static func getHorizontalTileSize():
	return 2
