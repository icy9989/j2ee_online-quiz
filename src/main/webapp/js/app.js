const togglers = document.querySelector('.togglers');
togglers.addEventListener('click',()=>{
    togglers.classList.toggle('fivesixs');
});

$(function () {
    $(document).click(function (event) {
        var clickover = $(event.target);
        var _opened = $(".navbar-collapse").hasClass("navbar-collapse collapse show");
        if (_opened === true && !clickover.hasClass("navbar-toggler")) {
            $("button.navbar-toggler").click();
        }
    });
});    

// START CALENDAR
const date = new Date();
const day = document.getElementById('day');
const year = document.getElementById('year');
const month = document.getElementById('month');
const daydate = document.getElementById('daydate');
let months = ['Janurary','February','March','April','May','June','July','August','September','October','November','December'];

day.innerText = displayday();
month.innerText = months[date.getMonth()];
daydate.innerText = date.getDate();
year.innerText = date.getFullYear();

function displayday() {
    switch(date.getDay()) {
        case 0:
            return 'SUNDAY';
        case 1:
            return 'MONDAY';
        case 2:
            return 'TUESDAY';
        case 3:
            return 'WEDNESDAY';
        case 4:
            return 'THURSDAY';
        case 5:
            return 'FRIDAY';
        case 6:
            return 'SATURDAY';
    }
};
// END CALENDAR

// Extract Username for porfile
const profiletexts = document.querySelector('.profiletexts');
let letter = profiletexts.textContent.charAt(0).toUpperCase();
console.log(letter);
profiletexts.textContent = letter;

// show password
const eyeiconone = document.querySelector('.eyeiconones');
const eyeicontwo = document.querySelector('.eyeicontwos');
const pwone = document.querySelector('.pwones');
const pwtwo = document.querySelector('.pwtwos');

openPw(eyeiconone,pwone);
openPw(eyeicontwo,pwtwo);

function openPw(eyeicon,pw) {
    eyeicon.addEventListener('click', ()=> {
        if(eyeicon.classList.contains('fa-eye')) {
            eyeicon.classList.replace('fa-eye','fa-eye-slash');
            pw.setAttribute('type','text');
        } else {
             eyeicon.classList.replace('fa-eye-slash','fa-eye');
            pw.setAttribute('type','password');
        }
    })
}

setTimeout(function () {
  
            // Closing the alert
            $('.alert').alert('close');
        }, 5000);
        
$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})