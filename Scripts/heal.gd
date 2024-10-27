extends Button


func _on_pressed() -> void:
	owner.choose_player()
	get_parent().hide()
