extends Button

@onready var master_bus := AudioServer.get_bus_index("Master")

func _ready() -> void:
	update_text()

func _pressed() -> void:
	AudioServer.set_bus_mute(master_bus, not AudioServer.is_bus_mute(master_bus))
	update_text()

func update_text() -> void:
	var is_muted := AudioServer.is_bus_mute(master_bus)
	text = "ATIVAR ÁUDIO" if is_muted else "DESATIVAR ÁUDIO"
