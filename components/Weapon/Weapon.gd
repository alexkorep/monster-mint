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

# Called when the node is added to the scene
func _ready():
	reset()

func reset():
	_set_level(0)
	_set_initial_price(initial_price)
	_update_hp_label()

# Called when the BuyButton is pressed, emits a signal with the current weapon
func _on_BuyButton_pressed():
	emit_signal("buy_weapon_clicked", self)

# Upgrades the weapon by increasing its level by 1
func upgrade():
	_set_level(level + 1)

# Sets the name of the weapon and updates the corresponding label
func set_weapon_name(name):
	weapon_name = name
	$Panel/NameLabel.text = weapon_name

# Sets the texture of the weapon and updates the corresponding sprite
func _set_texture(new_texture):
	texture = new_texture
	$Panel/Sprite.texture = new_texture

# Returns the price for a given level, calculated based on the initial price and the price multiplier
func get_price_for_level(new_level):
	var result_price = initial_price
	for _i in range(new_level):
		result_price *= price_multiplier
	return result_price

# Returns the current price to upgrade the weapon
func get_price():
	return get_price_for_level(level)

# Sets the initial price of the weapon and updates the price label
func _set_initial_price(new_price):
	initial_price = new_price
	update_price_label()

# Updates the price label with the current price to upgrade the weapon
func update_price_label():
	$Panel/PriceLabel.text = NumberFormatter.format_large_number(get_price_for_level(level))

# Sets the level of the weapon, updates the price label and the level label
func _set_level(new_level):
	level = new_level
	update_price_label()
	$Panel/LevelLabel.text = str(level)
	_update_hp_label()

# Returns the current hit points (HP) of the weapon, calculated as the product of hp_per_level and the current level
func get_hp():
	return hp_per_level * level

func _update_hp_label():
	$Panel/HpLabel.text = NumberFormatter.format_large_number(get_hp()) + 'hp'

func disable_buy_button_if_not_enough_candles(candles):
	if candles < get_price():
		$Panel/BuyButton.disabled = true
	else:
		$Panel/BuyButton.disabled = false
