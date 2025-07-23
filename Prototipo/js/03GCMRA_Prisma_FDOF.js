import {Clock,AxesHelper} from "../../../three.js-master/build/three.module.js";

import { createCamera } from './camera.js';
import { createScene } from './scene.js';
import { createLights } from './lights.js';
import { createAmbientLights } from "./CreateAmbientLight.js";
import { Resizer } from './Resizer.js';
import { createRenderer } from './renderer.js';
import { OrbitControls } from "../../../three.js-master/examples/jsm/controls/OrbitControls.js";
import { createSphere } from "./createSphere.js";
import { CreateTrail } from "./CreateTrail.js";
import {buscarDatos} from "./buscar_datos_prisma_FDOF.js"
import { Group, Vector3 } from "../../three.js-master/build/three.module.js";
import { Euler } from "../../three.js-master/build/three.module.js";
import { CreatePlane } from "./CreatePlane.js";
import { createCube } from "./CreateCube.js";
import {importGLTF} from "./LoadGLTF.js"
import {GLTFLoader} from "../../three.js-master/examples/jsm/loaders/GLTFLoader.js"

const container = document.querySelector('#scene-container');

//-------

let camera;
let renderer;
let scene;

camera = createCamera(.2,.2,.2);
renderer = createRenderer();
scene = createScene();

const controls = new OrbitControls( camera, renderer.domElement );
controls.update();



//Luces-------
const light1 = createLights(2,1,0,0);
const light2 = createLights(3,0,2,0);
const light3 = createLights(3,0,0,2);
const light4 = createLights(3,2,2,2);
const light5 = createLights(3,-1,-1,-1);

const ambientLight = createAmbientLights();

const Luces = new Group();
Luces.add(light1,light2,light3,light4,light5)
//------------

//Axis Helper
const axesHelper = new AxesHelper( 1.5 );
//-------------

// add the automatically created <canvas> element to the page
container.append(renderer.domElement);

//Floor

const w = 15;
const h = 15;
const plane = CreatePlane(w,h);
const paredR = plane.clone();
const paredL = paredR.clone();
const habitacion = new Group();

plane.position.z = -w/2;
paredR.rotation.y = Math.PI/2;
paredR.position.x = -w/2;
paredL.position.y = -w/2;
paredL.rotation.x = -Math.PI/2;
habitacion.add(plane,paredR,paredL)
//----------------------


//Satelite
//const satelite = createSphere(2,0,0,0);
const satelite = createCube(.1,.1,.1,1);

//---Prisma
const Cube = createCube(7,4,1,1)


//GLTF

//importGLTF('Sat.gltf',scene)

let rotor
let Marco1

  // Función para cargar el modelo GLTF/GLB
  function loadModel(url = 'prisma.gltf') {
    return new Promise((resolve, reject) => {
        const loader = new GLTFLoader();
        loader.load(url, function (gltf) {
            const loadedModel = gltf.scene;
            resolve(loadedModel); // La promesa se resuelve con el modelo cargado
        }, undefined, function (error) {
            reject(error); // La promesa se rechaza con el error
        });
    });
}
// Marco 1
loadMarco('Modelos_GLTF/MarcoFDOF.gltf')
.then(loadedModel => {
    Marco1 = loadedModel;
    scene.add(Marco1);
    
    //animate(); // Iniciar la animación después de cargar el modelo
})
.catch(error => {
    console.error('Error loading model:', error);
});


// Función para cargar el modelo GLTF/GLB
function loadMarco(url = 'Modelos_GLTF/Marco1.gltf') {
  return new Promise((resolve, reject) => {
      const loader = new GLTFLoader();
      loader.load(url, function (gltf) {
          const loadedModel = gltf.scene;
          resolve(loadedModel); // La promesa se resuelve con el modelo cargado
      }, undefined, function (error) {
          reject(error); // La promesa se rechaza con el error
      });
  });
}


//Agregar a la escena



scene.add(Luces,habitacion,satelite);
//--------------------

//Slider
let sliderValue = document.getElementById('mySlider').value;
document.getElementById('mySlider').addEventListener('input', function () {
    sliderValue = this.value;
    document.getElementById('sliderValue').textContent = "x" + sliderValue;
});

//--------------


const resizer = new Resizer(container, camera, renderer);
    resizer.onResize = () => {
      renderer.render(scene, camera);
    }


const clock = new Clock();

  let time=0
  


  renderer.setAnimationLoop(() => {
      renderer.render(scene, camera);
      const delta = clock.getDelta();
      time += delta*sliderValue
   
      const t1 = buscarDatos(time.toFixed(2),"t1")
      const t2 = -buscarDatos(time.toFixed(2),"t2")
      const t3 = buscarDatos(time.toFixed(2),"t3")
      const t4 = -buscarDatos(time.toFixed(2),"t4")
      const t5 = buscarDatos(time.toFixed(2),"t5")
      const Sec1 = new Euler(t1,t2,t3,'XYZ');
      satelite.setRotationFromEuler(Sec1);

      
      const Sec2 = new Euler(0,t4,0,'XYZ');
      const Sec3 = new Euler(t5,0,0,'XYZ');

    satelite.setRotationFromEuler(Sec1);
   
    

    if (Marco1){
        satelite.add(Marco1)
      Marco1.setRotationFromEuler(Sec2);
    }
    

  });
