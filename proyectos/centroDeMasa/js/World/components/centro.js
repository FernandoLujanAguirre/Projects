import * as THREE from 'https://esm.sh/three@0.161.0';
import {flecha} from "./flecha.js"

function VectorcentroMasa(c1,c2,c3,c4){

const color = 0xAD8E70;
const rojo = 0xff0000;

const CMx = (c1.x+c2.x+c3.x+c4.x)/4; // m=1, sumatoria de m=4
const CMy = (c1.y+c2.y+c3.y+c4.y)/4;
const CMz = (c1.z+c2.z+c3.z+c4.z)/4;

const magF = 0.4;
const CM = flecha(CMx,CMy,CMz,0,0,0,color);
const Fuerza1 = flecha(-magF,0,0,c1.x,c1.y,c1.z,color);
const Fuerza2 = flecha(magF,0,0,c2.x,c2.y,c2.z,color);

const Fuerza3 = flecha(0,magF,0,c3.x,c3.y,c3.z,color);
const Fuerza4 = flecha(0,-magF,0,c4.x,c4.y,c4.z,color);

// estas distancias son respecto al CM
const R1 = new THREE.Vector3 (c1.x-CMx, c1.y-CMy, c1.z-CMz);
const R2 = new THREE.Vector3 (c2.x-CMx, c2.y-CMy, c2.z-CMz);
const R3 = new THREE.Vector3 (c3.x-CMx, c3.y-CMy, c3.z-CMz);
const R4 = new THREE.Vector3 (c4.x-CMx, c4.y-CMy, c4.z-CMz);

const FR1 = flecha(R1.x,R1.y,R1.z,CMx,CMy,CMz,0xFB8B24);
const FR2 = flecha(R2.x,R2.y,R2.z,CMx,CMy,CMz,0xD90368);
const FR3 = flecha(R3.x,R3.y,R3.z,CMx,CMy,CMz,0x084887);
const FR4 = flecha(R4.x,R4.y,R4.z,CMx,CMy,CMz,0x04A777);

const vecM1 = R1.cross(Fuerza1.Vector);
const M1 = flecha(vecM1.x,vecM1.y,vecM1.z,CMx,CMy,CMz,0xFB8B24);

const vecM2 = R2.cross(Fuerza2.Vector);
const M2 = flecha(vecM2.x,vecM2.y,vecM2.z,CMx,CMy,CMz,0xD90368);

const vecM3 = R3.cross(Fuerza3.Vector);
const M3 = flecha(vecM3.x,vecM3.y,vecM3.z,CMx,CMy,CMz,0x084887);

const vecM4 = R4.cross(Fuerza4.Vector);
const M4 = flecha(vecM4.x,vecM4.y,vecM4.z,CMx,CMy,CMz,0x04A777);

const vecRes = new THREE.Vector3(vecM1.x + vecM2.x + vecM3.x + vecM4.x,vecM1.y + vecM2.y + + vecM3.y + vecM4.y,vecM1.z + vecM2.z + vecM3.z + vecM4.z);
const Resultante = flecha(vecRes.x,vecRes.y,vecRes.z,CMx,CMy,CMz,0xF7F5FB);


return [CM,Fuerza1,Fuerza2,M1,M2,Resultante,Fuerza3,Fuerza4,M3,M4,FR1,FR2,FR3,FR4]
}

export {VectorcentroMasa}