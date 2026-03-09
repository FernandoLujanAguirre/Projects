import * as THREE from 'https://esm.sh/three@0.161.0';

function CreateLine(Ox,Oy,Oz,x,y,z){
    
    const points = [];
    points.push( new THREE.Vector3( Ox, Oy, Oz ) ); // Start point
    points.push( new THREE.Vector3( x, y, z ) );  // End point

    const geometry = new THREE.BufferGeometry().setFromPoints( points );

    const material = new THREE.LineBasicMaterial( { color: 0x00ff00 } ); // A green line

    const line = new THREE.Line( geometry, material );

    return line;
    
}

export {CreateLine}