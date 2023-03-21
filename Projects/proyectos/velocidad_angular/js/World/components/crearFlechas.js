import {Vector3, ArrowHelper} from "../../../../../three.js-master/build/three.module.js"
import {flecha} from "./flecha.js"

function crearFlechas(elementos){
let flechas =[];

    for (let i=0;i<elementos;i++){
        flechas[i]=flecha(0,0,0,0,0,0,0x7149C6)

    }
return flechas
}

export {crearFlechas}