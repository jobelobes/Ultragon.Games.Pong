extends KinematicBody2D

class_name Ball

export var max_speed = 1000
export var min_speed = 200
export var speed_increment = 10
export var speed = 300
var _velocity = Vector2(0.25, 0.75)
var _rnd = RandomNumberGenerator.new()

func _ready():
	self.reset()

func _physics_process(delta):
	var collision = move_and_collide(self._velocity * speed * delta)
	if collision:
		speed = clamp(speed + speed_increment, min_speed, max_speed)
		self._velocity = self._velocity.bounce(collision.normal).normalized()
		
func reset():
	self.position = self.get_viewport_rect().get_center()
	self._velocity = Vector2(self._rnd.randf_range(-2.0, 2.0), self._rnd.randf_range(-1.0, 1.0)).normalized()
