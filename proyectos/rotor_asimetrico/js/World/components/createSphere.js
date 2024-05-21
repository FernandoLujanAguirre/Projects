import { SphereGeometry,MeshPhongMaterial,Mesh,Float32BufferAttribute, BufferGeometry, PointsMaterial, Points } from "../../../../../three.js-master/build/three.module.js";

function createSphere(x,y,z){
    const escala = 1;
    const dotGeometry = new BufferGeometry();
dotGeometry.setAttribute( 'position', new Float32BufferAttribute( [x,y,z], 3 ) );
const dotMaterial = new PointsMaterial( { size: 0.05, color: 0xff0000,transparent:false,opacity: 1.0 } );
const dots = new Points( dotGeometry, dotMaterial );
return dots
}

export {createSphere}