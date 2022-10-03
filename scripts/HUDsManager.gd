extends Node

enum controlFlowEnum {MAIN, ROOM_BUILD, ROOM_ADMIN}
var controlFlow = controlFlowEnum.MAIN

func _on_BuildButton_button_up():
	if (controlFlow != controlFlowEnum.MAIN):
		return
	controlFlow = controlFlowEnum.ROOM_BUILD
	$RoomBuildControl.visible = true
	$MainHUD.visible = false
	pass # Replace with function body.

# TODO: clicking the area over the buildbutton to close the popup 
# causes the buildbutton to be pressed
func roomSelectHide():
	controlFlow = controlFlowEnum.MAIN
	$MainHUD.visible = true
	pass # Replace with function body.

func openRoomAdmin(room: ColonyRoom):
	if (controlFlow != controlFlowEnum.MAIN):
		return
	controlFlow = controlFlowEnum.ROOM_ADMIN
	$MainHUD.visible = false
	$RoomAdmin.visible = true
	$RoomAdmin.open(room)
	pass

func closeRoomAdmin():
	controlFlow = controlFlowEnum.MAIN
	$MainHUD.visible = true
	$RoomAdmin.visible = false
	$RoomAdmin/AntSelect.visible = false
	for i in $RoomAdmin/AntSelect/VBoxContainer/GridContainer.get_children():
		i.queue_free()
