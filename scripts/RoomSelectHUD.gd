extends Control

var OneCellBuildOption = preload("res://scenes/1CellBuildOption.tscn")
var twoCellBuildOption = preload("res://scenes/2CellBuildOption.tscn")

func _on_ElevatorRoomSelectButton_button_up():
	roomSelected(ElevatorRoom, true)

func _on_FoodRoomSelectButton_button_up():
	roomSelected(FoodRoom, false)
	
func _on_EnergyRoomSelectButton_button_up():
	roomSelected(EnergyRoom, false)
	
func roomSelected(roomType, isElevator): 
	$RoomSelectControl.visible = false
	var buildOptionPositions = Grid.getRoomBuildOptions(roomType.getHorizontalTileSize(), isElevator)
	var buildOption
	match roomType.getHorizontalTileSize():
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
	var game = get_node(Constants.gamePath)
	game.addRoom(roomType, row, col)
	_reset()

func _reset(): 
	for child in $RoomSelectBuildControl.get_children():
		child.queue_free()
	visible = false
	$RoomSelectControl.visible = true
	var HUDsManager = get_node(Constants.hudsManagerPath)
	HUDsManager.roomSelectHide()
