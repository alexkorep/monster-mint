extends Node

signal score_updated(new_score)

var current_level: int = 0
var current_monster: int = 0

func _ready():
	$Monster.connect("ui_monster_hit", self, "_on_ui_monster_hit")
	start_game()

# Initialize game state and score
var is_game_over = false
var score = 0

func start_game():
	# Initialize game state and score
	is_game_over = false
	score = 0
	emit_signal("score_updated", score)
	set_level(0)

func end_game():
	# Handle game over logic
	is_game_over = true

func increase_score(points):
	# Increment the score
	score += points
	emit_signal("score_updated", score)

func _on_ui_monster_hit():
	increase_score(1)
	var hp = 1
	var health = $Monster.current_health
	if health > hp:
		var new_health = health - hp
		$Monster.current_health = new_health
		print(new_health)
	else:
		next_monster()

func get_current_level():
	return $Levels.get_children()[current_level]
	
func get_current_monster():
	return get_current_level().get_children()[current_monster]

func set_level(level_no):
	current_level = level_no
	var level = get_current_level()
	$BackgroundSprite.texture = level.background
	set_monster(0)
	
func set_monster(monster_no):
	current_monster = monster_no
	var monster = get_current_monster()
	$Monster.initial_health = monster.initial_health
	$Monster.current_health = monster.initial_health
	$Monster.set_texture(monster.texture)

func next_monster():
	current_monster += 1
	if current_monster >= len(get_current_level().get_children()):
		next_level()
	else:
		set_monster(current_monster)

func next_level():
	current_level += 1
	if current_level >= len($Levels.get_children()):
		current_level = 0
	set_level(current_level)
