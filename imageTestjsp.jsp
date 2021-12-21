<script type="text/javascript">
var InputImage =
(function loadImageFile() {
    if (window.FileReader) {
        var ImagePre;
        var ImgReader = new window.FileReader();
        var fileType = /^(?:image\/bmp|image\/gif|image\/jpeg|image\/png|image\/x\-xwindowdump|image\/x\-portable\-bitmap)$/i;
 
        ImgReader.onload = function (Event) {
            if (!ImagePre) {
                var newPreview = document.getElementById("imagePreview");
                ImagePre = new Image();
                ImagePre.style.width = "200px";
                ImagePre.style.height = "140px";
                newPreview.appendChild(ImagePre);
            }
            ImagePre.src = Event.target.result;
            
        };
 
        return function () {
        
            var img = document.getElementById("image").files;
          
            if (!fileType.test(img[0].type)) {
             alert("이미지 파일을 업로드 하세요");
             return;
            }
            
            ImgReader.readAsDataURL(img[0]);
        }
 
    }
  
            document.getElementById("imagePreview").src = document.getElementById("image").value;
 
      
})();
 
 
</script>
</head>
<body>
<div id="imagePreview"></div><br>
<input id="image" type="file" onchange="InputImage();">
</body>