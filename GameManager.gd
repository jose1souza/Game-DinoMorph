extends Node

var vidas: int = 3
var jogadores = {}
var pontos_de_respawn = {
	"dino_verde": Vector2(220, 100),
	"dino_amarelo": Vector2(350, 1000),
	"dino_azul": Vector2(100, 20),
	"dino_vermelho": Vector2(-500, 150)
}

# Contador de estrelas por fase
var estrelas_por_fase = {
	"fase_01": 0,
	"fase_02": 0,
	"fase_03": 0,
	"fase_04": 0
}

func registrar_jogador(nome: String, jogador: Node):
	if jogador and not jogadores.has(nome):
		jogadores[nome] = jogador
		print("Jogador", nome, "registrado.")

func coletar_estrela(fase: String):
	if estrelas_por_fase.has(fase):
		estrelas_por_fase[fase] += 1
		print("Estrelas coletadas na", fase, ":", estrelas_por_fase[fase], "/3")

		if estrelas_por_fase[fase] == 3:
			vidas += 1
			print("Bônus de vida! Vidas atuais:", vidas)

func perder_vida() -> void:
	vidas -= 1
	print("Vidas restantes: %d" % vidas)
	if vidas <= 0:
		game_over()

func ressuscitar_jogadores():
	for nome in jogadores.keys():
		var jogador = jogadores[nome]
		var posicao_respawn = pontos_de_respawn.get(nome, Vector2(100, 100))
		if jogador and is_instance_valid(jogador):
			jogador.global_position = posicao_respawn
			jogador.visible = true
			jogador.set_physics_process(true)
			print("Jogador", nome, "ressuscitado em", posicao_respawn)
		else:
			print("Jogador", nome, "não encontrado ou inválido. Recriando registro.")
			jogadores.erase(nome)

func game_over():
	print("Game Over!")
	vidas = 3
	get_tree().change_scene_to_file("res://game_over.tscn")
