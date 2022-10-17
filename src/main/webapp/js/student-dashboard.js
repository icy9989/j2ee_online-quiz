const listitems = document.querySelectorAll('.listitems');
const dashboard = document.querySelector('#dashboard');
const course = document.querySelector('#course');
const display_courses = document.querySelectorAll('.display-courses');

listitems.forEach((listitem)=> {
    listitem.addEventListener('click', ()=> {
        removeAllActive();
        listitem.classList.add('actives');

        if(listitem.classList.contains('dashboards')) {
            dashboard.style.display = "block";
        } else if(listitem.classList.contains('courses')){
			course.style.display = "block";
		}        
    })
});

display_courses.forEach((display_course)=>{
	display_course.innerText = display_course.innerText.slice(0,13);
})


function removeAllActive() {
    listitems.forEach((listitem)=>{
        listitem.classList.remove('actives');
        dashboard.style.display = "none";
        course.style.display = "none";
    })
}
