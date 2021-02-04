document.addEventListener('turbolinks:load', function() {
    let control = document.querySelector('.sort-by-title')

    if(control) control.addEventListener('click', sortRowsByTitle)
})

function sortRowsByTitle() {
    let ul = document.querySelector('.list-group')

    //NodeList
    //https://developer.mozilla.org/ru/docs/Web/API/NodeList
    let rows = ul.querySelectorAll('li')
    let sortedRows = []

    for(let i = 0; i < rows.length; i++) {
        sortedRows.push(rows[i])
    }

    let arrowUp = this.querySelector('.octicon-arrow-up')
    
    if(this.querySelector('.octicon-arrow-up').classList.contains('hide')) {                
        sortedRows.sort(compareRowsAsc)
        this.querySelector('.octicon-arrow-up').classList.remove('hide')
        this.querySelector('.octicon-arrow-down').classList.add('hide')
    } else {
        sortedRows.sort(compareRowsDesc)
        this.querySelector('.octicon-arrow-down').classList.remove('hide')
        this.querySelector('.octicon-arrow-up').classList.add('hide')
    }

    let sortedUl = document.createElement('ul')
    sortedUl.classList.add('list-group')
    sortedUl.classList.add('list-group-flush')
    sortedUl.appendChild(rows[0])

    for(let i = 0; i < sortedRows.length; i++) {
        sortedUl.appendChild(sortedRows[i])
    }

    ul.parentNode.replaceChild(sortedUl, ul)

}

function compareRowsAsc(row1, row2) {
    let testTitle1 = row1.textContent
    let testTitle2 = row2.textContent

    if(testTitle1 < testTitle2) {return -1}
    if(testTitle1 > testTitle2) {return 1}
    return 0
}

function compareRowsDesc(row1, row2) {
    let testTitle1 = row1.textContent
    let testTitle2 = row2.textContent

    if(testTitle1 < testTitle2) {return 1}
    if(testTitle1 > testTitle2) {return -1}
    return 0
}
