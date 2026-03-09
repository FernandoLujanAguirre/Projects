import {AxesHelper} from 'https://esm.sh/three@0.161.0';

function createAxes(axesSize) { 

    const axes = new AxesHelper( axesSize );
    return axes
}

export{createAxes}