extends CharacterBody3D
@onready var navAgent:NavigationAgent3D = $NavigationAgent3D
@onready var detectionArea: Area3D = $Area3D
@export var wayPoints:Node3D
const SPEED = 2
var target:Marker3D
func chooseMarker():
	var wps = wayPoints.get_children()
	if target:
		wps.pop_at(wps.find(target))
	target = wps.pick_random()
func _ready() -> void:
	chooseMarker()
func _physics_process(delta):
	#var playerPosition = target
	if not target:
		return
	print((target.global_position-global_position).length())
	if (target.global_position-global_position).length()<1:
		chooseMarker()
	navAgent.target_position = target.global_position
	var dir = (navAgent.get_next_path_position()-global_position).normalized()
	velocity = dir*SPEED
	look_at(position+dir*Vector3(1,0,1))
	move_and_slide()
