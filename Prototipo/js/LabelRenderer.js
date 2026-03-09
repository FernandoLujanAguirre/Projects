import { CSS2DRenderer } from "https://esm.sh/three@0.161.0/examples/jsm/renderers/CSS2DRenderer.js";

function labelRenderer(){
const labelRenderer = new CSS2DRenderer();
labelRenderer.setSize( window.innerWidth, window.innerHeight );
labelRenderer.domElement.style.position = 'absolute';
labelRenderer.domElement.style.top = '0px';
document.body.appendChild( labelRenderer.domElement );

return labelRenderer;
}
export { labelRenderer };