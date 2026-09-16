extends Node2D

@export var forte_textura: CompressedTexture2D
var vida = 2

@onready var imagem: Sprite2D = $Imagem

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	imagem.texture = forte_textura

func foi_acertado():
	vida -= 1
	
	if vida == 0:
		queue_free()
