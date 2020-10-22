extends RigidBody2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
export(int) var count = 5
var spread = preload('res://Spread.tscn')
var partcle =preload('res://particle.tscn') 
var custom_particle = preload('res://CustomParticle.tscn')
#
var contact_position = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.connect('body_entered', self, 'collision_object')


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	if state.get_contact_count() >= 1 :
		contact_position = state.get_contact_local_position(0)

func collision_object(body : Node2D)-> void :
	#spread object
	# spread_object(count)
	explosion_particles()
	self.queue_free()
func explosion_particles()-> void :
	var speed = 20
	var count_particles = 30 
	var center_explotion = custom_particle.instance()
	center_explotion.position = contact_position
	center_explotion.velocity =Vector2(0,0)
	center_explotion.duration = 0
	center_explotion.gravity =0
	get_parent().add_child(center_explotion)
	for i in range( 0, count_particles+1):
		var angle =  (i * PI * 2)/ count_particles
		var explosion_particle = custom_particle.instance()
		explosion_particle.position =contact_position + Vector2(cos(angle), sin(angle)) * get_random_value(0,20);
		explosion_particle.velocity = Vector2(cos(angle)* speed, sin(angle) * speed)
		explosion_particle.velocity *= get_random_value(1,6) 
		explosion_particle.duration = get_random_value(0.2, 1.0)
		explosion_particle.gravity = 2
		get_parent().add_child(explosion_particle)

	pass
func spread_object(count_object : int)->void : 
	var particle_node = partcle.instance()
	particle_node.position =contact_position 
	particle_node.get_node('splash').emitting = true
	particle_node.get_node('explosive').emitting =true
	get_parent().add_child(particle_node)
	var center_spread = spread.instance()
	center_spread.self_modulate= Color.yellow
	center_spread.position = contact_position
	center_spread.time = 0
	get_parent().add_child(center_spread)
	var count_spread = 15
	for i in range(0, count_spread+ 1) : 
		var rad_angle = (    i *  PI   / count_spread  )
		var node_spread_left = spread.instance()
		node_spread_left.position = contact_position
		node_spread_left.angle = rad_angle
		node_spread_left.time =15
		node_spread_left.decrement_time= get_random_value(0.5, 0.9)
		get_parent().add_child(node_spread_left)
	pass
#angle is return in degres
func get_angle_range(angle_from:float , angle_to:float , count : int, loop_index :int)-> float :
	return deg2rad(angle_from + loop_index* (angle_to - angle_from )/ count - 90 ) 

func get_random_value( min_val:float, max_val:float)->float:
	var rndg = RandomNumberGenerator.new()
	rndg.randomize()
	return rndg.randf_range(min_val, max_val)
