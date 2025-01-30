extends Area2D

@export var speed = 100 #bullet speed
var fireAngle #needs to be global

func _ready() -> void:
	fireAngle = 7 #fire angle will be set with a signal, this is just a test

func _process(delta: float) -> void:
	if (fireAngle == 0): #these check the frame johnny is in and fires a bullet in that direction
		position.y += speed * delta
	
	elif (fireAngle == 1): 
		position.y += speed * delta
		position.x -= speed * delta
	
	elif (fireAngle == 2): 
		position.x -= speed * delta
	
	elif (fireAngle == 3):
		position.y -= speed * delta
		position.x -= speed * delta
	
	elif (fireAngle == 4):
		position.y -= speed * delta
	
	elif (fireAngle == 5):
		position.y -= speed * delta
		position.x += speed * delta
	
	elif (fireAngle == 6):
		position.x += speed * delta
	
	elif (fireAngle == 7): 
		position.y += speed * delta
		position.x += speed * delta
