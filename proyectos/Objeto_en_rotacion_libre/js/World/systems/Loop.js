import { Clock, LineBasicMaterial, BufferGeometry,Line, Vector3, Points, Euler } from "../../../../../three.js-master/build/three.module.js";
import {buscarDatos} from "../../buscar_datos.js"

const clock = new Clock();

let time = 0;
let rotx=0;
let roty=0;
let rotz=0;
class Loop {
    constructor(camera, scene, renderer, composer, controls) {
      this.camera = camera;
      this.scene = scene;
      this.renderer = renderer;
      this.composer = composer;
      this.controls = controls;
      this.updatables = [];
      
    }

    start() {
      let v_oldd_x = 0;
      let v_oldd_y = 75;
      let v_oldd_z = 0;
      let comp = undefined;
      let v_old = new Vector3(v_oldd_x,v_oldd_y,v_oldd_z);

        this.renderer.setAnimationLoop(() => {
            const delta = clock.getDelta();
            time += delta;
                        
            if (rotx !==null){
            
            rotx=buscarDatos(time.toFixed(2),"x");
            roty=buscarDatos(time.toFixed(2),"y");
            rotz=buscarDatos(time.toFixed(2),"z");
          } else {window.alert("se acabo la simu")}
            for (const iter of this.updatables) {
           
            iter.rotation.x= rotx;
            iter.rotation.y= roty;
            iter.rotation.z= rotz;
           
            }
            
            //Coordenadas de los puntos
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
              comp = rotx;                     
            
        this.renderer.render(this.scene, this.camera);
        //this.composer.render();
        });
      }
    }

    export { Loop };
