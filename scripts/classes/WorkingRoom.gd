extends ColonyRoom

var workPositions = []
var workAstarPositions = []
var assignedAnts = []
var numAntsWorking = 0
var timer: Timer
var maxTimerTime

var MAX_REDUCED_TIME_PERC = 50

class_name WorkingRoom

#// TODO: timer should not start if there are no ants in the room
	
func workingRoomInit(_horizontalTileSize: int, _loiterPositions, _workPositions, _timer: Timer, _maxTimerTime: int):
	workPositions = _workPositions
	assignedAnts.resize(workPositions.size())
	timer = _timer
	maxTimerTime = _maxTimerTime
	
	add_to_group(Constants.workingRoomsGroup)
	for i in workPositions:
		var astarPos = addAstarPosition(AStarPosition.StandingType.WORK, Vector2(i, 0))
		workAstarPositions.append(astarPos)
		
	colonyRoominit(_horizontalTileSize, _loiterPositions)

func _ready():
	startTimer()

func assignAnt(ant: Ant, index: int):
	var didRemoveAnt = false
	if assignedAnts[index] != null:
		assignedAnts[index].setAntLoitering()
		assignedAnts[index] = null
		numAntsWorking-=1
		didRemoveAnt = true
		
	assignedAnts[index] = ant
	numAntsWorking +=1
	
	if (!didRemoveAnt):
		var timeMultiplier = 1 - (float(MAX_REDUCED_TIME_PERC/ workPositions.size()) / 100)
		timer.set_wait_time(timer.get_time_left() * timeMultiplier)
		timer.start()
		
	return workAstarPositions[index]
	
func maybeRemoveAnt(ant: Ant):
	for i in range(assignedAnts.size()):
		if (assignedAnts[i] == ant): 
			assignedAnts[i] = null
			numAntsWorking -= 1
			var timeMultiplier = float(maxTimerTime / float(maxTimerTime - ((maxTimerTime * MAX_REDUCED_TIME_PERC / workPositions.size()) / 100)))
			timer.set_wait_time(timer.get_time_left() * timeMultiplier)
			
func _on_Button_button_up():
	onRoomClicked(self)
	
func startTimer():
	var waitTime = maxTimerTime - ((float(MAX_REDUCED_TIME_PERC * numAntsWorking / workPositions.size()) / 100) * maxTimerTime)
	timer.set_wait_time(waitTime)
	timer.start()
