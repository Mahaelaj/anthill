extends Node2D

var horizontalTileSize: int
var roomType
var aStarPositions = []
var loiterAstarPositions = []
var workAstarPositions = []

class_name ColonyRoom

func _init(_horizontalTileSize: int, _roomType, _loiterPositions, _workPositions):
	horizontalTileSize = _horizontalTileSize
	roomType = _roomType
	loiterAstarPositions = _loiterPositions
	print ("horizontalTileSize ", horizontalTileSize)
	print ("roomType ", roomType)

func init():
	if roomType == Constants.RoomType.ELEVATOR:
		var astarPos = AStarPosition.new(AStarPosition.StandingType.ELEVATOR)
		astarPos.global_position = Vector2(global_position.x + 15, global_position.y)
		aStarPositions.append(astarPos)
	
	for i in loiterAstarPositions:
		var astarPos = AStarPosition.new(AStarPosition.StandingType.LOITER)
		astarPos.global_position = Vector2(global_position.x + i, global_position.y)
		aStarPositions.append(astarPos)
		AntManager.emptyLoiteringPositions.append(astarPos)
		
	var roomsNode = get_node("/root/Game/Rooms")
	roomsNode.add_child(self)
