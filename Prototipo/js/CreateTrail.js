import * as THREE from 'https://esm.sh/three@0.161.0';

function CreateTrail(Ox,Oy,Oz,x,y,z){
    const material = new THREE.LineBasicMaterial({
        color: 0x000000
    });
    
    const vertices = [];
    vertices.push( new THREE.Vector3( Ox,Oy,Oz ) );
    vertices.push( new THREE.Vector3(x,y,z ) );
    const geometry = new THREE.BufferGeometry().setFromPoints( vertices );
    
    const line = new THREE.Line( geometry, material );
    return(line);
    }
    
    export {CreateTrail}