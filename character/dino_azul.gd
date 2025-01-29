extends CharacterBody2D

const SPEED = 135.0
const JUMP_VELOCITY = -275.0
const GRAVITY = 500.0
const MAX_JUMPS = 2
@onready var anim = $animacao1 as AnimatedSprite2D
var jump_count = 0
var movimento_continuo = false
var direcao_continua = 1  # 1 para direita, -1 para esquerda

func _ready():
	GameManager.registrar_jogador("dino_azul", self)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	if Input.is_action_just_pressed("ui_jump"):
		if is_on_floor():
			jump_count = 0
		if jump_count < MAX_JUMPS:
			velocity.y = JUMP_VELOCITY
			anim.play("pulando")
			jump_count += 1

	if is_on_floor():
		jump_count = 0

	var direction = Input.get_axis("ui_movl", "ui_movr")
	
	if direction != 0:
		movimento_continuo = true
		direcao_continua = direction

	if movimento_continuo:
		velocity.x = direcao_continua * SPEED
		anim.scale.x = direcao_continua
		if is_on_floor():
			anim.play("correndo")

	move_and_slide()
