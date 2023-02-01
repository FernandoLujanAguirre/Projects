import { createCamera } from './components/camera.js';
import { createCube } from './components/cube.js';
import { createScene } from './components/scene.js';
import { createControls } from './systems/controls.js';
import { createRenderer } from './systems/renderer.js';
import { createPostprocessing } from "./systems/postprocessing.js";
import { Resizer } from './systems/Resizer.js';
import { Loop } from './systems/Loop.js';
import {createAxes } from "./components/axes.js"
import {createLights } from "./components/lights.js"
import { createPoints } from "./components/points.js";
import {loadObject} from "./components/objects.js"
import {agrupar} from "./systems/agrupar.js"
import { createTrail } from "./components/line.js";
import { FrameBar } from './systems/FramesBar.js';
// These variables are module-scoped: we cannot access them
// from outside the module
let camera;
let renderer;
let scene;
let loop;
let axes;
let composer;
let stats;
class World {

  constructor(container) {
    
    camera = createCamera();
    scene = createScene();
       
    renderer = createRenderer();
    composer = createPostprocessing(scene, camera, renderer);

    axes = createAxes(200);
    container.append(renderer.domElement);

    stats = FrameBar();

    const [light,ambientLight] = createLights();
    const controls = createControls(camera, renderer.domElement);
    const [rotor,edges] = createCube();
    const point = createPoints();
    const trail = createTrail();

    loop = new Loop(camera, scene, renderer,composer,null,stats);
        
    loop.updatables.push(rotor,edges,point);
    
     
    scene.add(axes, agrupar(point,rotor,edges))

    const resizer = new Resizer(container, camera, renderer);
    resizer.onResize = () => {
      this.render();
    }
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
