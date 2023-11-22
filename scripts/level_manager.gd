extends Node

export var level_names = [
	"Candyland Meadows", # 001
	"Candyland Valley", # 002
	"Caramel Peaks", # 003
	"Minty Mountains", # 004
	"Gummy Square", # 005
	"Jellybean Square", # 006
	"Sugar Town", # 007
	"Chocolate Bridge", # 008
	"Cloud Nine", # 009
	"Cloud Ten", # 010
	"Caramel Volcano", # 011
	"Chocolate Volcano", # 012
	"Water Taffy Lake", # 013
	"Sky High", # 014
	"Dark Chocolate Volcano", # 015
	"Dark Chocolate Lava", # 016
	"Green Forest", # 017
	"Red Forest", # 018
	"Candy Cave", # 019
	"Treasure Cave", # 020
	"Marshmallow Cluod Kingdom", # 021
	"Marshmallow Clouds", # 022
	"Frosted Cookie Cottage", # 023
	"Frosted Cookie Village", # 024
	"Licorice Labyrinth", # 025
	"Fizzy Soda Lake", # 026
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
	var health: float = 10
	for _i in range(level):
		health *= 2
	return health

func get_monster_reward(level):
	var reward: float = 10
	for _i in range(level):
		reward *= 3
	return reward

func get_monster_texture(level, monster):
	var idx = (level * monsters_per_level + monster) % monster_images.size()
	return monster_images[idx]

