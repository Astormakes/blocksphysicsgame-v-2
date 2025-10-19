extends Node3D

@onready var new_grid_label = $CameraPivot/Camera3D/Control/GrayBackground/Label

var current_grid: Node3D = null

func _ready():
	
	new_grid_label.gui_input.connect(_on_label_input)
	new_grid_label.mouse_filter = Control.MOUSE_FILTER_STOP

func _on_label_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		_create_new_grid()

func _create_new_grid():
	# Remove any existing grid
	if current_grid:
		current_grid.queue_free()
		current_grid = null

	# Create new grid
	var grid_scene = preload("res://Scenes/Grid/Grid.tscn")
	current_grid = grid_scene.instantiate()
	add_child(current_grid)

	print("Created new grid: ", current_grid.name)
