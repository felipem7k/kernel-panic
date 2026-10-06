extends CanvasLayer

func show_screen() -> void:
	visible = true
	get_tree().paused = true

func _unhandled_input(event: InputEvent) -> void:
	if visible and event.is_action_released("atirar"):
		get_tree().paused = false
		get_tree().reload_current_scene()
