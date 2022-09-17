extends Node2D

var ElevatorRoom = preload("res://scenes/rooms/ElevatorRoom.tscn")
var FoodRoom = preload("res://scenes/rooms/FoodRoom.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var room = ElevatorRoom.instance()
	$Grid.setCell(room, 2, 5)
	room.init()
	$PathFinding.connectRoom(2,5)
	pass # Replace with function body.
	
func addRoom(roomType, row, col):
	var room
	match roomType:
		Constants.RoomType.ELEVATOR:
			room = ElevatorRoom.instance()
		Constants.RoomType.FOOD:
			room = FoodRoom.instance()
	$Grid.setCell(room, row, col)
	room.init()
	$PathFinding.connectRoom(row, col)
