import {Group} from "../../../../../three.js-master/build/three.module.js";



function agrupar(ele1,ele2,ele3){

    const group = new Group();
    
         const grupo = group.add(ele1,ele2,ele3) 
           
         return(grupo)

}

export {agrupar}