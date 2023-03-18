import { createCamera } from '../../js/World/Components/camera.js';
import { createScene } from '../../js/World/Components/scene.js';
import { createControls } from '../../js/World/Systems/controls.js';
import { createRenderer } from '../../js/World/Systems/renderer.js';
import { Resizer } from '../../js/World/Systems/Resizer.js';
import { Loop } from './systems/Loop.js';
import {createCube} from "../../js/World/Components/createCube.js"
import {createAxes } from "../../js/World/Components/axes.js"
import {createLights } from "../../js/World/Components/lights.js"
import { FrameBar } from '../../js/World/Systems/FramesBar.js';
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
// Default
    camera = createCamera();
    scene = createScene();
    renderer = createRenderer();
    axes = createAxes(4);

    const [cubo, edges] = createCube(2.4,1,1,1);
    container.append(renderer.domElement);
    stats = FrameBar();
    const [mainLight,ambientLight,spotLight,spotLightHelper] = createLights();
    const controls = createControls(camera, renderer.domElement);
//

    loop = new Loop(camera, scene, renderer,composer,null,stats);

    loop.updatables.push(axes,cubo);
    
     
    scene.add(axes,spotLight,ambientLight,cubo)

    const resizer = new Resizer(container, camera, renderer);
    resizer.onResize = () => {
      this.render();
    }
  }

  async init() {
   
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
