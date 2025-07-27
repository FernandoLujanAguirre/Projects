import * as THREE from 'https://esm.sh/three@0.161.0';


  //import { EffectComposer } from "../../../three.js-master/three/examples/jsm/postprocessing/EffectComposer.js";
  /*import { RenderPass } from "../../../three.js-master/three/examples/jsm/postprocessing/RenderPass.js";
  import { GlitchPass } from "../../../three.js-master/three/examples/jsm/postprocessing/GlitchPass.js";
  */
import { OrbitControls } from 'https://esm.sh/three@0.161.0/examples/jsm/controls/OrbitControls.js';
  import {buscarDatos} from "./buscar_datos.js"

  const container = document.querySelector('#scene-container');
  const clock = new THREE.Clock();
// create a Scene
const scene = new THREE.Scene();


// Set the background color
scene.background = new Color('skyblue');

// Create a camera
const fov = 35; // AKA Field of View
const aspect = container.clientWidth / container.clientHeight;
const near = 0.1; // the near clipping plane
const far = 100; // the far clipping plane

const camera = new THREE.PerspectiveCamera(fov, aspect, near, far);
camera.up.set(0,0,1);
camera.position.set(1,1,1);

// create a geometry
const geometry = new THREE.BoxBufferGeometry(.5, .1, .01);
const edges = new THREE.EdgesGeometry( geometry );
const line = new THREE.LineSegments( edges, new THREE.LineBasicMaterial( { color: 0x000000 } ) );
// create a default (white) Basic material
const material = new THREE.MeshBasicMaterial({color: 0x999999});

// create a Mesh containing the geometry and material
const cube = new THREE.Mesh(geometry, material);

// add the mesh to the scene

// create the renderer
const renderer = new THREE.WebGLRenderer({ antialias: true });
//const composer = new EffectComposer( renderer );
//const renderer = new WebGLRenderer();
// next, set the renderer to the same size as our container element
renderer.setSize(container.clientWidth, container.clientHeight);

// finally, set the pixel ratio so that our scene will look good on HiDPI displays
renderer.setPixelRatio(window.devicePixelRatio);

// add the automatically created <canvas> element to the page
container.append(renderer.domElement);

//Orbit controls

const controls = new OrbitControls( camera, renderer.domElement );
controls.update();

//Axis Helper
const axesHelper = new THREE.AxesHelper( 0.3 );


    let time=0
    scene.add(cube,line,axesHelper);

    renderer.setAnimationLoop(() => {
        renderer.render(scene, camera);
        const delta = clock.getDelta();
        time += delta
       
        const posx=cube.rotation.x=buscarDatos(time.toFixed(2),"x")
        const posy=cube.rotation.y=buscarDatos(time.toFixed(2),"y")
        const posz=cube.rotation.z=buscarDatos(time.toFixed(2),"z")

        const LineXpos=line.rotation.x=buscarDatos(time.toFixed(2),"x")
        const LineYpos=line.rotation.y=buscarDatos(time.toFixed(2),"y")
        const LineZpos=line.rotation.z=buscarDatos(time.toFixed(2),"z")
  
    });
