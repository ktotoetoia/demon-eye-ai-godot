extends KinematicBody2D

var vel = Vector2()

var player_pos = Vector2(0,0)
var look_at_player = true
var speed = 200
var rayc = 0
var rtspd = .01
var damage = 25

var focus = false
var focus2 = false

onready var player = find_parent("game").find_node("player")

func  _physics_process(delta):
	vel = move_and_slide(vel)
	if !focus and !focus2:
		speed = 200
		rtspd = .04
	LookAtPlayer()
	Move()
func LookAtPlayer():
	if look_at_player==true:
		player_pos = player.global_position
	var pll = player_pos - global_position
	var angle = pll.angle()
	var glr = global_rotation
	global_rotation = lerp_angle(glr,angle,rtspd)
func Move():
	vel = global_position.direction_to($move.global_position) * speed
	if $rc.is_colliding():
		scale *= -1
		rayc +=1
		if rayc >2:
			$Timer.start()
	if rayc == 0:
		rtspd = .01
	if rayc > 1:
		rtspd = .03
	if rayc > 3:
		rtspd = .06
	if rayc >6:
		rtspd = .01
		rayc = 0

func _on_nma_body_entered(body):
	if body == player:
		look_at_player = false
func _on_nma_body_exited(body):
	if body == player:
		look_at_player = true

func _on_Timer_timeout():
	rayc = 0

func _on_Area2D_body_exited(body):
	if body == player:
		focus = true
func _on_Area2D_body_entered(body):
	if body == player:
		focus = false

func _on_area_body_entered(body):
	if body == player:
		focus = false
func _on_area_body_exited(body):
	if body == player:
		focus = true

func _on_hit_body_entered(body):
	if body == player:
		if "hp" in body:
			body.hp -=  int(rand_range(damage -5,damage +5))
