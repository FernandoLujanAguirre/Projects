import { createCamera } from './Components/camera.js';
import { createScene } from './Components/scene.js';
import { createControls } from './Systems/controls.js';
import { createRenderer } from './Systems/renderer.js';
import { Resizer } from './Systems/Resizer.js';
import { Loop } from './Systems/Loop.js';
import {createAxes } from "./Components/axes.js"
import {createLights } from "./Components/lights.js"
import { FrameBar } from './Systems/FramesBar.js';
import { createCone } from './Components/createCone.js';
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
    container.append(renderer.domElement);
    stats = FrameBar();
    const [mainLight,ambientLight,spotLight,spotLightHelper] = createLights();
    const controls = createControls(camera, renderer.domElement);
//

    const cono = createCone(1,2,64);
    cono.position.set(0,1,0)


    loop = new Loop(camera, scene, renderer,composer,null,stats);

    loop.updatables.push(cono);
    
     
    scene.add(axes,spotLight,ambientLight,cono)

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
