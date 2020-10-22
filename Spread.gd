extends Node2D


var angle = 0
# var speed  = 10
var time = 2
var t =0
var decrement_time= 0
var max_distance = 10 
var target_position = Vector2(0,0)
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var spread =null 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spread =load('res://Spread.tscn') 
	target_position = direction_calulate(angle) * max_distance + self.position 
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if time <=0 :
		return 
	self.position =  self.position.linear_interpolate(target_position, delta* time)
	if self.position != target_position :
		show_spread(angle, time- decrement_time , decrement_time, max_distance )
		set_process(false)
	# move_spread(angle, speed , delta)
	# speed -= delta * decrement_speed
	# if speed <= 0 :
		# set_process(false)
	
func move_spread(angle: float , speed :float , delta : float )-> void : 
	var moving = direction_calulate(angle)  * speed * delta
	self.position +=  moving 

#angle in radian 
func direction_calulate(angle :float)->Vector2 :
	var x = cos(angle)
	var y = sin(angle)

	return Vector2(x, y)
func show_spread(angle:float , time :float , decrement_time:float , max_distance:float)->void :
	var new_spread = spread.instance()
	new_spread.angle = angle
	new_spread.time = time
	new_spread.decrement_time =decrement_time
	new_spread.max_distance  = max_distance
	new_spread.position = self.position
	get_parent().add_child(new_spread)
