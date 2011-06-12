// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.


// open a single window
var window = Ti.UI.createWindow({
	backgroundColor:'white'
});

var view1 = Ti.UI.createView();

var button1 = Ti.UI.createButton({
	title: 'ImagePicker',
	height: 32,
	width: 120,
	top: 30
});

view1.add(button1);
window.add(view1);
window.open();

// TODO: write your module tests here
var tielcimagepicker = require('jp.kray.ti.ELCImagePicker');
Ti.API.info("module is => " + tielcimagepicker);

var imageViews = [];
button1.addEventListener('click', function() {
	for(var i=0; i<imageViews.length; i++) {
		view1.remove(imageViews[i]);
	}
	imageViews.length = 0;
	
	while((imview = imageViews.pop()) != null) {
		view1.remove(imview);
	}
	tielcimagepicker.loadImagePicker({
		success:function(data){
	        Ti.API.info('success callback!');
			if (data && data.images) {
				var images = data.images;
				for(var i=0; i<images.length; i++) {
					var imageView = Ti.UI.createImageView({
						image: images[i],
						top: 100 + 20 * i
					});
					imageViews.push(imageView);
					view1.add(imageView);
				}
			}
	    },
	    cancel:function(){
	        Ti.API.info('cancel callback!');
	    }
	});
});
