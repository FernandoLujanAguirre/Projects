import { Clock, LineBasicMaterial, BufferGeometry,Line, Vector3, Points, Euler,Quaternion, ArrowHelper } from "../../../../../three.js-master/build/three.module.js";
import {buscarDatos} from "../../buscar_datos.js"
import { flecha } from "../components/flecha.js";
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
      let v_oldd_x = 0;
      let v_oldd_y = 0.06;
      let v_oldd_z = 0;
      let v_old = new Vector3(v_oldd_x,v_oldd_y,v_oldd_z);


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
            
            const omegax = buscarDatos(time.toFixed(2),"omegax");
            const omegay = buscarDatos(time.toFixed(2),"omegay");
            const omegaz = buscarDatos(time.toFixed(2),"omegaz");
        
            
       
            let quaternion = new Quaternion();

            quaternion.fromArray([a1,a2,a3,a0])
            const lengthVec = Math.sqrt(omegax**2+omegay**2+omegaz**2);// Calculates the length of vector V
            //this.updatables[3].setDirection(new Vector3(omegax/lengthVec,omegay/lengthVec,omegaz/lengthVec))
            //this.updatables[3].setLength(Math.sqrt(omegax**2+omegay**2+omegaz**2)/8)
           
            for (const iter of this.updatables) {
            if (iter.type!="ArrowHelper"){
            iter.quaternion.copy(quaternion)
            }else{
           
            }
                      
            }

            let v_new= new Vector3(v_oldd_x,v_oldd_y,v_oldd_z).applyQuaternion(quaternion)
            function createTrail(v_old,v_new){
              const material = new LineBasicMaterial({
                color: 0x0000ff
              });
              let vertices = [];
              vertices.push(v_old);
              vertices.push(v_new);
                         
              const geometry = new BufferGeometry().setFromPoints( vertices );
              
              const line = new Line( geometry, material );
              
              return(line);
              }
              this.scene.add(createTrail(v_old,v_new))


              if (this.scene.children.length>3500){this.scene.children.splice(2,1)
                
              }
              
              v_old = v_new;

             
            
            
        this.renderer.render(this.scene, this.camera);
       
        });
      }
    }

    export { Loop };
