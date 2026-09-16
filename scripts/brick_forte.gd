extends Node2D

@export var forte_textura: CompressedTexture2D
@export var fraco_textura: CompressedTexture2D
@export_range(0.5, 1.0, 0.01) var escala_fraco: float = 0.9
var vida = 2

@onready var imagem: Sprite2D = $Imagem

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	imagem.texture = forte_textura

func foi_acertado():
	if vida <= 0:
		return

	vida -= 1
	
	if vida == 0:
		queue_free()
	else:
		imagem.scale *= forte_textura.get_size() / fraco_textura.get_size()
		imagem.texture = fraco_textura

		scale *= (escala_fraco - 0.05)
