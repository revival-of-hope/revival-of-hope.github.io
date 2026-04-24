document.addEventListener("DOMContentLoaded", function () {
  // 你的 GitHub Pages 子路径名
  const repoName = "/hugo-stack-blog";

  // 获取页面所有图片
  const images = document.querySelectorAll("img");

  images.forEach((img) => {
    const src = img.getAttribute("src");

    // 检查 src 是否以 /img 或 /uploads 等你存放图片的路径开头
    // 且确保它还没有被加上仓库名
    if (src && src.startsWith("/") && !src.startsWith(repoName)) {
      img.src = repoName + src;
    }
  });
});
