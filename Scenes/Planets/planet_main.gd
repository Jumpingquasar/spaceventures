# GravityBody.gd
extends StaticBody2D

@export var gravity_strength := 50000000.0
var colliding_bodies := {}  # Dictionary used as a set

func _ready():
	$DisabledGravityArea.connect("body_entered", _on_body_entered)
	$DisabledGravityArea.connect("body_exited", _on_body_exited)

func _on_body_entered(body):
	colliding_bodies[body] = true

func _on_body_exited(body):
	colliding_bodies.erase(body)

func _physics_process(delta):
	for target in get_tree().get_nodes_in_group("affected_by_gravity"):
		if not target.has_method("apply_gravity_force"):
			continue

		# Skip if colliding with planet
		if target in colliding_bodies:
			continue

		var dir = target.global_position - global_position
		var dist_squared = dir.length_squared()
		if dist_squared == 0:
			continue

		var force = -dir.normalized() * (gravity_strength / dist_squared) * delta
		target.apply_gravity_force(force)
