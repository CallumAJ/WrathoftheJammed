extends CharacterBody2D

#@export var Bullet : PackedScene

var speed = 300.0
var speedFloor = 150
@export var JUMP_VELOCITY := -500.0
@export var DOUBLE_JUMP_VELOCITY := -600
@export var DOUBLEJUMP_MAX := 2
var doubleJump = 0
var airDirection = 1
var fireAngle = 0
@export var MAX_SPEED := 300

signal bullet(pos, fireAngle)

func _ready() -> void:
	position = Vector2 (640, 640)

func _process(delta) -> void:
	if Input.is_action_just_pressed("shoot"):
		bullet.emit($GunBarrel.global_position)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_on_floor():
		doubleJump = DOUBLEJUMP_MAX;
		fireAngle = 0;
		$"GunBarrel".set_rotation_degrees(0)
		speed = MAX_SPEED
		speedFloor = speed /2
	if not is_on_floor() and doubleJump < DOUBLEJUMP_MAX:
		fireAngle = $AnimatedSprite2D.get_frame()
	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept"):
		#shoot()
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	elif  Input.is_action_just_pressed("jump") and not is_on_floor() and doubleJump == DOUBLEJUMP_MAX:
		velocity.y = DOUBLE_JUMP_VELOCITY
		doubleJump -= 1
	elif  Input.is_action_just_pressed("jump") and not is_on_floor() and doubleJump != 0:
		if fireAngle == 0:
			velocity.y = DOUBLE_JUMP_VELOCITY
			$"GunBarrel".set_rotation_degrees(0)
		elif fireAngle == 1:
			velocity.x = DOUBLE_JUMP_VELOCITY * airDirection *-1
			velocity.y = DOUBLE_JUMP_VELOCITY / 2
			$"GunBarrel".set_rotation_degrees(0)
		elif fireAngle == 2:
			velocity.x = DOUBLE_JUMP_VELOCITY * airDirection *-1
			$"GunBarrel".set_rotation_degrees(0)
		elif fireAngle == 3:
			velocity.x = DOUBLE_JUMP_VELOCITY * airDirection *-1
			velocity.y = (DOUBLE_JUMP_VELOCITY * -1) / 2
			$"GunBarrel".set_rotation_degrees(0)
		elif fireAngle == 4:
			velocity.y = DOUBLE_JUMP_VELOCITY * -1
			$"GunBarrel".set_rotation_degrees(180)
		elif fireAngle == 5:
			velocity.x = DOUBLE_JUMP_VELOCITY * (airDirection)
			velocity.y = (DOUBLE_JUMP_VELOCITY * -1) / 2
			$"GunBarrel".set_rotation_degrees(0)
		elif fireAngle == 6:
			velocity.x = DOUBLE_JUMP_VELOCITY * (airDirection)
			$"GunBarrel".set_rotation_degrees(0)
		elif fireAngle == 7:
			velocity.y = DOUBLE_JUMP_VELOCITY /2
			velocity.x = DOUBLE_JUMP_VELOCITY * (airDirection)
			$"GunBarrel".set_rotation_degrees(0)
		if fireAngle > 4:
			airDirection *= -1
			
		if fireAngle % 2 != 0:
			speed = 400
			speedFloor = -200
		elif fireAngle == 2 or fireAngle == 6:
			speed = 600
			speedFloor = -400
		doubleJump -= 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction and doubleJump == DOUBLEJUMP_MAX:
		velocity.x = direction * speed
	elif direction:
		if direction == airDirection:
			velocity.x = direction * speed *1.5
		else:
			velocity.x = direction * speedFloor
	elif is_on_floor():
		velocity.x = move_toward(velocity.x, 0, speed)
	if is_on_floor():
		if direction != 0:
			airDirection = direction
	move_and_slide()
	if velocity.x > 0 and is_on_floor():
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.flip_h = false
	elif velocity.x < 0 and is_on_floor():
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.flip_h = true
	elif airDirection > 0 and not is_on_floor() and doubleJump < DOUBLEJUMP_MAX:
		$AnimatedSprite2D.play("jumpspin")
		$AnimatedSprite2D.flip_h = false
	elif airDirection < 0 and not is_on_floor() and doubleJump < DOUBLEJUMP_MAX:
		$AnimatedSprite2D.play("jumpspin")
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.play("idle")
		
	


func _on_bullet(pos: Variant) -> void:
	pass # Replace with function body.
