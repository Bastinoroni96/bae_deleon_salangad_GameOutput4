extends Button


func _on_pressed():
	get_parent().owner.update_announcement("Self","Haste")
	owner.set_status("Haste")
	owner.pop_out()
	owner.next_attack()
