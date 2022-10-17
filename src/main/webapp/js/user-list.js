function tableSearch() {
    let input, filter, table, tr, td_userName, i, txtValue;

    input = document.getElementById('search');
    filter = input.value.toLowerCase();
    table = document.getElementById('myTable');
    tr = document.getElementsByTagName('tr');
    
    for(let i = 0; i < tr.length; i++) {
        td_courseName = tr[i].getElementsByTagName('td')[1];
        if(td_courseName) {
            txtValue = td_courseName.textContent || td_courseNamee.innerText;
            if(txtValue.toLowerCase().indexOf(filter) > -1) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }

    }
}

