import * as THREE from 'https://esm.sh/three@0.161.0';

function createAxes(axesSize) { 

    const axes = new THREE.AxesHelper( axesSize );
    return axes
}

export{createAxes}