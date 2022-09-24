extends Node

export var cell_height_px = 64
export var rows = 5
export var columns = 11

var grid = []

# Called when the node enters the scene tree for the first time.
func _init():
	var cell_size =  Vector2(cell_height_px, cell_height_px)
	for r in rows:
		for c in columns:
			var cell = ReferenceRect.new()
			var cell_pos = Vector2(c * cell_height_px, r * cell_height_px)
			cell.set_position(cell_pos)
			cell.set_size(cell_size)
			cell.border_color = Color(1, 0, 0, 1)
			cell.editor_only = false
			add_child(cell)
	
	grid.resize(rows)
	for i in range (rows):
		var cells = []
		cells.resize(columns)
		cells.fill(null)
		grid[i] = cells

func getCellSnapPos(pos: Vector2) -> Vector2Obj:
	if pos.x < 0 || pos.y < 0 || pos.x > cell_height_px * columns || pos.y > cell_height_px * rows: 
		return null

	var cell_pos = Vector2.ZERO
	
	cell_pos.x = pos.x / cell_height_px
	if pos.x % cell_height_px > 0:
		cell_pos.x += 1
	
	cell_pos.y = pos.y / cell_height_px
	if pos.y % cell_height_px > 0:
		cell_pos.y += 1

	return Vector2Obj.new(cell_pos)

func setCell(room, row: int, col: int):
	for i in range(room.horizontalTileSize):

		grid[row][col + i] = room
		
	room.set_position(Vector2(col * cell_height_px, row * cell_height_px))
	add_child(room)
	
func getRoomBuildOptions(room_col_size: int, is_elevator: bool) -> Array:
	var gridCellBuildOptions = []
	for r in range(rows):
		for c in range (columns):
			if grid[r][c] != null:
				_addLeftGridCellBuildOption(r, c, room_col_size, gridCellBuildOptions)
				_addRightGridCellBuildOption(r, c, room_col_size, gridCellBuildOptions)
				if is_elevator && grid[r][c].roomType == Constants.RoomType.ELEVATOR:
					_addElevatorOptions(r, c, gridCellBuildOptions)
				
	return gridCellBuildOptions
	
func getGridCellPos(pos: Vector2) -> Vector2:
	return pos * cell_height_px
	pass
	
func getRoomAtGridPos(row: int, col: int) -> ColonyRoom:
	if row < 0 || row >= rows || col < 0 || col >= columns: return null
	return grid[row][col]
	
func _addLeftGridCellBuildOption(row, col, room_col_size, gridCellBuildOptions):
	if (col - room_col_size < 0):
		return
		
	for i in range(1, room_col_size + 1):
		if (grid[row][col - i] != null):
			return
			
	_addGridCellOption(row, col - room_col_size, gridCellBuildOptions)
	
func _addRightGridCellBuildOption(row, col, room_col_size, gridCellBuildOptions):
	if (col + room_col_size >= columns): 
		return
	
	for i in range(1, room_col_size + 1):
		if (grid[row][col + i] != null):
			return
			
	_addGridCellOption(row, col + 1, gridCellBuildOptions)

func _addElevatorOptions(row, col, gridCellBuildOptions):
	if (row != 0 && grid[row- 1][col] == null):
		_addGridCellOption(row -1, col, gridCellBuildOptions)
			
	if (row < rows - 1 && grid[row + 1][col] == null):
		_addGridCellOption(row + 1, col, gridCellBuildOptions)

func _addGridCellOption(row, col, gridCellBuildOptions):
	for i in gridCellBuildOptions:
		if i.x == col && i.y == row:
			return
	
	gridCellBuildOptions.push_back(Vector2(col, row))
