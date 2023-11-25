extends Popup

signal new_game()

onready var VersionLabel = $Panel/VBoxContainer/VersionLabel

func _ready():
	var app_version = ProjectSettings.get("application/config/version")
	VersionLabel.text = "Version: " + app_version


func _on_NewGameButton_pressed():
	$NewGameConfirmationDialog.visible = true

func _on_CloseButton_pressed():
	visible = false

func _on_NewGameConfirmationDialog_confirmed():
	visible = false
	emit_signal("new_game")
