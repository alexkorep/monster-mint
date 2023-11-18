extends Label

var game_manager = null

func _ready():
	GameManager.game_manager.connect("score_updated", 
		self, "_on_score_updated")

func _on_score_updated(new_score):
	text = str(new_score)
