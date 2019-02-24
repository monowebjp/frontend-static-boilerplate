module.exports = {
	mode: 'production',
	entry: {
		'./docs/assets/js/bundle': './src/assets/js/main.ts'
	},
	output: {
		path: __dirname,
		filename: '[name].js'
	},
	module: {
		rules: [
			{
				enforce: 'pre',
				test: /\.ts?$/,
				use: [
					{
						loader: 'tslint-loader',
						options: {
							typeCheck: true,
							fix: true
						}
					}
				]
			}, {
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