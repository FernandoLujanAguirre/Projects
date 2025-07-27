import { createCamera } from '../../../Prototipo/js/camera.js';
import { createCube } from '../../../Prototipo/js/cube.js';
import { createScene } from '../../../Prototipo/js/scene.js';
import { createControls } from '../../../Prototipo/js/controls.js';
import { createRenderer } from '../../../Prototipo/js/renderer.js';
import { createPostprocessing } from "../../../Prototipo/js/postprocessing.js";
import { Resizer } from '../../../Prototipo/js/Resizer.js';
import { Loop } from './systems/Loop.js';
import {createAxes } from "../../../Prototipo/js/axes.js"
import {createLights } from "../../../Prototipo/js/lights.js"
import { createPoints } from "./components/points.js";
import {loadObject} from "../components/objects.js"
import {agrupar} from "./systems/agrupar.js";
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

    const [mainLight,ambientLight,spotLight,spotLightHelper] = createLights();
    const controls = createControls(camera, renderer.domElement);
    const [rotor,edges] = createCube();
    const point = createPoints();
    const trail = createTrail();

    loop = new Loop(camera, scene, renderer,composer,null,stats);
        
    loop.updatables.push(rotor,point);
    
     
    scene.add(axes, agrupar(point,rotor),ambientLight,spotLight)

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
