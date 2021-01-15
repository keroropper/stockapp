if (document.URL.match( /new/ ) || document.URL.match( /edit/ )) {
  document.addEventListener("DOMContentLoaded", function(){
    const ImageList = document.getElementById('image-list');

     // 選択した画像を表示する関数
    const createImageHTML = (blob) => {
      // 画像を表示するためのdiv要素を生成
      const imageElement = document.createElement("div"); 
      imageElement.setAttribute('class', 'image-element')
      let imageElementNum = document.querySelectorAll(".image-element").length
      // 表示する画像を生成
      const blobImage = document.createElement("img"); 
      blobImage.setAttribute('src', blob); 
      blobImage.setAttribute('width', 300); 
      blobImage.setAttribute('height', 300); 

      //ファイル選択ボタン作成
      const inputHTML = document.createElement("input")
      inputHTML.setAttribute('id', `article_image_${imageElementNum}`)
      inputHTML.setAttribute('name', 'article[images][]')
      inputHTML.setAttribute('type', 'file')


      // 生成したHTMLの要素をブラウザに表示させる
      imageElement.appendChild(blobImage); 
      imageElement.appendChild(inputHTML);
      ImageList.appendChild(imageElement); 

      inputHTML.addEventListener('change', (e) => {
         file = e.target.files[0];  //一番目の挿入画像を指定
         blob = window.URL.createObjectURL(file);  //上記画像のURLを取得
         createImageHTML(blob);
      })
    };

    document.getElementById('article-image').addEventListener('change', function(e){
      // 画像を上書きしたら、元の画像を削除する
      // const imageContent = document.querySelector('img');
      // if (imageContent){
      //   imageContent.remove();
      // }

      let file = e.target.files[0];  //一番目の挿入画像を指定
      let blob = window.URL.createObjectURL(file);  //上記画像のURLを取得

      createImageHTML(blob);
    });
  });
};