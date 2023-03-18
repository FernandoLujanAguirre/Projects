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

            
          let rotacionx = this.updatables[0].rotation.x;
          let rotaciony = this.updatables[0].rotation.y;
          let rotacionz = this.updatables[0].rotation.z;
        
          if  (rotacionx<1){

            this.updatables[0].rotation.x+=0.01;
            this.updatables[1].rotation.x+=0.01;
          }else if(rotaciony<1){
            
              this.updatables[0].rotation.y+=0.01;
              this.updatables[1].rotation.y+=0.01;
            }else if(rotacionz<1){
              this.updatables[0].rotation.z+=0.01;
              this.updatables[1].rotation.z+=0.01;
            }
          

            
        this.renderer.render(this.scene, this.camera);
       
        });
      }
    }

    export { Loop };
