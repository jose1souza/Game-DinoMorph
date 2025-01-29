extends CharacterBody2D

const SPEED = 250.0
const JUMP_VELOCITY = -296.0
const GLIDE_FACTOR = 0.24
const GRAVITY = 500.0
@onready var anim = $animacao1 as AnimatedSprite2D
var pulando = false
var em_dano = false
var gliding = false

func _ready():
	GameManager.registrar_jogador("dino_amarelo", self)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		if gliding and velocity.y > 0:
			velocity.y += GRAVITY * GLIDE_FACTOR * delta
			if anim.animation != "planando":
				anim.play("planando")
		else:
			velocity.y += GRAVITY * delta

	if Input.is_action_just_pressed("ui_jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			anim.play("pulando")
			pulando = true
			gliding = false
		elif not gliding:
			gliding = true
			anim.play("planando")

	if Input.is_action_just_released("ui_jump"):
		gliding = false

	if is_on_floor():
		pulando = false
		gliding = false
		anim.play("parado")

	var direction = Input.get_axis("ui_movl", "ui_movr")
	if direction:
		velocity.x = direction * SPEED
		anim.scale.x = direction
		if !pulando and !gliding:
			anim.play("correndo")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if !gliding and is_on_floor():
			anim.play("parado")

	move_and_slide()
