extends CharacterBody3D

const SPEED = 5.0
var sens = 0.3
var currentHover:StaticBody3D = null
var canMove = true
func _input(event):
	if canMove:
		if event is InputEventMouseMotion:
			$Camera3D.rotation_degrees.x -= event.relative.y*sens
			rotation_degrees.y -= event.relative.x*sens
			$Camera3D.rotation_degrees.x = clamp($Camera3D.rotation_degrees.x,-90,90)
		elif event.is_action_pressed("INTERACT"):
			if currentHover: currentHover.onInteract(self)
		elif event.is_action_pressed("FOCUS"):
			if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			else:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
func showText(text):
	$CanvasLayer/RichTextLabel.text = text
	$CanvasLayer/RichTextLabel.show()
func hideText():
	$CanvasLayer/RichTextLabel.text = ""
	$CanvasLayer/RichTextLabel.hide()
var RAY_LENGTH = 4
func _physics_process(delta: float) -> void:
	var space_state = get_world_3d().direct_space_state
	var cam = $Camera3D
	var pos = get_viewport().get_visible_rect().size/2
	var origin = cam.project_ray_origin(pos)
	var end = origin + cam.project_ray_normal(pos) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true
	var result = space_state.intersect_ray(query)
	var noSelection = true
	Global.Player = self
	if result.has("collider") and canMove:
			var res:Node3D = result.collider
			if res.is_in_group("interactable"):
				noSelection = false
				if res != currentHover:
					currentHover = res
					showText(currentHover.mess())
	if noSelection and currentHover:
		hideText()
		currentHover = null
	if not is_on_floor():
		velocity += get_gravity() * delta
	var input_dir := Vector2.ZERO
	if canMove:
		input_dir = Input.get_vector("LEFT","RIGHT","UP","DOWN")
	var direction := (global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()
