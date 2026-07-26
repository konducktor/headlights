shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
uniform float amount : hint_range(-100.0, 100.0) = 0.0;

void fragment() {
    // Маска из альфа-канала текстуры объекта
    float mask = texture(TEXTURE, UV).a;

    // Цвет экрана за объектом
    vec4 screen = texture(screen_texture, SCREEN_UV);

    // Осветляем/затемняем
    screen.rgb += amount / 100.0;

    // Показываем только там, где непрозрачна маска
    COLOR = vec4(screen.rgb, mask);
}