extends Label

@onready var lives: Node = $"../../Lives"

func _ready() -> void:
	lives.changed.connect(refresh)
	refresh()

func refresh() -> void:
	text = lives.lives_text()
