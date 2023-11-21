extends Node2D

signal settings_pressed()

export var score: int = 0 setget set_score

onready var scoreLabel = $MainPanel/ScoreLabel
onready var monsterNumberLabel = $MainPanel/MonsterNumberLabel
onready var hpLabel = $MainPanel/HPLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	set_score(score)

func set_score(new_score: int):
	score = new_score
	if scoreLabel:
		scoreLabel.text = str(score)
		
func set_monster_number(number, total):
	monsterNumberLabel.text = str(number) + '/' + str(total)

func _on_SettingsButton_pressed():
	emit_signal("settings_pressed")

func set_hp(hp):
	hpLabel.text = NumberFormatter.format_large_number(hp) + 'hp'
