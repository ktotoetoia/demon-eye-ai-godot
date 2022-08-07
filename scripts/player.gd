extends KinematicBody2D


var speed = 500
var jumpforce = 750
var gravity = 30
var hp = 100
var vel = Vector2()

func _physics_process(delta):
	if Input.is_action_pressed("left"):
		vel.x = -speed
	elif Input.is_action_pressed("right"):
		vel.x = +speed
	else: vel.x = 0
	if is_on_floor():
		if Input.is_action_pressed("up"):
			vel.y =-jumpforce
	if !is_on_floor():
		vel.y += gravity
	vel = move_and_slide(vel, Vector2.UP)
