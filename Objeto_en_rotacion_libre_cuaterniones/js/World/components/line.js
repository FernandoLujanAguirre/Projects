import { LineBasicMaterial, BufferGeometry, Line, Vector3 } from 'https://esm.sh/three@0.161.0';


function createTrail(){
const material = new LineBasicMaterial({
	color: 0x0000ff
});

const vertices = [];
vertices.push( new Vector3( - 500, 0, 0 ) );
vertices.push( new Vector3( 0, 500, 0 ) );
const geometry = new BufferGeometry().setFromPoints( vertices );

const line = new Line( geometry, material );
return(line);
}

export {createTrail}