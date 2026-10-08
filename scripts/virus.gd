@tool
extends Node2D

@export var textures: Array[Texture2D]:
	set(value):
		textures = value
		if is_node_ready():
			show_stage()
@export_range(0.5, 1.0, 0.01) var damage_scale: float = 0.85
@export var hit_points := 10

var hits_taken := 0

@onready var image: Sprite2D = $Image
@onready var collision: CollisionShape2D = $Area2D/CollisionShape2D

func _ready() -> void:
	show_stage()

func take_hit() -> int:
	hits_taken += 1
	if hits_taken >= textures.size():
		queue_free()
		return hit_points + hit_points * textures.size()

	scale *= damage_scale
	show_stage()
	return hit_points

func show_stage() -> void:
	if textures.is_empty():
		return

	var texture := textures[hits_taken]
	var shape := collision.shape as RectangleShape2D
	image.texture = texture
	image.scale = shape.size / texture.get_size()
