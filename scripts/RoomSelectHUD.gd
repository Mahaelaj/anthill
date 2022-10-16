extends Control

var OneCellBuildOption = preload("res://scenes/1CellBuildOption.tscn")
var twoCellBuildOption = preload("res://scenes/2CellBuildOption.tscn")

func roomSelected(roomType): 
	$ScrollContainer.visible = false
	var buildOptionPositions = Grid.getRoomBuildOptions(roomType.getHorizontalTileSize(), roomType == ElevatorRoom)
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
	$ScrollContainer.visible = true
	var HUDsManager = get_node(Constants.hudsManagerPath)
	HUDsManager.roomSelectHide()

func _on_ElevatorRoomSelectButton_button_up():
	roomSelected(ElevatorRoom)

func _on_FoodRoomSelectButton_button_up():
	roomSelected(FoodRoom)
	
func _on_EnergyRoomSelectButton_button_up():
	roomSelected(EnergyRoom)
	
func _on_ARoomSelectButton_button_up():
	roomSelected(ARoom)

func _on_BRoomSelectButton_button_up():
	roomSelected(BRoom)

func _on_CRoomSelectButton_button_up():
	roomSelected(CRoom)

func _on_DRoomSelectButton_button_up():
	roomSelected(DRoom)

func _on_ERoomSelectButton_button_up():
	roomSelected(ERoom)

func _on_FRoomSelectButton_button_up():
	roomSelected(FRoom)

func _on_StorageSelectButton_button_up():
	roomSelected(StorageRoom)
	pass # Replace with function body.

func _on_MarketSelectButton_button_up():
	roomSelected(MarketRoom)
