extends TileMap

@onready var GrowTimer: Timer = $"../Timer"
var treeSpawnRate: int = 30
var allTrees: Array

func _ready() -> void:
	GlobalSignals.DayEnded.connect(_On_Day_Ended)

func _On_Day_Ended() -> void:
	var treeCounter: int = 0
	while treeCounter < treeSpawnRate:
		#print("Trees ", GetAllTrees().size())
		var tree: Vector2i = GetAllEndings().pick_random()
		#print("Baum ", tree)
		var freeCells: Array = []
		for cell: Vector2i in get_surrounding_cells(tree):
			if get_cell_tile_data(1, cell) == null:
				freeCells.append(cell)
		if !freeCells.is_empty():
		#var freeRandomCell: Vector2i = get_surrounding_cells(tree).filter(func(cell: Vector2i) -> Vector2i:
				#if
		#)
		#for tree: Vector2i in GetAllEndings():
		#set_cells_terrain_connect(1, get_surrounding_cells(tree), 0, 0)
			get_surrounding_cells(tree)
			var rand: int = randi_range(0, get_surrounding_cells(tree).size() - 1)
			#print(freeCells)
			set_cell(1, freeCells.pick_random(), 0, Vector2i(8, 7))
			treeCounter += 1
			#set_cells_terrain_connect(1, get_surrounding_cells(tree), 0, 0)

func GetAllEndings() -> Array:
	var tileArr: Array = []
	for cell in get_used_cells(1):
		if get_cell_tile_data(1, cell).get_custom_data_by_layer_id(0):
			tileArr.append(cell)
	return tileArr

func GetAllTrees() -> Array:
	return get_used_cells(1)
