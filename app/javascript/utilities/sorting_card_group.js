document.addEventListener('turbolinks:load', function() {
    let control = document.querySelector('.btn-sort')
    if(control) control.addEventListener('click', sortCardByTitle)
})

function sortCardByTitle() {
    let cardGroup = document.querySelector('.card-group')
    let cards = cardGroup.querySelectorAll('.test-card')

    let sortedCards = []

    for(let i = 0; i < cards.length; i++) {
        sortedCards.push(cards[i])
    }

    
     if(this.querySelector('.octicon-arrow-up').classList.contains('hide')) {                
        sortedCards.sort(compareCardAsc)
        this.querySelector('.octicon-arrow-up').classList.remove('hide')
        this.querySelector('.octicon-arrow-down').classList.add('hide')
    } else {
        sortedCards.sort(compareCardDesc)
        this.querySelector('.octicon-arrow-down').classList.remove('hide')
        this.querySelector('.octicon-arrow-up').classList.add('hide')
    }

    let sortedCardsGroup = document.createElement('div')
    sortedCardsGroup.classList.add('card-group')
    
    sortedCardsGroup.appendChild(cards[0])

    for(let i = 0; i < sortedCards.length; i++) {
      sortedCardsGroup.appendChild(sortedCards[i])
    }

    cardGroup.parentNode.replaceChild(sortedCardsGroup, cardGroup)

}

function compareCardAsc(firstCard, secondCard) {
    let firstCardTitle = firstCard.querySelector('.lead').textContent
    let secondCardTitle = secondCard.querySelector('.lead').textContent

    if(firstCardTitle < secondCardTitle) {return -1}
    if(firstCardTitle > secondCardTitle) {return 1}
    return 0
}

function compareCardDesc(firstCard, secondCard) {
    let firstCardTitle = firstCard.querySelector('.lead').textContent
    let secondCardTitle = secondCard.querySelector('.lead').textContent

    if(firstCardTitle < secondCardTitle) {return 1}
    if(firstCardTitle > secondCardTitle) {return -1}
    return 0
}
