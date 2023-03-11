import { Clock, LineBasicMaterial, BufferGeometry,Line, Vector3, Points, Euler } from "../../../../../three.js-master/build/three.module.js";
import { CMcoo } from "../components/CMcoo.js";
import { lengthDir } from "../components/length.js";
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
            this.updatables[0].position.copy(new Vector3(c1x, c1y, c1z));
            // Recalculo del centro de masa
            const [cmx, cmy, cmz] = CMcoo(c1x,c1y,c1z);
            const [norm, dir] = lengthDir(cmx, cmy, cmz);

            // Vector de posición de las esferas, con respecto al C.M  
            const R1 = new Vector3 (c1x-cmx, c1y-cmy, c1z-cmz);
            const R2 = new Vector3 (0-cmx, -1-cmy, 0-cmz);
            const R3 = new Vector3 (1-cmx, 0-cmy, 0-cmz);
            const R4 = new Vector3 (-1-cmx, 0-cmy, 0-cmz);
            //Actualiza a R1
            const [normR1, dirR1] = lengthDir(R1.x,R1.y,R1.z);
            this.updatables[11].setDirection(dirR1);
            this.updatables[11].setLength(normR1);
            this.updatables[11].position.copy(new Vector3(cmx, cmy, cmz));
            //Actualiza a R2
            const [normR2, dirR2] = lengthDir(R2.x,R2.y,R2.z);
            this.updatables[12].setDirection(dirR2);
            this.updatables[12].setLength(normR2);
            this.updatables[12].position.copy(new Vector3(cmx, cmy, cmz));
            //Actualiza a R3
            const [normR3, dirR3] = lengthDir(R3.x,R3.y,R3.z);
            this.updatables[13].setDirection(dirR3);
            this.updatables[13].setLength(normR3);
            this.updatables[13].position.copy(new Vector3(cmx, cmy, cmz));
            //Actualiza a R4
            const [normR4, dirR4] = lengthDir(R4.x,R4.y,R4.z);
            this.updatables[14].setDirection(dirR4);
            this.updatables[14].setLength(normR4);
            this.updatables[14].position.copy(new Vector3(cmx, cmy, cmz));
            //R1 11

            //FUERZA 2 6
            //FUERZA 3 7

            // Vectores de momento angular           
            const vecM1 = R1.cross(this.updatables[2].Vector);
            const vecM2 = R2.cross(this.updatables[6].Vector);
            const vecM3 = R3.cross(this.updatables[7].Vector);
            const vecM4 = R4.cross(this.updatables[8].Vector);

            const [normM1, dirM1] = lengthDir(vecM1.x,vecM1.y,vecM1.z);
            const [normM2, dirM2] = lengthDir(vecM2.x,vecM2.y,vecM2.z);
            const [normM3, dirM3] = lengthDir(vecM3.x,vecM3.y,vecM3.z);
            const [normM4, dirM4] = lengthDir(vecM4.x,vecM4.y,vecM4.z);

            const [normRes, dirRes] = lengthDir(vecM1.x+vecM2.x + vecM3.x+vecM4.x,vecM1.y + vecM2.y + vecM3.y + vecM4.y,vecM1.z + vecM2.z + vecM3.z + vecM4.z);

            this.updatables[1].setDirection(dir);
            this.updatables[1].setLength(norm);

            this.updatables[2].position.copy(new Vector3(c1x, c1y, c1z));

            this.updatables[3].setDirection(dirM1);
            this.updatables[3].setLength(normM1);
            this.updatables[3].position.copy(new Vector3(cmx, cmy, cmz));

            this.updatables[4].setDirection(dirM2);
            this.updatables[4].setLength(normM2);
            this.updatables[4].position.copy(new Vector3(cmx, cmy, cmz));

            this.updatables[9].setDirection(dirM3);
            this.updatables[9].setLength(normM3);
            this.updatables[9].position.copy(new Vector3(cmx, cmy, cmz));

            this.updatables[10].setDirection(dirM4);
            this.updatables[10].setLength(normM4);
            this.updatables[10].position.copy(new Vector3(cmx, cmy, cmz));
            
            this.updatables[5].setDirection(dirRes);
            this.updatables[5].setLength(normRes);
            this.updatables[5].position.copy(new Vector3(cmx, cmy, cmz));

            this.updatables[15].position.copy(new Vector3(0,0.5*Math.cos(theta*Math.PI/180),0.5*Math.sin(theta*Math.PI/180)));
            this.updatables[15].rotation.x=(theta*Math.PI/180)
            //console.log(normRes)


        this.renderer.render(this.scene, this.camera);
        //this.composer.render();
        });
      }
    }

    export { Loop };
