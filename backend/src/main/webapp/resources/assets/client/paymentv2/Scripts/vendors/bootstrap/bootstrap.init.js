//====================BOOTSTRAP INIT=================//

// fix modal
// end fix modal
$(document).ready(function () {

  var modalEls = document.querySelectorAll('.modal')
  if (modalEls) {
    modalEls.forEach(el => {
      el.addEventListener('shown.bs.modal', function (event) {
        window.innerWidth < 769 ? BNS.on() : ''
      })
      el.addEventListener('hide.bs.modal', function (event) {
        BNS.off()
      })
    })
  }

  document.querySelectorAll('[data-bs-toast="toast"]').forEach(el => {
    var elID = el.getAttribute('toast-target').replace('#', '');
    el.addEventListener('click', () => {
      console.log(el)
      var bsAlert = new bootstrap.Toast(document.getElementById(elID));//inizialize it
      bsAlert.show();
    })
  })


  var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-tooltip="tooltip"]'))
  var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl, {
      html: true,
      popperConfig: {
        modifiers: {
          preventOverflow: {
            boundariesElement: 'viewport',
            escapeWithReference: true
          }
        },
      }
    })
  });
  document.querySelectorAll('.collapse').forEach(el => {
    bootstrap.Dropdown.getInstance(el.addEventListener('show.bs.collapse', function () {
      el.closest('.acc-group')?.classList.add('collapse-showing')
    }))
    bootstrap.Dropdown.getInstance(el.addEventListener('shown.bs.collapse', function () {
      el.closest('.acc-group')?.classList.remove('collapse-showing');
    }))
  })
});

document.querySelectorAll('[data-bs-stack-modal-target]').forEach(el => {
  el.addEventListener('click', e => {
    e.preventDefault()
    var bsTarget = el.getAttribute('data-bs-stack-modal-target');
    document.querySelector(bsTarget).style.zIndex = '3002';
    var myModal = new bootstrap.Modal(document.querySelector(bsTarget), {})
    myModal.show()
  });
})
//====================END BOOTSTRAP INIT=================//