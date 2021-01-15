if (location.pathname.match("articles/new")){
  document.addEventListener("DOMContentLoaded", () => {
    const inputElement = document.getElementById("article-tag-name");
    inputElement.addEventListener("keyup", () => {
      const keyword = document.getElementById("article-tag-name").value;
      const XHR = new XMLHttpRequest();
      XHR.open("GET", `search/?keyword=${keyword}`, true);
      XHR.responseType = "json";
      XHR.send();
      XHR.onload = () => {
          const tagName = XHR.response.keyword;
          const searchResult = document.getElementById("search-result");
          searchResult.innerHTML = "";
          if (XHR.response) {
          tagName.forEach((tag) => {
            const childElement = document.createElement("div");
            childElement.setAttribute("class", "child");
            childElement.setAttribute("id", tag.id);
            childElement.innerHTML = tag.name;
            searchResult.appendChild(childElement);
            const clickElement = document.getElementById(tag.id);
            clickElement.addEventListener("click", () => {
              document.getElementById("article-tag-name").value = clickElement.textContent;
              clickElement.remove();
            });
          });
        };
      };
    });
  });
};