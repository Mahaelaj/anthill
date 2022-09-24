extends ScrollContainer

var antOptionForAntSelect = preload("res://scenes/AntOptionForAntSelect.tscn")

func open(room: ColonyRoom, index: int):
	visible = true
	for i in range(AntManager.ants.size()):
		var antOption = antOptionForAntSelect.instance()
		antOption.init(AntManager.ants[i], room, index)
		$VBoxContainer/GridContainer.add_child(antOption)
