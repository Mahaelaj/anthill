extends Node2D

var horizontalTileSize: int
var roomType
var loiterPositions = []
var aStarPositions = []

class_name ColonyRoom

func colonyRoominit(_horizontalTileSize: int, _roomType, _loiterPositions):
	horizontalTileSize = _horizontalTileSize
	roomType = _roomType
	loiterPositions = _loiterPositions
	
	for i in loiterPositions:
		var astarPos =addAstarPosition(AStarPosition.StandingType.LOITER, Vector2(i, 0))
		AntManager.emptyLoiteringPositions.append(astarPos)

func onRoomClicked(room: ColonyRoom):
	get_node(Constants.hudsManagerPath).openRoomAdmin(room)
	pass
	
func addAstarPosition(type, position):
	var astarPos = AStarPosition.new(type)
	astarPos.position = position
	aStarPositions.append(astarPos)
	aStarPositions.sort_custom(Sorters, "sortAStarPositionsAsc")
	add_child(astarPos)
	return astarPos
