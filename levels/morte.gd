extends Area2D

var destino_fases = {
	"fase_01": Vector2(250, 150),
	"fase_02": Vector2(-1000, 200),
	"fase_03": Vector2(400, 100),
	"fase_04": Vector2(500, 150)
}
var tempo_limite = 10.0  # Tempo limite em segundos (apenas para fase_04)
var jogador: CharacterBody2D = null
var timer: Timer = null

func _ready() -> void:
	# Conectar o sinal de colisão com a função
	if not self.body_entered.is_connected(_on_Area2D_body_entered):
		self.body_entered.connect(_on_Area2D_body_entered)

	# Configura o Timer apenas na fase_04
	if get_fase_atual() == "fase_04":
		configurar_timer()

func get_fase_atual() -> String:
	var fase_nome = get_tree().get_current_scene().name
	if destino_fases.has(fase_nome):
		return fase_nome
	else:
		print("Aviso: Nome da fase '%s' não encontrado em 'destino_fases'." % fase_nome)
		return "fase_01"  # Define um valor padrão para evitar respawn em (0, 0)

func configurar_timer() -> void:
	timer = Timer.new()
	timer.wait_time = tempo_limite
	timer.one_shot = true
	timer.timeout.connect(_on_time_limit_reached)
	add_child(timer)
	timer.start()

func _on_Area2D_body_entered(body: Node) -> void:
	if body is CharacterBody2D and body.is_in_group("jogador"):
		jogador = body
		matar_e_ressuscitar_jogador()

func _on_time_limit_reached() -> void:
	if jogador:
		matar_e_ressuscitar_jogador()

func matar_e_ressuscitar_jogador() -> void:
	if jogador:
		var camera = jogador.get_node("Camera2D") if jogador.has_node("Camera2D") else null
		var posicao_morte = jogador.global_position

		# Desativa o jogador e mantém a câmera no local da morte
		jogador.visible = false
		jogador.set_physics_process(false)
		jogador.velocity = Vector2.ZERO
		if camera:
			camera.offset = posicao_morte - jogador.global_position

		# Aguarda 1.8 segundos
		await get_tree().create_timer(1.8).timeout

		# Define o ponto de reaparecimento com base na fase atual
		var destino = destino_fases.get(get_fase_atual(), destino_fases["fase_01"])
		jogador.global_position = destino

		# Reativa o jogador e restaura a câmera
		jogador.visible = true
		jogador.set_physics_process(true)
		if camera:
			camera.offset = Vector2.ZERO

		GameManager.perder_vida()
