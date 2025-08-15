extends CharacterBody2D

@export var thrust_force := 1000.0
@export var reverse_thrust := 600.0
@export var rotation_speed := 3.0
@export var max_speed := 2000.0

func _physics_process(delta):
	# Rotation
	if Input.is_action_pressed("left"):
		rotation -= rotation_speed * delta
	if Input.is_action_pressed("right"):
		rotation += rotation_speed * delta

	# Thrust forward (W)
	if Input.is_action_pressed("up"):
		var forward = Vector2.RIGHT.rotated(rotation)
		velocity += forward * thrust_force * delta
		%Propulsion1.emitting = true
		%Propulsion2.emitting = true
		%Propulsion3.emitting = true
		%Propulsion4.emitting = true
	# Reverse thrust (S)
	if Input.is_action_pressed("down"):
		var backward = Vector2.RIGHT.rotated(rotation)
		velocity -= backward * reverse_thrust * delta

	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed

	move_and_collide(velocity * delta)

# Called by gravity sources
func apply_gravity_force(force: Vector2):
	velocity += force
