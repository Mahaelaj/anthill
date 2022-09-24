extends Node2D

var ElevatorRoom = preload("res://scenes/rooms/ElevatorRoom.tscn")
var FoodRoom = preload("res://scenes/rooms/FoodRoom.tscn")

var food: float = 0
var maxFood = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var room = ElevatorRoom.instance()
	Grid.setCell(room, 2, 5)
	room.init()
	PathFinding.connectRoom(2,5)
	
func addRoom(roomType, row, col):
	var room
	match roomType:
		Constants.RoomType.ELEVATOR:
			room = ElevatorRoom.instance()
		Constants.RoomType.FOOD:
			room = FoodRoom.instance()
			maxFood += 300
	Grid.setCell(room, row, col)
	room.init()
	PathFinding.connectRoom(row, col)

func assignAntToRoom(ant: Ant, room: ColonyRoom, index: int):
	var aStarPos = room.assignAnt(ant, index)
	print("moving ant to ", aStarPos.global_position)
	ant.setAntWorking(aStarPos)

func updateResource(resourceType, count: float):
	if resourceType == Constants.ResourceType.FOOD:
		food = clamp(food + count, 0, maxFood)
#		print(food, " / ", maxFood, " = ", (maxFood / food))
		var foodPercentage = 0
		if maxFood != 0:
			foodPercentage = food/ maxFood * 100
			
		$HUDsManager/MainHUD/FoodBar.updateValue(foodPercentage)
