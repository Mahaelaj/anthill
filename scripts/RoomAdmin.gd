extends Control

var room: ColonyRoom

func open(_room: ColonyRoom):
	room = _room

func _on_Fill_Position_1_button_up():
	onFillButtonPress(0)
	pass # Replace with function body.

func _on_Fill_Position_2_button_up():
	onFillButtonPress(1)
	pass # Replace with function body.

func onFillButtonPress(num: int): 
	$AntSelect.open(room, num)
