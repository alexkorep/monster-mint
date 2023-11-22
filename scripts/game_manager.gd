extends Node

var current_level: int = 0
var current_monster: int = 0
var candies_score = 0
var max_open_level = 0

onready var Monster = $TopArea/Monster
onready var CandleParticles2D = $TopArea/CandleParticles2D
onready var HUD = $TopArea/HUD
onready var BackgroundSprite = $TopArea/BackgroundSprite
onready var WeaponstScrollContainer = $WeaponstScrollContainer
onready var Settings = $Settings
onready var LevelHUD = $TopArea/LevelHUD
onready var Levels = $LevelManager

export var save_file_name = "user://save_game.dat"

func _ready():
	Monster.connect("ui_monster_hit", self, "_on_ui_monster_hit")
	WeaponstScrollContainer.connect("buy_clicked", self, "_on_upgrade_weapon")
	HUD.connect("settings_pressed", self, "_on_settings_pressed")
	Settings.connect("new_game", self, "new_game")
	LevelHUD.connect("prev_level", self, "go_prev_level")
	LevelHUD.connect("next_level", self, "go_next_level")

	if not load_game():
		new_game()

func new_game():
	delete_game_file()

	# Initialize game state and score
	set_level(0)
	set_score(0)
	set_monster(0)
	WeaponstScrollContainer.reset_weapons()
	HUD.set_hp(get_total_hp())
	update_level_hud()

func set_score(score):
	candies_score = score
	HUD.set_score(candies_score)
	WeaponstScrollContainer.disable_buy_button_if_not_enough_candles(candies_score)

func increase_score(points):
	# Increment the score
	set_score(candies_score + points)

func _on_ui_monster_hit():
	var hp = get_total_hp()
	var health = Monster.current_health
	if health > hp:
		var new_health = health - hp
		Monster.current_health = new_health
	else:
		var candies = Levels.get_monster_reward(current_level)
		increase_score(candies)
		CandleParticles2D.emitting = true
		next_monster()

func get_monster_progress():
	var monster_count = Levels.monsters_per_level
	if current_monster >= monster_count - 1:
		return monster_count
	return current_monster

func get_monsters_on_level():
	return Levels.monsters_per_level

func set_level(level_no):
	current_level = level_no
	BackgroundSprite.texture = Levels.get_level_background_texture(level_no)
	set_monster(0)
	update_level_hud()
	
func set_monster(monster_no):
	current_monster = monster_no
	var health = Levels.get_monster_health(current_level)
	Monster.initial_health = health
	Monster.current_health = health
	Monster.set_texture(Levels.get_monster_texture(current_level, current_monster))
	
	HUD.set_monster_number(get_monster_progress(), get_monsters_on_level())
	update_level_hud()

func next_monster():
	current_monster += 1
	set_monster(current_monster)
	save_game()

func next_level():
	current_level += 1
	set_level(current_level)
	save_game()

func _on_upgrade_weapon(weapon):
	if weapon.price <= candies_score:
		candies_score -= weapon.price
		HUD.set_score(candies_score)
		WeaponstScrollContainer.upgrade_weapon(weapon)
		WeaponstScrollContainer.disable_buy_button_if_not_enough_candles(candies_score)
		HUD.set_hp(get_total_hp())
		save_game()
	
func get_total_hp():
	# +1 because it's initial hp without any weapons
	return WeaponstScrollContainer.get_total_hp() + 1

func save_game():
	var save_game = File.new()
	var save_data = {} # Your game data as a dictionary

	# Populate save_data with game information
	save_data["candies_score"] = candies_score
	save_data["current_level"] = current_level
	save_data["current_monster"] = current_monster
	save_data["max_open_level"] = max_open_level
	WeaponstScrollContainer.save_weapons(save_data)

	save_game.open(save_file_name, File.WRITE)
	save_game.store_var(save_data)
	save_game.close()

func save_game_exists():
	var save_game = File.new()
	if save_game.file_exists(save_file_name):
			return true
	return false

func load_game():
	var save_game = File.new()
	if not save_game.file_exists(save_file_name):
		return false

	save_game.open(save_file_name, File.READ)
	var save_data = save_game.get_var()
	save_game.close()
	
	# Now extract the data and set it in your game
	if (not save_data or 
			not save_data.has("candies_score") or 
			not save_data.has("current_level") or 
			not save_data.has("current_monster") or 
			not save_data.has("max_open_level")):
		return  false

	set_score(save_data["candies_score"])
	set_level(save_data["current_level"])
	set_monster(save_data["current_monster"])
	max_open_level = save_data["max_open_level"]
	WeaponstScrollContainer.load_weapons(save_data)
	WeaponstScrollContainer.disable_buy_button_if_not_enough_candles(candies_score)
	HUD.set_hp(get_total_hp())
	update_level_hud()
	return true

func delete_game_file():
	var dir = Directory.new()
	dir.remove(save_file_name)

func _on_settings_pressed():
	$Settings.popup()

func update_level_hud():
	var next_enabled = current_monster >= get_monsters_on_level() or current_level < max_open_level
	LevelHUD.enable_buttons(current_level > 0, next_enabled)
	LevelHUD.set_level(current_level + 1, Levels.get_level_name(current_level))

func go_prev_level():
	print(current_level)
	if current_level <= 0:
		return
	current_level -= 1
	set_level(current_level)
	# Mark that we killed all monsters on this level
	set_monster(get_monsters_on_level())
	save_game()

func go_next_level():
	print('current_level', current_level, 'max_open_level', max_open_level)
	if (current_monster < get_monsters_on_level()) and (current_level >= max_open_level):
		return
	current_level += 1
	print('moving to ', current_level)
	if current_level > max_open_level:
		max_open_level = current_level
	set_level(current_level)
	save_game()
