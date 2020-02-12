'use strict';

/* Create a new Fractal instance and export it for use elsewhere if required */
const fractal = module.exports = require('@frctl/fractal').create();

/* Set the title of the project */
fractal.set('project.title', 'PROJECT_NAME Module Library');

/* Tell Fractal where the components will live */
fractal.components.set('path', __dirname + '/src/modules');
fractal.components.set('label', 'modules');
fractal.components.set('title', 'Modules');

/* Tell Fractal where the documentation pages will live */
fractal.docs.set('path', __dirname + '/src/docs');
fractal.docs.set('indexLabel', 'CodingGuide');

/* */
const mandelbrot = require('@frctl/mandelbrot');
const myCustomisedTheme = mandelbrot({
    skin: "navy"
});

fractal.web.set('static.path', __dirname + '/src/dev_assets');
fractal.web.theme(myCustomisedTheme);
