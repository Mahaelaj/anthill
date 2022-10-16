extends WorkingRoom

class_name MarketRoom

var maxFoodA = 50
var maxEnergy = 50
var maxA = 50
var maxB = 50
var maxC = 50
var maxD = 50
var maxE = 50
var maxF = 50

var foodA = 0
var energy = 0
var a = 0
var b = 0
var c = 0
var d = 0
var e = 0
var f = 0

func init():
	add_to_group(Constants.marketRoomsGroup)
	workingRoomInit(getHorizontalTileSize(), [32, 96], [55, 103], $SellTimer, 180)

static func getHorizontalTileSize():
	return 2
	
func updateResource(resourceType, count):
	match resourceType:
		Constants.ResourceType.FOOD_A:
			foodA =  clamp(foodA + count, 0, maxFoodA)
		Constants.ResourceType.ENERGY:
			energy =  clamp(energy + count, 0, maxEnergy)
		Constants.ResourceType.A:
			a = clamp(a + count, 0, maxA)
		Constants.ResourceType.B:
			b = clamp(b + count, 0, maxB)
		Constants.ResourceType.C:
			c = clamp(c + count, 0, maxC)
		Constants.ResourceType.D:
			d = clamp(d + count, 0, maxD)
		Constants.ResourceType.E:
			e = clamp(e + count, 0, maxE)
		Constants.ResourceType.F:
			f = clamp(f + count, 0, maxF)

func isStorageFullForResource(resourceType) -> bool:
	match resourceType:
		Constants.ResourceType.FOOD_A:
			return maxFoodA - foodA == 0
		Constants.ResourceType.ENERGY:
			return maxEnergy - energy == 0
		Constants.ResourceType.A:
			return maxA - a == 0
		Constants.ResourceType.B:
			return maxB - b == 0
		Constants.ResourceType.C:
			return maxC - c == 0
		Constants.ResourceType.D:
			return maxD - d == 0
		Constants.ResourceType.E:
			return maxE - e == 0
		Constants.ResourceType.F:
			return maxF - f == 0
	return true

func _on_SellTimer_timeout():
	var funds = 0
	funds += foodA * Constants.resourcePrices[Constants.ResourceType.FOOD_A]
	foodA = 0
	funds += energy * Constants.resourcePrices[Constants.ResourceType.ENERGY]
	energy = 0
	funds += a * Constants.resourcePrices[Constants.ResourceType.A]
	a = 0
	funds += b * Constants.resourcePrices[Constants.ResourceType.B]
	b = 0
	funds += c * Constants.resourcePrices[Constants.ResourceType.C]
	c = 0
	funds += d * Constants.resourcePrices[Constants.ResourceType.D]
	d = 0
	funds += e * Constants.resourcePrices[Constants.ResourceType.E]
	e = 0
	funds += f * Constants.resourcePrices[Constants.ResourceType.F]
	f = 0
	get_node(Constants.gamePath).updateFunds(funds)
	startTimer()
