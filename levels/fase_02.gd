extends Node2D

var fase_atual = "fase_02"  # Altere conforme a fase
var jogador: CharacterBody2D = null

func _ready() -> void:
	jogador = get_node_or_null("dino_amarelo")
	if jogador == null:
		print("Erro: Jogador não encontrado.")
		print("Hierarquia da cena:", get_tree().root.get_children())  # Imprime a hierarquia para ajudar na depuração
	else:
		print("Jogador carregado com sucesso.")

func coletar_estrela():
	if GameManager:
		GameManager.coletar_estrela(fase_atual)
		print("Estrela coletada na", fase_atual)
