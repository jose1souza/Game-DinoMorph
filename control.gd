extends Control

@onready var star_label = $"hud/Control/Container/Container_Estrelas/Label"
@onready var vidas_label = $"hud/Control/Container/Container_Estrelas/LabelVidas"
var estrelas_por_fase = 0

func _ready():
	# Verifica se os nós existem antes de usá-los
	if not star_label:
		print("Erro: Label 'star_label' não encontrado.")
	if not vidas_label:
		print("Erro: Label 'vidas_label' não encontrado.")
	
	update_star_count()
	atualizar_label_vidas()

func update_star_count():
	if star_label:
		star_label.text = "Estrelas: %d / 3" % estrelas_por_fase

func collect_star():
	estrelas_por_fase += 1
	update_star_count()

func atualizar_label_vidas():
	if vidas_label and GameManager:
		vidas_label.text = "Vidas: %d" % GameManager.vidas
	else:
		print("Erro: GameManager não encontrado ou vidas_label não inicializado.")

func _process(_delta):
	atualizar_label_vidas()
