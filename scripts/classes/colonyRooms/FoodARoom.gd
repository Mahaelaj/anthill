extends ResourceRoom

class_name FoodARoom

func init():
	resourceRoomInit(getHorizontalTileSize(), [32, 96], [55, 103], Constants.ResourceType.FOOD_A, 180)
	
static func getHorizontalTileSize():
	return 2
