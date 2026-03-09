import { SphereGeometry,MeshPhongMaterial,Mesh } from 'https://esm.sh/three@0.161.0';

function createSphere(radius){
const geometry = new SphereGeometry( radius, 64, 64 );
const material1 = new MeshPhongMaterial( { color: 0xFB8B24 } );

const sphere = new Mesh( geometry, material1 );

return sphere
}

export {createSphere}