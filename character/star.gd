extends Node2D

@onready var estrela_colidiu = false  # Flag para garantir que a estrela só seja coletada uma vez

# Método para se conectar ao sinal de colisão
func _ready() -> void:
	connect("body_entered", Callable(self, "_on_estrela_colidiu"))

# Método chamado quando o jogador colide com a estrela
func _on_estrela_colidiu(body):
	if body is CharacterBody2D and !estrela_colidiu:  # Verifica se o corpo que colidiu é um jogador
		estrela_colidiu = true
		print("Jogador colidiu com a estrela.")

		# Percorre os ancestrais até encontrar o nó da fase
		var fase_atual = find_fase(self)
		print("Estrela coletada na", fase_atual)

		var game_manager = get_node("/root/GameManager")  # Obtém o GameManager
		if game_manager:
			game_manager.coletar_estrela(fase_atual)  # Passa a fase atual para o GameManager
		
		queue_free()  # Remove a estrela da cena
		print("Estrela coletada na", fase_atual)

# Função que percorre os ancestrais e encontra o nó da fase
func find_fase(estrela: Node) -> String:
	var parent = estrela.get_parent()
	while parent:
		if parent is Node2D and parent.name.begins_with("fase_0") and parent.name.length() == 7:  # Verifica o nome com 7 caracteres
			return parent.name  # Retorna o nome da fase
		parent = parent.get_parent()
	return "fase_desconhecida"  # Se não encontrar, retorna um valor default
