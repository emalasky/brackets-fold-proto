/*
 * Copyright (c) 2012 Adobe Systems Incorporated. All rights reserved.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *     http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

precision mediump float;

// Built-in attributes.

attribute vec4 a_position;
attribute vec2 a_texCoord;
attribute vec2 a_meshCoord;

// Built-in uniforms.

uniform mat4 u_projectionMatrix;
uniform vec2 u_textureSize;

// Uniforms passed-in from CSS

uniform mat4 transform;

uniform float direction;

uniform float mapDepth;

uniform float t;
uniform float shadow;

// Varyings

varying float v_lighting;

// Constants

const float PI = 3.1415629;

// Main

void main()
{
    vec4 pos = a_position;
    float ramp = a_meshCoord.y;
    if (ramp > 0.5) {
    	ramp = 1.0 - ramp;
    }
    float zOffset = ramp * -50.0;
    float adjT = t * 0.999; // don't get to the end to avoid overlap
  
    pos.z = zOffset * mapDepth * adjT - mapDepth * adjT / 2.0;
    pos.y = (pos.y + 0.5) * (1.0 - adjT) - 0.5; 

    v_lighting = 1.0 - (ramp * adjT * 1.5);

    gl_Position = u_projectionMatrix * transform * pos;
}