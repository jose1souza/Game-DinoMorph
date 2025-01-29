extends Label

var tempo_restante: float = 70.0

func atualizar_timer(delta: float) -> void:
	if tempo_restante > 0:
		tempo_restante -= delta
		text = "Tempo restante: %.2f segundos" % max(tempo_restante, 0)
	else:
		text = "Tempo esgotado!"
