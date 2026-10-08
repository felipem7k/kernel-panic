extends Label

@onready var score: Node = $"../../Score"

func _ready() -> void:
	score.changed.connect(refresh)
	refresh()

func refresh() -> void:
	text = "%s   %s" % [score.points_text(), score.high_score_text()]
