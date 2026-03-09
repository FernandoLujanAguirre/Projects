import Stats from "https://esm.sh/three@0.161.0/examples/jsm/libs/stats.module.js";


function FrameBar(){
const stats = Stats();
document.body.appendChild(stats.dom);
return(stats);

}

export{FrameBar}