import Typed from 'typed.js';

function loadDynamicBannerText() {
  new Typed('#banner-typed-text', {
    strings: ["um filme", "uma sessão", "um horário"],
    typeSpeed: 35,
    loop: true,
    loopCount: 3,
    attr: 'placeholder',
  });
}

export { loadDynamicBannerText };
