shader_type canvas_item;

uniform vec4 color_mod : hint_color;

void fragment() {
	COLOR = texture(TEXTURE, UV) * color_mod;
}