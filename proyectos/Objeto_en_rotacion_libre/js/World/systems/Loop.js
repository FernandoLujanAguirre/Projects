import { Clock, LineBasicMaterial, BufferGeometry,Line, Vector3, Points, Euler } from "../../../../../three.js-master/build/three.module.js";
import {buscarDatos} from "../../buscar_datos.js"

const clock = new Clock();

let time = 0;
let i = 0;

class Loop {
    constructor(camera, scene, renderer,controls) {
      this.camera = camera;
      this.scene = scene;
      this.renderer = renderer;
      this.controls = controls;
      this.updatables = [];
      
    }

    start() {
      let v_oldd_x = 0;
      let v_oldd_y = 75;
      let v_oldd_z = 0;

      let v_old = new Vector3(v_oldd_x,v_oldd_y,v_oldd_z);

        this.renderer.setAnimationLoop(() => {
            const delta = clock.getDelta();
            time += delta;
            i +=1;
            
            const rotx=buscarDatos(time.toFixed(2),"x");
            const roty=buscarDatos(time.toFixed(2),"y");
            const rotz=buscarDatos(time.toFixed(2),"z");
            for (const iter of this.updatables) {
           
            iter.rotation.x= rotx;
            iter.rotation.y= roty;
            iter.rotation.z= rotz;
           
            }
            


            const rot = new Euler( rotx, roty, rotz );
            let v_new= new Vector3(v_oldd_x,v_oldd_y,v_oldd_z).applyEuler(rot,"XYZ");
                              

             function createTrail(v_old,v_new){
              const material = new LineBasicMaterial({
                color: 0x0000ff
              });
              const vertices = [];
              vertices.push(v_old);
              vertices.push(v_new);
              const geometry = new BufferGeometry().setFromPoints( vertices );
              
              const line = new Line( geometry, material );
              
              return(line);
              }

              this.scene.add(createTrail(v_old,v_new))
              v_old = v_new;
              
              //this.scene.add(createTrail());


            //this.updatables[2].geometry.attributes.position.arra    
            
            
        this.renderer.render(this.scene, this.camera);
        });
      }
    }

    export { Loop };
