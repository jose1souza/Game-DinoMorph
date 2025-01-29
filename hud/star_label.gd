extends Label

func _process(delta):
	var fase_atual = get_tree().current_scene.name
	if GameManager.estrelas_por_fase.has(fase_atual):
		text = "Estrelas: %d / 3" % GameManager.estrelas_por_fase[fase_atual]
	else:
		text = "Estrelas: 0 / 3"
