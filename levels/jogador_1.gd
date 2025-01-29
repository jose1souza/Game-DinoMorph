extends CharacterBody2D

const SPEED = 115.0
const JUMP_VELOCITY = -280.0
const GRAVITY = 460.0
@onready var anim = $animacao1 as AnimatedSprite2D
var pulando = false
var em_dano = false

func _ready():
	GameManager.registrar_jogador("dino_verde", self)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	if Input.is_action_just_pressed("ui_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("pulando")
		pulando = true

	pulando = not is_on_floor()

	var direction = Input.get_axis("ui_movl", "ui_movr")
	if direction != 0:
		velocity.x = direction * SPEED
		anim.scale.x = direction
		if not pulando:
			anim.play("correndo")
		else:
			anim.play("pulando")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			anim.play("parado")

	move_and_slide()
