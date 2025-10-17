
const API_BASE = 'http://localhost:8080/medic-1/userApi/special';





const specialtyFilter = document.getElementById('specialtyFilter');
const amountInput = document.getElementById('amount');
const filterBtn = document.getElementById('filter-btn');
const resultsContainer = document.getElementById('specialistsResults');

filterBtn.addEventListener('click', async () => {
  const role = specialtyFilter.value;
  const amount = amountInput.value;

  try {

  console
    const response = await fetch(`${API_BASE}?role=${encodeURIComponent(role)}&tarif=${encodeURIComponent(amount)}`);
    if (!response.ok) throw new Error('Erreur réseau');

    const data = await response.json();
    console.log('Réponse API :', data);


    resultsContainer.innerHTML = '';

 resultsContainer.innerHTML = '';

    data.forEach(item => {
      const btn = document.createElement('button');
      btn.textContent = item.fullName || item.username || JSON.stringify(item);
      btn.dataset.id = item.id;
      btn.classList.add('spec-button');
      resultsContainer.appendChild(btn);

      btn.addEventListener('click', async () => {
        try {
          const creneauRes = await fetch(`http://localhost:8080/medic-1/creneauApi?userId=${item.id}`);
          const creneauData = await creneauRes.json();
          const columns = [
              "2025-10-15", "2025-10-16", "2025-10-17", "2025-10-18",
              "2025-10-19", "2025-10-20", "2025-10-21"
          ];


          const times = [...new Set(creneauData.map(slot => slot.debut.slice(11,16) + ' - ' + slot.fin.slice(11,16)))].sort();


          const calendarMap = {};
          columns.forEach(day => calendarMap[day] = {});
          creneauData.forEach(slot => {
              const day = slot.debut.slice(0,10);
              const time = slot.debut.slice(11,16) + ' - ' + slot.fin.slice(11,16);
              if(calendarMap[day]) calendarMap[day][time] = slot;
          });


          const tbody = document.getElementById('calendarBody');
          times.forEach(time => {
              const tr = document.createElement('tr');

              const tdTime = document.createElement('td');
              tdTime.textContent = time;
              tr.appendChild(tdTime);

              columns.forEach(day => {
                  const td = document.createElement('td');
                  const slot = calendarMap[day][time];

                  if(slot){


                      if(slot.disponible){
                          const input = document.createElement('input');
                          input.type = 'radio';
                          input.name = 'selectedSlot';
                          input.value = slot.id;
                          td.appendChild(input);
                      } else {
                          td.textContent = '📅 Session réservée';
                      }
                  }
                  tr.appendChild(td);
              });

              tbody.appendChild(tr);
          });

        } catch (err) {
          console.error('Erreur récupération creneaux:', err);
        }
      });
    });

  } catch (error) {
    console.error('Erreur lors de la récupération des spécialistes :', error);
  }
});


document.getElementById("confirmButton").addEventListener("click", () => {

    const selectedInput = document.querySelector("input[name='selectedSlot']:checked");

    if (!selectedInput) {
        alert("Please select a slot first!");
        return;
    }

    const creneauId = selectedInput.value;
    confirm(creneauId);
});




function confirm(creneauid) {
    const urlParams = new URLSearchParams(window.location.search);
    const consultationId = urlParams.get('consultationId');


    const formData = new URLSearchParams();
    formData.append("consultationId", consultationId);
    formData.append("creneauId", creneauid);

    fetch("http://localhost:8080/medic-1/teleExpertise", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: formData.toString()
    })
    .then(res => res.json())
    .then(data => console.log(data))
    .catch(err => console.error(err));
}


const modal = document.getElementById('tele');
const launch = document.getElementById('expert');
const closeBtn = document.getElementById('closeModal');

launch.addEventListener('click', () => {
  modal.style.display = 'flex';
});

closeBtn.addEventListener('click', () => {
  modal.style.display = 'none';
});

// Optional: close if you click outside the modal content
modal.addEventListener('click', (e) => {
  if (e.target === modal) modal.style.display = 'none';
});




