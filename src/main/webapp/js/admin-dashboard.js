const listitems = document.querySelectorAll('.listitems');
const dashboard = document.querySelector('#dashboard');
const student = document.querySelector('#student');
const instructor = document.querySelector('#instructor');
const course = document.querySelector('#course');

listitems.forEach((listitem)=> {
    listitem.addEventListener('click', ()=> {
        removeAllActive();
        listitem.classList.add('actives');

        if(listitem.classList.contains('dashboards')) {
            dashboard.style.display = "block";
        } else if(listitem.classList.contains('students')) {
            student.style.display = "block";
        } else if(listitem.classList.contains('instructors')) {
            instructor.style.display = "block";
        } else if(listitem.classList.contains('courses')){
			course.style.display = "block";
		}        
    })
});

function removeAllActive() {
    listitems.forEach((listitem)=>{
        listitem.classList.remove('actives');
        dashboard.style.display = "none";
        student.style.display = "none";
        instructor.style.display = "none";
        course.style.display = "none";
    })
}






