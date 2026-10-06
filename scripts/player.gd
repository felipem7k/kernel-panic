extends CharacterBody2D

@export_range(0, 2000) var velocidade = 800.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every physics frame. 'delta' is the elapsed time since the previous physics frame.
func _physics_process(delta: float) -> void:
	var direcao = 0.0
	if Input.is_action_pressed("direita"):
		direcao += 1.0

	elif Input.is_action_pressed("esquerda"):
		direcao -= 1.0

	if direcao != 0.0:
		move_and_collide(Vector2(direcao * velocidade * delta, 0.0))
