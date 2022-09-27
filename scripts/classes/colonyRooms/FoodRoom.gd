extends ColonyRoom

class_name FoodRoom

# Class Constructor
func _init().(2, Constants.RoomType.FOOD, [32, 96], [55, 103]):
	add_to_group("workingRooms")
	pass

func _on_Button_button_up():
	onRoomClicked(self)
	pass # Replace with function body.

func _process(delta):
	get_node(Constants.gamePath).updateResource(Constants.ResourceType.FOOD, delta * numAntsWorking)
