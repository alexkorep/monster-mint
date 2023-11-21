extends Node

export var level_names = [
	"Candyland Meadows",
	"Sugary Peaks",
	"Minty Forest",
	"Gummy Grotto",
	"Lollipop Lake",
	"Chocolate Canyon",
	"Jellybean Jungle",
	"Marshmallow Marsh",
	"Caramel Castle",
	"Toffee Tunnels",
]

# Declare array of textures for level backgrounds
export var level_images: Array = []
export var monster_images: Array = []
export var monsters_per_level = 10
	
func get_level_background_texture(level):
	var idx = level % level_images.size()
	return level_images[idx]

func get_level_name(level):
	var idx = level % level_names.size()
	return level_names[idx]

func get_monster_health(level):
	return 10 + level * 2

func get_monster_texture(level, monster):
	var idx = (level * monsters_per_level + monster) % monster_images.size()
	return monster_images[idx]

