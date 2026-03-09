import * as THREE from 'https://esm.sh/three@0.161.0';



function agrupar(ele1,ele2,ele3){

    const group = new THREE.Group();
    
         const grupo = group.add(ele1,ele2,ele3) 
           
         return(grupo)

}

export {agrupar}