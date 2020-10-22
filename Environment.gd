extends Node2D 


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var canvas_layer =get_node("CanvasLayer")
	var viewport_filter = get_node('ViewportContainer/Viewport2')
	print(viewport_filter)
	canvas_layer.custom_viewport = viewport_filter
	canvas_layer.get_node('filter_viewport').visible = true
	pass # Replace with function body.




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
