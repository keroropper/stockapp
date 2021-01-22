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


// function previewFile() {
//   const preview = document.querySelector('img'); //どこでプレビューするか指定。'img[name="preview"]'などにすればimg複数あっても指定できます。
//   const file = document.querySelector('input[type=file]').files[0];//'input[type=file]'で投稿されたファイル要素の0番目を参照します。input[type=file]にmutipleがなくてもこのコードになります。
//   const reader = new FileReader();

//   reader.addEventListener("load", function () {
//     preview.src = reader.result
//   }, false);

//   if (file) {
//     reader.readAsDataURL(file);
//   }

// }



// function previewFiles() {
//   var preview_array = [];
//   var file_array = [];
//   var reader_array  = [];
//   var file_length = document.querySelector('input[type=file]').files.length;
//   for(var i=0; i<3; i++){
//       document.querySelector('img[name="preview' + i + '"]').src = "";
//   }
//   for(var i=0; i<file_length; i++){
//       preview_array.push(document.querySelector('img[name="preview' + i + '"]'));
//       file_array.push(document.querySelector('input[type=file]').files[i]);
//       reader_array.push(new FileReader());
//   }
//   //なぜかfor文回せない。
//   // for(var j=0; j<file_length; j++){
//   //   reader_array[j].addEventListener("load", function () {
//   //     preview_array[j].src = reader_array[j].result;
//   //   }, false);
//   // }
//   if(file_length>0){
//       console.log("0");
//       reader_array[0].addEventListener("load", function () {
//           preview_array[0].src = reader_array[0].result;
//       }, false);
//   }

//   if(file_length>1){
//       console.log("1");
//       reader_array[1].addEventListener("load", function () {
//           preview_array[1].src = reader_array[1].result;
//       }, false);
//   }

//   if(file_length>2){
//       console.log("2");
//       reader_array[2].addEventListener("load", function () {
//           preview_array[2].src = reader_array[2].result;
//       }, false);
//   }

//   for(var i=0; i<file_length; i++){
//       reader_array[i].readAsDataURL(file_array[i]);
//   }
// }