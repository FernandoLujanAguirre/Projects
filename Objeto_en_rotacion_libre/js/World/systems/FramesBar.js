import Stats  from "../../../../../three.js-master/examples/jsm/libs/stats.module.js"

function FrameBar(){
const stats = Stats();
document.body.appendChild(stats.dom);
return(stats);

}

export{FrameBar}