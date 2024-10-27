extends Button




func _on_pressed() -> void:
	owner.choose_player("Shield")
	get_parent().hide()
