extends CanvasLayer

@onready var result_sound: AudioStreamPlayer = $ResultSound
@onready var select_sound: AudioStreamPlayer = $SelectSound

func show_screen() -> void:
	visible = true
	get_tree().paused = true
	result_sound.play()

func _unhandled_input(event: InputEvent) -> void:
	if visible and event.is_action_released("atirar"):
		restart()

func restart() -> void:
	set_process_unhandled_input(false)
	select_sound.play()
	await select_sound.finished
	get_tree().paused = false
	get_tree().reload_current_scene()
