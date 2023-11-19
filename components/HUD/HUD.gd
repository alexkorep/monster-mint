extends Node2D

export var score: int = 0 setget set_score

onready var scoreLabel = $ScorePanel/ScoreLabel
onready var monsterNumberLabel = $MonsterNumberPanel/MonsterNumberLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("score_updated", self, "set_score")
	set_score(score)

func set_score(new_score: int):
	score = new_score
	if scoreLabel:
		scoreLabel.text = str(score)
		
func set_monster_number(number, total):
	monsterNumberLabel.text = str(number) + '/' + str(total)
