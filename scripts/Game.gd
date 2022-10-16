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
var StorageR = preload("res://scenes/rooms/StorageRoom.tscn")
var MarketR = preload("res://scenes/rooms/MarketRoom.tscn")

var funds = 0

var food: int = 0
var maxFood = 0

var energy: int = 0
var maxEnergy = 0

var a: int = 0
var maxA: = 0

var b: int = 0
var maxB: = 0

var c: int = 0
var maxC: = 0

var d: int = 0
var maxD: = 0

var e: int = 0
var maxE: = 0

var f: int = 0
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
		StorageRoom:
			room = StorageR.instance()
			maxFood += 300
			maxEnergy += 300
			maxA += 300
			maxB += 300
			maxC += 300
			maxD += 300
			maxE += 300
			maxF += 300
		MarketRoom:
			room = MarketR.instance()

	room.init()
	Grid.setCell(room, row, col)
	$Rooms.add_child(room)
	PathFinding.connectRoom(row, col)

func assignAntToRoom(ant: Ant, room: ColonyRoom, index: int):
	if ant.activity == ant.activityEnum.WORKING:
		var roomNodes = $Rooms.get_tree().get_nodes_in_group(Constants.workingRoomsGroup)
		for room in roomNodes:
			room.maybeRemoveAnt(ant)
	var aStarPos = room.assignAnt(ant, index)
	ant.setAntWorking(aStarPos)

func updateResource(resourceType, count):
	match resourceType:
		Constants.ResourceType.FOOD:
			var remainder = food + count - maxFood
			food = clamp(food + count, 0, maxFood)
			var foodPercentage = 0
			if maxFood != 0:
				foodPercentage = food/ maxFood * 100
			$HUDsManager/FoodEnergyBars/FoodBar.value = foodPercentage
			if remainder > 0:
				addResourcesToMarket(Constants.ResourceType.FOOD, remainder)
		Constants.ResourceType.ENERGY:
			var remainder = energy + count - maxEnergy
			energy = clamp(energy + count, 0, maxEnergy)
			var energyPercentage = 0
			if maxEnergy != 0:
				energyPercentage = energy/ maxEnergy * 100
			$HUDsManager/FoodEnergyBars/EnergyBar.value = energyPercentage
			if remainder > 0:
				addResourcesToMarket(Constants.ResourceType.ENERGY, remainder)
		Constants.ResourceType.A:
			var remainder = a + count - maxA
			a = clamp(a + count, 0, maxA)
			var aPercentage = 0
			if maxA != 0:
				aPercentage = a/ maxA * 100
			$HUDsManager/ResourceOverview/ABar.value = aPercentage
			if remainder > 0:
				addResourcesToMarket(Constants.ResourceType.A, remainder)
		Constants.ResourceType.B:
			var remainder = b + count - maxB
			b = clamp(b + count, 0, maxB)
			var bPercentage = 0
			if maxB != 0:
				bPercentage = b/ maxB * 100
			$HUDsManager/ResourceOverview/BBar.value = bPercentage
			if remainder > 0:
				addResourcesToMarket(Constants.ResourceType.B, remainder)
		Constants.ResourceType.C:
			var remainder = c + count - maxC
			c = clamp(c + count, 0, maxC)
			var cPercentage = 0
			if maxC != 0:
				cPercentage = c/ maxC * 100
			$HUDsManager/ResourceOverview/CBar.value = cPercentage
			if remainder > 0:
				addResourcesToMarket(Constants.ResourceType.C, remainder)
		Constants.ResourceType.D:
			var remainder = d + count - maxD
			d = clamp(d + count, 0, maxD)
			var dPercentage = 0
			if maxD != 0:
				dPercentage = d/ maxD * 100
			$HUDsManager/ResourceOverview/DBar.value = dPercentage
			if remainder > 0:
				addResourcesToMarket(Constants.ResourceType.D, remainder)
		Constants.ResourceType.E:
			var remainder = e + count - maxE
			e = clamp(e + count, 0, maxE)
			var ePercentage = 0
			if maxE != 0:
				ePercentage = e/ maxE * 100
			$HUDsManager/ResourceOverview/EBar.value = ePercentage
			if remainder > 0:
				print("adding e")
				addResourcesToMarket(Constants.ResourceType.E, remainder)
		Constants.ResourceType.F:
			var remainder = f + count - maxF
			f = clamp(f + count, 0, maxF)
			var fPercentage = 0
			if maxF != 0:
				fPercentage = f/ maxF * 100
			$HUDsManager/ResourceOverview/FBar.value = fPercentage
			if remainder > 0:
				addResourcesToMarket(Constants.ResourceType.F, remainder)
				
# TODO: workers should reduce work time
func addResourcesToMarket(resourceType, count):
	var marketRooms = $Rooms.get_tree().get_nodes_in_group(Constants.marketRoomsGroup)
	if marketRooms.size() == 0:
		return
	var remainder = count % marketRooms.size()
	for i in marketRooms:
		i.updateResource(resourceType, count)
		if (!i.isStorageFullForResource(resourceType) && remainder > 0): 
			i.updateResource(resourceType, 1)
			remainder -= 1

func updateFunds(count):
	funds += count
	$HUDsManager/FoodEnergyBars/Funds.text = "$ " + str(funds)
	
