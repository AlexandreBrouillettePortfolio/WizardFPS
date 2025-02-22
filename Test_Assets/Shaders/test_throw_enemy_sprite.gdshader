shader_type spatial;
//shader_type canvas_item;

render_mode unshaded;

uniform sampler2D base_tex;
uniform sampler2D over_tex;
uniform bool active;
uniform bool isDamageActive;

void fragment() {
		float ratioX = float(float((textureSize(base_tex, 1)).x)/float((textureSize(over_tex, 1)).x));
		float ratioY = float(float((textureSize(base_tex, 1)).y)/float((textureSize(over_tex, 1)).y));
		vec2 uvRatio = vec2(ratioX, ratioY);
		vec4 base = texture(base_tex, UV);
    	vec4 over = texture(over_tex, UV * uvRatio);
		vec4 damage = vec4(1.0, 0.0, 0.0, 0.5);
		vec3 pass1 = vec3(base.rgb * (base.a) * (1.0 - (over.a * float(active))) + over.rgb * (over.a * float(active)));
		ALBEDO = vec3(pass1.rgb * (base.a* 0.35) * (1.0 - (damage.a * float(isDamageActive))) + damage.rgb * (damage.a * float(isDamageActive)));
		ALPHA = base.a;
}
