extends Node

enum ResourceType {FOOD_A, FOOD_B, FOOD_C, FOOD_D, FOOD_E, FOOD_F, ENERGY, A, B, C, D, E, F}

var antSelectPath = "/root/Game/HUDsManager/RoomAdmin/AntSelect"
var roomAdminPath = "/root/Game/HUDsManager/RoomAdmin"
var gamePath = "/root/Game"
var hudsManagerPath = "/root/Game/HUDsManager"

var resourcePrices = {
	ResourceType.FOOD_A: 1,
	ResourceType.FOOD_B: 1,
	ResourceType.FOOD_C: 1,
	ResourceType.FOOD_D: 1,
	ResourceType.FOOD_E: 1,
	ResourceType.FOOD_F: 1,
	ResourceType.ENERGY: 1,
	ResourceType.A: 2,
	ResourceType.B: 2,
	ResourceType.C: 2,
	ResourceType.D: 3,
	ResourceType.E: 3,
	ResourceType.F: 4,
}

var marketRoomsGroup = "MarketRooms"
var workingRoomsGroup = "WorkingRooms"


