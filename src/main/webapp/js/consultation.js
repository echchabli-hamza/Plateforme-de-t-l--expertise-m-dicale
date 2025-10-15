
const API_BASE = 'http://localhost:8080/medic-1/api/special';





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

    // (Optionally clear previous results)
    resultsContainer.innerHTML = '';

    // (Optionally display the results)
    data.forEach(item => {
      const div = document.createElement('div');
      div.textContent = item.fullname || JSON.stringify(item);
      resultsContainer.appendChild(div);
    });

  } catch (error) {
    console.error('Erreur lors de la récupération des spécialistes :', error);
  }
});





