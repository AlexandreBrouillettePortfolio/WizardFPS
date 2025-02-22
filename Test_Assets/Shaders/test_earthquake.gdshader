shader_type spatial;

void vertex() {
	VERTEX.y = 0.1*sin(VERTEX.x*(TIME*10.0)) + 0.1*sin(VERTEX.z*(TIME*6.0));
}

void fragment() {
	ALBEDO = vec3(0.35, 0.08, 0);
	ALPHA = 0.3;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
