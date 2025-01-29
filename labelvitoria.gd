extends Label

func _ready() -> void:
	if GameManager.estrelas_por_fase:
		var total_estrelas = contar_estrelas_totais()
		if total_estrelas == 12:
			text = "Incrível! Você coletou todas as 12 estrelas do jogo! 🌟"
		else:
			text = "Parabéns! Você coletou %d de 12 estrelas. Continue tentando para pegar todas!" % total_estrelas
	else:
		text = "Erro: Não foi possível acessar o sistema de estrelas."

func contar_estrelas_totais() -> int:
	var total = 0
	for fase in GameManager.estrelas_por_fase.keys():
		total += GameManager.estrelas_por_fase[fase]
	return total
