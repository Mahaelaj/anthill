extends Node2D

var ElevatorR = preload("res://scenes/rooms/ElevatorRoom.tscn")
var FoodR = preload("res://scenes/rooms/FoodRoom.tscn")
var EnergyR = preload("res://scenes/rooms/EnergyRoom.tscn")
var AR = preload("res://scenes/rooms/ARoom.tscn")
var BR = preload("res://scenes/rooms/BRoom.tscn")
var CR = preload("res://scenes/rooms/CRoom.tscn")
var DR = preload("res://scenes/rooms/DRoom.tscn")
var ER = preload("res://scenes/rooms/ERoom.tscn")
var FR = preload("res://scenes/rooms/FRoom.tscn")

var food: float = 0
var maxFood = 0

var energy: float = 0
var maxEnergy = 0

var a: float = 0
var maxA: = 0

var b: float = 0
var maxB: = 0

var c: float = 0
var maxC: = 0

var d: float = 0
var maxD: = 0

var e: float = 0
var maxE: = 0

var f: float = 0
var maxF: = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	addRoom(ElevatorRoom, 2, 5)
	
func addRoom(roomType, row, col):
	var room
	match roomType:
		ElevatorRoom:
			room = ElevatorR.instance()
		FoodRoom:
			room = FoodR.instance()
			maxFood += 300
		EnergyRoom:
			room = EnergyR.instance()
			maxEnergy += 300
		ARoom:
			room = AR.instance()
			maxA += 300
		BRoom:
			room = BR.instance()
			maxB += 300
		CRoom:
			room = CR.instance()
			maxC += 300
		DRoom:
			room = DR.instance()
			maxD += 300
		ERoom:
			room = ER.instance()
			maxE += 300
		FRoom:
			room = FR.instance()
			maxF += 300
			
	room.init()
	Grid.setCell(room, row, col)
	$Rooms.add_child(room)
	PathFinding.connectRoom(row, col)

func assignAntToRoom(ant: Ant, room: ColonyRoom, index: int):
	if ant.activity == ant.activityEnum.WORKING:
		var roomNodes = $Rooms.get_tree().get_nodes_in_group("ResourceRooms")
		for room in roomNodes:
			room.maybeRemoveAnt(ant)
	var aStarPos = room.assignAnt(ant, index)
	ant.setAntWorking(aStarPos)

func updateResource(resourceType, count: float):
	match resourceType:
		Constants.ResourceType.FOOD:
			food = clamp(food + count, 0, maxFood)
			var foodPercentage = 0
			if maxFood != 0:
				foodPercentage = food/ maxFood * 100
			$HUDsManager/MainHUD/FoodBar.updateValue(foodPercentage)
		Constants.ResourceType.ENERGY:
			energy = clamp(energy + count, 0, maxEnergy)
			var energyPercentage = 0
			if maxEnergy != 0:
				energyPercentage = energy/ maxEnergy * 100
			$HUDsManager/MainHUD/EnergyBar.updateValue(energyPercentage)
