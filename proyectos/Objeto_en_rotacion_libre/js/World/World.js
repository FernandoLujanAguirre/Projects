import { createCamera } from './components/camera.js';
import { createCube } from './components/cube.js';
import { createScene } from './components/scene.js';
import { createControls } from './systems/controls.js';
import { createRenderer } from './systems/renderer.js';
import { Resizer } from './systems/Resizer.js';
import { Loop } from './systems/Loop.js';
import {createAxes } from "./components/axes.js"
import {createLights } from "./components/lights.js"
import { createPoints } from "./components/points.js";
import {loadObject} from "./components/objects.js"
import {Group} from "../../../../../three.js-master/build/three.module.js"; 
import { createTrail } from "./components/line.js";
// These variables are module-scoped: we cannot access them
// from outside the module
let camera;
let renderer;
let scene;
let loop;
let axes
class World {

  constructor(container) {
    const group = new Group();

    camera = createCamera();
    scene = createScene();
       
    renderer = createRenderer();

    axes = createAxes(200);
    container.append(renderer.domElement);

    const [light,ambientLight] = createLights();
    const controls = createControls(camera, renderer.domElement);
    const [rotor,edges] = createCube();
    const point = createPoints();
    const trail = createTrail();
    
    group.add(point,rotor,edges);

    loop = new Loop(camera, scene, renderer,controls);
        
    loop.updatables.push(rotor,edges,point);
    
     
    scene.add(axes,light,ambientLight,group);

    const resizer = new Resizer(container, camera, renderer);
  }

  async init() {
    const { parrot } = await loadObject();

    // move the target to the center of the front bird
    
    //scene.add(parrot);
    //loop.updatables.push(parrot)
  }

  render() {
    // draw a single frame
    renderer.render(scene, camera);
  }

  start() {
    loop.start();
  }
}

export { World };
