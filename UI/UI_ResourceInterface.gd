extends Control
@onready var food_label: Label = $ResourcesContainer/FoodContainer/FoodLabel
@onready var energy_label: Label = $ResourcesContainer/EnergyContainer/EnergyLabel
@onready var wood_label: Label = $ResourcesContainer/WoodContainer/WoodLabel



func _ready() -> void:
	GlobalSignals.DayEnded.connect(_On_Day_Ended)
	GlobalSignals.BuildingPlaced.connect(_On_Building_Placed)
	food_label.text = str(%ColonyService.food)
	wood_label.text = str(%ColonyService.wood)
	energy_label.text = str(%ColonyService.energy)
	#food_label.text = str(StatsManager.food)
	#energy_label.text = str(StatsManager.energy)
	#wood_label.text = str(StatsManager.wood)
	#StatsManager.ressourcesUpdated.connect(_ressourcesUpdated)


func _On_Building_Placed(building: Node) -> void:
	await get_tree().create_timer(0.5).timeout
	food_label.text = str(%ColonyService.food)
	wood_label.text = str(%ColonyService.wood)
	energy_label.text = str(%ColonyService.energy)

func _On_Day_Ended() -> void:
	await get_tree().create_timer(0.5).timeout
	food_label.text = str(%ColonyService.food)
	wood_label.text = str(%ColonyService.wood)
	energy_label.text = str(%ColonyService.energy)

#func _ressourcesUpdated():
	#food_label.text = str(StatsManager.food)
	#energy_label.text = str(StatsManager.energy)
	#wood_label.text = str(StatsManager.wood)
