import {Vector3, ArrowHelper} from "../../../../../three.js-master/build/three.module.js"
import {flecha} from "./flecha.js"

function VectorcentroMasa(c1,c2,c3,c4){

const amarillo = 0xffff00;
const rojo = 0xff0000;

const CMx = (c1.x+c2.x+c3.x+c4.x)/4; // m=1, sumatoria de m=4
const CMy = (c1.y+c2.y+c3.y+c4.y)/4;
const CMz = (c1.z+c2.z+c3.z+c4.z)/4;

const magF = 0.3;
const CM = flecha(CMx,CMy,CMz,0,0,0);
const Fuerza1 = flecha(-magF,0,0,c1.x,c1.y,c1.z,amarillo);
const Fuerza2 = flecha(magF,0,0,c2.x,c2.y,c2.z,amarillo);


// estas distancias son respecto al CM
const R1 = new Vector3 (c1.x-CMx, c1.y-CMy, c1.z-CMz);
const R2 = new Vector3 (c2.x-CMx, c2.y-CMy, c2.z-CMz);
const R3 = new Vector3 (c3.x-CMx, c3.y-CMy, c3.z-CMz);
const R4 = new Vector3 (c4.x-CMx, c4.y-CMy, c4.z-CMz);


const vecM1 = R1.cross(Fuerza1.Vector);
const M1 = flecha(vecM1.x,vecM1.y,vecM1.z,CMx,CMy,CMz,rojo);

const vecM2 = R2.cross(Fuerza2.Vector);
const M2 = flecha(vecM2.x,vecM2.y,vecM2.z,CMx,CMy,CMz,rojo);

const vecRes = new Vector3(vecM1.x + vecM2.x,vecM1.y + vecM2.y,vecM1.z + vecM2.z);
const Resultante = flecha(vecRes.x,vecRes.y,vecRes.z,CMx,CMy,CMz,rojo);


return [CM,Fuerza1,Fuerza2,M1,M2,Resultante]
}

export {VectorcentroMasa}