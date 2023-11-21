extends Control

signal prev_level
signal next_level

func _on_PrevButton_pressed():
	emit_signal("prev_level")

func _on_NextButton_pressed():
	emit_signal("next_level")

func enable_buttons(prev, next):
	$MainPanel/PrevButton.disabled = !prev
	$MainPanel/NextButton.disabled = !next

func set_level(index, name):
	$MainPanel/LevelNameLabel.text = name
	$MainPanel/LevelIndexLabel.text = str(index)
