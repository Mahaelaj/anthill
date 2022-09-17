extends Node

var astar = AStar2D.new()
var nextId = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func connectRoom(gridRow: int, gridCol: int):
	print(gridRow, gridCol)
	var grid = get_node("/root/Game/Grid")
	var room = grid.getRoomAtGridPos(gridRow, gridCol) 
	for i in range(room.aStarPositions.size()):
		var id =  astar.get_available_point_id()
		astar.add_point(id, room.aStarPositions[i].global_position)
		room.aStarPositions[i].aStarId = id
		if i != 0:
			print("connecting loiter rooms ", room.aStarPositions[i - 1].aStarId, " ", id)
			astar.connect_points(room.aStarPositions[i - 1].aStarId, id)
		
	connectRoomToSides(gridRow, gridCol, room)

func connectRoomToSides(gridRow: int, gridCol: int, room: ColonyRoom):
	var grid = get_node("/root/Game/Grid")

	if room.roomType == Constants.RoomType.ELEVATOR:
		# top
		var topRoom = grid.getRoomAtGridPos(gridRow -1, gridCol)
		if (topRoom != null && topRoom.roomType == Constants.RoomType.ELEVATOR):
			astar.connect_points(room.aStarPositions[0].aStarId, topRoom.aStarPositions[0].aStarId)
		# bottom
		var bottomRow = grid.getRoomAtGridPos(gridRow + 1, gridCol)
		if (bottomRow != null && bottomRow.roomType == Constants.RoomType.ELEVATOR):
			print("connecting bottom")
			astar.connect_points(room.aStarPositions[0].aStarId, bottomRow.aStarPositions[0].aStarId)
	# left
	var leftRoom = grid.getRoomAtGridPos(gridRow, gridCol - 1)
	if (leftRoom != null):
		print ("connecting left")
		astar.connect_points(room.aStarPositions[0].aStarId, leftRoom.aStarPositions.back().aStarId)
	#right
	var rightRoom = grid.getRoomAtGridPos(gridRow, gridCol + room.horizontalTileSize)
	if (rightRoom != null):
		print("connecting right")
		astar.connect_points(room.aStarPositions.back().aStarId, rightRoom.aStarPositions[0].aStarId)
	for i in room.aStarPositions:
		print ("is point connected ", i.aStarId, " ", astar.get_id_path(i.aStarId, 0))

func getPointPath(position: Vector2, aStarPointIdTarget: int):
	var closestPoint = astar.get_closest_point(position)
	return astar.get_id_path(closestPoint, aStarPointIdTarget)

func getPointPosition(pointId: int):
	return astar.get_point_position(pointId)
