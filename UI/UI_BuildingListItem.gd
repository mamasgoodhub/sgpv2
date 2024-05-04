extends TextureButton

signal BuildingSelected
@onready var warn_icon: TextureRect = $WarnIcon

var data: BuildingData

func init(_data: BuildingData, canBuild: bool) -> void:
	if _data:
		data = _data
		$Icon.set_texture(data.texture)
		if canBuild:
			warn_icon.hide()
			disabled = false
		else:
			warn_icon.show()
			disabled = true

func _on_pressed() -> void:
	BuildingSelected.emit(self)


func _on_mouse_entered() -> void:
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	pass # Replace with function body.
