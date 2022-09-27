extends Node2D

var horizontalTileSize: int
var roomType
var loiterPositions = []
var workPositions = []
var aStarPositions = []
var workAstarPositions = []
var assignedAnts = []
var resourceType 
var numAntsWorking = 0

class_name ColonyRoom

func _init(_horizontalTileSize: int, _roomType, _loiterPositions, _workPositions):
	horizontalTileSize = _horizontalTileSize
	roomType = _roomType
	loiterPositions = _loiterPositions
	workPositions = _workPositions
	assignedAnts.resize(workPositions.size())

func init():
	if roomType == Constants.RoomType.ELEVATOR:
		var astarPos = AStarPosition.new(AStarPosition.StandingType.ELEVATOR)
		astarPos.global_position = Vector2(global_position.x + 15, global_position.y)
		aStarPositions.append(astarPos)
	
	for i in loiterPositions:
		var astarPos = AStarPosition.new(AStarPosition.StandingType.LOITER)
		astarPos.global_position = Vector2(global_position.x + i, global_position.y)
		aStarPositions.append(astarPos)
		AntManager.emptyLoiteringPositions.append(astarPos)

	for i in workPositions:
		var astarPos = AStarPosition.new(AStarPosition.StandingType.WORK)
		astarPos.global_position = Vector2(global_position.x + i, global_position.y)
		aStarPositions.append(astarPos)
		workAstarPositions.append(astarPos)
		
	aStarPositions.sort_custom(Sorters, "sortAStarPositionsAsc")

func onRoomClicked(room: ColonyRoom):
	get_node(Constants.hudsManagerPath).openRoomAdmin(room)
	pass
	
func assignAnt(ant: Ant, index: int):
	if assignedAnts[index] != null:
		assignedAnts[index].setAntLoitering()
		assignedAnts[index] = null
		numAntsWorking-=1
	
	assignedAnts[index] = ant
	numAntsWorking +=1
	return workAstarPositions[index]
	
func maybeRemoveAnt(ant: Ant):
	for i in range(assignedAnts.size()):
		if (assignedAnts[i] == ant): 
			assignedAnts[i] = null
			numAntsWorking -= 1
