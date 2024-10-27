extends Node2D

# for global
signal next_attack
 

# Define the signal with parameters, e.g., `enemy_id` (string)
signal dead_enemy(title: String)

# Function to emit the signal, allowing you to call `emit_dead_enemy` with parameters
func emit_dead_enemy(title: String):
	emit_signal("dead_enemy", title)
