class_name Workstation
extends Node2D

var workers: Array[Alien]
var data: BuildingData
var NEEDED_WORKERS: int
var bodys: Array
var oldMouseCell: Vector2i
var trees: Dictionary
var active: bool = false
@onready var tileMap: TileMap = $Tiles
@onready var chimney: AnimatedSprite2D = $Chimney
@onready var inactive_warning: Sprite2D = $InActiveWarning

func _ready() -> void:
	GlobalSignals.DayEnded.connect(_On_Day_Ended)
	NEEDED_WORKERS = data.neededWorkers
	#for polygon in polygon.polygon:
		#print(tiles.map_to_local(polygon))
		#tiles.set_cell(0, tiles.map_to_local(polygon), 0, Vector2i(1, 0))

func SetActive(state: bool) -> void:
	if state == false:
		inactive_warning.show()
	else:
		inactive_warning.hide()
	active = state

func IsActive() -> bool:
	return active

func _On_Day_Ended() -> void:
	chimney.hide()
	SendWorkersHome()

func SendWorkersHome() -> void:
	for worker: Alien in workers:
		worker.SendToHome()
		await get_tree().create_timer(0.2).timeout

func AddWorker(alien: Alien) -> void:
	workers.append(alien)
	alien.SetWorkplace(self)

func NeedsWorkers() -> bool:
	return !NEEDED_WORKERS == workers.size()

func GetNeededWorkersAmount() -> int:
	return NEEDED_WORKERS - workers.size()

#Visuell darstellen
func _ChangedCell() -> void:
	pass
	#for body: Node2D in bodys:
		#print("Body ", body)
		#if bodys[body] != tileMap.local_to_map(to_local(body.position - Vector2(0, 0))):
			#bodys[body] = tileMap.local_to_map(to_local(body.position - Vector2(0, 0)))
			#if tileMap.get_used_cells(0).has(bodys[body]):
				#tileMap.set_cell(0, bodys[body], 0, Vector2i(3, 0))
		#else:
			#if tileMap.get_used_cells(0).has(bodys[body]):
				#tileMap.set_cell(0, bodys[body], 0, Vector2i(0, 0))

func _unhandled_input(event: InputEvent) -> void:
	pass
	#var mousePos: Vector2 = get_global_mouse_position()
	#var mouseCell: Vector2i = tileMap.local_to_map(mousePos)
	#if oldMouseCell != mouseCell:
		#for tree: RID in trees:
			#var cell: Vector2i = tileMap.local_to_map(to_local(trees[tree]))
			#if tileMap.get_used_cells(0).has(cell):
				#tileMap.set_cell(0, cell - Vector2i(1, 1), 0, Vector2i(0, 0), 4)
				#tileMap.set_cell(0, cell - Vector2i(1, 1), 0, Vector2i(3, 0))
		##_ChangedCell()
		#oldMouseCell = mouseCell
		#var body: Array = $Area2D.get_overlapping_bodies()
		#if !body.is_empty():
			#print(body)
			#body[0].get_coords_for_body_rid
		#print(tileMap.get_used_cells(0))
		#for cell in tileMap.get_used_cells(0):
			##print("Penis " ,cell)
			##print(tileMap.local_to_map(to_global(cell)))
			#var worldmap: TileMap = get_tree().get_root().get_node("World").get_node("WorldMap")
			#var tree: Vector2i = worldmap.local_to_map(worldmap.map_to_local(tileMap.local_to_map(to_global(cell))))
			#print("Tree ", tree)
			#if tileMap.get_used_cells(0).has(tree):
				#print("True")

#func _on_area_2d_body_entered(_body: Node2D) -> void:
	#bodys[_body] = null
#
#
#func _on_area_2d_body_exited(_body: Node2D) -> void:
	#bodys.erase(_body)
func _process(delta: float) -> void:
	pass
	#print(trees)
	#print(tileMap.get_used_cells(0))
	#print($Area2D.get_overlapping_bodies())
	#var worldmap: TileMap = get_tree().get_root().get_node("World").get_node("WorldMap")
	#print(worldmap.GetAllTrees())

func GetTreesInArea() -> Array:
	return []

func _on_area_2d_body_shape_entered(body_rid: RID, _body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if _body.is_class("TileMap"):
		trees[body_rid] = _body.map_to_local(_body.get_coords_for_body_rid(body_rid))
		print(trees)
	#bodys.append(_body)
	#print(_body.position)
	#if _body.is_class("TileMap"):
		#var treeCoords: Vector2i = _body.map_to_local(_body.get_coords_for_body_rid(body_rid))
		#print(treeCoords)
	#tileMap.map_
	#trees[body_rid] = treeCoords
	#print(body)
	#bodys.append(_body)
	#get_viewport().warp_mouse(body)
	#var tree: Node = TREE.instantiate()
	#print("Bodycoord ", body)
	#get_tree().get_root().call_deferred("add_child", tree)
	#tree.set_deferred("position", to_global(body) - Vector2(32, 32))
	#print(to_global(body) - Vector2(32, 32))
	#var cell: Vector2i = to_global(body) - Vector2(16, 16)
	#tileMap.set_cell(0, cell, 0, Vector2i(3, 0))
	#print(_GetAllTrees())
	
func _GetAllTrees() -> Dictionary:
	return trees


func _on_area_2d_body_shape_exited(body_rid: RID, _body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	trees.erase(body_rid)
	print(trees)
