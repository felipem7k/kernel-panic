extends Node2D

var velocidade = Vector2(200, -350)
var rebote = 700
var margin = 32

var ativa = false
var DISTACIA_DO_PLAYER = 48

@onready var player = $"../Player"
@onready var texto = $"../Control/Label"
@onready var bg_texto = $"../Control/LabelBackgound"
@onready var imagem: Sprite2D = $Imagem

@export_range(-180.0, 180.0, 1.0) var angulo_original_imagem: float = 45.0

func lancar(posicao: Vector2) -> void:
	position = posicao + Vector2(0, -DISTACIA_DO_PLAYER)
	visible = true
	ativa = true
	texto.visible = false
	bg_texto.visible = false
	
	var ir_esqueda = randi() % 2 == 0
	var vx = -rebote * 0.4 if ir_esqueda else rebote *0.4
	velocidade = Vector2(vx, -rebote).normalized() * rebote
	atualizar_rotacao_imagem()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ativa:
		position += velocidade * delta
		
		rebate_na_tela()
		atualizar_rotacao_imagem()
		saiu_da_tela()
	elif Input.is_action_pressed("atirar"):
		lancar(player.position)
	
func atualizar_rotacao_imagem() -> void:
	if not velocidade.is_zero_approx():
		imagem.rotation = velocidade.angle() - deg_to_rad(angulo_original_imagem)

func saiu_da_tela():
	if position.y > get_viewport_rect().size.y:
		texto.visible = true
		bg_texto.visible = true
		ativa = false
		visible = false
		velocidade = Vector2.ZERO
	
func rebate_na_tela():
	var tela = get_viewport_rect()
	
	if position.x <= margin:
		position.x = margin
		velocidade.x = abs(velocidade.x)
	elif position.x >= tela.size.x - margin:
		position.x = tela.size.x - margin
		velocidade.x = -abs(velocidade.x)
		
	if position.y <= margin:
		position.y = margin
		velocidade.y = abs(velocidade.y)

func aumentar_gradualmente_a_velocidade():
	velocidade.y = clamp(velocidade.y*1.02, velocidade.y-300, velocidade.y+300)
	velocidade.x = clamp(velocidade.x*1.02, velocidade.x-300, velocidade.x+300)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		velocidade.y = -abs(velocidade.y)
		if velocidade.y == 0.0:
			velocidade.y = -rebote
		aumentar_gradualmente_a_velocidade()
	if(area.is_in_group("enemies")):
		var centro_obj = area.global_position
		var diff = global_position - centro_obj
		if abs(diff.x) > abs(diff.y):
			velocidade.x = -velocidade.x
		else:
			velocidade.y = -velocidade.y
			
		var obj = area.get_parent()
		if obj.has_method("foi_acertado"):
			obj.foi_acertado()
		else:
			obj.queue_free()
			
		aumentar_gradualmente_a_velocidade()

	atualizar_rotacao_imagem()
