extends Button


func _on_pressed() -> void:
	owner.choose_player("Heal")
	get_parent().hide()
