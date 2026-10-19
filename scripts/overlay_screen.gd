class_name OverlayScreen
extends CanvasLayer

const MENU_SCENE := "res://scenes/menu.tscn"

@onready var options: VBoxContainer = $Content/Options
@onready var select_sound: AudioStreamPlayer = $SelectSound

func change_scene(path: String) -> void:
	set_process_unhandled_input(false)
	options.process_mode = Node.PROCESS_MODE_DISABLED
	select_sound.play()
	await select_sound.finished
	get_tree().paused = false
	get_tree().change_scene_to_file(path)

func _on_main_menu_pressed() -> void:
	change_scene(MENU_SCENE)

func _on_quit_pressed() -> void:
	get_tree().quit()
