extends Node

var currentDay: int

func _on_button_pressed() -> void:
	GlobalSignals.NewDayStarted.emit()
	currentDay += 1
	#%BuildingList.hide()
