extends Node

func _on_BuildButton_button_up():
	$RoomBuildControl.visible = true
	$MainHUD.visible = false
	pass # Replace with function body.

# TODO: clicking the area over the buildbutton to close the popup 
# causes the buildbutton to be pressed
func roomSelectHide():
	$MainHUD.visible = true
	pass # Replace with function body.

func roomSelectedForPlacement(roomType):
	pass
