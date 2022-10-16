extends WorkingRoom

var resourceType 
var resouceAmountOnTimeout = 15

class_name ResourceRoom
	
func resourceRoomInit(_horizontalTileSize: int, _loiterPositions, _workPositions, _resourceType, _maxTimerTime):
	resourceType = _resourceType
	var timer = Timer.new()
	timer.connect("timeout", self, "_on_ResourceTimer_timeout") 
	timer.one_shot = true
	add_child(timer)
	workingRoomInit(_horizontalTileSize, _loiterPositions, _workPositions, timer, _maxTimerTime)

func _on_ResourceTimer_timeout():
	get_node(Constants.gamePath).updateResource(resourceType, resouceAmountOnTimeout)
	startTimer()

