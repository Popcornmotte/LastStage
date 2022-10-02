extends Sprite


var fire = false
var s1 = false
var s2 = false
var deploy = false
const explosionShort = preload("res://Sounds/explosionShort.wav")


# Called when the node enters the scene tree for the first time.
func _ready():
	$CapR.rotation_degrees = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if  Input.is_action_just_pressed("fire"):
		if !fire:
			fire = true
			$Stage1.start()
		elif !s1:
			s1 = true
			$Stage1.detach()
			$Stage2.start()
		elif !s2:
			s2 = true
			$Stage2.detach()
		elif !deploy:
			deploy = true
			deploy()
	pass

func deploy():
	$AnimationPlayer.play("DeployPayload")
	Audio.playSfx(explosionShort)
	pass
