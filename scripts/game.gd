extends Node2D

@export var levels: Array[PackedScene]

var current_level_index := 0
var current_level: Node2D

@onready var levels_container: Node2D = $Levels
@onready var bullet: CharacterBody2D = $Bullet
@onready var victory: CanvasLayer = $Victory

func _ready() -> void:
	load_level(0)

func load_level(index: int) -> void:
	current_level_index = index
	current_level = levels[index].instantiate()
	current_level.all_bricks_destroyed.connect(_on_all_bricks_destroyed)
	levels_container.add_child(current_level)

func _on_all_bricks_destroyed() -> void:
	current_level.queue_free()

	var next_index := current_level_index + 1
	if next_index >= levels.size():
		victory.show_screen()
		return

	load_level(next_index)
	bullet.reset()
