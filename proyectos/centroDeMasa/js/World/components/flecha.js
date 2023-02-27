import {Vector3, ArrowHelper} from "../../../../../three.js-master/build/three.module.js"


function flecha(Vx,Vy,Vz,Ox,Oy,Oz,Color){

const Vector = new Vector3(Vx,Vy,Vz);    
const Origen = new Vector3(Ox,Oy,Oz);    

const lengthVec = Math.sqrt(Vector.x**2+Vector.y**2+Vector.z**2);
const VectorUnit = new Vector3 (Vector.x/lengthVec,Vector.y/lengthVec,Vector.z/lengthVec);

const Flecha = new ArrowHelper( VectorUnit, Origen, lengthVec, Color );
Flecha.Vector=Vector;

return Flecha
}

export {flecha}