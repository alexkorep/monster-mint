extends Node

signal score_updated(new_score)

var game_manager

func _ready():
	assert(game_manager == null, "Duplicate GameManager instance!")
	game_manager = self
	start_game()

# Initialize game state and score
var is_game_over = false
var score = 0

func start_game():
	# Initialize game state and score
	is_game_over = false
	score = 0
	emit_signal("score_updated", score)

func end_game():
	# Handle game over logic
	is_game_over = true

func increase_score(points):
	# Increment the score
	score += points
	game_manager.emit_signal("score_updated", score)
