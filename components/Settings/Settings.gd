extends Popup

signal new_game()

func _on_NewGameButton_pressed():
	$NewGameConfirmationDialog.visible = true

func _on_CloseButton_pressed():
	visible = false

func _on_NewGameConfirmationDialog_confirmed():
	visible = false
	emit_signal("new_game")
