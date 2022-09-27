extends Node

enum RoomType {UNSET, ELEVATOR, FOOD, ENERGY}

#TODOD Make col a property of the colony rooms
var Rooms = {
	RoomType.ELEVATOR: {
		"col": 1
	},
	RoomType.FOOD: {
		"col": 2
	},
	RoomType.ENERGY: {
		"col": 2
	}
}

enum ResourceType {FOOD, ENERGY}

var antSelectPath = "/root/Game/HUDsManager/RoomAdmin/AntSelect"
var roomAdminPath = "/root/Game/HUDsManager/RoomAdmin"
var gamePath = "/root/Game"
var hudsManagerPath = "/root/Game/HUDsManager"
