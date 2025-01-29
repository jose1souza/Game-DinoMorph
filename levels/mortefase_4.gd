extends Area2D

@onready var script_principal = get_tree().get_current_scene()

func _ready() -> void:
	# Conectar o sinal de colisão com a função
	if not is_connected("body_entered", Callable(self, "_on_Area2D_body_entered")):
		connect("body_entered", Callable(self, "_on_Area2D_body_entered"))
		print("Zona de morte conectada.")

func _on_Area2D_body_entered(body: Node) -> void:
	# Quando o jogador entra na zona de morte
	if body is CharacterBody2D and body.is_in_group("jogador") and not script_principal.morte_em_progresso:
		print("Jogador entrou na zona de morte.")
		script_principal.matar_e_ressuscitar_jogador()
