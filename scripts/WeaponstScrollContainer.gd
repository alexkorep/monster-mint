extends ScrollContainer

signal buy_clicked(weapon)

export var hide_zero_level_weapons = false

var item_template = preload("res://components/Weapon/Weapon.tscn")
var list_items = ["Item 1", "Item 2", "Item 3"]
onready var Upgrades = $"../Upgrades"

func _ready():
	update_weapon_visibility()
	connect_weapon_signals()

func connect_weapon_signals():
	for weapon in $VBoxContainer.get_children():
		weapon.connect("buy_weapon_clicked", self, "_on_buy_weapon")

func update_weapon_visibility():
	if not hide_zero_level_weapons:
		# Make all weapons visible
		for weapon in $VBoxContainer.get_children():
			weapon.visible = true
		return

	# Make all weapons that have level > 0 visible. Make also the next weapon visible
	var next_should_be_visible = true
	for weapon in $VBoxContainer.get_children():
		if weapon.level > 0 :
			weapon.visible = true
		else:
			if next_should_be_visible:
				weapon.visible = true
				next_should_be_visible = false
			else:
				weapon.visible = false


func _on_buy_weapon(weapon):
	emit_signal("buy_clicked", weapon)
	
func upgrade_weapon(weapon):
	weapon.upgrade()
	update_weapon_visibility()

func get_total_hp():
	var total_hp = 0
	for weapon in $VBoxContainer.get_children():
		total_hp += weapon.get_hp()
	return total_hp

func reset_weapons():
	for weapon in $VBoxContainer.get_children():
		weapon.reset()

func save_weapons(save_data):
	# TODO think about backward compatibility
	var container = {}
	for weapon in $VBoxContainer.get_children():
		container[weapon.name] = {
			"level": weapon.level
		}
	save_data["weapons"] = container

func load_weapons(save_data):
	var container = save_data["weapons"]
	for weapon in $VBoxContainer.get_children():
		if container.has(weapon.name):
			weapon.level = container[weapon.name]["level"]
		else:
			weapon.level = 0
	update_weapon_visibility()
