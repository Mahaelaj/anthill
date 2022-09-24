extends Control

var OneCellBuildOption = preload("res://scenes/1CellBuildOption.tscn")
var twoCellBuildOption = preload("res://scenes/2CellBuildOption.tscn")

func _on_ElevatorRoomSelectButton_button_up():
	roomSelected(Constants.RoomType.ELEVATOR)

func _on_FoodRoomSelectButton_button_up():
	roomSelected(Constants.RoomType.FOOD)
	
func roomSelected(roomType): 
	$RoomSelectControl.visible = false
	var buildOptionPositions = Grid.getRoomBuildOptions(Constants.Rooms[roomType].col, roomType == Constants.RoomType.ELEVATOR)
	var buildOption
	match Constants.Rooms[roomType].col:
			1: buildOption = OneCellBuildOption
			2: buildOption = twoCellBuildOption
			
	for i in buildOptionPositions:
		var buildOptionInstance = buildOption.instance()
		buildOptionInstance.set_position(Grid.getGridCellPos(i))
		buildOptionInstance.gridRow = i.y
		buildOptionInstance.gridColumn = i.x
		buildOptionInstance.roomType = roomType
		$RoomSelectBuildControl.add_child(buildOptionInstance)
		var t = buildOptionInstance.connect("button_up", buildOptionInstance, "_on_button_up")
		
func _on_CloseButton_button_up():
	_reset()

func roomPositionSelected(row, col, roomType):
	var game = get_node("/root/Game")
	game.addRoom(roomType, row, col)
	_reset()

func _reset(): 
	for child in $RoomSelectBuildControl.get_children():
		child.queue_free()
	visible = false
	$RoomSelectControl.visible = true
	var HUDsManager = get_node("/root/Game/HUDsManager")
	HUDsManager.roomSelectHide()
