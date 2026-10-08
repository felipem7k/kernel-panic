extends CanvasLayer

@onready var score: Node = $"../Score"
@onready var score_label: Label = $Content/Score
@onready var record_label: Label = $Content/Record
@onready var result_sound: AudioStreamPlayer = $ResultSound
@onready var select_sound: AudioStreamPlayer = $SelectSound

func show_screen() -> void:
	score.save_high_score()
	score_label.text = score.points_text()
	record_label.text = "NOVO RECORDE!" if score.is_new_record else score.high_score_text()
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
