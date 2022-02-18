extends KinematicBody

var velocity = Vector3(0,0,0)
const SPEED = 6
const ROTSPEED = 10
const GRAVITY = 0.2
const JUMPFORCE = 8
var debug_mode

func _physics_process(delta):
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
		velocity.x = 0
	elif Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$Spatial.rotation_degrees.y = 0
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$Spatial.rotation_degrees.y = 180
	else:
		velocity.x = lerp(velocity.x,0,0.1)
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMPFORCE
	
	velocity.y = velocity.y - GRAVITY
	
	move_and_slide(velocity, Vector3.UP)

func _on_Area_body_entered(body):
	get_tree().reload_current_scene()

func _on_Goal_body_entered(body):
	debug_mode = true
	translation.x = -10

# DEBUG MODE STUFF
var mouse_sens = 0.3
var camera_anglev=0

func _input(event):         
	if event is InputEventMouseMotion and debug_mode:
		$InterpolatedCamera.rotate_y(deg2rad(-event.relative.x*mouse_sens))
		var changev=-event.relative.y*mouse_sens
		if camera_anglev+changev>-50 and camera_anglev+changev<50:
			camera_anglev+=changev
			$InterpolatedCamera.rotate_x(deg2rad(changev))
	if Input.is_action_pressed("debug_up") and debug_mode:
		$InterpolatedCamera.translation.z -= 1
	if Input.is_action_pressed("debug_down") and debug_mode:
		$InterpolatedCamera.translation.z += 1
	if Input.is_action_pressed("debug_left") and debug_mode:
		$InterpolatedCamera.translation.x -= 1
	if Input.is_action_pressed("debug_right") and debug_mode:
		$InterpolatedCamera.translation.x += 1
