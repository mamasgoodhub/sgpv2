class_name Accommodation
extends Node2D

const MAX_RESIDENTS = 2
var residents: Array[Alien]
var data: BuildingData = load("res://Data/Buildings/Buildings/House.tres")

func _ready() -> void:
	GlobalSignals.NewDayStarted.connect(_On_NewDayStarted)

func AddResident(alien: Alien) -> void:
	residents.append(alien)
	alien.SetHome(self)
	alien.SendToHome()

func HasSpace() -> bool:
	return !MAX_RESIDENTS == residents.size()

func GetFreeSpace() -> int:
	return MAX_RESIDENTS - residents.size()

func SendResidentsToWork() -> void:
	for resident: Alien in residents:
		if resident.GetWorkplace() != null:
			if !resident.GetWorkplace().NeedsWorkers() and resident.GetWorkplace().IsActive():
				resident.SendToWork()
				await get_tree().create_timer(0.2).timeout

func _On_NewDayStarted() -> void:
	SendResidentsToWork()
