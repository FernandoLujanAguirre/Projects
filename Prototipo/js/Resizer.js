const setSize = (container, camera, renderer) => {
  // Ajusta el aspect ratio de la cámara
  camera.aspect = container.clientWidth / container.clientHeight;
  camera.updateProjectionMatrix();

  // Ajusta el tamaño del renderer al contenedor
  renderer.setSize(container.clientWidth, container.clientHeight, false);
  renderer.setPixelRatio(window.devicePixelRatio);
};

class Resizer {
  constructor(container, camera, renderer, callback) {
    // set initial size
    setSize(container, camera, renderer);

    window.addEventListener('resize', () => {
      // set the size again if a resize occurs
      setSize(container, camera, renderer);
      // perform any custom actions
      if (typeof this.onResize === 'function') this.onResize();
      if (typeof callback === 'function') callback();
    });
  }

  onResize() {}
}

export { Resizer };