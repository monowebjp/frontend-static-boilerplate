module.exports = {
    mode: 'development',
    devtool: 'inline-source-map',
    // メインとなるJavaScriptファイル（エントリーポイント）
    entry: {
        './dist/assets/js/bundle': './src/sites/assets/js/main.ts'
    },
    output: {
        path: __dirname,
        filename: '[name].js'
    },
    module: {
        rules: [
            {
                // 拡張子 .ts の場合
                test: /\.ts$/,
                // TypeScript をコンパイルする
                use: 'ts-loader'
            }
        ]
    },
    // import 文で .ts ファイルを解決するため
    resolve: {
        extensions: [
            '.ts'
        ]
    }
};