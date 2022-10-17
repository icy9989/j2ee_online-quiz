const backgrounds = document.querySelector('.backgrounds');

window.addEventListener("resize", function() {
	
    if(this.window.innerWidth < 992) {
        backgrounds.classList.add('hides');
    } else {
        backgrounds.classList.remove('hides');
    }
});

if(window.innerWidth < 992) {
    backgrounds.classList.add('hides');
}


const eyeicons = document.querySelector('.eyeicons');
const password = document.querySelector('#password');

eyeicons.addEventListener('click',()=>{
	if(eyeicons.classList.contains('fa-eye')){
		eyeicons.classList.replace('fa-eye','fa-eye-slash');
		password.setAttribute('type','text');
	} else {
		eyeicons.classList.replace('fa-eye-slash','fa-eye');
		password.setAttribute('type','password');
	}
	
})