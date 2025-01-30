extends Node2D

var bulletScene: PackedScene = load("res://scenes/bullet.tscn")

func _on_player_player_death() -> void:
	get_tree().reload_current_scene()

func _on_player_bullet(pos) -> void:
	var bullet = bulletScene.instantiate() #supposed to make a bullet (doesnt)
	$Bullets.add_child(bullet)
	bullet.position = pos
