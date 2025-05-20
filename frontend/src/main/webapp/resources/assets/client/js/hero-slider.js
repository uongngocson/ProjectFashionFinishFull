const swiper = new Swiper('.heroSwiper', {
    // Optional parameters
    direction: 'horizontal', // 'vertical' or 'horizontal'
    loop: true, // Enable looping
    effect: 'fade', // Use fade effect for smooth transition
    fadeEffect: {
        crossFade: true // Enable cross-fade for smoother fade
    },
    autoplay: {
        delay: 4000, // Delay between transitions (in ms)
        disableOnInteraction: false, // Keep autoplaying even after user interaction
    },
    speed: 1000, // Transition speed (in ms)

    // If we need pagination
    pagination: {
        el: '.swiper-pagination',
        clickable: true, // Allow clicking on pagination bullets
    },

    // And if we need navigation buttons
    // navigation: {
    //     nextEl: '.swiper-button-next',
    //     prevEl: '.swiper-button-prev',
    // },

    // And if we need scrollbar
    // scrollbar: {
    //     el: '.swiper-scrollbar',
    // },
}); 