extends Node2D

var aStarId: int 
var standingType

enum StandingType {LOITER, ELEVATOR, WORK}

class_name AStarPosition

func _init(_standingType):
	standingType = _standingType
