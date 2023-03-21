import {AxesHelper} from "../../../../../three.js-master/build/three.module.js";

function createAxes(axesSize) { 

    const axes = new AxesHelper( axesSize );
    return axes
}

export{createAxes}