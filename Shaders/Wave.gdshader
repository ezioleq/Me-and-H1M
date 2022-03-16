shader_type canvas_item;

uniform float phase_multiplier = 5f;
uniform float intensity = 0.3f;
uniform float wave_width = 0.5f;
uniform float wave_height = 0.1f;

void vertex() {
	float phase = TIME * phase_multiplier;
	float offset = (VERTEX.x + (VERTEX.y * wave_height)) * wave_width;
	VERTEX.y += sin(phase + offset) * intensity;
}

void fragment() {
	
}
