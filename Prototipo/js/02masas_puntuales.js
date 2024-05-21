import {Clock,AxesHelper} from "../../../three.js-master/build/three.module.js";

import { createCamera } from './camera.js';
import { createScene } from './scene.js';
import { createLights } from './lights.js';
import { Resizer } from './Resizer.js';
import { createRenderer } from './renderer.js';
import { OrbitControls } from "../../../three.js-master/examples/jsm/controls/OrbitControls.js";
import { createSphere } from "./createSphere.js";
import { CreateTrail } from "./CreateTrail.js";
import {buscarDatos} from "./buscar_datos.js"
import { Group, Vector3 } from "../../three.js-master/build/three.module.js";
import { Euler } from "../../three.js-master/build/three.module.js";
import { CreatePlane } from "./CreatePlane.js";

const container = document.querySelector('#scene-container');

//-------

let camera;
let renderer;
let scene;

camera = createCamera(10,10,10);
renderer = createRenderer();
scene = createScene();

const controls = new OrbitControls( camera, renderer.domElement );
controls.update();



//-------

const r = 0.1;

const rx = 0;
const ry = 1;
const rz = 1;

const light1 = createLights(3,1,0,0);
const light2 = createLights(3,0,2,0);
const light3 = createLights(3,0,0,2);
const light4 = createLights(3,2,2,2);
const light5 = createLights(3,-1,-1,-1);


const sphere = createSphere(r,rx,-ry,rz);
const sphereCon = createSphere(r,rx,-ry,-rz);



let L1 = CreateTrail(0,0,0,rx,-ry,rz);
let L2 = CreateTrail(0,0,0,rx,-ry,-rz);



//Axis Helper
const axesHelper = new AxesHelper( 1.5 );


// add the automatically created <canvas> element to the page
container.append(renderer.domElement);

//Floor

const w = 10;
const h = 10;
const plane = CreatePlane(w,h);
const paredR = plane.clone();
const paredL = paredR.clone();
const habitacion = new Group();


plane.position.z = -w/2;
paredR.rotation.y = Math.PI/2;
paredR.position.x = -w/2;
paredL.position.y = -w/2;
//paredL.rotation.z = Math.PI/4;
paredL.rotation.x = -Math.PI/2;


habitacion.add(plane,paredR,paredL)



sphere.add(sphereCon)


const resizer = new Resizer(container, camera, renderer);
    resizer.onResize = () => {
      renderer.render(scene, camera);
    }


const clock = new Clock();

  let time=0
  
  scene.add(light1,light2,light3,light4,light5,sphere,sphereCon,L1,L2,habitacion);

  renderer.setAnimationLoop(() => {
      renderer.render(scene, camera);
      const delta = clock.getDelta();
      time += delta
   
   
      const Cx = buscarDatos(time.toFixed(2),"x")
      const Cy = -buscarDatos(time.toFixed(2),"y")
      const Cz = buscarDatos(time.toFixed(2),"z")
      const C4 = buscarDatos(time.toFixed(2),"x2") 

      /*sphere.rotation.x= Cx;
      sphere.rotation.y= Cy;
      sphere.rotation.z=Cz;

      masa.rotation.x = C4
  */
      

      const vector3 = new Vector3(rx,-ry,rz)
      const vector4 = new Vector3(rx,-ry,-rz)
      
      
      const Rot1 = new Euler( Cx, Cy, Cz, 'XYZ' );
      const Rot2 = new Euler(  C4, 0, 0, 'XYZ' );
      
      vector3.applyEuler(Rot1)

      vector4.applyEuler(Rot2)
      vector4.applyEuler(Rot1)

     
       scene.remove(L1,L2)
      
       L1 = CreateTrail(0,0,0,vector3.x,vector3.y,vector3.z);
       L2 = CreateTrail(0,0,0,vector4.x,vector4.y,vector4.z);
       
       sphere.position.set(vector3.x,vector3.y,vector3.z)
       sphereCon.position.set(vector4.x,vector4.y,vector4.z)
 

      scene.add(L1,L2);
     
    
    
  });
