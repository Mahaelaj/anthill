extends Node2D

var aStarPointPath = []
var loiterPosition: AStarPosition
var nextPosition: Vector2Obj
var speed = 25
# Called when the node enters the scene tree for the first time.
func _ready():
	getNewPath()

func getNewPath():
	var newLoiterAstarPosition: AStarPosition = AntManager.getEmptyLoiteringPosition()
	if newLoiterAstarPosition == null:
		$LoiterTimer.start()
	else:
		loiterPosition = newLoiterAstarPosition
		var pathFinding = get_node("/root/Game/PathFinding")
		aStarPointPath = pathFinding.getPointPath(global_position, loiterPosition.aStarId)

func _on_LoiterTimer_timeout():
	getNewPath()

func resetPath():
	if (loiterPosition != null): 
		AntManager.addEmptyLoiteringPositionAndShuffle(loiterPosition)
		loiterPosition = null
		nextPosition = null
		aStarPointPath = []
	
func _process(delta):
	if nextPosition == null: 
		if aStarPointPath.size() > 0:
			var pathFinding = get_node("/root/Game/PathFinding")
			nextPosition = Vector2Obj.new(pathFinding.getPointPosition(aStarPointPath[0]))
			var helper = get_node("/root/Game/Helper")
		else:
			return
			
	var velocity = (global_position.direction_to(nextPosition.vector)) * speed * delta
	global_position += velocity
	if (global_position.distance_to(nextPosition.vector) < 1):
		aStarPointPath.remove(0)
		nextPosition = null
		if aStarPointPath.size() == 0: 
			resetPath()
			$LoiterTimer.start()
