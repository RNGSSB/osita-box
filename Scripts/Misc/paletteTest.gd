@tool
extends Sprite2D


func setPalette(color1 : Color, color2 : Color, color3 : Color, 
color4 : Color, color5 : Color, 
color6 : Color, color7 : Color, color8 : Color,  
color9 : Color, color10 : Color, color11 : Color):
	get_material().set_shader_parameter("target_color", Vector4(color1.r, color1.g, color1.b, color1.a))
	get_material().set_shader_parameter("target_color2", Vector4(color2.r, color2.g, color2.b, color2.a))
	get_material().set_shader_parameter("target_color3", Vector4(color3.r, color3.g, color3.b, color3.a))
	get_material().set_shader_parameter("target_color4", Vector4(color4.r, color4.g, color4.b, color4.a))
	get_material().set_shader_parameter("target_color5", Vector4(color5.r, color5.g, color5.b, color5.a))
	get_material().set_shader_parameter("target_color6", Vector4(color6.r, color6.g, color6.b, color6.a))
	get_material().set_shader_parameter("target_color7", Vector4(color7.r, color7.g, color7.b, color7.a))
	get_material().set_shader_parameter("target_color8", Vector4(color8.r, color8.g, color8.b, color8.a))
	get_material().set_shader_parameter("target_color9", Vector4(color9.r, color9.g, color9.b, color9.a))
	get_material().set_shader_parameter("target_color10", Vector4(color10.r, color10.g, color10.b, color10.a))
	get_material().set_shader_parameter("target_color11", Vector4(color11.r, color11.g, color11.b, color11.a))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !Engine.is_editor_hint():
		self.queue_free()


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	setPalette(owner.glove_color_main, owner.glove_color_socket, owner.shirt_color_main, owner.shirt_color_bottom, owner.pant_color_main, owner.pant_color_lines, owner.shirt_color_shading, owner.pant_color_shading, owner.glove_color_shading, owner.glove_color_inner, owner.glove_color_socket_shading,)
