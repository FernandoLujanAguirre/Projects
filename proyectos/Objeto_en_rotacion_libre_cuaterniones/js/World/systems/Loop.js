import { Clock, LineBasicMaterial, BufferGeometry,Line, Vector3, Points, Euler,Quaternion } from "../../../../../three.js-master/build/three.module.js";
import {buscarDatos} from "../../buscar_datos.js"

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
            
                       if (alert == 0){
              alert = buscarDatos(time.toFixed(2),"alert");
              
            } else if(alert == 1){window.alert("Se acabó el tiempo de la animación, acepta \n" + "t = " + time + "s")
              alert=2}

            const a0 = buscarDatos(time.toFixed(2),"a0");
            const a1 = buscarDatos(time.toFixed(2),"a1");
            const a2 = buscarDatos(time.toFixed(2),"a2");
            const a3 = buscarDatos(time.toFixed(2),"a3");
            
            let quaternion = new Quaternion();

            quaternion.fromArray([a1,a2,a3,a0])
            for (const iter of this.updatables) {
            iter.quaternion.copy(quaternion)
    
           
            }


              if (this.scene.children.length>3500){this.scene.children.splice(2,1)
                
              }
              

             
            
        this.renderer.render(this.scene, this.camera);
        //this.composer.render();
        });
      }
    }

    export { Loop };
