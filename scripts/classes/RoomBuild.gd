extends Node

var gridRow
var gridColumn
var horizontalTileSize
var roomType

func _on_button_up():
	get_node("/root/Game/HUDsManager/RoomBuildControl").roomPositionSelected(gridRow, gridColumn, roomType) 
	
