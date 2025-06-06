extends CharacterBody3D
@onready var navAgent:NavigationAgent3D = $NavigationAgent3D
@onready var shapeCast: ShapeCast3D = $ShapeCast3D
const SPEED = 2
func _physics_process(delta):
	var playerPosition = Global.get("Player")
	navAgent.target_position = playerPosition.global_position
	var dir = (navAgent.get_next_path_position()-global_position).normalized()
	velocity = dir*SPEED
	
	look_at(position+dir*Vector3(1,0,1))
	move_and_slide()
