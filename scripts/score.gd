extends Node

signal changed

const SAVE_PATH := "user://high_score.cfg"

var points := 0
var high_score := 0
var is_new_record := false

func _ready() -> void:
	load_high_score()

func add(amount: int) -> void:
	points += amount
	if points > high_score:
		high_score = points
		is_new_record = true

	changed.emit()

func points_text() -> String:
	return "PONTOS %05d" % points

func high_score_text() -> String:
	return "RECORDE %05d" % high_score

func load_high_score() -> void:
	var config := ConfigFile.new()
	if config.load(SAVE_PATH) != OK:
		return

	high_score = config.get_value("score", "high_score", 0)

func save_high_score() -> void:
	if not is_new_record:
		return

	var config := ConfigFile.new()
	config.set_value("score", "high_score", high_score)
	config.save(SAVE_PATH)
