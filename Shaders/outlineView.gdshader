shader_type spatial;
render_mode unshaded;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform sampler2D NORMAL_ROUGHNESS_TEXTURE : hint_normal_roughness_texture, repeat_disable, filter_linear_mipmap;
uniform sampler2D depth_texture : hint_depth_texture, repeat_disable, filter_nearest;
/**void vertex() {
	POSITION = vec4(VERTEX, 1.0);
}**/
void fragment() {
	ALBEDO = vec3(0,0,0);

	vec2 e = vec2(1./VIEWPORT_SIZE.xy);
	vec2 uvs[4];
	uvs[0] = SCREEN_UV+vec2(0., -1.)*e;
	uvs[1] = SCREEN_UV+vec2(1., 0.)*e;
	uvs[2] = SCREEN_UV+vec2(0., 1.)*e;
	uvs[3] = SCREEN_UV+vec2(-1., 0.)*e;
	vec2 depths[4];
	depths[0] = SCREEN_UV+vec2(0., -1.)*e;
	depths[1] = SCREEN_UV+vec2(1., 0.)*e;
	depths[2] = SCREEN_UV+vec2(0., 1.)*e;
	depths[3] = SCREEN_UV+vec2(-1., 0.)*e;
	//CODE FOR NORMAL BASED OUTLINES
	vec3 screen_normal = texture(NORMAL_ROUGHNESS_TEXTURE, SCREEN_UV).xyz;
	float mainDepth = textureLod(depth_texture, SCREEN_UV, 0.0).x;
	vec3 ndc = vec3(SCREEN_UV * 2.0 - 1.0, mainDepth);
	vec4 view = INV_PROJECTION_MATRIX * vec4(ndc, 1.0);
	view.xyz /= view.w;
	float linearDepth = -view.z;
	float normDot = 0.0;
	float sumDiffDepth = 0.0;
	for (int i = 0; i < 4; i++) {
		sumDiffDepth += abs(mainDepth-textureLod(depth_texture, depths[i], 0.0).x);
		//texture(NORMAL_ROUGHNESS_TEXTURE, uvs[i]).xyz; gives us the norm at the UV one pixel away
		normDot += dot(screen_normal*2.0-vec3(1.0,1.0,1.0), texture(NORMAL_ROUGHNESS_TEXTURE, uvs[i]).xyz*2.0-vec3(1.0,1.0,1.0));
	}
	normDot /= 4.0;
	sumDiffDepth /= 4.0;
	if((normDot<0.99||sumDiffDepth>0.001)){
		float brightness = 1.0*(1.0/(4.0*linearDepth));
		if(brightness<0.0001){
			brightness=0.0;
		}
		ALBEDO = vec3(brightness,0.0,0.0);
	}

}