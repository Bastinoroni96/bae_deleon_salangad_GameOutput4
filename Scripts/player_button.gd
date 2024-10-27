extends Button

@export var character : Character:
	set(value):
		character = value
		text = value.title

func _on_pressed():

	character.set_status("Heal")
	get_parent().hide()
	get_parent().owner.update_announcement(text,"Heal")
	get_parent().owner.pop_out()
	get_parent().owner.next_attack()
