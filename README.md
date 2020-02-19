<div align="center">
<h1>Frontend Static Boilerplate</h1>
<p>静的Webサイトを作るためのスタートキット</p>
<img width="500" src="https://github.com/monowebjp/frontend-static-boilerplate/raw/master/documents/screenshot.png" alt="">
</div>

## Overview
DockerとBrowser-syncでhttpsサーバーを建て、構築します。  
ローカルホストの設定まで含めたセットアップを行います。

## Installation and usage 
### ready
- Gitリポジトリ
- プロジェクト名
- 開発に使用するホスト名
### initial
```shell script
cd REPOSITORY_DIRECTORY
curl -L -O https://github.com/monowebjp/frontend-static-boilerplate/raw/master/setup.sh
sudo sh setup.sh
```
### running
```shell script
npm start
```

## Directories and Files
```.
   ├── README.md                  # 本ファイル、プロジェクトに反映する際は削除される
   ├── documents                  # ドキュメントで使う画像等を格納するディレクトリ
   │   └── screenshot.png
   ├── README.sample.md           # 適用先プロジェクトのREADMEの基となるファイル
   ├── bs-config.js               # ブラウザの自動更新設定ファイル
   ├── docker
   │   └── nginx.conf             # ローカルサーバーの設定ファイル
   ├── docker-compose.yml         # ローカルサーバーの設定ファイル
   ├── ejs.config.json            # ejsを書く際に使用する共通設定ファイル
   ├── fractal.js             # スタイルガイドを制作するための設定ファイル
   ├── imagemin-config.js         # 画像圧縮のためのスクリプトファイル
   ├── package.json               # boilerplateを使用するためのスクリプトファイル
   ├── postcss.config.js          # CSSをビルドする際の設定ファイル
   ├── setup.sh                   # boilerplateの初期設定を行うための実行ファイル
   ├── src                        # 実プロジェクトで編集するファイルを格納したディレクトリ
   │   ├── assets                 # Sass, JS等を格納するディレクトリ
   │   │   ├── js                 # JSファイルを格納するディレクトリ
   │   │   └── scss               # Sassファイルを格納するディレクトリ
   │   │       ├── foundation     # base, normalize, palleteなどのSass
   │   │       ├── layouts        # header, footerなど全体レイアウトのSass
   │   │       ├── object
   │   │       │   ├── component  # 汎用的に使うパーツのSass
   │   │       │   ├── project    # 特定ページ固有パーツのSass
   │   │       │   └── utility    # 余白、文字サイズ等の設定classのSass
   │   │       └── style.scss
   │   ├── partials               # 複数HTMLで共通して使用するパーツを格納する
   │   └── index.ejs              # HTMLの元となるファイル
   ├── tsconfig.json              # JSの記述ルールを記載したファイル
   ├── webpack.config.js          # JSのビルド設定を記載したファイル
   ├── .editorconfig              # インデント等の記述ルールを記載したファイル
   ├── .stylelint                 # Sassの記述ルールを記載したファイル
   ├── .gitignore                 # Gitに共有しないファイルを記述する
   └── yarn.lock                  # 使用しているパッケージの情報（手動では編集しない）
```
