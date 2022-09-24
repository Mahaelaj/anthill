extends Node

enum RoomType {UNSET, ELEVATOR, FOOD}

# Can col be moved to a variable on the room node.
var Rooms = {
	RoomType.ELEVATOR: {
		"col": 1
	},
	RoomType.FOOD: {
		"col": 2
	}
}

enum ResourceType {FOOD}

var antSelectPath = "/root/Game/HUDsManager/RoomAdmin/AntSelect"
var roomAdminPath = "/root/Game/HUDsManager/RoomAdmin"
var gamePath = "/root/Game"
var hudsManagerPath = "/root/Game/HUDsManager"
