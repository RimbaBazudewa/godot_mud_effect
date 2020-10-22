extends Area2D

signal explosion

export(Vector2) var accelaration 
export(Vector2) var velocity 
export (float) var duration = 0.5
var is_collision = false
var is_stop = false
var time = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.connect('body_entered', self, 'colision_particle');
	self.connect('body_exited', self, 'exit_colision_particle')
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var percent =1 
	if not is_collision and not is_stop :
		apply_force(Vector2(0,gravity))
		velocity  +=  accelaration


	elif is_collision and not is_stop :
		percent = 0.1	
		apply_force(Vector2(0, gravity * percent))
		velocity += accelaration*  percent

	else :
		velocity = Vector2(0,0);
	if  is_stop or is_collision :
		if(time >= duration ): 
			velocity *=0	
		time += delta	
	position += velocity* percent * delta
	accelaration *= 0
	
func apply_force(force :Vector2)->void :
	self.accelaration += force

func colision_particle (body :Node2D)-> void :
	is_collision = true	
	emit_signal('explosion')
func exit_colision_particle(body : Node2D)->void :
	if is_collision  :
		is_stop =true	
