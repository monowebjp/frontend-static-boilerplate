<link href="https://kevinburke.bitbucket.io/markdowncss/markdown.css" rel="stylesheet"></link>
---
title: PROJECT_NAME コーディングガイド
status: draft
context:
  sites:
    - name: 本番環境
      url: PUBLISH_URL
    - name: ステージング環境
      url: STAGING_URL
---
PROJECT_NAMEで使われるモジュールを作成する際のコーディングガイドです。

## 基本原則
CSS構成は<a href="https://github.com/hiloki/flocss" target="_blank">FLOCSS</a>をベースとします。

レイヤー構成はFLOCSSのFoundationレイヤーとObjectの子レイヤーを用います。<br>
Layoutレイヤーは使用しません。

1. Foundation
1. Component
1. Project
1. Utility
1. General(独立ページ専用スタイル)

### Foundation
デフォルトスタイル初期化のNormalize.cssや、プロジェクトにおける基本的なスタイルを定義します。<br>ページの下地としての全体の背景や、基本的なタイポグラフィなどが該当します。<br>
また、Bootstrap等のプラグイン系cssもここに入ります。


### Component
再利用性が高く、粒度の小さいモジュールを定義します。<br>
一般的によく使われるパターンであり、例えば、ボタンや見出しなどが該当します。<br>
また、それ単体では文脈を持たないものでもあります。


### Project
複数のComponentを組み合わせて構成されるモジュールや、単体で大きく複雑な構造を持つモジュールを定義します。


### Utility
わずかなスタイルの調整のための便利クラスです。<br>
Utilityの多くは単一のプロパティで定義されますが、clearfixやtext-overflow: ellipsis；のような複数のプロパティの組み合わせによって成立するものも含まれます。

### General(独立ページ専用スタイル)
ランディングページやデモページなど、サイトと切り離された特殊なページで利用します。<br>
影響範囲はページ内に限り、プロジェクト・コンポーネントのスタイルの上書きを許可します。


## ファイル・ディレクトリ構成
```
└─ /scss
   ├─ /foundation
   │  ├─ _base.scss
   │  ├─ _normalize.scss
   │  └─ (_plugin.scss)
   │
   ├─ /component
   │  ├─ _button.scss
   │  └─ ...
   │
   ├─ /project
   │  ├─ _articlelist.scss
   │  └─ ...
   │
   ├─ /utility
   │  └─ _utility.scss
   │
   ├─ /general(独立したページ単位でディレクトリを作成)
   │  └─ ...
   │
   └─ style.scss
```

## 命名規則(component, project)
MindBEMdingをベースとして、`Block`, `Element`, `Modifier`に分類して命名します。
* `Block`と`Element`間は"\__"<small>(アンダースコア)</small>でつなぎます
* `Block`または`Element`と`Modifier`間は"\--"<small>(ハイフン)</small>でつなぎます
<br><br>
各レイヤーを示すためのprefix（プレフィックス）をつけます。
* Componentレイヤーのモジュール = "c-"
* Projectレイヤーのモジュール = "p-"
<br><br>
要素名が2単語以上になる場合、単語の区切りはキャメルケースで示します。
* longClassName
<br>
クラス名構成）`prefix-blockNmae__elemntName--modifyName`
<br><br>
クラス名の決め方
1. 文脈を持たない要素は見た目
1. 文脈を持つ要素は役割
1. 単語の省略はなるべくしない
<br>
①の例）c-button（ボタン要素）<br>
②の例）p-userProfile（ユーザープロフィール要素）


## 命名規則(utility)
  utilityを示すプレフィックスをつけ、「プロパティ名の<a href="https://www.granfairs.com/blog/staff/efficiency-by-emmet-02" target="_blank">Emmet省略記法</a> + 値」をキャメルケースで表記します。

例）text-align: center; を付与するutilityクラスであれば、 `u-taCenter`

## 命名規則(general)
配置ディレクトリの頭文字をプレフィックスとし、FLOCSSのプレフィックスと重複する場合は2文字とします。

配置するディレクトリの頭文字をプレフィックスとします。
* extra = "e-" // FLOCSSと被らないので1文字
* page = "pa-" // FLOCSSのProjectと被るので2文字

クラス名構成）`prefix-pageName_elementName-modifyName`

## カスケーディング
原則として、モジュール間のカスケーディング、他のモジュールを親とするセレクタを用いたカスケーディングは禁止とします。
例外として、ProjectレイヤーがComponentレイヤーのモジュールを変更することは許容します。
<pre><code style="border: 1px solid #cc0000; background: #ccff00;">
.c-button {
  .c-dialog {        // NG
    color: #333;
  }
  .c-dialog_image {  // NG
    color: #333;
  }
}

.p-articles {
  .p-comments {  // NG
    color: #333;
  }
}
</code></pre>
```
.p-articles {
  .c-media_image {  // OK
    color: #333;
  }
}
```

## レイアウト
Componentの再利用性を保つため、位置やサイズに関するプロパティをComponentモジュール自身が持つことを避けます。
位置やサイズの指定が必要な場合、親となるProjectモジュールによって定義されます。
ただし、どこで利用されてもサイズが同一に固定されるモジュールや、子要素の位置を指定するために必要な場合は例外とします。
```
.c-list {
  width: 50%;         // NG
  height: 50%;        // NG
  padding: 10px;
  margin: 20px;       // NG
  position: absolute; // NG
  left: 50%;          // NG
}

// Projectモジュールがサイズなどを持つのはOK
.p-profile {
  width: 30%;            // OK
  height: 30%;           // OK
  position: relative;    // OK
  // Projectモジュールの子要素として定義されるのはOK
  .c-list {
    width: 50%;          // OK
    height: 50%;         // OK
    margin: 20px;        // OK
    position: absolute;  // OK
    left: 50%;           // OK
  }
}
```

## タグへのclassのつけ方
Projectモジュールのクラス同士がネストすることを禁止します。
```
// NG .p-bモジュールの中に.p-aモジュールのelementクラス(.p-a_child)がネストされているのでx
<div class="p-a">
  <div class="p-a_child">
    <div class="p-b">
      <div class="p-a_child">
        <div class="p-b_child">Sample</div>
      </div>
    </div>
  </div>
</div>
```
<br>
1つのタグに同レイヤーのクラス(ProjectとProject、ComponentとComponent)を禁止します。
(Utilityは例外)
```
// NG .p-aモジュールの最子孫elementクラス(.p-a_child2)と、.p-bモジュールのblockクラスが同じタグに付与されているのでx
<div class="p-a">
  <div class="p-a_child">
    <div class="p-a_child2 p-b">
      <div class="p-b_child">Sample</div>
    </div>
  </div>
</div>
```
<br>
タグセレクタを使用する場合には、気づかずにネストしている可能性があるので注意してください。
```
// NG .p-a > div > div > div > div と、.p-b > div > div がネストの関係になっているのでx
<div class="p-a">
  <div>
    <div class="p-b">
      <div>
        <div>Sample</div>
      </div>
    </div>
  </div>
</div>

// p-a style
.p-a {
  > div {
    color: red;
    > div {
      color: blue;
    }
    > div > div > div {
      color: green;
    }
  }
}

// p-b style
.p-b {
  > div > div {
    color: yellow;
  }
}
```


## 記述上のルール
Blockをルートとして記述してください。
```
// OK
.c-block {
  .c-block_elemnt {
    color: #333;
  }
}

// NG
.c-block_elemnt {
  color: #333;
}
```
<br>
影響範囲を限定するため、可能な限り子セレクタで指定してください。
```
.c-block {
  .c-block_elemnt {    // これでもいいけど
    color: #333;
  }
  > .c-block_elemnt {  // 可能であれば">"で指定
    color: #333;
  }
}
```
<br>
idセレクタは使用しないでください。
タグセレクタの使用は許容しますが、影響範囲に気をつけてください。
```
#c-block {  // NG
  color: #333;
}

.c-block {
  li {      // OKだけど、予期しない<li>にもスタイルが当たってしまわないか注意する
    color: #333;
  }
  > li {    // こちらの方が影響範囲が限定的
    color: #333;
  }
}

```
<br>
可読性を保持するため、記述のネストは3段階までにしてください。
```
.p-block {
  > .p-block_level2 {
    > .p-block_level3 {   // OK(ネスト3階層)
      color: #333;
      > .p-block_level4 { // NG(ネスト4階層)
        color: #666;
      }
    }
  }
}
```
<br>
メディアクエリの場合は1階層目とカウントせず、あくまでもBlockの始まりを1階層目とする
```
@media screen and (max-width: $breakPoint) {
  .p-block { // 1階層目
    > .p-block_level2 {
      > .p-block_level3 { // OK(ネスト3階層←メディアクエリを入れると4階層目)
        color: #333;
      }
    }
  }
}
```
<br>
メディアクエリは、PC記述にネストして書くのではなく、切り離して記述してください。
```
.c-block {
  color: #333;
  @media screen and (max-width: $breakPoint) { // NG
    color: #fff;
  }
}

// SP用にメディアクエリを切り離して書く
@media screen and (max-width: $breakPoint) {
  .c-block {
    color: #fff;
  }
}
```


## カラーコードの指定
文字や背景、ボーダーなどで使われる色指定のもの。
すべて小文字の16進数表記で統一。
```
.c-button {
  color: #333; // OK 省略可
  background: rgba(#263238, .7); // OK rgb()、rgba()も16進数可
}

.c-button {
  color: #FFF; // NG 大文字は不可
  background: rgba(#FF5722, .7); // NG
}

```

---
## サイト一覧
{{#each sites}}
* <a href="{{ this.url }}" target="_blank">{{ this.name }}</a>
{{/each}}
