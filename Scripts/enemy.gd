extends CharacterBody3D
@onready var navAgent:NavigationAgent3D = $NavigationAgent3D
@onready var detectionArea: Area3D = $Area3D
@export var wayPoints:Node3D
var detectableRange = 10
var FOV = 160
var SPEED = 2
var target:Marker3D
func chooseMarker():
	var wps = wayPoints.get_children()
	if target:
		wps.pop_at(wps.find(target))
	target = wps.pick_random()
func _ready() -> void:
	chooseMarker()
func isPlayerVisible():
	var space_state = get_world_3d().direct_space_state
	var origin = global_position
	var vec = Global.Player.global_position-origin
	if vec.length()>detectableRange:
		return false
	var dir = vec.normalized()
	var ang = acos(dir.dot(transform.basis*Vector3.FORWARD))
	if rad_to_deg(ang)>FOV/2:
		return false
	var query = PhysicsRayQueryParameters3D.create(origin, origin+dir*detectableRange)
	query.exclude = [self]
	var result = space_state.intersect_ray(query)
	if result.has("collider"):
		return result.collider==Global.Player
	return false
	
