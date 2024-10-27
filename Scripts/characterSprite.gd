extends Sprite2D

@export var character : Character

var health_bar : ProgressBar
var shield_icon : Sprite2D

const emptySlot =  preload("res://Assets/VFX/emptySlot.png")
const occupiedSlot = preload("res://Assets/VFX/occupiedSlot.png")
var slot_list : Array[Sprite2D]

func _ready():
	if character:
		character.node = self
		texture = character.fight
		
		#assumes character has HealthBar
		health_bar = get_node("HealthBar")
		var health = character.health
		health_bar.max_value = character.max_health 
		updateHealth(health)
		
		#for shield icon
		if character.CharacterType == 'Player':
			shield_icon = get_node("Shield")
		
		#for the king (boss)
		if character.title == 'King':
			for i in range(1,6):
				slot_list.append(get_child(i))
				
				
func updateHealth(health):
		health_bar.value = character.health
		#else:
			#print("HealthBar node not found. Check the node hierarchy.")
func showShield():
	shield_icon.show()
func hideShield():
	shield_icon.hide()
	
# for the king (boss)
func occupySlot(i):
	slot_list[i].texture = occupiedSlot
	
func emptyASlot(i):
	slot_list[i].texture = emptySlot

func openMenu(word):
	$"../../UI/Panel".show()
	$"../../UI/Panel/Label".text = word
