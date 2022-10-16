extends ResourceRoom

class_name FoodFRoom

func init():
	resourceRoomInit(getHorizontalTileSize(), [32, 96], [55, 103], Constants.ResourceType.FOOD_F, 180)
	
static func getHorizontalTileSize():
	return 2
