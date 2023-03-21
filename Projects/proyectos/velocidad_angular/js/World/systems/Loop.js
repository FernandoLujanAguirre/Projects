import { Clock, LineBasicMaterial, BufferGeometry,Line, Vector3, Points, Euler } from "../../../../../three.js-master/build/three.module.js";
import { CMcoo } from "../components/CMcoo.js";
import { flecha } from "../components/flecha.js";
import { lengthDir } from "../components/length.js";
const clock = new Clock();

let time = 0;
let alert = 0;
class Loop {
    constructor(camera, scene, renderer, controls,stats,cssRenderer) {
      this.camera = camera;
      this.scene = scene;
      this.renderer = renderer;
      this.controls = controls;
      this.stats = stats;
      this.updatables = [];
      this.cssRenderer = cssRenderer;

    }

    start() {
      
        this.renderer.setAnimationLoop(() => {
            this.stats.update();

            let slider = document.getElementById('myRange');
            let theta = document.getElementById('myRange').value
            const l1 = 1;

            slider.addEventListener("change", function() { 
              theta = this.value;                                        
            })
            
            // Posicion de la esfera móvil
            const c1x = 0;
            const c1y = Math.cos(theta*Math.PI/180)*l1;
            const c1z = Math.sin(theta*Math.PI/180)*l1;
            
            // Actualiza a la posicion de la masa
            this.updatables[11].position.copy(new Vector3(c1x, c1y, c1z));

            // Recalculo del centro de masa (vector R_a)
            const [cmx, cmy, cmz] = CMcoo(c1x,c1y,c1z);
            const [normCM, dirCM] = lengthDir(cmx, cmy, cmz);
            this.updatables[0].setDirection(dirCM);
            this.updatables[0].setLength(normCM);
            // Vector de momento angular
            const OmegaVec = new Vector3(0,0,1);
            this.updatables[1].setDirection(OmegaVec);
            this.updatables[1].setLength(1);
            this.updatables[1].position.copy(new Vector3(cmx, cmy, cmz));

            // Vector de posición de las esferas, con respecto al C.M  (r_a)
            const R1 = new Vector3 (c1x-cmx, c1y-cmy, c1z-cmz);
            const R2 = new Vector3 (0-cmx, -1-cmy, 0-cmz);
            const R3 = new Vector3 (1-cmx, 0-cmy, 0-cmz);
            const R4 = new Vector3 (-1-cmx, 0-cmy, 0-cmz);
            
            const R = [R1,R2,R3,R4];

            let N = 0;
            let D= 0;

              // Dibujo de los vectores de posicion
              for(let i=0;i<4;i++){
              [N,D] = (lengthDir(R[i].x,R[i].y,R[i].z));
              this.updatables[2+i].setDirection(D);
              this.updatables[2+i].setLength(N);
              this.updatables[2+i].position.copy(new Vector3(cmx, cmy, cmz));
            }
            
            let V = [];
              for(let i=0;i<4;i++){
              V[i] = new Vector3(0,0,1).cross(R[i]);
              [N,D] = (lengthDir(V[i].x,V[i].y,V[i].z));
              
              this.updatables[6+i].setDirection(D);
              this.updatables[6+i].setLength(N);
              this.updatables[6+i].position.copy(new Vector3(R[i].x+cmx, R[i].y+cmy,R[i].z + cmz));
            }

            let M = new Vector3(0,0,0);
            for(let i=0;i<4;i++){
             M = M.add(R[i].cross(V[i]));
              }
            
            [N,D] = (lengthDir(M.x,M.y,M.z));
            this.updatables[10].setDirection(D);
            this.updatables[10].setLength(N);
            this.updatables[10].position.copy(new Vector3(cmx,cmy,cmz));
            console.log(M.y)



            
        this.renderer.render(this.scene, this.camera);
        
        //this.composer.render();
        });
      }
    }

    export { Loop };
