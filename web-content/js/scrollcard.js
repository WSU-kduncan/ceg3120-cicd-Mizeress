const container = document.querySelector('.scroll-container');
const cards = document.querySelectorAll('.gallery-card');
const DEAD_TIME = 250; 
let debounceTimer;

cards.forEach(card => {
  card.addEventListener('mouseenter', () => {
    clearTimeout(debounceTimer);

    debounceTimer = setTimeout(() => {
      // 1. Remove zoom from all others
      cards.forEach(c => c.classList.remove('active'));

      // 2. Scroll the container to center the card
      card.scrollIntoView({
        behavior: 'smooth',
        block: 'nearest',
        inline: 'center'
      });

      // 3. Trigger zoom ONLY after scroll starts to prevent visual overlap
      setTimeout(() => {
        card.classList.add('active');
      }, 100); 

    }, DEAD_TIME);
  });

  card.addEventListener('mouseleave', () => {
    clearTimeout(debounceTimer);
  });
});
