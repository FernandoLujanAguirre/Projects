import * as THREE from 'https://esm.sh/three@0.161.0';


function flecha(Vx,Vy,Vz,Ox,Oy,Oz,Color){

const Vector = new THREE.Vector3(Vx,Vy,Vz);    
const Origen = new THREE.Vector3(Ox,Oy,Oz);    

const lengthVec = Math.sqrt(Vector.x**2+Vector.y**2+Vector.z**2);
const VectorUnit = new THREE.Vector3 (Vector.x/lengthVec,Vector.y/lengthVec,Vector.z/lengthVec);

const Flecha = new THREE.ArrowHelper( VectorUnit, Origen, lengthVec, Color );
Flecha.Vector=Vector;

return Flecha
}

export {flecha}