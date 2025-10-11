extends Node

var player

var fruits := 0 : 
	set(val):
		fruits = val
		if player != null:
			player.updateUiFruits()
			$AudioStreamPlayer.play()
