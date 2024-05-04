class_name WorkplaceData
extends BuildingData
#
#enum WORKPLACECATEGORY {
	#ENERGY,
	#FOOD,
	#WOOD,
#}

#
@export var neededWorkers: int
@export var produces: Dictionary = {BUILDINGCATEGORY.ENERGY: 1, BUILDINGCATEGORY.FOOD: 1, BUILDINGCATEGORY.WOOD: 1}
#@export var texture: Texture
#@export_multiline var description: String
#@export var buildingNode: PackedScene
#@export var workplaceCategory : WORKPLACECATEGORY:
	#get:
		#return workplaceCategory
