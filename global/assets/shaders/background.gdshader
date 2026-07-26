shader_type canvas_item;

uniform vec4 color_a : source_color = vec4(0.02, 0.02, 0.05, 1.0);
uniform vec4 color_b : source_color = vec4(0.06, 0.02, 0.10, 1.0);
uniform vec4 color_c : source_color = vec4(0.01, 0.03, 0.04, 1.0);

uniform float noise_scale : hint_range(0.5, 10.0) = 3.0;
uniform float speed : hint_range(0.0, 1.0) = 0.08;
uniform float brightness : hint_range(0.0, 2.0) = 1.0;
uniform float contrast : hint_range(0.5, 3.0) = 1.4;

highp float hash21(highp vec2 p) {
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 45.32);
    return fract(p.x * p.y);
}

highp float noise(highp vec2 p) {
    highp vec2 i = floor(p);
    highp vec2 f = fract(p);

    highp float a = hash21(i);
    highp float b = hash21(i + vec2(1.0, 0.0));
    highp float c = hash21(i + vec2(0.0, 1.0));
    highp float d = hash21(i + vec2(1.0, 1.0));

    highp vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

highp float fbm(highp vec2 p) {
    highp float value = 0.0;
    highp float amp = 0.5;
    for (int i = 0; i < 5; i++) {
        value += amp * noise(p);
        p *= 2.0;
        amp *= 0.5;
    }
    return value;
}

void fragment() {
    highp vec2 uv = UV * noise_scale;

    // Оборачиваем время, чтобы числа не росли бесконечно и не теряли точность
    highp float t = mod(TIME, 1000.0);

    highp vec2 motion1 = vec2(t * speed, t * speed * 0.6);
    highp vec2 motion2 = vec2(-t * speed * 0.7, t * speed * 0.4);

    float n1 = fbm(uv + motion1);
    float n2 = fbm(uv * 1.6 + motion2);

    n1 = pow(n1, contrast);
    n2 = pow(n2, contrast);

    vec3 col = mix(color_a.rgb, color_b.rgb, n1);
    col = mix(col, color_c.rgb, n2 * 0.5);
    col *= brightness;

    COLOR = vec4(col, 1.0);
}