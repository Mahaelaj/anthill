extends Control

var ant: Ant
var room: ColonyRoom 
var index: int

func init(_ant: Ant, _room: ColonyRoom, _index: int):
	ant = _ant
	room = _room
	index = _index
	$AntNameLabel.text = ant.antName

func _on_Button_button_up():
	get_node(Constants.gamePath).assignAntToRoom(ant, room, index)
	get_node(Constants.hudsManagerPath).closeRoomAdmin()
