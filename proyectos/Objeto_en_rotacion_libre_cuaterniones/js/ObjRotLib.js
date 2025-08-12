
import * as THREE from 'https://esm.sh/three@0.161.0';
import { OrbitControls } from 'https://esm.sh/three@0.161.0/examples/jsm/controls/OrbitControls.js';
import { createCube } from '../../../Prototipo/js/CreateCube.js'; 
//import { EffectComposer } from "../../../three.js-master/three/examples/jsm/postprocessing/EffectComposer.js";
  /*import { RenderPass } from "../../../three.js-master/three/examples/jsm/postprocessing/RenderPass.js";
  import { GlitchPass } from "../../../three.js-master/three/examples/jsm/postprocessing/GlitchPass.js";
  */
 import {buscarDatos} from "./buscar_datos.js"

  const container = document.querySelector('#scene-container');
  const clock = new THREE.Clock();
// create a Scene
const scene = new THREE.Scene();


// Set the background color
scene.background = new THREE.Color('skyblue');

// Create a camera
const fov = 35; // AKA Field of View
const aspect = container.clientWidth / container.clientHeight;
const near = 0.1; // the near clipping plane
const far = 100; // the far clipping plane

const camera = new THREE.PerspectiveCamera(fov, aspect, near, far);
camera.up.set(0,0,1);
camera.position.set(5,5,5);





const cube2 = createCube(1,2,3,1);

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

const controls = new OrbitControls(camera, renderer.domElement);
controls.update();

//Axis Helper
const axesHelper = new THREE.AxesHelper( 0.3 );


    let time=0
    scene.add(cube2,axesHelper);

    renderer.setAnimationLoop(() => {
        renderer.render(scene, camera);
        const delta = clock.getDelta();
        time += delta
       
        const t1 = buscarDatos(time.toFixed(2), "t1");
        const t2 = -buscarDatos(time.toFixed(2), "t2");
        const t3 = buscarDatos(time.toFixed(2), "t3");
        const Sec1 = new THREE.Euler(t1, t2, t3, 'XYZ');


        cube2.setRotationFromEuler(Sec1);
    });
