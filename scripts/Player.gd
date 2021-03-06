extends KinematicBody

var velocity = Vector3(0,0,0)
const SPEED = 6
const GRAVITY = 0.4
const JUMPFORCE = 14

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
		$JumpSound.play()
	
	if !is_on_floor():
		velocity.y = velocity.y - GRAVITY
	
	move_and_slide(velocity, Vector3.UP)

func _on_Area_body_entered(body):
	get_tree().reload_current_scene()

func _on_Goal_body_entered(body):
	translation.x = -10
