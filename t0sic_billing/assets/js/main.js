$(document).ready(function(){
  var nameInput = document.getElementById('inner');
  var numberInput = document.getElementById('belop');
  var dateInput = document.getElementById('date');
  var reciver = document.getElementById('reciver');
  var sender = document.getElementById('sender');
  var belopOutput = document.getElementById('belop-upkey');


  window.addEventListener('message', function(event) {
    if (event.data.action == 'open') {
      $('.overlay').show();
      clearDocumnet();
      sender.innerText = event.data.sender;
      reciver.innerText = event.data.reciver;
      reciver.closestPlayer = event.data.closestplayer
      document.getElementById('pay').style.display = 'none';
      document.getElementById('inner').disabled = false;
      document.getElementById('date').disabled = false;
      document.getElementById('belop').disabled = false;
      document.getElementById('send').style.display = 'block';
      document.getElementById('pay').style.display = 'none';
    } else if (event.data.action == 'close') {
      $('.overlay').hide();
    }
  });

  document.onkeyup = function(data) {
    if (data.which == 27) {
        $('.overlay').hide();
        $.post('http://t0sic_billing/NUIFocusOff');
    }
  }

  document.getElementById("belop").addEventListener("keyup", output);

  function output() {
    belopOutput.innerHTML = numberInput.value
  }

  window.addEventListener('message', function(event) {
    if (event.data.action == 'reciver-open') {
      clearDocumnet();
      $('.overlay').show();
      reciverOpen();
    }
  });

  function reciverOpen() {
    clearDocumnet();
    reciver.innerText = event.data.reciver2;
    sender.innerText = event.data.sender;
    dateInput.value = event.data.date;
    nameInput.value = event.data.name;
    numberInput.value = event.data.belop;
    belopOutput.innerHTML = event.data.belop;

    $('.overlay').show();
    document.getElementById('inner').disabled = true;
    nameInput.style.background = 'white';
    document.getElementById('date').disabled = true;
    nameInput.style.background = 'white';
    document.getElementById('belop').disabled = true;
    nameInput.style.background = 'white';
    document.getElementById('send').style.display = 'none';
    document.getElementById('pay').style.display = 'block';
  }

  function clearDocumnet() {
    numberInput.value = "";
    nameInput.value = "";
    dateInput.value = "";
    reciver.innerText = "";
    sender.innerText = "";
    belopOutput.innerHTML = '';
  }

  document.getElementById('pay').addEventListener('click', function (e) {

    e.preventDefault();

    $('.overlay').hide();

    $.post('http://t0sic_billing/NUIFocusOff');

    $.post('http://t0sic_billing/pay', JSON.stringify({

      sum: numberInput.value
    }));
    
    clearDocumnet();
  })
  
  document.querySelector('form.pure-form').addEventListener('submit', function (e) {
  
      e.preventDefault();

      if (nameInput.value.length > 0 && numberInput.value.length > 0 && dateInput.value.length > 0 && sender.innerText != null && reciver.innerText != null) {
        $('.overlay').hide();
        
        $.post('http://t0sic_billing/NUIFocusOff');
        $.post('http://t0sic_billing/send', JSON.stringify({
          date: dateInput.value,
          reason: nameInput.value,
          sum: numberInput.value,
          reciver : reciver.innerText,
          sender: reciver.innerText,
          closestplayer: reciver.closestPlayer
        }));
      clearDocumnet()
      } else {
          document.getElementById('error').innerHTML = 'Please fill in all fields.';
      };
  });

});