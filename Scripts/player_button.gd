extends Button

@export var character : Character:
	set(value):
		character = value
		text = value.title


func _on_pressed():
	var currAction = get_parent().action
	character.set_status(currAction)
	get_parent().hide()
	get_parent().owner.update_announcement(text,currAction)
	get_parent().owner.pop_out()
	get_parent().owner.next_attack()
