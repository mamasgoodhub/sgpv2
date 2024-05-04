extends Node

var population: Array[Alien] = [load("res://Alien.tscn").instantiate(), load("res://Alien.tscn").instantiate(), load("res://Alien.tscn").instantiate()]
var food: int = 10
var wood: int = 100
var energy: int = 0
var co2: int = 0
var buildings: Array
var accommodations: Array[Accommodation]
var usedEnergy: int = 0

enum ALIENSTATE {
	WORK,
	SLEEP
}

var currentAlienState: ALIENSTATE = ALIENSTATE.SLEEP

func _ready() -> void:
	GlobalSignals.BuildingPlaced.connect(_On_BuildingPlaced)
	GlobalSignals.NewDayStarted.connect(_On_NewDayStarted)
	GlobalSignals.DayEnded.connect(_On_DayEnded)

func _On_NewDayStarted() -> void:
	currentAlienState = ALIENSTATE.WORK
	Engine.time_scale = 1
	await get_tree().create_timer(5).timeout
	GlobalSignals.DayEnded.emit()
	currentAlienState = ALIENSTATE.SLEEP

func _On_DayEnded() -> void:
	if %Spaceship.residents.size() > 0:
		if GetCountFreeSpace() > 0:
			for freeAccommodation: Accommodation in GetFreeAccommodations():
				if %Spaceship.residents.size() - freeAccommodation.GetFreeSpace() <= 0:
					for resident: Alien in %Spaceship.residents:
						freeAccommodation.AddResident(resident)
						await get_tree().create_timer(0.2).timeout
						%Spaceship.residents.clear()
				else:
					for i: int in freeAccommodation.GetFreeSpace():
						freeAccommodation.AddResident(%Spaceship.residents.pop_front())
						await get_tree().create_timer(0.2).timeout
	if !GetNotFilledWorkStations().is_empty():
		for workplace: Workstation in GetNotFilledWorkStations():
			if !GetResidentsWithoutJob().is_empty():
				if GetResidentsWithoutJob().size() - workplace.GetNeededWorkersAmount() <= 0:
					for resident: Alien in GetResidentsWithoutJob():
						workplace.AddWorker(resident)
				else:
					for i: int in workplace.GetNeededWorkersAmount():
						workplace.AddWorker(GetResidentsWithoutJob().pop_front())
	#Collect resources
	var activeWorkstations: Array = GetWorkStations().filter(
		func(ws: Workstation) -> bool:
			return !GetNotFilledWorkStations().has(ws))
	
	for workstation: Workstation in activeWorkstations:
		#energy += workstation.data.produces[BuildingData.BUILDINGCATEGORY.ENERGY]
		food += workstation.data.produces[BuildingData.BUILDINGCATEGORY.FOOD]
		wood += workstation.data.produces[BuildingData.BUILDINGCATEGORY.WOOD]
	#FeedColony
	food -= GetPopulation().size()

func CalcUsedEnergy() -> void:
	for workstation: Workstation in GetWorkStations():
		if usedEnergy + workstation.data.energyCost <= energy:
			usedEnergy += workstation.data.energyCost

func _On_BuildingPlaced(building: Node2D) -> void:
	wood -= building.data.buildingCost
	buildings.append(building)
	#if building.data.buildingCategory == BuildingData.BUILDINGCATEGORY.MISC:
	if building.data.buildingCategory == BuildingData.BUILDINGCATEGORY.ENERGY:
		energy += building.data.produces[BuildingData.BUILDINGCATEGORY.ENERGY]
	
	var inactiveStations: Array = GetWorkStations().filter(
		func(ws: Workstation) -> bool:
			return !ws.IsActive()
	)
	for ws: Workstation in inactiveStations:
		if ws.data.energyCost + usedEnergy <= energy:
			ws.SetActive(true)
			usedEnergy += ws.data.energyCost
		else:
			ws.SetActive(false)
	if %Spaceship.residents.size() > 0:
		if GetCountFreeSpace() > 0:
			for freeAccommodation: Accommodation in GetFreeAccommodations():
				if %Spaceship.residents.size() - freeAccommodation.GetFreeSpace() <= 0:
					for resident: Alien in %Spaceship.residents:
						freeAccommodation.AddResident(resident)
						await get_tree().create_timer(0.2).timeout
					%Spaceship.residents.clear()
					return
				else:
					for i: int in freeAccommodation.GetFreeSpace():
						freeAccommodation.AddResident(%Spaceship.residents.pop_front())
						await get_tree().create_timer(0.2).timeout
	if !GetNotFilledWorkStations().is_empty():
		for workplace: Workstation in GetNotFilledWorkStations():
			if GetResidentsWithoutJob().is_empty():
				return
			else:
				if GetResidentsWithoutJob().size() - workplace.GetNeededWorkersAmount() <= 0:
					for resident: Alien in GetResidentsWithoutJob():
						workplace.AddWorker(resident)
					return
				else:
					for i: int in workplace.GetNeededWorkersAmount():
						workplace.AddWorker(GetResidentsWithoutJob().pop_front())
				#for resident: Alien in GetResidentsWithoutJob():
					#if resident.GetWorkplace() == null
		#else:
			#pass

func GetAccommodations() -> Array:
	return buildings.filter(
		func(building: Node2D) -> bool:
			return building.data.buildingCategory == BuildingData.BUILDINGCATEGORY.MISC
	)

func GetWorkStations() -> Array:
	return buildings.filter(
		func(building: Node2D) -> bool:
			return building.data.buildingCategory != BuildingData.BUILDINGCATEGORY.MISC
	)

func GetNotFilledWorkStations() -> Array:
	return GetWorkStations().filter(
		func(workstation: Workstation) -> bool:
			return workstation.NeedsWorkers()
	)

func GetCountWorkersNeeded() -> int:
	var workersNeeded: int
	for workstation: Workstation in GetNotFilledWorkStations():
		workersNeeded += workstation.GetNeededWorkersAmount()
	return workersNeeded

func GetFreeAccommodations() -> Array:
	return GetAccommodations().filter(
		func(accommodation: Node2D) -> bool:
			return accommodation.HasSpace()
	)

func GetCountFreeSpace() -> int:
	var freeSpace: int
	for freeAccommodation: Node2D in GetFreeAccommodations():
		freeSpace += freeAccommodation.GetFreeSpace()
	return freeSpace

func GetPopulation() -> Array:
	return %Colony.get_children()

func GetResidentsWithoutJob() -> Array:
	var residentsWithHome: Array = GetPopulation().filter(
		func(resident: Alien) -> bool:
			return resident.GetHome() != null
	)
	return residentsWithHome.filter(
		func(resident: Alien) -> bool:
			return resident.GetWorkplace() == null
	)
