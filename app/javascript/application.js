//= require cocoon

document.addEventListener("DOMContentLoaded", function() {
  document.getElementById("submit-link").addEventListener("click", function(event) {
    event.preventDefault();

    const form = document.querySelector("form");

    // Send the form via AJAX to avoid page refresh
    fetch(form.action, {
      method: form.method,
      body: new FormData(form),
      headers: {
        "X-Requested-With": "XMLHttpRequest"
      }
    })
    .then(response => response.json())
    .then(data => {
      if (data.redirect_to) {
        // Show success message (e.g., Toast)
        showToast(data.message);

        // Redirect to the show page after a delay
        setTimeout(() => {
          window.location.href = data.redirect_to;
        }, 2000); // Delay for 2 seconds before redirect
      } else {
        // Handle errors or validation failures
        alert("Something went wrong. Please check the form fields.");
      }
    })
    .catch(error => {
      console.error("Error:", error);
      alert("An error occurred while submitting the form.");
    });
  });
});

// Function to display a toast message
function showToast(message) {
  const toast = document.createElement("div");
  toast.classList.add("toast");
  toast.innerText = message;
  document.body.appendChild(toast);

  // Remove toast after 3 seconds
  setTimeout(() => {
    toast.remove();
  }, 3000);
}
import "./controllers"
