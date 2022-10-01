extends ColonyRoom

var workPositions = []
var workAstarPositions = []
var assignedAnts = []
var resourceType 
var numAntsWorking = 0

class_name ResourceRoom
	
func resourceRoomInit(_horizontalTileSize: int, _roomType, _loiterPositions, _workPositions, _resourceType):
	workPositions = _workPositions
	assignedAnts.resize(workPositions.size())
	resourceType = _resourceType
	add_to_group("ResourceRooms")
	for i in workPositions:
		var astarPos = addAstarPosition(AStarPosition.StandingType.WORK, Vector2(i, 0))
		workAstarPositions.append(astarPos)
		
	colonyRoominit(_horizontalTileSize, _roomType, _loiterPositions)

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
			
func _on_Button_button_up():
	onRoomClicked(self)

func _process(delta):
	print (resourceType, " ",  numAntsWorking)
	get_node(Constants.gamePath).updateResource(resourceType, delta * numAntsWorking)

