extends OverlayScreen

@onready var resume_button: Button = $Content/Options/ResumeButton

func _unhandled_input(event: InputEvent) -> void:
	if not event.is_action_pressed("ui_cancel"):
		return

	if visible:
		resume()
	elif not get_tree().paused:
		pause()

func pause() -> void:
	visible = true
	get_tree().paused = true
	resume_button.grab_focus()

func resume() -> void:
	visible = false
	get_tree().paused = false

func _on_resume_pressed() -> void:
	select_sound.play()
	resume()

func _on_audio_pressed() -> void:
	select_sound.play()
