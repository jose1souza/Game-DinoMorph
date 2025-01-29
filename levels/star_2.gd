extends Node2D

@onready var star_label = $Label
@onready var star_label2 = $Label2
var star_count = 0

func _ready():
	update_star_count()

func update_star_count():
	star_label.text = "Estrelas: %d / 3" % star_count
	star_label2.text = "Estrelas: %d / 3" % star_count
