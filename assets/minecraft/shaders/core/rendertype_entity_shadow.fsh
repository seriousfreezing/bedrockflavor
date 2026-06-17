#version 150

uniform sampler2D Sampler0;
in float sphericalVertexDistance;
in float cylindricalVertexDistance;
in vec2 texCoord0;
in vec4 vertexColor;
out vec4 fragColor;

float sdPolygon(vec2 p, float s) {
    float angle = atan(p.y, p.x) + 3.14159265;
    float sectorAngle = 6.2831853 / s;
    float edgeDistance = cos(floor(0.5 + angle / sectorAngle) * sectorAngle - angle) * length(p);
    return edgeDistance - 1.0;
}

void main() {
    vec2 uv = texCoord0 * 2.0 - 1.0;
    float distance = sdPolygon(uv, 12.0);
    float shapeAlpha = step(distance, 0.0);
    vec4 tex = texture(Sampler0, texCoord0);
    fragColor = vec4(tex.rgb, shapeAlpha * vertexColor.a);
}