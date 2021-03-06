import * as THREE from 'three';
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js';
import fragment from './shaders/fragment.glsl';
import vertex from './shaders/vertex.glsl';

export default class Sketch {
    constructor(options) {
        this.time = 0;
        this.container = options.dom;
        this.scene = new THREE.Scene();

        this.width = this.container.offsetWidth;
        this.height = this.container.offsetHeight;

        this.camera = new THREE.PerspectiveCamera( 70, this.width / this.height, 0.01, 10 );
        this.camera.position.z = 1;

        this.renderer = new THREE.WebGLRenderer( { antialias: true } );
        // this.renderer.setSize( this.width, this.height );
        // this.renderer.setAnimationLoop( animation );
        this.container.appendChild( this.renderer.domElement );


        this.controls = new OrbitControls( this.camera, this.renderer.domElement)


        this.resize();
        this.setupResize();
        this.addObjects();
        this.render();
    }

    setupResize() {
        window.addEventListener('resize', this.resize.bind(this));
    }

    resize() {
        this.width = this.container.offsetWidth;
        this.height = this.container.offsetHeight;
        this.renderer.setSize( this.width, this.height)
        this.camera.aspect = this.width / this.height;
        this.camera.updateProjectionMatrix()
    }


    addObjects() {
        
    this.geometry = new THREE.PlaneBufferGeometry( 0.5, 0.5,100,100);
	this.material = new THREE.MeshNormalMaterial();

    this.material = new THREE.ShaderMaterial({
        side: THREE.DoubleSide,
        fragmentShader: fragment,
        vertexShader:  vertex,
        wireframe: true
    })

	this.mesh = new THREE.Mesh( this.geometry, this.material );
	this.scene.add( this.mesh );

    }
    // Create render loop

    render() {

        this.time+=0.05;
        this.mesh.rotation.x = this.time / 2000;
	    this.mesh.rotation.y = this.time / 1000;

	    this.renderer.render( this.scene, this.camera );
        // console.log(this.time); Check out the magic of time incrementing in 0.05 ms!
        window.requestAnimationFrame(this.render.bind(this));
    }
}

new Sketch({
    dom: document.getElementById('container')
});




// First thing to do is to add some Objects to our scene as well as a resize function.
// Line 49-53 is our first object we are going to add.

// Next we need to populate our animation loop we can take the code from three.js and
// add it to our render function.

// When you change something in three.js you have to deliberatly say you changed it!
// In this instance for resizing we need to update our camera metrics or matrix metrics.

// Once changing the buffer geo to plane when rotating the plane the posterior plane is invisible
// Just set the side key to our objects.    side: THREE.DoubleSide,


// By adding the wireframe: true we can see inside our shapes and shaders and all the points 
// in the 3d space. this.geometry = new THREE.PlaneBufferGeometry( 0.5, 0.5,10,10); Awesome grid looking cube
// 