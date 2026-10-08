extends Node2D

signal all_bricks_destroyed

func _ready() -> void:
	child_order_changed.connect(_on_child_order_changed)

func _on_child_order_changed() -> void:
	if is_inside_tree() and get_child_count() == 0:
		all_bricks_destroyed.emit()
