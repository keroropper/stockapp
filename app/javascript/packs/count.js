if (document.URL.match( /new/ ) || document.URL.match( /edit/ )) {
  function count(){
    const articleText = document.getElementById("article-content");
    articleText.addEventListener("keyup", () => {
    const countVal = articleText.value.trim().length;
    const stringCount = document.getElementById("string-count");
    stringCount.innerHTML = `${countVal}文字`;
    });
  };
  window.addEventListener("load", count);
};
