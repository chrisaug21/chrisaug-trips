/**
 * Component System for Trip Pages
 * Loads and inserts HTML templates, initializes event listeners, and handles active states.
 */

// Wait for the document to be fully loaded
document.addEventListener('DOMContentLoaded', function() {
  // Initialize the component system
  initComponents();
});

/**
 * Initialize the component system by loading all templates and setting up the page
 */
function initComponents() {
  // Load the header template
  loadTemplate('../templates/header.html', 'header-container')
    .then(() => {
      // After header is loaded, set up mobile navigation
      setupMobileNavigation();
    })
    .catch(error => console.error('Error loading header:', error));
  
  // Load the trip navigation template
  loadTemplate('../templates/trip-nav.html', 'trip-nav-container')
    .then(() => {
      // After trip nav is loaded, set active links and initialize sticky behavior
      setActiveNavLinks();
      initializeStickyNav();
    })
    .catch(error => console.error('Error loading trip nav:', error));
}

/**
 * Load a template from a file and insert it into a container element
 * @param {string} templatePath - Path to the template file
 * @param {string} containerId - ID of the container element
 * @returns {Promise} - A promise that resolves when the template is loaded
 */
function loadTemplate(templatePath, containerId) {
  return new Promise((resolve, reject) => {
    const container = document.getElementById(containerId);
    
    if (!container) {
      reject(`Container ${containerId} not found`);
      return;
    }
    
    // Fetch the template file
    fetch(templatePath)
      .then(response => {
        if (!response.ok) {
          throw new Error(`Failed to load template: ${response.statusText}`);
        }
        return response.text();
      })
      .then(html => {
        // Insert the template HTML into the container
        container.innerHTML = html;
        resolve();
      })
      .catch(error => {
        console.error(`Error loading template ${templatePath}:`, error);
        reject(error);
      });
  });
}

/**
 * Set up mobile navigation toggle functionality
 */
function setupMobileNavigation() {
  const mobileNavToggle = document.querySelector('.mobile-nav-toggle');
  const nav = document.querySelector('nav');
  
  if (mobileNavToggle && nav) {
    mobileNavToggle.addEventListener('click', function() {
      nav.classList.toggle('mobile-nav-open');
    });
  }
}

/**
 * Set active state for navigation links based on current page
 */
function setActiveNavLinks() {
  // Get the current page pathname
  const currentPage = window.location.pathname.split('/').pop();
  
  // Set active state for trip navigation links
  const tripNavLinks = document.querySelectorAll('.trip-nav-link');
  
  tripNavLinks.forEach(link => {
    if (link.getAttribute('href') === currentPage) {
      link.classList.add('active');
    }
  });
  
  // Set active state for main navigation links
  const mainNavLinks = document.querySelectorAll('nav ul li a');
  
  mainNavLinks.forEach(link => {
    const linkPath = link.getAttribute('href');
    if (linkPath && currentPage.includes(linkPath) && linkPath !== '#' && linkPath !== '../index.html') {
      link.classList.add('active');
    } else if (currentPage === 'index.html' && linkPath === '../index.html') {
      link.classList.add('active');
    }
  });
  
  // Handle mobile trip home link
  const mobileHomeLink = document.querySelector('.mobile-trip-home-link');
  if (mobileHomeLink && (currentPage === '' || currentPage === 'index.html')) {
    mobileHomeLink.classList.add('active');
  }
}

/**
 * Initialize sticky navigation functionality
 */
function initializeStickyNav() {
  const tripNav = document.querySelector('.trip-nav');
  
  if (tripNav) {
    // First make sure headers and nav have the correct stacking order
    const header = document.querySelector('header');
    if (header) {
      header.style.zIndex = '900';
    }
    
    // Ensure the trip-nav has the correct sticky properties
    tripNav.style.position = 'sticky';
    tripNav.style.top = '0';
    tripNav.style.zIndex = '1000';
    
    // Always add the fixed-nav class for consistent appearance
    tripNav.classList.add('fixed-nav');
    
    // Handle scroll effects
    window.addEventListener('scroll', function() {
      if (window.scrollY > 10) {
        tripNav.classList.add('scrolled');
        // Force the sticky behavior by toggling the position property
        tripNav.style.position = 'sticky';
      } else {
        tripNav.classList.remove('scrolled');
      }
    });
    
    // Force a repaint to ensure sticky behavior takes effect
    setTimeout(function() {
      tripNav.style.position = 'static';
      setTimeout(function() {
        tripNav.style.position = 'sticky';
      }, 10);
    }, 0);
  }
}

/**
 * Initialize any page-specific functionality
 * @param {Object} options - Configuration options for the page
 */
function initPage(options = {}) {
  // Initialize map modal functionality if present
  initMapModal();
  
  // Execute any custom initialization function
  if (options.init && typeof options.init === 'function') {
    options.init();
  }
}

/**
 * Initialize map modal functionality
 */
function initMapModal() {
  const tripMap = document.getElementById('trip-map');
  const mapModal = document.getElementById('mapModal');
  const closeBtn = document.querySelector('.map-modal-close');
  
  if (tripMap && mapModal && closeBtn) {
    tripMap.addEventListener('click', function() {
      mapModal.style.display = 'flex';
      
      document.addEventListener('keydown', function(event) {
        if (event.key === 'Escape') {
          mapModal.style.display = 'none';
        }
      });
    });
    
    closeBtn.addEventListener('click', function() {
      mapModal.style.display = 'none';
    });
    
    window.addEventListener('click', function(event) {
      if (event.target === mapModal) {
        mapModal.style.display = 'none';
      }
    });
  }
} 