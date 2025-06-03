extends CharacterBody3D


const SPEED = 5.0
var sens = 0.3
func _input(event):
	if event is InputEventMouseMotion:
		$Camera3D.rotation_degrees.x -= event.relative.y*sens
		rotation_degrees.y -= event.relative.x*sens
		$Camera3D.rotation_degrees.x = clamp($Camera3D.rotation_degrees.x,-90,90)
	elif event.is_action_pressed("FOCUS"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif event.is_action_pressed("ui_cancel"):
		get_tree().quit()
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
var RAY_LENGTH = 10000
func _physics_process(delta: float) -> void:
	var space_state = get_world_3d().direct_space_state
	var cam = $Camera3D
	var pos = get_viewport().get_visible_rect().size/2
	var origin = cam.project_ray_origin(pos)
	var end = origin + cam.project_ray_normal(pos) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true
	var result = space_state.intersect_ray(query)
	if result.has("collider"):
		print(result.collider)
	if not is_on_floor():
		velocity += get_gravity() * delta
	var input_dir := Input.get_vector("LEFT","RIGHT","UP","DOWN")
	var direction := (global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()
