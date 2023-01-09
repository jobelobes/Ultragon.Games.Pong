extends KinematicBody2D

class_name Ball

export var max_speed = 1000
export var min_speed = 200
export var speed_increment = 10
export var speed = 300
var velocity = Vector2(0.25, 0.75)

func _ready():
	var rnd = RandomNumberGenerator.new()
	velocity = Vector2(rnd.randf(), rnd.randf()).normalized()

func _physics_process(delta):
	var collision = move_and_collide(velocity * speed * delta)
	if collision:
		speed = clamp(speed + speed_increment, min_speed, max_speed)
		velocity = velocity.bounce(collision.normal).normalized()
