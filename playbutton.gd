extends Button

@onready var game_manager = get_node("/root/GameManager")

# Chama a função quando o botão é pressionado
func _on_pressed() -> void:
	# Reseta as estrelas para 0 em todas as fases
	game_manager.estrelas_por_fase = {
		"fase_01": 0,
		"fase_02": 0,
		"fase_03": 0,
		"fase_04": 0
	}
	
	# Reseta as vidas para 3
	game_manager.vidas = 3
	
	# Muda para a primeira fase
	get_tree().change_scene_to_file("res://levels/fase_01.tscn")
