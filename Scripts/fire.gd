extends Button


func _on_pressed() -> void:
	owner.choose_enemy("Fire")
	get_parent().hide()
