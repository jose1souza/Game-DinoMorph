extends CharacterBody2D

const SPEED = 250.0
const JUMP_VELOCITY = -250.0
const FALL_SLOW_FACTOR = 0.3
const GRAVITY = 500.0
@onready var anim = $animacao1 as AnimatedSprite2D
var shoot_cooldown = 0.5

func _ready():
	# Verifica se o jogador está na cena corretamente
	if is_instance_valid(self):
		print("Jogador carregado na cena:", self.name)
	else:
		print("Jogador NÃO encontrado na cena!")

	# Registra o jogador no GameManager
	GameManager.registrar_jogador("dino_vermelho", self)
	print("Jogador registrado no GameManager.")

	# Adiciona o jogador ao grupo de vidas
	if not is_in_group("jogadores"):
		add_to_group("jogadores")
		print("Jogador adicionado ao grupo 'jogadores'.")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * FALL_SLOW_FACTOR * delta

	if Input.is_action_just_pressed("ui_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("pulando")

	var direction := Input.get_axis("ui_movl", "ui_movr")
	if direction:
		velocity.x = direction * SPEED
		anim.scale.x = direction
		if is_on_floor():
			anim.play("correndo")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			anim.play("parado")
	
	move_and_slide()
