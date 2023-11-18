extends Area2D

func _ready():
	# This makes sure the node processes input events.
	set_process_input(true)

func react_to_click():
	# Logic to make the sprite shrink and then return to normal
	# For example, using an AnimationPlayer:
	var animation_player = get_node("../AnimationPlayer") # Adjust the path as necessary
	# Stop the animation if it's already playing
	animation_player.stop()
	animation_player.play("ShrinkGrow")
	
	var mouse_pos = get_global_mouse_position()
	$CandleParticles2D.global_position = mouse_pos  # Set the Particles2D position
	$CandleParticles2D.emitting = true

func _on_MonsterArea2D_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed) or (event is InputEventScreenTouch and  event.pressed):
		react_to_click()
