extends Control

var UI_BuildingItem: PackedScene = preload("res://UI/UI_BuildingListItem.tscn")
var uiBI : Node = null
var building : Node = null
@onready var colonyService: Node = %ColonyService

func _ready() -> void:
	GlobalSignals.BuildingPlaced.connect(_On_BuildingPlaced)
	_Update()

func _On_BuildingPlaced(building: Node) -> void:
	_Update()

func _Update() -> void:
	await get_tree().create_timer(0.1).timeout
	for child in $TabContainer/Wood/MarginContainer/ScrollContainer/HBoxContainer.get_children():
		child.queue_free()
	for child in $TabContainer/Energy/MarginContainer/ScrollContainer/HBoxContainer.get_children():
		child.queue_free()
	for child in $TabContainer/Food/MarginContainer/ScrollContainer/HBoxContainer.get_children():
		child.queue_free()
	for child in $TabContainer/Misc/MarginContainer/ScrollContainer/HBoxContainer.get_children():
		child.queue_free()
	var buildings: Array[BuildingData] = DatabaseService.GetBuildings()
	for building in buildings:
		var canBuild: bool = true
		uiBI = UI_BuildingItem.instantiate()
		uiBI.BuildingSelected.connect(_On_BuildingSelected)
		get_node("TabContainer/" + building.BUILDINGCATEGORY.keys()[building.buildingCategory].to_lower().capitalize() + "/MarginContainer/ScrollContainer/HBoxContainer").add_child(uiBI)
		if colonyService.wood - building.buildingCost <= 0:
			canBuild = false
		else:
			canBuild = true
		uiBI.init(building, canBuild)

func _On_BuildingSelected(ButtonBuilding: TextureButton) -> void:
	if %DnDHolder.get_child_count() > 0:
		%DnDHolder.get_child(0).queue_free()
	var mouse_pos: Vector2 = get_global_mouse_position()
	#print(ButtonBuilding.data)
	building = ButtonBuilding.data.buildingNode.instantiate()
	building.data = ButtonBuilding.data
	%DnDHolder.add_child(building)

	building.position -= Vector2(-8, -8)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("LMB") and %DnDHolder.get_child_count() > 0:
		%DnDHolder.get_child(0).reparent(%Buildings)
		GlobalSignals.BuildingPlaced.emit(%Buildings.get_child(%Buildings.get_child_count() - 1))
