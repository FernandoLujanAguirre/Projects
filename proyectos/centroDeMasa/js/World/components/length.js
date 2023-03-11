import { Vector3 } from "../../../../../three.js-master/build/three.module.js";

function lengthDir(v1,v2,v3){
    const norma = Math.sqrt(v1**2+v2**2+v3**2);
    const dir = new Vector3(v1/norma,v2/norma,v3/norma);
    return [norma,dir]
}

export{lengthDir}