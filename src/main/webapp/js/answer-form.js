const hours = document.getElementById('hours');
const minutes = document.getElementById('minutes');
const seconds = document.getElementById('seconds');

const endtimes = document.querySelector('.endtimes');

const arr = endtimes.value.split(" ");
const str = arr[0] +" "+ arr[1] +" "+ arr[2]+" "+ arr[5]+ " "+ arr[3];
const endtime = new Date(str);

function updatecountdown(){
	const currenttime = new Date();
	
	const diff = endtime - currenttime;
	
	const d = Math.floor(diff / 1000 / 60 / 60 / 24);
    
    const h = Math.floor(diff / 1000 / 60 / 60) % 24;
 
    const m = Math.floor(diff / 1000 / 60) % 60;
 
    const s = Math.floor(diff / 1000 ) % 60;

    hours.textContent = h < 10 ? "0"+h : h;
    minutes.innerText = m < 10 ? "0"+m : m;
    seconds.innerText = s < 10 ? "0"+s : s;

}

updatecountdown();

setInterval(updatecountdown, 1000);

const current_submit = new Date();
const diff_submit = endtime - current_submit;

 var auto_refresh = setInterval(
   function()
     {
    	submitform();
     }, diff_submit);

   function submitform()
     {
    	 document.getElementById('btn-submit').click();
     }
