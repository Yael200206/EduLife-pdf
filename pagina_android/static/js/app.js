document.addEventListener("DOMContentLoaded", function () {
	// Verifica si es un dispositivo móvil (ancho de pantalla <= 767px)
	if (window.innerWidth >= 767) {
	  return; // No activa la funcionalidad en dispositivos móviles
	}
  
	const carousel = document.querySelector(".carousel");
	const cards = document.querySelectorAll(".card");
  
	let currentIndex = 0;
  
	function showCard(index) {
	  const newPosition = -index * 100 + "%";
	  carousel.style.transform = "translateX(" + newPosition + ")";
	}
  
	function nextCard() {
	  currentIndex = (currentIndex + 1) % cards.length;
	  showCard(currentIndex);
	}
  
	setInterval(nextCard, 4000); // Cambia la tarjeta cada 4 segundos (ajusta según sea necesario)
  });

  

document.addEventListener("DOMContentLoaded", function () {
	
	const carouselA = document.querySelector(".carouselA");
	const aviso = document.querySelectorAll(".aviso");

	let currentIndexA = 0;

	function showCard(index) {
		const newPosition = -index * 100 + "%";
		carouselA.style.transform = "translateX(" + newPosition + ")";
	}

	function nextCard() {
		currentIndexA = (currentIndexA + 1) % aviso.length;
		showCard(currentIndexA);
	}

	setInterval(nextCard, 5000); // Cambia la tarjeta cada 3 segundos (ajusta según sea necesario)
});


