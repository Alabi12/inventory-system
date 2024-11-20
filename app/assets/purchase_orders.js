document.addEventListener('DOMContentLoaded', function () {
  // Add new purchase order item
  document.getElementById('add-item').addEventListener('click', function(e) {
    e.preventDefault();

    let newItem = document.createElement('div');
    newItem.classList.add('nested-fields');
    newItem.innerHTML = document.querySelector('.nested-fields').innerHTML;
    document.getElementById('purchase-order-items').appendChild(newItem);
  });

  // Remove purchase order item
  document.querySelectorAll('.remove-item').forEach(function(button) {
    button.addEventListener('click', function(e) {
      e.preventDefault();
      this.closest('.nested-fields').remove();
    });
  });
});
