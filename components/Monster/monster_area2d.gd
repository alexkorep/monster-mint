extends Area2D

func _ready():
	set_process_input(true)

func react_to_click():
	var animation_player = get_node("../AnimationPlayer") # Adjust the path as necessary
	animation_player.stop()
	animation_player.play("ShrinkGrow")	
	var mouse_pos = get_global_mouse_position()
	$CandleParticles2D.global_position = mouse_pos  # Set the Particles2D position
	$CandleParticles2D.emitting = true
	$"../../".on_ui_monster_hit()

func _on_MonsterArea2D_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed) or (event is InputEventScreenTouch and  event.pressed):
		react_to_click()
