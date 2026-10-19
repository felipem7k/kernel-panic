extends Control

const GAME_SCENE := "res://scenes/jogo.tscn"

@onready var options: VBoxContainer = $Frame/Stage/Options
@onready var play_button: Button = $Frame/Stage/Options/PlayButton
@onready var select_sound: AudioStreamPlayer = $SelectSound

func _ready() -> void:
	play_button.grab_focus()

func _on_play_pressed() -> void:
	options.process_mode = Node.PROCESS_MODE_DISABLED
	select_sound.play()
	await select_sound.finished
	get_tree().change_scene_to_file(GAME_SCENE)

func _on_audio_pressed() -> void:
	select_sound.play()

func _on_quit_pressed() -> void:
	get_tree().quit()
