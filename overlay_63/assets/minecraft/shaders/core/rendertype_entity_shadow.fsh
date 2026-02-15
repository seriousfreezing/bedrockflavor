#version 330
#moj_import <minecraft:dynamictransforms.glsl>

in vec2 texCoord0;
in vec4 vertexColor;
out vec4 fragColor;

float sdPolygon(vec2 p, int s) {
    float angle = atan(p.y, p.x) + 3.14159265;
    float sectorAngle = 6.2831853 / float(s);
    float edgeDistance = cos(floor(0.5 + angle / sectorAngle) * sectorAngle - angle) * length(p);
    return edgeDistance - 1.0;
}

void main() {
    vec2 uv = clamp(texCoord0 * 2.0 - 1.0, -1.2, 1.2);
    float dodecagon = sdPolygon(uv, 12);
    float alpha = step(dodecagon, 0.0);
    fragColor = vec4(0.0, 0.0, 0.0, alpha) * vertexColor * ColorModulator;
}