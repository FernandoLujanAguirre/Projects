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
import { createSphere } from './components/createSphere.js';
import { createLine } from './components/createLine.js';
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

    const [mainLight,ambientLight,spotLight,spotLightHelper] = createLights();
    const controls = createControls(camera, renderer.domElement);
    const [rotor,edges] = createCube();
    const point = createPoints();
    const trail = createTrail();

    const esfera1 = createSphere(-0.03,-0.03,0);
    const esfera2 = createSphere(0,.06,0);

    const linea = createLine();

    loop = new Loop(camera, scene, renderer,composer,null,stats);
        
    loop.updatables.push(linea,esfera1,esfera2);
    
     
    scene.add(axes,linea,esfera1,esfera2,ambientLight,spotLight)

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
