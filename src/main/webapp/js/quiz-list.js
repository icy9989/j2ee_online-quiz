function tableSearch() {
    let input, filter, table, tr, td_quizName, i, txtValue;

    input = document.getElementById('search');
    filter = input.value.toLowerCase();
    table = document.getElementById('myTable');
    tr = document.getElementsByTagName('tr');
    
    for(let i = 0; i < tr.length; i++) {
        td_quizName = tr[i].getElementsByTagName('td')[1];
        if(td_quizName) {
            txtValue = td_quizName.textContent || td_quizName.innerText;
            if(txtValue.toLowerCase().indexOf(filter) > -1) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }
        
    
    }
}