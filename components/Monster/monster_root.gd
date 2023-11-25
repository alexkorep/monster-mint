extends Control
signal ui_monster_hit()

export var initial_health: float = 0
export var current_health: float = 0 setget set_current_health, get_current_health
var _current_health: float = 0
var health_restore_per_second_percent: float = 0.1


func _process(delta):
	var new_health = (_current_health + 
		initial_health*delta*health_restore_per_second_percent)
	if new_health > initial_health:
		new_health = initial_health
	if _current_health != new_health:
		set_current_health(new_health)

func on_ui_monster_hit():
	emit_signal("ui_monster_hit")

func set_texture(texture):
	$MonsterSprite.texture = texture
	
func set_current_health(val):
	$ProgressBar.max_value = initial_health
	$ProgressBar.value = val
	_current_health = val
	
func get_current_health():
	return _current_health
