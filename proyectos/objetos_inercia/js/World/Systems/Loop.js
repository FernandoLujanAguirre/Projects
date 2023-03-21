import { Clock, LineBasicMaterial, BufferGeometry,Line, Vector3, Points, Euler,Quaternion, ArrowHelper } from "../../../../../three.js-master/build/three.module.js";
const clock = new Clock();

const initquaternion = new Quaternion();

let time = 0;
let alert = 0;
class Loop {
    constructor(camera, scene, renderer, composer, controls,stats) {
      this.camera = camera;
      this.scene = scene;
      this.renderer = renderer;
      this.composer = composer;
      this.controls = controls;
      this.stats = stats;
      this.updatables = [];
      
    }

    start() {

        this.renderer.setAnimationLoop(() => {
            this.stats.update(); // Status bar
            const delta = clock.getDelta(); // get time
            time += delta;



            
        this.renderer.render(this.scene, this.camera);
       
        });
      }
    }

    export { Loop };
