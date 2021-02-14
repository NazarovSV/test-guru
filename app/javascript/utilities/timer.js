document.addEventListener('turbolinks:load', app)

function app() {

    const element = document.getElementById('timer')
    
    if (element) {
        let timeout = element.dataset.timeout
        let id = element.dataset.id

        if (timeout > 0) {

            showTimer(element, timeout)

            let timer = setInterval(() => {
                timeout -= 1

                showTimer(element, timeout)

                if (timeout <= 0) {
                    clearTimeout(timer)
                    document.querySelector('form').submit();
                }
            }, 1000)
        }
    }
}

function div(val, by) {
    return (val - val % by) / by;
}


function showTimer(element, timeout) {
    let hours = div(timeout, 3600)
    let minutes = div(timeout % 3600, 60)
    let seconds = (timeout % (3600)) % 60

    if (timeout < 10) {
        element.classList.add("text-danger")
    }

    element.innerHTML = decorateTime(hours) + ':' + decorateTime(minutes) + ':' + decorateTime(seconds)
}

function decorateTime(number) {
    let result = number.toString()
    return result.length === 1 ? '0' + result : result
}
