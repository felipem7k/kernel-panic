extends OverlayScreen

@onready var score: Node = $"../Score"
@onready var score_label: Label = $Content/Score
@onready var record_label: Label = $Content/Record
@onready var result_sound: AudioStreamPlayer = $ResultSound
@onready var restart_button: Button = $Content/Options/RestartButton

func show_screen() -> void:
	score.save_high_score()
	score_label.text = score.points_text()
	record_label.text = "NOVO RECORDE!" if score.is_new_record else score.high_score_text()
	visible = true
	get_tree().paused = true
	result_sound.play()
	restart_button.grab_focus()

func _on_restart_pressed() -> void:
	change_scene(get_tree().current_scene.scene_file_path)
