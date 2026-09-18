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
@onready var colisao: CollisionShape2D = $Area2D/CollisionShape2D

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

func _physics_process(delta: float) -> void:
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

func rebater_no_brick(area: Area2D) -> bool:
	var colisao_brick: CollisionShape2D = area.get_node("CollisionShape2D")
	var limites_brick: Rect2 = colisao_brick.global_transform * colisao_brick.shape.get_rect()
	var limites_bola: Rect2 = colisao.global_transform * colisao.shape.get_rect()
	if not limites_bola.intersects(limites_brick):
		return false

	var diferenca := limites_bola.get_center() - limites_brick.get_center()
	var sobreposicao := (limites_bola.size + limites_brick.size) * 0.5 - diferenca.abs()
	var normal: Vector2
	var distancia: float
	if sobreposicao.x < sobreposicao.y:
		normal = Vector2.RIGHT if diferenca.x > 0.0 else Vector2.LEFT
		distancia = sobreposicao.x
	else:
		normal = Vector2.DOWN if diferenca.y > 0.0 else Vector2.UP
		distancia = sobreposicao.y

	if velocidade.dot(normal) >= 0.0:
		return false

	global_position += normal * (distancia + 1.0)
	velocidade = velocidade.bounce(normal)
	return true

func _on_area_2d_area_entered(area: Area2D) -> void:
	if not ativa:
		return

	if area.is_in_group("player"):
		velocidade.y = -abs(velocidade.y)
		if velocidade.y == 0.0:
			velocidade.y = -rebote
		aumentar_gradualmente_a_velocidade()
	if area.is_in_group("enemies"):
		var obj = area.get_parent()
		if obj.is_queued_for_deletion() or not rebater_no_brick(area):
			return

		if obj.has_method("foi_acertado"):
			obj.foi_acertado()
		else:
			obj.queue_free()
			
		aumentar_gradualmente_a_velocidade()

	atualizar_rotacao_imagem()
