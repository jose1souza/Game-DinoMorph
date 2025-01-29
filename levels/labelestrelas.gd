extends Label

var fase_atual = ""

func _ready():
	fase_atual = get_tree().current_scene.name

func _process(delta):
	if get_tree().current_scene.name != fase_atual:
		fase_atual = get_tree().current_scene.name

	if GameManager.estrelas_por_fase.has(fase_atual):
		var coletadas = GameManager.estrelas_por_fase[fase_atual]
		text = "Estrelas: %d / 3" % coletadas
