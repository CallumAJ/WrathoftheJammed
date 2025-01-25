extends Node2D

var bulletScene: PackedScene = load("res://scenes/bullet.tscn")

func _on_player_bullet(pos) -> void:
	var bullet = bulletScene.instantiate()
	$bullets.add_child(bullet)
	bullet.position = pos
	
