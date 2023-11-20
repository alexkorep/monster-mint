extends Node

var current_level: int = 0
var current_monster: int = 0
# Initialize game state and score
var is_game_over = false
var score = 0

onready var Monster = $TopArea/Monster
onready var CandleParticles2D = $TopArea/CandleParticles2D
onready var HUD = $TopArea/HUD
onready var BackgroundSprite = $TopArea/BackgroundSprite
onready var WeaponstScrollContainer = $WeaponstScrollContainer


func _ready():
	Monster.connect("ui_monster_hit", self, "_on_ui_monster_hit")
	WeaponstScrollContainer.connect("buy_clicked", self, "_on_upgrade_weapon")

	start_game()

func start_game():
	# Initialize game state and score
	is_game_over = false
	increase_score(100)
	emit_signal("score_updated", score)
	set_level(0)

func end_game():
	# Handle game over logic
	is_game_over = true

func increase_score(points):
	# Increment the score
	score += points
	HUD.set_score(score)

func _on_ui_monster_hit():
	var hp = 1
	var health = Monster.current_health
	if health > hp:
		var new_health = health - hp
		Monster.current_health = new_health
	else:
		var candies = get_current_monster().initial_health
		increase_score(candies)
		CandleParticles2D.emitting = true
		next_monster()

func get_current_level():
	return $Levels.get_children()[current_level]
	
func get_current_monster():
	return get_current_level().get_children()[current_monster]

func set_level(level_no):
	current_level = level_no
	var level = get_current_level()
	BackgroundSprite.texture = level.background
	set_monster(0)
	
func set_monster(monster_no):
	current_monster = monster_no
	var monster = get_current_monster()
	Monster.initial_health = monster.initial_health
	Monster.current_health = monster.initial_health
	Monster.set_texture(monster.texture)
	
	var total_monsters = len(get_current_level().get_children())
	HUD.set_monster_number(monster_no + 1, total_monsters)

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

func _on_upgrade_weapon(weapon):
	if weapon.price < score:
		score -= weapon.price
		HUD.set_score(score)
		WeaponstScrollContainer.upgrade_weapon(weapon)
	
# func get_hp():
# 	# List all Upgrades
# 	var hp = 1
# 	for upgrade in Upgrades.get_children():
# 		if upgrade.is_active:
# 			hp += upgrade.hp
