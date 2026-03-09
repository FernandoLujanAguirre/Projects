import { World } from "./World/WorldCone.js";

async function main() {
  // Get a reference to the container element
  const container = document.querySelector('#scene-container3');

  // create a new world
  const world = new World(container);

  // complete async tasks


  // start the animation loop
  await world.init();
  world.start();

}

main();
