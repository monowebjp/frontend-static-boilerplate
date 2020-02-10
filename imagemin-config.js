const imagemin = require('imagemin-keep-folder');
const imageminMozjpeg = require('imagemin-mozjpeg');
const imageminPngquant = require('imagemin-pngquant');
const imageminGifsicle = require('imagemin-gifsicle');
const imageminSvgo = require('imagemin-svgo');
const imageminWebp = require('imagemin-webp');

imagemin(['src/**/*.{jpg,png,gif,svg}'], {
    plugins: [
        imageminMozjpeg({quality: 80}),
        imageminPngquant({quality: [0.65, 0.8]}), //'65-80'←この書き方だとエラー出た
        imageminGifsicle(),
        imageminSvgo()
    ],
    replaceOutputDir: output => {
        return output.replace(/src\//, './dist/')
    }
}).then(() => {
    imagemin(['dist/**/*.{jpg,png,gif}'], {
        plugins: [
            imageminWebp()
        ]
    }).then(() => {
        console.log('Images optimized');
    });
});