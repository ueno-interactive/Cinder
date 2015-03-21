#version 400 core

const uint MATERIAL_COUNT	= 4;

const int MODE_AMBIENT		= 0;
const int MODE_DIFFUSE		= 1;
const int MODE_EMISSIVE		= 2;
const int MODE_SPECULAR		= 3;
const int MODE_SHININESS	= 4;
const int MODE_TWOSIDED		= 5;
const int MODE_MATERIAL_ID	= 6;

struct Material
{
	vec4	ambient;
	vec4	diffuse;
	vec4	emissive;
	vec4	specular;
	float	shininess;
	float	twoSided;
	uint 	pad0;
	uint 	pad1;
};

uniform Materials
{
	Material uMaterials[ MATERIAL_COUNT ];
};

uniform usampler2D uSamplerMaterial;

uniform int uMode;

in Vertex
{
	vec2 uv;
} vertex;

out vec4 oColor;

void main( void )
{
	vec4 color			= vec4( 0.0, 0.0, 0.0, 1.0 );
	uint id				= texture( uSamplerMaterial, vertex.uv ).r;
	Material material	= uMaterials[ id ];

	switch ( uMode ) {
	case MODE_AMBIENT:
		color = material.ambient;
		break;
	case MODE_DIFFUSE:
		color = material.diffuse;
		break;
	case MODE_EMISSIVE:
		color = material.emissive;
		break;
	case MODE_SPECULAR:
		color = material.specular;
		break;
	case MODE_SHININESS:
		color = vec4( vec3( material.shininess ) / 128.0, 1.0 );
		break;
	case MODE_TWOSIDED:
		color = vec4( vec3( material.twoSided ), 1.0 );
		break;
	case MODE_MATERIAL_ID:
		color = vec4( vec3( float( id ) / float( MATERIAL_COUNT ) ), 1.0 );
		break;
	}

	oColor = color;
}
