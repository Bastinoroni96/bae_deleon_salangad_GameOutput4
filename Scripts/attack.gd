extends Button


func _on_pressed() -> void:
	owner.choose_enemy("Slash")
	get_parent().hide()
