extends ResourceRoom

class_name FoodCRoom

func init():
	resourceRoomInit(getHorizontalTileSize(), [32, 96], [55, 103], Constants.ResourceType.FOOD_C, 180)
	
static func getHorizontalTileSize():
	return 2
