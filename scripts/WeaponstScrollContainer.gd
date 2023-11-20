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
	var weapon_idx = 0
	var last_visible_idx = 0
	for weapon in $VBoxContainer.get_children():
		if weapon.level > 0 :
			weapon.visible = true
			last_visible_idx = weapon_idx
		else:
			weapon.visible = false

	weapon_idx = last_visible_idx + 1
	# Make weapon_idx visible
	if weapon_idx < $VBoxContainer.get_child_count():
		$VBoxContainer.get_child(weapon_idx).visible = true

func _on_buy_weapon(weapon):
	emit_signal("buy_clicked", weapon)
	
func upgrade_weapon(weapon):
	weapon.upgrade()
	update_weapon_visibility()
