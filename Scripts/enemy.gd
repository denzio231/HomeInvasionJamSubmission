extends CharacterBody3D
@onready var navAgent:NavigationAgent3D = $NavigationAgent3D
const SPEED = 2
var stun = false
func deal_damage():
	stun = true
	get_tree().create_timer(10).connect("timeout",func(): stun=false)
func _physics_process(delta):
	var playerPosition = Global.get("Player")
	navAgent.target_position = playerPosition.global_position
	var dir = (navAgent.get_next_path_position()-global_position).normalized()
	if stun:
		velocity = Vector3.ZERO
	else:
		velocity = dir*SPEED
	look_at(position+dir*Vector3(1,0,1))
	move_and_slide()
