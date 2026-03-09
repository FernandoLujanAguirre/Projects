function CMcoo(c1x,c1y,c1z){
const l1=1;

const c2x=0
const c2y=-l1
const c2z=0

const c3x=l1
const c3y=0
const c3z=0

const c4x=-l1
const c4y=0
const c4z=0

    const CMx = (c1x+c2x+c3x+c4x)/4; // m=1, sumatoria de m=4
    const CMy = (c1y+c2y+c3y+c4y)/4;
    const CMz = (c1z+c2z+c3z+c4z)/4;

    return [CMx, CMy, CMz]
}

export{CMcoo}
