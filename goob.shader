shader_type canvas_item;
uniform float amount: hint_range(0.0, 5.0);
uniform vec4 water_color:hint_color;
uniform vec4 outline_color :hint_color;
void fragment()
{
	vec4 Color= textureLod(SCREEN_TEXTURE, SCREEN_UV,amount);
	float average = (Color.r + Color.g + Color.b + Color.a)/4.0;
	
	float thresh = step(0.3, average);
    vec4 sum = vec4(thresh * 0.7, thresh * 0.9, thresh, thresh);
	Color *= sum;
	float average_rgb =(Color.r + Color.g + Color.b)/3.0;
	if( average > 0.2){
		Color = vec4(water_color.rgb * average_rgb, 1);
	} else if (average > 0.15)
	{
		Color = outline_color
	}
	COLOR = Color;
	
	
	
}
