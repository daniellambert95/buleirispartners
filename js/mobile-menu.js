(function () {
    var CSS = [
        '#bip-mobile-menu{display:none;position:fixed;inset:0;z-index:99999;background:#bc8947;',
        'flex-direction:column;align-items:stretch;overflow-y:auto;}',
        '#bip-mobile-menu.bip-open{display:flex;}',
        '#bip-menu-close{position:absolute;top:20px;left:20px;background:none;border:none;cursor:pointer;',
        'padding:8px;line-height:1;z-index:1;}',
        '#bip-menu-close span{display:block;width:22px;height:2px;background:white;margin:4px 0;}',
        '#bip-menu-close span:first-child{transform:rotate(45deg) translate(4px,4px);}',
        '#bip-menu-close span:last-child{transform:rotate(-45deg) translate(4px,-4px);}',
        '#bip-mobile-menu nav{display:flex;flex-direction:column;align-items:center;justify-content:center;',
        'flex:1;padding:80px 30px 40px;width:100%;box-sizing:border-box;}',
        '.bip-item{width:100%;max-width:400px;text-align:center;',
        'border-bottom:1px solid rgba(255,255,255,0.25);}',
        '.bip-item:first-child{border-top:1px solid rgba(255,255,255,0.25);}',
        '.bip-item a,.bip-stoggle{display:block;width:100%;padding:18px 0;color:white;',
        'font-size:1.15rem;font-family:inherit;font-weight:400;letter-spacing:0.02em;',
        'text-decoration:none;text-align:center;background:none;border:none;cursor:pointer;',
        'box-sizing:border-box;}',
        '.bip-item a:hover,.bip-stoggle:hover{color:rgba(255,255,255,0.75);text-decoration:none;}',
        '.bip-submenu{display:none;padding:0 0 12px;}',
        '.bip-submenu.bip-open{display:block;}',
        '.bip-submenu a{display:block;padding:10px 0;color:rgba(255,255,255,0.85);',
        'font-size:1rem;text-decoration:none;}',
        '.bip-submenu a:hover{color:white;}',
        '.bip-cta{width:100%;max-width:400px;margin-top:28px;}',
        '.bip-cta a{display:block;width:100%;padding:16px 20px;background:#1C3D5A;color:white;',
        'text-align:center;font-size:1rem;font-weight:500;text-decoration:none;border-radius:4px;',
        'letter-spacing:0.03em;box-sizing:border-box;}',
        '.bip-cta a:hover{background:#163149;color:white;text-decoration:none;}',
        '.navbar-full-screen-menu-inner{display:none!important;}'
    ].join('');

    var style = document.createElement('style');
    style.textContent = CSS;
    document.head.appendChild(style);

    var HTML = [
        '<div id="bip-mobile-menu" role="dialog" aria-modal="true" aria-label="Navigation menu">',
        '<button id="bip-menu-close" aria-label="Close menu"><span></span><span></span></button>',
        '<nav>',
        '<div class="bip-item"><a href="index.html">Home</a></div>',
        '<div class="bip-item"><a href="about.html">About Us</a></div>',
        '<div class="bip-item">',
        '<button class="bip-stoggle" aria-expanded="false" aria-controls="bip-submenu">Services</button>',
        '<div class="bip-submenu" id="bip-submenu">',
        '<a href="service-fractional-cfo.html">Fractional CFO</a>',
        '<a href="service-bookkeeping.html">Accounting &amp; Bookkeeping</a>',
        '<a href="service-reporting.html">Reporting &amp; Financial Statements</a>',
        '<a href="service-tax-coordination.html">Tax Coordination</a>',
        '<a href="service-audit-preparation.html">Audit Preparation</a>',
        '<a href="service-business-sale-advisory.html">Business Acquisition and Sale Advisory</a>',
        '</div></div>',
        '<div class="bip-item"><a href="faq.html">FAQ</a></div>',
        '<div class="bip-item"><a href="contact.html">Contact</a></div>',
        '<div class="bip-cta">',
        '<a href="https://calendly.com/ben-hogan-blueirispartners/new-meeting" target="_blank" rel="noopener">',
        'Book Free Consultation</a>',
        '</div>',
        '</nav></div>'
    ].join('');

    var container = document.createElement('div');
    container.innerHTML = HTML;
    document.body.appendChild(container.firstElementChild);

    var menu = document.getElementById('bip-mobile-menu');
    var closeBtn = document.getElementById('bip-menu-close');
    var stoggle = menu.querySelector('.bip-stoggle');
    var submenu = document.getElementById('bip-submenu');

    function openMenu() {
        menu.classList.add('bip-open');
        document.body.style.overflow = 'hidden';
    }

    function closeMenu() {
        menu.classList.remove('bip-open');
        document.body.style.overflow = '';
    }

    closeBtn.addEventListener('click', closeMenu);

    menu.addEventListener('click', function (e) {
        if (e.target === menu) closeMenu();
    });

    document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape') closeMenu();
    });

    stoggle.addEventListener('click', function () {
        var isOpen = submenu.classList.toggle('bip-open');
        stoggle.setAttribute('aria-expanded', isOpen ? 'true' : 'false');
    });

    // Intercept the hamburger — the theme adds data-bs-toggle="collapse" which we need to suppress
    function bindHamburger() {
        var toggler = document.querySelector('header .navbar-toggler');
        if (!toggler || toggler._bipBound) return;
        toggler._bipBound = true;

        // Prevent Bootstrap Collapse from firing
        toggler.removeAttribute('data-bs-toggle');
        toggler.removeAttribute('data-bs-target');

        toggler.addEventListener('click', function (e) {
            e.preventDefault();
            e.stopImmediatePropagation();
            openMenu();
        });
    }

    // Run after theme JS has had a chance to set up (main.js fires on DOMContentLoaded)
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', bindHamburger);
    } else {
        bindHamburger();
    }
    // Fallback in case theme JS runs late
    setTimeout(bindHamburger, 100);
    setTimeout(bindHamburger, 500);
})();
