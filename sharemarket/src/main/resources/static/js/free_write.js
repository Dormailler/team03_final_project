$(document).ready(function(){
	function getImageFiles(e) {
		  const uploadFiles = [];
	      const files = e.currentTarget.files;
	      const imagePreview = document.querySelector('.image-preview');
	      const docFrag = new DocumentFragment();
	      
	      if ([...files].length >= 5) {
	        alert('이미지는 최대 4개까지 업로드가 가능합니다.');
	        return;
	      }
	      [...files].forEach(file => {
	    	    if (!file.type.match("image/.*")) {
	    	      alert('이미지 파일만 업로드가 가능합니다.');
	    	      return;
	    	    }
    	    if ([...files].length < 7) {
    	          uploadFiles.push(file);
    	          const reader = new FileReader();
    	          imagePreview.innerHTML = "";
    	          reader.onload = (e) => {
    	            const preview = createElement(e, file);
					
    	            imagePreview.appendChild(preview);
    	          };
    	          reader.readAsDataURL(file);
    	    }    
	   	 })
	}
	
	function createElement(e, file) {
		  
	      const li = document.createElement('li');
	      const img = document.createElement('img');
	      
	      img.setAttribute('src', e.target.result);
	      img.setAttribute('data-file', file.name);
	      
	      li.appendChild(img);

	      return li;
	}
	
	
	
	
	const realUpload = document.querySelector('.real-upload');
    const upload = document.querySelector('.upload');

    upload.addEventListener('click', () => realUpload.click());

    realUpload.addEventListener('change', getImageFiles);
    
    $('.location').on('click',function(){
    	$('#modal_wrap').show();
    });

    
    if(window.location.href.substr(-5) == "freew"){
    	$('#update_btn').hide();
    }else{
    	$('#register_btn').hide();
    }
    $('.close').on('click',function(){
		$('#modal_wrap').hide();
	})
	$('#cancel_btn').on('click',function(){
		location.href = "/free";
	})
	$('h1 span').on('click',function(){
		location.reload();
	});
});