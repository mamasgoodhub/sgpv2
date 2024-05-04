extends Node2D

var residents : Array[Alien]
const ALIEN = preload("res://Alien.tscn")
@onready var res_count: Label = $ResPanel/ResCount
@onready var res_panel: Panel = $ResPanel

func _ready() -> void:
	GlobalSignals.DayEnded.connect(_On_Day_Ended)
	GlobalSignals.BuildingPlaced.connect(_On_Building_Placed)
	residents = %ColonyService.population
	for resident in residents:
		%Colony.add_child(resident)
		resident.position = position
	if !residents.is_empty():
		res_panel.show()
		res_count.text = str(residents.size()) + "x"
	else:
		res_panel.hide()

func _On_Day_Ended() -> void:
	var alien: Alien = ALIEN.instantiate()
	residents.append(alien)
	alien.position = position
	%Colony.add_child(alien)
	await get_tree().create_timer(0.4).timeout
	if !residents.is_empty():
		res_panel.show()
		res_count.text = str(residents.size()) + "x"
	else:
		res_panel.hide()

func _On_Building_Placed(building: Node) -> void:
	await get_tree().create_timer(0.4).timeout
	if !residents.is_empty():
		res_panel.show()
		res_count.text = str(residents.size())
	else:
		res_panel.hide()
