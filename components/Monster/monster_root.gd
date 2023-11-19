extends Node2D
signal ui_monster_hit()

export var initial_health: float = 0
export var current_health: float = 0 setget set_current_health, get_current_health
var _current_health: float = 0

func _ready():
	var child = $MonsterSprite/MonsterArea2D


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
