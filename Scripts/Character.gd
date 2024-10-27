extends Resource
class_name Character

@export var title : String
@export var CharacterType : String
@export var icon : Texture2D
@export var fight : Texture2D
@export var attacking : Texture2D
@export var dead : Texture2D
@export var agility : int:
	set(value):
		agility = value
		speed = 200.0 / (log(agility) + 2) - 25
		queue_reset()
@export var health : int
@export var max_health : int = 100  # Set the maximum health
@export var mana : int
@export var stamina : int

@export var vfx_node : PackedScene = preload("res://Scenes/vfx.tscn")
var speed: float
var queue : Array[float]
var status = 1
var node

func queue_reset():
	queue.clear()
	for i in range(4):
		if queue.size() == 0:
			queue.append(speed * status)
		else:
			queue.append(queue[-1] + speed * status)
#
#
func tween_movement(shift, tree):
	var tween = tree.create_tween()
	tween.tween_property(node, "position", node.position + shift, 0.2)
	await tween.finished
#
#
func attack(tree):
	var shift = Vector2()
	if CharacterType == "Enemy":
		shift = Vector2(-30,0)
	else:
		shift = Vector2(30,0)
	node.texture = icon
	if node.position.x < node.get_viewport_rect().size.x/2:
		shift = -shift
	
	await tween_movement(-shift, tree)
	await tween_movement(shift, tree)
	node.texture = fight
	EventBus.next_attack.emit()
#
#
func pop_out():
	queue.pop_front()
	queue.append(queue[-1] + speed * status)
#
#
func add_vfx(type : String = ""):
	var vfx = vfx_node.instantiate()
	node.add_child(vfx)
	if type == "":
		return
	vfx.find_child("AnimationPlayer").play(type)
#
#
func get_attacked(type = ""):
	if type == "Slash":
		#deal damage between 10 to 20
		var SlashDamage = 10 + randi() % 11
		health -= SlashDamage
	
	if (health <= 0) and (CharacterType == 'Player'):
		print('end game')
		node.texture = dead
	elif (health <= 0) and (CharacterType == 'Enemy'):
		print('killed enemy')
		
	node.updateHealth(health)
	add_vfx(type)
	
#
#
func set_status(status_type : String):
	add_vfx(status_type)
	match status_type:
		"Haste":
			status = 0.5
		"Slow":
			status = 2
		"Heal":
			health += 20
			node.updateHealth(health)
	
	#print(queue)
	#for i in range(3):
		#queue.pop_back()
	#print(queue)
	#
	#for i in range(3):
		#queue.append(queue[-1] + speed * status)
	#print(queue)
