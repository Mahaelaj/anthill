extends ResourceRoom

class_name FoodBRoom

func init():
	resourceRoomInit(getHorizontalTileSize(), [32, 96], [55, 103], Constants.ResourceType.FOOD_B, 180)
	
static func getHorizontalTileSize():
	return 2
