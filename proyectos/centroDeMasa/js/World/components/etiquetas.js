import * as THREE from 'https://esm.sh/three@0.161.0';
import { CSS3DRenderer, CSS3DObject } from "https://esm.sh/three@0.161.0/examples/jsm/renderers/CSS3DRenderer.js";



function css3d(container){
const scenecss = new THREE.Scene();
const aspect = window.innerWidth/innerHeight;
const cameracss = new THREE.PerspectiveCamera(    35, // fov = Field Of View
aspect, // aspect ratio (dummy value)
0.1, // near clipping plane
200, // far clipping plane
);

cameracss.position.set(2,2,4);
cameracss.up.set(0,0,1);


let cssRenderer = new CSS3DRenderer();

cssRenderer.setSize(window.innerWidth,window.innerHeight);

container.appendChild(cssRenderer.domElement);

let caja = document.createElement('div');
caja.className = "etiqueta";

caja.innerHTML = "<p>H</p>";

let obj = new CSS3DObject(caja);
obj.position.set(0,0,0);
scenecss.add(obj)
return [cssRenderer,cameracss,scenecss]

}

export{css3d}