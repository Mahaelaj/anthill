extends Node2D

var aStarPointPath = []
var loiterPosition: AStarPosition
var nextPosition: Vector2Obj
var speed = 25
var dexterity = 0
var intelligence = 0
var strength = 0

export(String) var antName

class_name Ant

enum activityEnum {LOITERING, WORKING}
var activity = activityEnum.LOITERING

func init(_antName):
	antName = _antName
	
# Called when the node enters the scene tree for the first time.
func _ready():
	getNewLoiterPath()

func getNewLoiterPath():
	if activity != activityEnum.LOITERING:
		return
	var newLoiterAstarPosition: AStarPosition = AntManager.getEmptyLoiteringPosition()
	if newLoiterAstarPosition == null:
		$LoiterTimer.start()
	else:
		loiterPosition = newLoiterAstarPosition
		updateAStarPointPath(loiterPosition)

func _on_LoiterTimer_timeout():
	getNewLoiterPath()

func setAntWorking(aStarPos: AStarPosition):
	resetPath()
	activity = activityEnum.WORKING
	updateAStarPointPath(aStarPos)

func setAntLoitering():
	resetPath()
	activity = activityEnum.LOITERING
	getNewLoiterPath()
	
func updateAStarPointPath(aStarPos: AStarPosition):
	aStarPointPath = PathFinding.getPointPath(global_position, aStarPos.aStarId)

func resetPath():
	if (loiterPosition != null): 
		AntManager.addEmptyLoiteringPositionAndShuffle(loiterPosition)
	loiterPosition = null
	nextPosition = null
	aStarPointPath = []
		
func getNextPos(point: int):
	return Vector2Obj.new(PathFinding.getPointPosition(point))
	
func _process(delta):
	if nextPosition == null: 
		if aStarPointPath.size() > 0:
			nextPosition = getNextPos(aStarPointPath[0])
		else:
			return
			
	var velocity = (global_position.direction_to(nextPosition.vector)) * speed * delta
	global_position += velocity
	if (global_position.distance_to(nextPosition.vector) < 1):
		aStarPointPath.remove(0)
		nextPosition = null
		if aStarPointPath.size() == 0: 
			resetPath()
			if activity == activityEnum.LOITERING:
				$LoiterTimer.start()
