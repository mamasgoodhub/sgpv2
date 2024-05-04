extends Node2D

func _process(delta: float) -> void:
	pass
	#if Input.is_action_just_pressed("SCROLL_UP"):
		#$Camera2D.zoom += Vector2(0.25, 0.25)
	#if Input.is_action_just_pressed("SCROLL_DOWN"):
		#$Camera2D.zoom -= Vector2(0.25, 0.25)

func _unhandled_input(event: InputEvent) -> void:
	var mouse_pos: Vector2 = get_global_mouse_position()
	$Camera2D/Indicator.global_position = Vector2(
		snapped(get_global_mouse_position().x - 8, 16),
		snapped(get_global_mouse_position().y - 8, 16)
	)
	if event is InputEventMouseButton:
		if event.button_index == 4:
			$Camera2D.zoom += Vector2(0.25, 0.25)
		elif event.button_index == 5:
			$Camera2D.zoom -= Vector2(0.25, 0.25)
