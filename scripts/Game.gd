extends Node2D

var ElevatorR = preload("res://scenes/rooms/ElevatorRoom.tscn")
var FoodAR = preload("res://scenes/rooms/FoodARoom.tscn")
var FoodBR = preload("res://scenes/rooms/FoodBRoom.tscn")
var FoodCR = preload("res://scenes/rooms/FoodCRoom.tscn")
var FoodDR = preload("res://scenes/rooms/FoodDRoom.tscn")
var FoodER = preload("res://scenes/rooms/FoodERoom.tscn")
var FoodFR = preload("res://scenes/rooms/FoodFRoom.tscn")
var EnergyR = preload("res://scenes/rooms/EnergyRoom.tscn")
var AR = preload("res://scenes/rooms/ARoom.tscn")
var BR = preload("res://scenes/rooms/BRoom.tscn")
var CR = preload("res://scenes/rooms/CRoom.tscn")
var DR = preload("res://scenes/rooms/DRoom.tscn")
var ER = preload("res://scenes/rooms/ERoom.tscn")
var FR = preload("res://scenes/rooms/FRoom.tscn")
var StorageR = preload("res://scenes/rooms/StorageRoom.tscn")
var MarketR = preload("res://scenes/rooms/MarketRoom.tscn")
var HatchingR = preload("res://scenes/rooms/HatchingRoom.tscn")

var funds = 0

var foodA: int = 0
var maxFoodA = 0

var foodB: int = 0
var maxFoodB = 0

var foodC: int = 0
var maxFoodC = 0

var foodD: int = 0
var maxFoodD = 0

var foodE: int = 0
var maxFoodE = 0

var foodF: int = 0
var maxFoodF = 0

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
		FoodARoom:
			room = FoodAR.instance()
			maxFoodA += 300
			updateFood()
		FoodBRoom:
			room = FoodBR.instance()
			maxFoodB += 300
			updateFood()
		FoodCRoom:
			room = FoodCR.instance()
			maxFoodC += 300
			updateFood()
		FoodDRoom:
			room = FoodDR.instance()
			maxFoodD += 300
			updateFood()
		FoodERoom:
			room = FoodER.instance()
			maxFoodE += 300
			updateFood()
		FoodFRoom:
			room = FoodFR.instance()
			maxFoodF += 300
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
			maxFoodA += 300
			maxFoodB += 300
			maxFoodC += 300
			maxFoodD += 300
			maxFoodE += 300
			maxFoodF += 300
			maxEnergy += 300
			maxA += 300
			maxB += 300
			maxC += 300
			maxD += 300
			maxE += 300
			maxF += 300
		MarketRoom:
			room = MarketR.instance()
		HatchingRoom:
			room = HatchingR.instance()
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
		Constants.ResourceType.FOOD_A:
			var remainder = foodA + count - maxFoodA
			foodA = clamp(foodA + count, 0, maxFoodA)
			updateFood()
			var foodAPercentage = 0
			if maxFoodA != 0:
				foodAPercentage = float(foodA)/ maxFoodA * 100
			$HUDsManager/ResourceOverview/FoodABar.value = foodAPercentage
			if remainder > 0:
				addResourcesToMarket(Constants.ResourceType.FOOD_A, remainder)
		Constants.ResourceType.FOOD_B:
			var remainder = foodB + count - maxFoodB
			foodB = clamp(foodB + count, 0, maxFoodB)
			updateFood()
			var foodBPercentage = 0
			if maxFoodB != 0:
				foodBPercentage = float(foodB)/ maxFoodB * 100
			$HUDsManager/ResourceOverview/FoodBBar.value = foodBPercentage
			if remainder > 0:
				addResourcesToMarket(Constants.ResourceType.FOOD_B, remainder)
		Constants.ResourceType.FOOD_C:
			var remainder = foodC + count - maxFoodC
			foodC = clamp(foodC + count, 0, maxFoodC)
			updateFood()
			var foodCPercentage = 0
			if maxFoodC != 0:
				foodCPercentage = float(foodC)/ maxFoodC * 100
			$HUDsManager/ResourceOverview/FoodCBar.value = foodCPercentage
			if remainder > 0:
				addResourcesToMarket(Constants.ResourceType.FOOD_C, remainder)
		Constants.ResourceType.FOOD_D:
			var remainder = foodD + count - maxFoodD
			foodD = clamp(foodD + count, 0, maxFoodD)
			updateFood()
			var foodDPercentage = 0
			if maxFoodD != 0:
				foodDPercentage = float(foodD)/ maxFoodD * 100
			$HUDsManager/ResourceOverview/FoodDBar.value = foodDPercentage
			if remainder > 0:
				addResourcesToMarket(Constants.ResourceType.FOOD_D, remainder)
		Constants.ResourceType.FOOD_E:
			var remainder = foodE + count - maxFoodE
			foodE = clamp(foodE + count, 0, maxFoodE)
			updateFood()
			var foodEPercentage = 0
			if maxFoodE != 0:
				foodEPercentage = float(foodE)/ maxFoodE * 100
			$HUDsManager/ResourceOverview/FoodEBar.value = foodEPercentage
			if remainder > 0:
				addResourcesToMarket(Constants.ResourceType.FOOD_E, remainder)
		Constants.ResourceType.FOOD_F:
			var remainder = foodF + count - maxFoodF
			foodF = clamp(foodF + count, 0, maxFoodF)
			updateFood()
			var foodFPercentage = 0
			if maxFoodF != 0:
				foodFPercentage = float(foodF)/ maxFoodF * 100
			$HUDsManager/ResourceOverview/FoodFBar.value = foodFPercentage
			if remainder > 0:
				addResourcesToMarket(Constants.ResourceType.FOOD_F, remainder)
		Constants.ResourceType.ENERGY:
			var remainder = energy + count - maxEnergy
			energy = clamp(energy + count, 0, maxEnergy)
			var energyPercentage = 0
			if maxEnergy != 0:
				energyPercentage = float(energy)/ maxEnergy * 100
			$HUDsManager/FoodEnergyBars/EnergyBar.value = energyPercentage
			if remainder > 0:
				addResourcesToMarket(Constants.ResourceType.ENERGY, remainder)
		Constants.ResourceType.A:
			var remainder = a + count - maxA
			a = clamp(a + count, 0, maxA)
			var aPercentage = 0
			if maxA != 0:
				aPercentage = float(a)/ maxA * 100
			$HUDsManager/ResourceOverview/ABar.value = aPercentage
			if remainder > 0:
				addResourcesToMarket(Constants.ResourceType.A, remainder)
		Constants.ResourceType.B:
			var remainder = b + count - maxB
			b = clamp(b + count, 0, maxB)
			var bPercentage = 0
			if maxB != 0:
				bPercentage = float(b)/ maxB * 100
			$HUDsManager/ResourceOverview/BBar.value = bPercentage
			if remainder > 0:
				addResourcesToMarket(Constants.ResourceType.B, remainder)
		Constants.ResourceType.C:
			var remainder = c + count - maxC
			c = clamp(c + count, 0, maxC)
			var cPercentage = 0
			if maxC != 0:
				cPercentage = float(c)/ maxC * 100
			$HUDsManager/ResourceOverview/CBar.value = cPercentage
			if remainder > 0:
				addResourcesToMarket(Constants.ResourceType.C, remainder)
		Constants.ResourceType.D:
			var remainder = d + count - maxD
			d = clamp(d + count, 0, maxD)
			var dPercentage = 0
			if maxD != 0:
				dPercentage = float(d)/ maxD * 100
			$HUDsManager/ResourceOverview/DBar.value = dPercentage
			if remainder > 0:
				addResourcesToMarket(Constants.ResourceType.D, remainder)
		Constants.ResourceType.E:
			var remainder = e + count - maxE
			e = clamp(e + count, 0, maxE)
			var ePercentage = 0
			if maxE != 0:
				ePercentage = float(e)/ maxE * 100
			$HUDsManager/ResourceOverview/EBar.value = ePercentage
			if remainder > 0:
				addResourcesToMarket(Constants.ResourceType.E, remainder)
		Constants.ResourceType.F:
			var remainder = f + count - maxF
			f = clamp(f + count, 0, maxF)
			var fPercentage = 0
			if maxF != 0:
				fPercentage = float(f)/ maxF * 100
			$HUDsManager/ResourceOverview/FBar.value = fPercentage
			if remainder > 0:
				addResourcesToMarket(Constants.ResourceType.F, remainder)
func updateFood(): 
	var food = foodA
	var maxFood = maxFoodA
	var foodPercentage = 0
	if maxFoodA != 0:
		foodPercentage = float(food)/ maxFood * 100
	$HUDsManager/FoodEnergyBars/FoodBar.value = foodPercentage
				
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
	
func getResourceAmt(resourceType):
	match resourceType:
		Constants.ResourceType.FOOD_A:
			return foodA
		Constants.ResourceType.FOOD_B:
			return foodB
		Constants.ResourceType.FOOD_C:
			return foodC
		Constants.ResourceType.FOOD_D:
			return foodD
		Constants.ResourceType.FOOD_E:
			return foodE
		Constants.ResourceType.FOOD_F:
			return foodF
		Constants.ResourceType.A:
			return a
		Constants.ResourceType.B:
			return b
		Constants.ResourceType.C:
			return c
		Constants.ResourceType.D:
			return d
		Constants.ResourceType.E:
			return e
		Constants.ResourceType.F:
			return f

func createAnts(count, positions):
	for i in range(0, count):
		var ant = AntManager.createAnt(positions[i])
		$Ants.add_child(ant)
