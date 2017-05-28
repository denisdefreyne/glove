#version 330 core

in vec2 TexCoords;
out vec4 color;

uniform sampler2D image;
uniform vec4 spriteColor;
uniform int textured;

void main()
{
    if (textured == 0)
        color = spriteColor;
    else
        color = texture(image, TexCoords) * spriteColor;
}
