#version 330 core

layout (location = 0) in vec2 inVertex;
layout (location = 1) in vec2 inTexCoords;

out vec2 TexCoords;

uniform mat4 model;
uniform mat4 projection;

void main()
{
    TexCoords = inTexCoords;
    gl_Position = projection * model * vec4(inVertex.xy, 0.0, 1.0);
}
