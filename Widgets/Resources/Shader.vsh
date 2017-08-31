//
//  ViewController.m
//  LearnOpenGLESWithGPUImage
//
//  Created by loyinglin on 16/5/10.
//  Copyright © 2016年 loyinglin. All rights reserved.
//

attribute vec4 position;
attribute vec2 texCoord;

varying vec2 texCoordVarying;

    ///*
void main()
{
    float preferredRotation = 3.14;
    mat4 rotationMatrix = mat4(
                               cos(preferredRotation), -sin(preferredRotation), 0.0, 0.0,
                               sin(preferredRotation),  cos(preferredRotation), 0.0, 0.0,
                               0.0,0.0, 1.0, 0.0,
                               0.0,0.0, 0.0, 1.0);
    gl_Position = rotationMatrix * position;
    texCoordVarying = texCoord;
}
    /*
     attribute vec4 a_color;
     attribute vec4 a_position;
     varying vec4 v_color;
     uniform mat4 u_MVPMatrix;
     void main()
     {
     v_color = a_color;
     gl_Position = u_MVPMatrix * a_position;
     }
     */

