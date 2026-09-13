extends Sprite2D

@export var forte_textura: CompressedTexture2D
@export var fraco_textura: CompressedTexture2D
var vida = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture = forte_textura

func foi_acertado():
	vida -= 1
	
	if vida == 0:
		queue_free()
	else:
		texture = fraco_textura
