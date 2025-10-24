shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

uniform vec4 find_color : source_color;
uniform vec4 find_color2 : source_color;
uniform vec4 find_color3 : source_color;
uniform vec4 find_color4 : source_color;
uniform vec4 find_color5 : source_color;
uniform vec4 find_color6 : source_color;
uniform vec4 find_color7 : source_color;
uniform vec4 find_color8 : source_color;
uniform vec4 find_color9 : source_color;
uniform vec4 find_color10 : source_color;
uniform vec4 find_color11 : source_color;
uniform vec4 separator : source_color;
uniform vec4 target_color : source_color;
uniform vec4 target_color2 : source_color;
uniform vec4 target_color3 : source_color;
uniform vec4 target_color4 : source_color;
uniform vec4 target_color5 : source_color;
uniform vec4 target_color6 : source_color;
uniform vec4 target_color7 : source_color;
uniform vec4 target_color8 : source_color;
uniform vec4 target_color9 : source_color;
uniform vec4 target_color10 : source_color;
uniform vec4 target_color11 : source_color;


void fragment() {
	vec4 pixel_color = texture(TEXTURE, UV);
	if(length(pixel_color.rgb - find_color.rgb) < 0.01){
		COLOR.rgb= target_color.rgb;
	}

	if(length(pixel_color.rgb - find_color2.rgb) < 0.01){
		COLOR.rgb= target_color2.rgb;
	}

	if(length(pixel_color.rgb - find_color3.rgb) < 0.01){
		COLOR.rgb= target_color3.rgb;
	}

	if(length(pixel_color.rgb - find_color4.rgb) < 0.01){
		COLOR.rgb= target_color4.rgb;
	}

	if(length(pixel_color.rgb - find_color5.rgb) < 0.01){
		COLOR.rgb= target_color5.rgb;
	}

	if(length(pixel_color.rgb - find_color6.rgb) < 0.01){
		COLOR.rgb= target_color6.rgb;
	}

	if(length(pixel_color.rgb - find_color7.rgb) < 0.01){
		COLOR.rgb= target_color7.rgb;
	}

	if(length(pixel_color.rgb - find_color8.rgb) < 0.01){
		COLOR.rgb= target_color8.rgb;
	}

	if(length(pixel_color.rgb - find_color9.rgb) < 0.01){
		COLOR.rgb= target_color9.rgb;
	}

	if(length(pixel_color.rgb - find_color10.rgb) < 0.01){
		COLOR.rgb= target_color10.rgb;
	}

	if(length(pixel_color.rgb - find_color11.rgb) < 0.01){
		COLOR.rgb= target_color11.rgb;
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
