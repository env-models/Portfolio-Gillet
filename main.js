/* ==========================================================================
   Raphael Gillet — portfolio
   Plain JS, no build step, no dependencies.

   1. Scroll reveals (IntersectionObserver, fade + translateY)
   2. Count-up stats (first time their section enters view)
   3. Subtle parallax on [data-parallax] (requestAnimationFrame, translate3d)
   4. Hero canvas: drifting points on a slow flow field
   5. Top bar border once scrolled

   Everything respects prefers-reduced-motion.
   ========================================================================== */

(function () {
  'use strict';

  var root = document.documentElement;
  root.classList.add('js');

  var reduceMq = window.matchMedia('(prefers-reduced-motion: reduce)');
  var reduce = reduceMq.matches;
  var onReduceChange = [];

  function listenMq(mq, fn) {
    if (mq.addEventListener) mq.addEventListener('change', fn);
    else if (mq.addListener) mq.addListener(fn);
  }

  listenMq(reduceMq, function (e) {
    reduce = e.matches;
    for (var i = 0; i < onReduceChange.length; i++) onReduceChange[i]();
  });

  var hasIO = 'IntersectionObserver' in window;

  /* ----------------------------------------------------------------------
     1. Reveals
     ---------------------------------------------------------------------- */

  (function reveals() {
    var items = document.querySelectorAll('.reveal');
    if (!items.length) return;

    function showAll() {
      for (var i = 0; i < items.length; i++) items[i].classList.add('is-visible');
    }

    if (reduce || !hasIO) {
      showAll();
      return;
    }

    var io = new IntersectionObserver(function (entries) {
      for (var i = 0; i < entries.length; i++) {
        if (entries[i].isIntersecting) {
          entries[i].target.classList.add('is-visible');
          io.unobserve(entries[i].target);
        }
      }
    }, { rootMargin: '0px 0px -8% 0px', threshold: 0.05 });

    for (var i = 0; i < items.length; i++) io.observe(items[i]);

    onReduceChange.push(function () {
      if (reduce) showAll();
    });
  })();

  /* ----------------------------------------------------------------------
     2. Counters
     ---------------------------------------------------------------------- */

  (function counters() {
    var items = document.querySelectorAll('.count[data-target]');
    if (!items.length || reduce || !hasIO) return; // final values are already in the HTML

    function group(n) {
      return String(n).replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    }

    function animate(el) {
      var target = parseFloat(el.getAttribute('data-target'));
      if (isNaN(target)) return;
      var prefix = el.getAttribute('data-prefix') || '';
      var suffix = el.getAttribute('data-suffix') || '';
      var finalText = el.textContent;
      var duration = 1200;
      var start = null;

      function frame(now) {
        if (start === null) start = now;
        var p = Math.min(1, (now - start) / duration);
        var eased = 1 - Math.pow(1 - p, 3); // ease-out cubic
        var value = Math.round(target * eased);
        el.textContent = prefix + group(value) + suffix;
        if (p < 1) requestAnimationFrame(frame);
        else el.textContent = finalText; // land on exactly the authored text
      }

      el.textContent = prefix + group(0) + suffix;
      requestAnimationFrame(frame);
    }

    var io = new IntersectionObserver(function (entries) {
      for (var i = 0; i < entries.length; i++) {
        if (entries[i].isIntersecting) {
          animate(entries[i].target);
          io.unobserve(entries[i].target);
        }
      }
    }, { threshold: 0.5 });

    for (var i = 0; i < items.length; i++) io.observe(items[i]);
  })();

  /* ----------------------------------------------------------------------
     3. Parallax + top bar state (one scroll listener, rAF-throttled)
     ---------------------------------------------------------------------- */

  (function scrollEffects() {
    var topbar = document.querySelector('.topbar');
    var nodes = document.querySelectorAll('[data-parallax]');
    var items = [];
    for (var i = 0; i < nodes.length; i++) {
      var factor = parseFloat(nodes[i].getAttribute('data-parallax'));
      items.push({
        el: nodes[i],
        f: isNaN(factor) ? 0.07 : Math.max(-0.1, Math.min(0.1, factor)),
        ref: nodes[i].closest('section') || nodes[i].parentElement
      });
    }

    var ticking = false;
    var wideMq = window.matchMedia('(min-width: 768px)');

    function parallaxAllowed() {
      return !reduce && wideMq.matches;
    }

    function resetParallax() {
      for (var i = 0; i < items.length; i++) items[i].el.style.removeProperty('--py');
    }

    function update() {
      ticking = false;
      if (topbar) topbar.classList.toggle('is-scrolled', window.scrollY > 8);
      if (!parallaxAllowed()) return;

      var vh = window.innerHeight;
      for (var i = 0; i < items.length; i++) {
        var it = items[i];
        var r = it.ref.getBoundingClientRect();
        if (r.bottom < -vh || r.top > vh * 2) continue; // far off-screen, skip
        var delta = (r.top + r.height / 2) - vh / 2;      // section centre vs viewport centre
        it.el.style.setProperty('--py', (-delta * it.f).toFixed(1) + 'px');
      }
    }

    function onScroll() {
      if (!ticking) {
        ticking = true;
        requestAnimationFrame(update);
      }
    }

    window.addEventListener('scroll', onScroll, { passive: true });
    window.addEventListener('resize', onScroll, { passive: true });
    listenMq(wideMq, function () {
      if (!parallaxAllowed()) resetParallax();
      onScroll();
    });
    onReduceChange.push(function () {
      if (!parallaxAllowed()) resetParallax();
      onScroll();
    });
    update();
  })();

  /* ----------------------------------------------------------------------
     4. Hero canvas: drifting points on a slow flow field
     ---------------------------------------------------------------------- */

  (function heroCanvas() {
    var canvas = document.querySelector('.hero__canvas');
    if (!canvas || !canvas.getContext) return;
    var hero = canvas.parentElement;
    var ctx = canvas.getContext('2d', { alpha: false });
    if (!ctx) return;

    // Keep the canvas background identical to the page background.
    var bg = (getComputedStyle(root).getPropertyValue('--bg') || '').trim();
    if (!/^#[0-9a-f]{6}$/i.test(bg)) bg = '#0b0b0c';
    var accent = (getComputedStyle(root).getPropertyValue('--accent-rgb') || '').trim() || '109, 179, 255';

    var TRAIL = 10;          // samples kept per point
    var SAMPLE_MS = 60;      // time between trail samples
    var SPEED = 26;          // px per second (times a per-point factor)

    var w = 0, h = 0, pts = [], linkR = 90, linkR2 = linkR * linkR;
    var raf = 0, last = 0, t = 0, sampleAcc = 0;
    var inView = true, pageVisible = !document.hidden;

    // Touch devices get ~30 fps (every other frame) to save battery; pointers get 60.
    var coarseMq = window.matchMedia('(pointer: coarse)');
    var coarse = coarseMq.matches, skipFrame = false;
    listenMq(coarseMq, function (e) { coarse = e.matches; });

    function rand(a, b) { return a + Math.random() * (b - a); }

    function spawn(p) {
      p.x = rand(0, w);
      p.y = rand(0, h);
      p.s = rand(0.6, 1.4);
      p.trail = [];
      return p;
    }

    function seed() {
      var n = Math.round(Math.max(160, Math.min(220, (w * h) / 5200)));
      pts = [];
      for (var i = 0; i < n; i++) pts.push(spawn({}));
      linkR = Math.max(60, Math.min(110, Math.min(w, h) * 0.13));
      linkR2 = linkR * linkR;
    }

    // Cheap, smooth pseudo-noise angle field.
    function field(x, y, time) {
      var nx = x / w, ny = y / h;
      return Math.sin(nx * 3.1 + time * 0.30) * 1.35
        + Math.cos(ny * 2.7 - time * 0.22) * 1.15
        + Math.sin((nx + ny) * 4.3 + time * 0.17) * 0.7;
    }

    function step(dt) {
      t += dt;
      sampleAcc += dt * 1000;
      var takeSample = sampleAcc >= SAMPLE_MS;
      if (takeSample) sampleAcc = 0;

      for (var i = 0; i < pts.length; i++) {
        var p = pts[i];
        var a = field(p.x, p.y, t);
        p.x += Math.cos(a) * SPEED * p.s * dt;
        p.y += Math.sin(a) * SPEED * p.s * dt;
        if (p.x < -12 || p.x > w + 12 || p.y < -12 || p.y > h + 12) {
          spawn(p);
          continue;
        }
        if (takeSample) {
          p.trail.push(p.x, p.y);
          if (p.trail.length > TRAIL * 2) p.trail.splice(0, 2);
        }
      }
    }

    function draw() {
      ctx.fillStyle = bg;
      ctx.fillRect(0, 0, w, h);

      // Connections between nearby points (two alpha buckets by distance).
      var near = [], far = [];
      for (var i = 0; i < pts.length; i++) {
        var a = pts[i];
        for (var j = i + 1; j < pts.length; j++) {
          var b = pts[j];
          var dx = a.x - b.x, dy = a.y - b.y;
          var d2 = dx * dx + dy * dy;
          if (d2 < linkR2) (d2 < linkR2 * 0.35 ? near : far).push(a.x, a.y, b.x, b.y);
        }
      }
      ctx.lineWidth = 1;
      strokeSegments(far, 'rgba(' + accent + ', 0.08)');
      strokeSegments(near, 'rgba(' + accent + ', 0.2)');

      // Trails.
      ctx.lineWidth = 1;
      ctx.strokeStyle = 'rgba(230, 230, 230, 0.32)';
      ctx.beginPath();
      for (var k = 0; k < pts.length; k++) {
        var tr = pts[k].trail;
        if (tr.length < 4) continue;
        ctx.moveTo(tr[0], tr[1]);
        for (var m = 2; m < tr.length; m += 2) ctx.lineTo(tr[m], tr[m + 1]);
        ctx.lineTo(pts[k].x, pts[k].y);
      }
      ctx.stroke();

      // Heads.
      ctx.fillStyle = 'rgba(230, 230, 230, 0.85)';
      for (var q = 0; q < pts.length; q++) {
        ctx.fillRect(pts[q].x - 0.75, pts[q].y - 0.75, 1.5, 1.5);
      }
    }

    function strokeSegments(seg, style) {
      if (!seg.length) return;
      ctx.strokeStyle = style;
      ctx.beginPath();
      for (var i = 0; i < seg.length; i += 4) {
        ctx.moveTo(seg[i], seg[i + 1]);
        ctx.lineTo(seg[i + 2], seg[i + 3]);
      }
      ctx.stroke();
    }

    function staticFrame() {
      // One still image of the field: a handful of short steps to form trails, then draw.
      sampleAcc = SAMPLE_MS;
      for (var i = 0; i < TRAIL; i++) step(SAMPLE_MS / 1000);
      draw();
    }

    function loop(now) {
      raf = 0;
      if (coarse) {
        skipFrame = !skipFrame;
        if (skipFrame) {
          if (shouldRun()) raf = requestAnimationFrame(loop);
          return;
        }
      }
      var dt = Math.min(0.05, (now - last) / 1000) || 0;
      last = now;
      step(dt);
      draw();
      if (shouldRun()) raf = requestAnimationFrame(loop);
    }

    function shouldRun() {
      return inView && pageVisible && !reduce && w > 0 && h > 0;
    }

    function sync() {
      if (shouldRun()) {
        if (!raf) {
          last = performance.now();
          raf = requestAnimationFrame(loop);
        }
      } else if (raf) {
        cancelAnimationFrame(raf);
        raf = 0;
      }
    }

    function resize() {
      var rect = hero.getBoundingClientRect();
      var nw = Math.max(1, Math.round(rect.width));
      var nh = Math.max(1, Math.round(rect.height));
      if (nw === w && nh === h) return;
      w = nw;
      h = nh;
      var dpr = Math.min(window.devicePixelRatio || 1, 2);
      canvas.width = Math.round(w * dpr);
      canvas.height = Math.round(h * dpr);
      ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
      seed();
      if (reduce) staticFrame();
      else draw();
      sync();
    }

    // Size to the hero only; re-size only when the hero's own box changes.
    if ('ResizeObserver' in window) {
      var ro = new ResizeObserver(function () { resize(); });
      ro.observe(hero);
    } else {
      window.addEventListener('resize', resize, { passive: true });
    }
    resize();

    // Pause when scrolled away or when the tab is hidden.
    if (hasIO) {
      new IntersectionObserver(function (entries) {
        inView = entries[0].isIntersecting;
        sync();
      }, { threshold: 0 }).observe(hero);
    }
    document.addEventListener('visibilitychange', function () {
      pageVisible = !document.hidden;
      sync();
    });

    onReduceChange.push(function () {
      if (reduce) {
        sync();          // stops the loop
        staticFrame();
      } else {
        sync();
      }
    });
  })();
})();
