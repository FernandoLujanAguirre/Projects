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
import {buscarDatos} from "./buscar_datos_prisma.js"
import { Group, Vector3 } from "../../three.js-master/build/three.module.js";
import { Euler } from "../../three.js-master/build/three.module.js";
import { CreatePlane } from "./CreatePlane.js";
import { createCube } from "./CreateCube.js";

const container = document.querySelector('#scene-container');

//-------

let camera;
let renderer;
let scene;

camera = createCamera(20,20,20);
renderer = createRenderer();
scene = createScene();

const controls = new OrbitControls( camera, renderer.domElement );
controls.update();



//Luces-------
const light1 = createLights(3,1,0,0);
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

const w = 20;
const h = 20;
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
const satelite = createSphere(5,0,0,0);
satelite.add(axesHelper)

//---Prisma
const Cube = createCube(7,4,1,1)

satelite.add(Cube)


//Agregar a la escena
scene.add(Luces,habitacion,satelite);
//--------------------






const resizer = new Resizer(container, camera, renderer);
    resizer.onResize = () => {
      renderer.render(scene, camera);
    }


const clock = new Clock();

  let time=0
  


  renderer.setAnimationLoop(() => {
      renderer.render(scene, camera);
      const delta = clock.getDelta();
      time += delta
   
      const t1 = buscarDatos(time.toFixed(2),"t1")
      const t2 = -buscarDatos(time.toFixed(2),"t2")
      const t3 = buscarDatos(time.toFixed(2),"t3")
      const t4 = -buscarDatos(time.toFixed(2),"t4")
      const t5 = buscarDatos(time.toFixed(2),"t5")
      const Sec1 = new Euler(t1,t2,t3,'XYZ');
      satelite.setRotationFromEuler(Sec1);

      
      const Sec2 = new Euler(t5,t4,0,'ZYX');
    Cube.setRotationFromEuler(Sec2);
   


  });
