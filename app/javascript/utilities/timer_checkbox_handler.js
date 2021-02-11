document.addEventListener('turbolinks:load', app)

function app() {
    let element = document.querySelector('.timer-checkbox')
    if (element) {
        element.addEventListener('change', displayTimeInput)
    }
}

function displayTimeInput(event) {
    
    let element = document.getElementById('test_timer')
    
    if (element) {
        if(event.target.checked) {
            element.classList.remove('hide')
        } else {
            element.classList.add('hide')
            element.value = ''
        }
    }
}