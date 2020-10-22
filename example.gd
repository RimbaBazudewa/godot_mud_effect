extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var fire_work =preload('res://FireWork.tscn')
var goob = preload('res://Goob.tscn')

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton :
		if event.is_pressed() and event.button_index == BUTTON_LEFT :
			show_goob(Vector2(event.position.x , event.position.y + 50))
			# show_fire_work(event.position)

func show_goob(pos : Vector2)->void :
	var goob_node = goob.instance()
	goob_node.position = pos
	add_child(goob_node)

func show_fire_work(pos : Vector2)-> void :
	var fire_work_node= fire_work.instance()	
	fire_work_node.position = pos
	add_child(fire_work_node)
	
