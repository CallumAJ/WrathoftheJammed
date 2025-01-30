extends Area2D

@export var speed = 600 #bullet speed

func _process(delta: float) -> void:
	position.y -= speed * delta #fires the bullet up at the given speed
	print("pew") #confirmation this got called
