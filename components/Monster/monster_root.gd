extends Node2D
signal ui_monster_hit()

export var initial_health: float = 0
export var current_health: float = 0

func _ready():
	var child = $MonsterSprite/MonsterArea2D
#	child.connect("ui_monster_hit", self, "_on_ui_monster_hit")

func on_ui_monster_hit():
	emit_signal("ui_monster_hit")

func set_texture(texture):
	$MonsterSprite.texture = texture
