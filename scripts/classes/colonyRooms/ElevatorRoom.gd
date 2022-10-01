extends ColonyRoom

class_name ElevatorRoom

# Class Constructor
func init():
	var astarPos = addAstarPosition(AStarPosition.StandingType.ELEVATOR, Vector2(15, 0))
	colonyRoominit(1, Constants.RoomType.ELEVATOR, [])
