extends Node2D

@onready var hud = $HUD_fase4/Control_fase4/Container_fase4/Container_fase4/LabelHUD

var destino_respawn = Vector2(-600, 160)
var jogador: CharacterBody2D = null
var morte_em_progresso = false
var tempo_limite = 70.0

func _ready() -> void:
	jogador = get_node_or_null("dino_vermelho")
	if jogador == null:
		print("Erro: Jogador não encontrado.")
	else:
		print("Jogador carregado com sucesso.")
	if hud:
		hud.tempo_restante = tempo_limite
	else:
		print("Erro: HUD não encontrada.")

func _process(delta: float) -> void:
	if morte_em_progresso:
		return

	if hud:
		hud.atualizar_timer(delta)
		if hud.tempo_restante <= 0:
			matar_e_ressuscitar_jogador()

func matar_e_ressuscitar_jogador() -> void:
	if morte_em_progresso:
		return
	morte_em_progresso = true

	if jogador:
		var camera = jogador.get_node("Camera2D") if jogador.has_node("Camera2D") else null
		var posicao_morte = jogador.global_position

		# Desativa o jogador e mantém a câmera no local da morte
		jogador.visible = false
		jogador.set_physics_process(false)
		jogador.velocity = Vector2.ZERO
		if camera:
			camera.offset = posicao_morte - jogador.global_position

		# Aguarda 1.8 segundos antes do respawn
		await get_tree().create_timer(1.8).timeout

		# Respawn e reativação
		jogador.global_position = destino_respawn
		jogador.visible = true
		jogador.set_physics_process(true)
		if camera:
			camera.offset = Vector2.ZERO

		# Atualiza estado do jogo e HUD
		GameManager.perder_vida()
		reiniciar_timer()

	morte_em_progresso = false

func reiniciar_timer() -> void:
	if hud:
		hud.tempo_restante = tempo_limite
