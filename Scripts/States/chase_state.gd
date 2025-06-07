extends stateNode
@export var waryState:stateNode
@export var searchState:stateNode
var mainNode:CharacterBody3D
var detectorArea:Area3D

func enter(mN):
	mainNode = mN
	mainNode.SPEED = 6
	mainNode.FOV = 360
	detectorArea = mainNode.get_node("Area3D")
func chase(delta):
	mainNode.navAgent.target_position = Global.Player.global_position
	var dir = (mainNode.navAgent.get_next_path_position()-mainNode.global_position).normalized()
	mainNode.velocity = mainNode.velocity.move_toward(dir*mainNode.SPEED,mainNode.SPEED)
	mainNode.look_at(mainNode.position+dir*Vector3(1,0,1))
	mainNode.move_and_slide()
func physicsHandler(delta:float):
	chase(delta)
	var bodies = detectorArea.get_overlapping_bodies()
	var gone = true
	if not mainNode.isPlayerVisible():
		return searchState
