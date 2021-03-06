void main(){
    vec3 newposition=position;
    newposition.z+=.5*sin(newposition.x*20.);
    
    gl_Position=projectionMatrix*modelViewMatrix*vec4(newposition,1.);
}

// Position is the coordinates in a 3d space vec 3 is basically for 3d space coordinates.

// We can add the x, y , z coordinates here.
// the vertex shader is all about the posistion of the object in a 3d space. and this applys to each of the points
// on the planebuffer geo and to animate it we would need time. Using the vertex though is how we can distort the 3d
// object. newposition.y+=.1*sin(newposition.x*20.); cool little effect for later maybe.

//  newposition.z+=.5*sin(newposition.x*20.); For a cool z distortion for my portfolio!

// Next we can add some more vertices to our planebufferGeo or points to our plane.