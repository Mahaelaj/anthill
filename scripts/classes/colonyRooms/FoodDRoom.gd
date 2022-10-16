extends ResourceRoom

class_name FoodDRoom

func init():
	resourceRoomInit(getHorizontalTileSize(), [32, 96], [55, 103], Constants.ResourceType.FOOD_D, 180)
	
static func getHorizontalTileSize():
	return 2
