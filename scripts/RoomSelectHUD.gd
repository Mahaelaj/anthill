extends Control

var OneCellBuildOption = preload("res://scenes/1CellBuildOption.tscn")
var twoCellBuildOption = preload("res://scenes/2CellBuildOption.tscn")
var threeCellBuildOption = preload("res://scenes/3CellBuildOption.tscn")

func roomSelected(roomType): 
	$ScrollContainer.visible = false
	var buildOptionPositions = Grid.getRoomBuildOptions(roomType.getHorizontalTileSize(), roomType == ElevatorRoom)
	var buildOption
	match roomType.getHorizontalTileSize():
			1: buildOption = OneCellBuildOption
			2: buildOption = twoCellBuildOption
			3: buildOption = threeCellBuildOption
			
	for i in buildOptionPositions:
		var buildOptionInstance = buildOption.instance()
		buildOptionInstance.set_position(Grid.getGridCellPos(i))
		buildOptionInstance.gridRow = i.y
		buildOptionInstance.gridColumn = i.x
		buildOptionInstance.roomType = roomType
		$RoomSelectBuildControl.add_child(buildOptionInstance)
		buildOptionInstance.connect("button_up", buildOptionInstance, "_on_button_up")
		
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

func _on_FoodARoomSelectButton_button_up():
	roomSelected(FoodARoom)

func _on_FoodBRoomSelectButton_button_up():
	roomSelected(FoodBRoom)

func _on_FoodCRoomSelectButton_button_up():
	roomSelected(FoodCRoom)

func _on_FoodDRoomSelectButton_button_up():
	roomSelected(FoodDRoom)
	
func _on_FoodERoomSelectButton_button_up():
	roomSelected(FoodERoom)

func _on_FoodFRoomSelectButton_button_up():
	roomSelected(FoodFRoom)
	
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

func _on_MarketSelectButton_button_up():
	roomSelected(MarketRoom)

func _on_HatchingRoomSelectButton_button_up():
	roomSelected(HatchingRoom)
