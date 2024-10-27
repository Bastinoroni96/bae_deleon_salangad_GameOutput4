extends Sprite2D

@export var character : Character

var health_bar : ProgressBar

func _ready():
	if character:
		character.node = self
		texture = character.fight
		health_bar = get_node("HealthBar")  # Assuming HealthBar is a child node
		if health_bar:
			health_bar.max_value = character.max_health 
			health_bar.value = character.health
		else:
			print("HealthBar node not found. Check the node hierarchy.")
