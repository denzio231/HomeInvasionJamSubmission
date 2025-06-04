extends Node3D

func _process(delta):
	var playerPosition = Global.get("Player")
	look_at(playerPosition.position)
	#TODO interactions
