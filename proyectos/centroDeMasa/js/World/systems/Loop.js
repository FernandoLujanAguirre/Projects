import { Clock, LineBasicMaterial, BufferGeometry,Line, Vector3, Points, Euler } from "../../../../../three.js-master/build/three.module.js";


const clock = new Clock();

let time = 0;
let alert = 0;
class Loop {
    constructor(camera, scene, renderer, controls,stats) {
      this.camera = camera;
      this.scene = scene;
      this.renderer = renderer;
      this.controls = controls;
      this.stats = stats;
      this.updatables = [];
      
    }

    start() {
      
        this.renderer.setAnimationLoop(() => {
            this.stats.update();
            
                       
        this.renderer.render(this.scene, this.camera);
        //this.composer.render();
        });
      }
    }

    export { Loop };
