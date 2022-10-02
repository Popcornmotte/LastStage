extends Node


func playSfx(clip : AudioStream):
	for child in $sfx.get_children():
		if child.playing == false:
			child.stream = clip
			child.play()
			break

func playMusic(music : AudioStream):
	$music/musicPlayer.stream = music
	$music/musicPlayer.play()

