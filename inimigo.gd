extends CharacterBody2D

const SPEED = 150.0
const GRAVITY = 900.0

var direction = -1
@onready var sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	velocity.x = direction * SPEED
	
	var collision_info = move_and_slide()
	if collision_info and is_on_wall():
		direction *= -1
