  document.querySelector(".add-item").addEventListener("click", function(e) {
    e.preventDefault();
    var newItem = document.querySelector(".nested-fields").cloneNode(true);
    newItem.querySelectorAll("input").forEach(input => input.value = "");
    document.querySelector("form").insertBefore(newItem, document.querySelector(".form-group"));
  });

  document.querySelectorAll(".remove-item").forEach(button => {
    button.addEventListener("click", function(e) {
      e.preventDefault();
      this.closest(".nested-fields").remove();
    });
  });
