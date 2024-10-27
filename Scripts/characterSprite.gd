extends Sprite2D

@export var character : Character

var health_bar : ProgressBar

func _ready():
	if character:
		character.node = self
		texture = character.fight
		
		#assumes character has HealthBar
		health_bar = get_node("HealthBar")
		var health = character.health
		health_bar.max_value = character.max_health 
		updateHealth(health)
		
func updateHealth(health):
		health_bar.value = character.health
		#else:
			#print("HealthBar node not found. Check the node hierarchy.")
