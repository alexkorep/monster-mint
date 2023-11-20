extends Control

signal buy_weapon_clicked(weapon)

# Texture of the weapon
export var texture: Texture = null setget _set_texture

# Name of the weapon
export var weapon_name: String = "" setget set_weapon_name

# Current level of the weapon
export var level: int = 0 setget _set_level

# Price to upgrade from level 0 to level 1
export var initial_price: float = 0 setget _set_initial_price

# Current prite to upgrade. Based on the initial price, and the current level
export var price = 0 setget , get_price

# How much the price increases per level
export var price_multiplier: float = 1.1

export var hp_per_level: int = 1

func _ready():
	_set_level(level)
	_set_initial_price(initial_price)

func _on_BuyButton_pressed():
	emit_signal("buy_weapon_clicked", self)

func upgrade():
	_set_level(level + 1)

func set_weapon_name(name):
	weapon_name = name
	$Panel/NameLabel.text = weapon_name

func _set_texture(new_texture):
	texture = new_texture
	$Panel/Sprite.texture = new_texture

func get_price_for_level(new_level):
	var result_price = initial_price
	for _i in range(new_level):
		result_price *= price_multiplier
	return result_price

func get_price():
	return get_price_for_level(level)

func _set_initial_price(new_price):
	initial_price = new_price
	update_price_label()

func update_price_label():
	$Panel/PriceLabel.text = NumberFormatter.format_large_number(get_price_for_level(level))

func _set_level(new_level):
	print("Setting level to " + str(new_level))
	level = new_level
	update_price_label()
	$Panel/LevelLabel.text = str(level)

func get_hp():
	return hp_per_level * level
