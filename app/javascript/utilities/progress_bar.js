document.addEventListener('turbolinks:load', app)

function app() {
    control = document.querySelector('.progress-bar')
    if (control) {
        calculateProgress(control)
    }
}

function calculateProgress(control) {
    currentProgress = control.dataset.currentProgress
    maxProgress = control.dataset.maxProgress
    displayProgress = (currentProgress / maxProgress) * 100;
    control.style.width = displayProgress + '%'
}