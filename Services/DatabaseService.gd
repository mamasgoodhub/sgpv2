extends Node

var buildings: Array[BuildingData] = []


func _ready() -> void:
#	"res://Database/Items/Blueberry.tres"
	LoadBuildings("res://Data/Buildings/")
#	print(ResourceLoader.has_cached("res://Database/Items/Blueberry.tres"))
#	ResourceLoader.load("res://Database/Items/Blueberry.tres")
#	print(ResourceLoader.has_cached("res://Database/Items/Blueberry.tres"))
#	var directory = DirAccess.open("res://Database/")
#	items.append(ResourceLoader.load("res://Database/Items/Blueberry.tres")) 
#	for entry in DirAccess.get_files_at("res://Database/Items/"):
#		database.append(ResourceLoader.load("res://Database/Items/%s" % entry))
##	print("Test2 ", test[0].name)
	
#	directory.list_dir_begin()
#	var filename = directory.get_next()
#	print("Filename ",filename)
##	print(directory.current_is_dir())
#	while(filename):
#		print(filename)
#		filename = directory.get_next()
#	print("DB", database)

func LoadBuildings(directory: String) -> void:
	for entry in DirAccess.get_directories_at(directory):
		if DirAccess.get_directories_at(directory + "%s" % entry):
			LoadBuildings(directory.get_base_dir() + "/" + entry + "/")
		if DirAccess.get_files_at(directory + "%s" % entry):
			for item in DirAccess.get_files_at(directory + "%s" % entry):
				ResourceLoader.load(directory + entry + "/" + item).set_name(item.get_basename())
				buildings.append(ResourceLoader.load(directory + entry + "/" + item))

func GetBuildings() -> Array[BuildingData]:
	return buildings

