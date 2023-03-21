import { SphereGeometry,MeshPhongMaterial,Mesh } from "../../../../../three.js-master/build/three.module.js";

function createSphere(radius){
const geometry = new SphereGeometry( radius, 64, 64 );
const material1 = new MeshPhongMaterial( { color: 0xFB8B24 } );

const spher1 = new Mesh( geometry, material1 );
return spher1
}

export {createSphere}