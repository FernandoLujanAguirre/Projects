import * as THREE from 'https://esm.sh/three@0.161.0';

function lengthDir(v1,v2,v3){
    const norma = Math.sqrt(v1**2+v2**2+v3**2);
    const dir = new THREE.Vector3(v1/norma,v2/norma,v3/norma);
    return [norma,dir]
}

export{lengthDir}