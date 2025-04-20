/**
 * Main JavaScript file for the Trip Guides site
 */

document.addEventListener('DOMContentLoaded', function() {
  // Mobile navigation toggle
  const mobileNavToggle = document.querySelector('.mobile-nav-toggle');
  const nav = document.querySelector('nav');
  
  if (mobileNavToggle && nav) {
    mobileNavToggle.addEventListener('click', function() {
      nav.classList.toggle('mobile-nav-open');
    });
  }
  
  // Highlight active page in navigation
  const currentLocation = window.location.pathname;
  const navLinks = document.querySelectorAll('nav a');
  
  navLinks.forEach(link => {
    const linkPath = link.getAttribute('href');
    if (linkPath && currentLocation.endsWith(linkPath) && linkPath !== '#') {
      link.classList.add('active');
    }
  });
  
  // Highlight active day in trip navigation if on day pages
  if (currentLocation.includes('day')) {
    const dayLinks = document.querySelectorAll('.day-link');
    const currentDay = currentLocation.split('/').pop();
    
    dayLinks.forEach(link => {
      if (link.getAttribute('href') === currentDay) {
        link.classList.add('active');
      }
    });
  }
}); 