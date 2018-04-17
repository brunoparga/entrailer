import Typed from 'typed.js';

function loadDynamicBannerText() {
  new Typed('#banner-typed-text', {
    strings: ["um filme", "uma sessão"],
    typeSpeed: 65,
    loop: true,
    attr: 'placeholder',
  });
}

export { loadDynamicBannerText };
