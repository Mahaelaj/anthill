extends Node
var emptyLoiteringPositions = []
var ants = []

var antScene = preload("res://scenes/Ant.tscn")

func getEmptyLoiteringPosition() -> AStarPosition:
	return emptyLoiteringPositions.pop_back()

func addEmptyLoiteringPositionAndShuffle(aStarPosition: AStarPosition): 
	emptyLoiteringPositions.append(aStarPosition)
	randomize()
	emptyLoiteringPositions.shuffle()
	
#remove this method after instantiated ants can be added to the ants array
func _ready():
	var antsNode = get_node("/root/Game/Ants")
	ants = antsNode.get_children()

func createAnt(position):
	var ant = antScene.instance()
	ant.init(Names.getName())
	ant.global_position = position
	ants.append(ant)
	return ant
