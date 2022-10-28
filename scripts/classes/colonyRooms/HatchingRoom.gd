extends ColonyRoom

class_name HatchingRoom

var prices = [
	{
		"minAnts": 0,
		"maxAnts": 9,
		"numResources": 1,
		"resources": [{
			"type": Constants.ResourceType.FOOD_A,
			"amt": 200
		}]
	},
	{
		"minAnts": 10,
		"maxAnts": 30,
		"numResources": 2,
		"resources": [
		{
			"type": Constants.ResourceType.FOOD_A, 
			"amt": 400
		},
		{
			"type": Constants.ResourceType.FOOD_B, 
			"amt": 200
		},
		{
			"type": Constants.ResourceType.FOOD_C, 
			"amt": 200
		},
		{
			"type": Constants.ResourceType.A, 
			"amt": 300
		},
		{
			"type": Constants.ResourceType.B, 
			"amt": 300
		},
		{
			"type": Constants.ResourceType.C, 
			"amt": 300
		}],
	},
	{
		"minAnts": 31,
		"maxAnts": 50,
		"numResources": 2,
		"resources": [
		{
			"type": Constants.ResourceType.FOOD_A, 
			"amt": 500
		},
		{
			"type": Constants.ResourceType.FOOD_B, 
			"amt": 400
		},
		{
			"type": Constants.ResourceType.FOOD_C, 
			"amt": 400
		},
		{
			"type": Constants.ResourceType.A, 
			"amt": 900
		},
		{
			"type": Constants.ResourceType.B, 
			"amt": 900
		},
		{
			"type": Constants.ResourceType.C, 
			"amt": 900
		},
		{
			"type": Constants.ResourceType.FOOD_D, 
			"amt": 200
		},
		{
			"type": Constants.ResourceType.FOOD_E, 
			"amt": 300
		},
		{
			"type": Constants.ResourceType.D, 
			"amt": 300
		},
		{
			"type": Constants.ResourceType.E, 
			"amt": 300
		}],
	},
	{
		"minAnts": 51,
		"maxAnts": 70,
		"numResources": 2,
		"resources": [
		{
			"type": Constants.ResourceType.D, 
			"amt": 1000
		},
		{
			"type": Constants.ResourceType.E, 
			"amt": 1000
		},
		{
			"type": Constants.ResourceType.FOOD_D, 
			"amt": 600
		},
		{
			"type": Constants.ResourceType.FOOD_E, 
			"amt": 600
		}]
	},
	{
		"minAnts": 71,
		"maxAnts": 90,
		"numResources": 3,
		"resources":
		[
		{
			"type": Constants.ResourceType.FOOD_A, 
			"amt": 1500
		},
		{
			"type": Constants.ResourceType.FOOD_B, 
			"amt": 1000
		},
		{
			"type": Constants.ResourceType.FOOD_C, 
			"amt": 1000
		},
		{
			"type": Constants.ResourceType.FOOD_D, 
			"amt": 1000
		},
				{
			"type": Constants.ResourceType.FOOD_E, 
			"amt": 1000
		},
		{
			"type": Constants.ResourceType.A, 
			"amt": 2000
		},
		{
			"type": Constants.ResourceType.B, 
			"amt": 2000
		},
		{
			"type": Constants.ResourceType.C, 
			"amt": 2000
		},
		{
			"type": Constants.ResourceType.D, 
			"amt": 2000
		},
		{
			"type": Constants.ResourceType.E, 
			"amt": 2000
		}],
	},
	{
		"minAnts": 91,
		"maxAnts": 99,
		"numResources": 1,
		"resources":  [
		{
			"type": Constants.ResourceType.FOOD_F, 
			"amt": 2000
		},
		{
			"type": Constants.ResourceType.F, 
			"amt": 2000
		}]
	},
]

var curResources = []
var priceRects

func init():
	colonyRoominit(getHorizontalTileSize(), [55, 103, 140])
	priceRects = [$price1, $price2, $price3]
	updatePrices()

func updatePrices():
	if (AntManager.ants.size() >= Constants.maxAnts):
		return
	var price = getPrice()
	randomize()
	price.resources.shuffle()
	for i in range(0, price.numResources):
		priceRects[i].get_child(0).text = Constants.resourceNames[price.resources[i].type]
		priceRects[i].get_child(1).text = str(price.resources[i].amt)
		priceRects[i].visible = true
		curResources.append(price.resources[i])
	pass

func getPrice():
	for price in prices:
		if AntManager.ants.size() >= price.minAnts && AntManager.ants.size() <= price.maxAnts:
			return price
			
func _process(delta):
	var game = get_node(Constants.gamePath)
	for i in range(0, curResources.size()):
		setRectColor(game.getResourceAmt(curResources[i].type), curResources[i].amt, priceRects[i])

func setRectColor(curAmt, neededAmt, priceRect):
	if (curAmt >= neededAmt):
		priceRect.color = Color(0, 1, 0)
	else:
		priceRect.color = Color(1, 0, 0)
	
static func getHorizontalTileSize():
	return 3

func _on_Button_button_up():
	if curResources.size() == 0:
		return
	var game = get_node(Constants.gamePath)
	for i in range(0, curResources.size()):
		if game.getResourceAmt(curResources[i].type) < curResources[i].amt:
			return
	for i in range(0, curResources.size()):
		game.updateResource(curResources[i].type, -curResources[i].amt)
	$Timer.start()
	resetPrices()

func _on_Timer_timeout():
	var numAntsCreate = min(3, Constants.maxAnts - AntManager.ants.size())
	get_node(Constants.gamePath).createAnts(numAntsCreate, [global_position + Vector2(30,0), global_position + Vector2(60,0), global_position + Vector2(90,0)] )
	updatePrices()

func resetPrices():
	for pr in priceRects:
		pr.visible = false
	curResources  = []
