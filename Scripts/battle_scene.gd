extends Node2D

@export var player_group : Node2D
@export var enemy_group : Node2D
@export var timeline : HBoxContainer
#
@export var options : VBoxContainer
@export var enemy_button : PackedScene
#
#
@export var player_button : PackedScene
#
var sorted_array = []
var players : Array[Character]
var enemies : Array[Character]

# notes for damages ====
# slash == 10-20 (also for enemies)

func _ready():
	for player in player_group.get_children():
		players.append(player.character)
		
		var PlayerButton = player_button.instantiate()
		PlayerButton.character = player.character
		%PlayerSelction.add_child(PlayerButton)
	#
	for enemy in enemy_group.get_children():
		enemies.append(enemy.character)
		#
		var button = enemy_button.instantiate()
		button.character = enemy.character
		%EnemySelection.add_child(button)
	#
	sort_and_display()
	EventBus.next_attack.connect(next_attack)
	
	EventBus.connect("dead_enemy", Callable(self, "dead_enemy"))

	#
	next_attack()
#
func sort_combined_queue():
	var player_array = []
	for player in players:
		for i in player.queue:
			player_array.append({"character" : player, "time": i})
	
	var enemy_array = []
	for enemy in enemies:
		for i in enemy.queue:
			enemy_array.append({"character" : enemy, "time": i})
	#
	sorted_array = player_array
	sorted_array.append_array(enemy_array)
	sorted_array.sort_custom(sort_by_time)
	#
#
func sort_by_time(a,b):
	return a["time"] < b["time"]
#
#
func update_timeline():
	var index : int = 0
	for slot in timeline.get_children():
		
		slot.find_child("TextureRect").texture = sorted_array[index]["character"].icon
		index += 1
#
#
func sort_and_display():
	sort_combined_queue()
	update_timeline()
	if sorted_array[0]["character"] in players:
		show_options()
#
#
func pop_out():
	sorted_array[0]["character"].pop_out()
	sort_and_display()
#
#
func attack():
	sorted_array[0]["character"].attack(get_tree())
#
#
func next_attack():
	if sorted_array[0]["character"] in players:
		return
	var playerHit = players.pick_random()
	update_announcement(playerHit.title)
	sorted_array[0]["character"].updateCooldown("")
	
#	special attack
	if (sorted_array[0]["character"].title == "King"):
		if (sorted_array[0]["character"].cooldown == 0):
			for player in players:
				player.get_attacked("Doom")
			sorted_array[0]["character"].resetMoon()
			sorted_array[0]["character"].updateCooldown("Doom")
		else:
			playerHit.get_attacked("Slash")
			sorted_array[0]["character"].updateMoon()
	else:
		playerHit.get_attacked("Slash")
	attack()
	pop_out()
	
	
#
func set_status(status_type):
	sorted_array[0]["character"].set_status(status_type)
	sort_and_display()
#
#
func show_options():
	options.show()
	var currentPlayer = sorted_array[0]["character"]
	if currentPlayer.title == 'Red':
		options.get_child(3).hide()
		options.get_child(4).show()
		if currentPlayer.cooldown > 0:
			options.get_child(4).disabled = true
		else:
			options.get_child(4).disabled = false
			
	#if Blue
	else:
		options.get_child(4).hide()
		#Show Fire
		options.get_child(3).show()
		if currentPlayer.cooldown > 0:
			options.get_child(3).disabled = true
		else:
			options.get_child(3).disabled = false
		#options.get_child(3).disabled = true
	options.get_child(0).grab_focus()
#
func choose_enemy(action):
	sorted_array[0]["character"].updateCooldown(action)
	%EnemySelection.UpdateAction(action)
	%EnemySelection.show()
	%EnemySelection.get_child(0).grab_focus()

func choose_player(action):
	sorted_array[0]["character"].updateCooldown(action) 
	%PlayerSelction.UpdateAction(action)
	%PlayerSelction.show()
	%PlayerSelction.get_child(0).grab_focus()


func update_announcement(defender, type : String = ""):
	var attacker = sorted_array[0]["character"].title
	if (type == "Haste"):
		%Announcement.text = str(attacker) + " cast Haste on himself "
	elif (type == "Heal"):
		%Announcement.text = str(attacker) + " healed " + str(defender)
	elif (type == "Fire"):
		%Announcement.text = str(attacker) + " burned " + str(defender)
	elif (type == "Shield"):
		%Announcement.text = str(attacker) + " protected " + str(defender)
	else:
		%Announcement.text = str(attacker) + " attacked " + str(defender)

func dead_enemy(title: String):
	#print(enemy_group.get_children())
	#for enemySelect in %EnemySelection.get_children():
		#enemySelect.queue_free()
		
	for i in (enemy_group.get_children().size()):
		if (enemy_group.get_children()[i]["character"].title) == title:
			enemies.remove_at(i)
			#enemy_group.remove_at(i)
			enemy_group.get_children()[i].queue_free()
			%EnemySelection.get_children()[i].queue_free()
			#enemy.queue_free()
			#enemies.remove_at(i)
		
	#for enemy in enemy_group.get_children():
		#print(enemy)
		#var button = enemy_button.instantiate()
		#button.character = enemy.character
		#%EnemySelection.add_child(button)
	#await get_tree().create_timer(.1).timeout
	#print(enemies)
	#print(enemy_group.get_children().size())
	#await (get_tree(), "idle_frame")
	await get_tree().create_timer(.1).timeout

	#print(enemy_group.get_children())
	#for enemy in enemy_group.get_children():
		#print(enemy_group)
	#print(enemies.)
			
		#print(enemy["character"].title)
		
		#
		#var button = enemy_button.instantiate()
		#button.character = enemy.character
		#%EnemySelection.add_child(button)
	#print(enemy_group)
	sort_and_display()
