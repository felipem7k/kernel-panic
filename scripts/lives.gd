extends Node

signal changed

const MAX_LIVES := 3

var remaining := MAX_LIVES

func lose_life() -> void:
	remaining = maxi(remaining - 1, 0)
	changed.emit()

func is_empty() -> bool:
	return remaining == 0

func lives_text() -> String:
	return "VIDAS %d" % remaining
