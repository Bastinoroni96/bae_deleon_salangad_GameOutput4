extends Button




func _on_pressed():
	owner.set_status("slash")
	owner.pop_out()
	owner.next_attack()
