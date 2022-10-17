function tableSearch() {
    let input, filter, table, tr, td_courseName, i, txtValue;

    input = document.getElementById('search');
    filter = input.value.toLowerCase();
    table = document.getElementById('myTable');
    tr = document.getElementsByTagName('tr');
    
    for(let i = 0; i < tr.length; i++) {
        td_courseName = tr[i].getElementsByTagName('td')[2];
        if(td_courseName) {
            txtValue = td_courseName.textContent || td_courseName.innerText;
            if(txtValue.toLowerCase().indexOf(filter) > -1) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }
        
    
    }
}