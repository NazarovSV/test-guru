document.addEventListener('turbolinks:load', function() {
    let control = document.querySelector('.password-confirmation')
    if(control) { 
        control.addEventListener('change', passwordMatching) 
        control.addEventListener('input', clearWarning)
    }
})

function passwordMatching() {  
    let password = document.getElementById('user_password').value
    let passwordConfirmation = document.getElementById('user_password_confirmation').value
    if(passwordConfirmation && password !== passwordConfirmation) {
        this.querySelector('.octicon-alert').classList.remove('hide')
        this.querySelector('.password-matching-failed').classList.remove('hide')
    }
}

function clearWarning() {
    this.querySelector('.octicon-alert').classList.add('hide')
        this.querySelector('.password-matching-failed').classList.add('hide')
}