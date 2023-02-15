import { createCamera } from './components/camera.js';
import { createScene } from './components/scene.js';
import { createControls } from './systems/controls.js';
import { createRenderer } from './systems/renderer.js';
import { Resizer } from './systems/Resizer.js';
import { Loop } from './systems/Loop.js';
import {createAxes } from "./components/axes.js"
import {createLights } from "./components/lights.js"
import { FrameBar } from './systems/FramesBar.js';
import {createMases} from "./components/mases.js"
import { VectorcentroMasa } from './components/centro.js';

// These variables are module-scoped: we cannot access them
// from outside the module
let camera;
let renderer;
let scene;
let loop;
let axes;
let stats;
class World {

  constructor(container) {
    
    camera = createCamera();
    scene = createScene();
       
    renderer = createRenderer();


    axes = createAxes(10);
    container.append(renderer.domElement);

    stats = FrameBar();

    const [light,ambientLight] = createLights();
    const controls = createControls(camera, renderer.domElement);
 
    const [s1,s2,s3,s4] = createMases();
    const vector = VectorcentroMasa();

    scene.add(axes,s1,s2,s3,s4,vector)


    
    loop = new Loop(camera, scene, renderer,controls,stats);
        
    loop.updatables.push();
    
     
    //scene.add(axes, agrupar(point,rotor,edges))

    const resizer = new Resizer(container, camera, renderer);
    resizer.onResize = () => {
      this.render();
    }
  }

  async init() {

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
