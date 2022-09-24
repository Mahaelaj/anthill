extends Node

var astar = AStar2D.new()

func connectRoom(gridRow: int, gridCol: int):
	var room = Grid.getRoomAtGridPos(gridRow, gridCol) 
	for i in range(room.aStarPositions.size()):
		var id =  astar.get_available_point_id()
		astar.add_point(id, room.aStarPositions[i].global_position)
		room.aStarPositions[i].aStarId = id
		if i != 0:
			astar.connect_points(room.aStarPositions[i - 1].aStarId, id)
		
	connectRoomToSides(gridRow, gridCol, room)

func connectRoomToSides(gridRow: int, gridCol: int, room: ColonyRoom):
	if room.roomType == Constants.RoomType.ELEVATOR:
		# top
		var topRoom = Grid.getRoomAtGridPos(gridRow -1, gridCol)
		if (topRoom != null && topRoom.roomType == Constants.RoomType.ELEVATOR):
			astar.connect_points(room.aStarPositions[0].aStarId, topRoom.aStarPositions[0].aStarId)
		# bottom
		var bottomRow = Grid.getRoomAtGridPos(gridRow + 1, gridCol)
		if (bottomRow != null && bottomRow.roomType == Constants.RoomType.ELEVATOR):
			astar.connect_points(room.aStarPositions[0].aStarId, bottomRow.aStarPositions[0].aStarId)
	# left
	var leftRoom = Grid.getRoomAtGridPos(gridRow, gridCol - 1)
	if (leftRoom != null):
		astar.connect_points(room.aStarPositions[0].aStarId, leftRoom.aStarPositions.back().aStarId)
	#right
	var rightRoom = Grid.getRoomAtGridPos(gridRow, gridCol + room.horizontalTileSize)
	if (rightRoom != null):
		astar.connect_points(room.aStarPositions.back().aStarId, rightRoom.aStarPositions[0].aStarId)

func getPointPath(position: Vector2, aStarPointIdTarget: int):
	var closestPoint = astar.get_closest_point(position)
	return astar.get_id_path(closestPoint, aStarPointIdTarget)

func getPointPosition(pointId: int):
	return astar.get_point_position(pointId)
