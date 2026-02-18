extends TextureProgressBar


@export var level0 : CompressedTexture2D
@export var level1 : CompressedTexture2D
@export var level2 : CompressedTexture2D
@export var level3 : CompressedTexture2D
@export var levelBurn : CompressedTexture2D


func setTexture(value):
	match value:
		0:
			texture_progress = level0
		1:
			texture_progress = level1
		2:
			texture_progress = level2
		3:
			texture_progress = level3
		4:
			texture_progress = levelBurn
