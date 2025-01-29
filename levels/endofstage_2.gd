extends Area2D

func _ready():
	# Conecta o sinal de colisão "body_entered" com o método que teleporta
	connect("body_entered", _on_body_entered)

# Método que será chamado quando algum corpo entrar na área
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("jogador"):  # Verifica se o corpo é o jogador
		get_tree().change_scene_to_file("res://levels/fase_03.tscn")
