extends Sprite2D

@export_range(0, 2000) var velocidade = 800.0
@export var margin = 80

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var tela_do_jogo = get_viewport_rect()
	var comprimento_da_tela = tela_do_jogo.size.x
	
	var direcao = 0.0
	if Input.is_action_pressed("direita"):
		direcao += 1.0
		
	elif Input.is_action_pressed("esquerda"):
		direcao -= 1.0
		
	if direcao != 0.0:
		var movimentacao = direcao * velocidade * delta
		
		position.x += movimentacao
		position.x = clamp(position.x, margin, comprimento_da_tela - margin)
