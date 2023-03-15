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
import { crearFlechas } from './components/crearFlechas.js';
import { cilindros } from './components/cilindro.js';
import { css3d } from './components/etiquetas.js';
// These variables are module-scoped: we cannot access them
// from outside the module
let camera;
let renderer;
let scene;
let loop;
let axes;
let stats;
let cssRenderer;
let cameracss; 
let scenecss;
class World {

  constructor(container) {

    camera = createCamera();
    scene = createScene();
    renderer = createRenderer();

    axes = createAxes(1.2);
    container.append(renderer.domElement);
    stats = FrameBar();

    const [light,ambientLight] = createLights();
    const controls = createControls(camera, renderer.domElement);
 
    const [s1,s2,s3,s4] = createMases();
    const [cil1,cil2,cil3] = cilindros();
    const elementos = 11;
    const flechas = crearFlechas(elementos);

    scene.add(axes,s1,s2,s3,s4)

    loop = new Loop(camera, scene, renderer,controls,stats,cssRenderer,cameracss,scenecss);

    for (let i=0;i<elementos;i++){
      scene.add(flechas[i])
      loop.updatables.push(flechas[i]);
    }

    loop.updatables.push(s1)

      //R1 11
 
    
     
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
