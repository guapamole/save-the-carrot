function showSpinner() {
  const spinner = document.querySelector('.spinner-border');
  const content = document.querySelector('.content');

  spinner.style.display = 'none';
  content.classList.remove('hidden');
}
