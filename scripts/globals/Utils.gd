extends Node

func get_layer(layers: Array[int]):
	var value: int = 0
	for layer in layers:
		value += int(pow(2, layer - 1))
	return value
