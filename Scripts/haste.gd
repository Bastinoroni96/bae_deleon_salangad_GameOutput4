extends Button


func _on_pressed():
	owner.set_status("Haste")
	owner.pop_out()
	owner.next_attack()
