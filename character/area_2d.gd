extends Area2D

func _on_Area2D_body_entered(body: Node) -> void:
	if body is CharacterBody2D and body.is_in_group("jogador"):
		print("Jogador detectado, executando ação de morte.")
		body.queue_free() # Remove o jogador da cena, simulando morte.
	else:
		print("Corpo não é do tipo 'CharacterBody2D' ou não pertence ao grupo correto.")

func _ready() -> void:
	if not self.body_entered.is_connected(_on_Area2D_body_entered):
		self.body_entered.connect(_on_Area2D_body_entered)
