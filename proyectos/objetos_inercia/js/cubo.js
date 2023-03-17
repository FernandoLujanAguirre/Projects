import { World } from "./World/World_cube.js";

async function main() {
  // Get a reference to the container element
  const container = document.querySelector('#scene-container1');

  // create a new world
  const world = new World(container);

  // complete async tasks


  // start the animation loop
  await world.init();
  world.start();

}

main();