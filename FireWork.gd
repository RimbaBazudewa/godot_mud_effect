extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var particle= null 
var last_particle_position = Vector2(0,0)
var custom_particle = preload('res://CustomParticle.tscn')
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	particle = get_node('CustomParticle')
	last_particle_position = particle.position
	particle.connect('explosion', self, 'explosion')
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
	# if particle  :
	# 	if particle.velocity.y >= 0 :
	# 		last_particle_position = particle.position
	# 		explosion_particles(last_particle_position)
	# 		particle.queue_free()
#	pass
func explosion()->void :
	last_particle_position = particle.position
	explosion_particles(last_particle_position)
	particle.queue_free()

func explosion_particles(pos: Vector2)-> void :
	var speed = 30
	var count_particles = 70 
	for i in range( 0, count_particles+1):
		var angle =  (i * PI * 2)/ count_particles
		var explosion_particle = custom_particle.instance()
		explosion_particle.position =pos + Vector2(cos(angle), sin(angle)) * get_random_value(20,50);
		explosion_particle.velocity = Vector2(cos(angle)* speed, sin(angle) * speed)
		explosion_particle.velocity *= get_random_value(1,7) 
		explosion_particle.gravity = 2
		add_child(explosion_particle)

	pass
func get_random_value( min_val:float, max_val:float)->float:
	var rndg = RandomNumberGenerator.new()
	rndg.randomize()
	return rndg.randf_range(min_val, max_val)

