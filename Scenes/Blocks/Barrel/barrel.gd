extends RigidBody3D

func _init() -> void:
	print("barrel.gd started!")


func action5_released(_pos,_normal,_id,_item): ### this dosent work on the colision shape...
	print("t-press on Barrel!")
