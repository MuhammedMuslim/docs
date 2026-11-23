<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>CNS Sales Portal</title>
<meta name="claude:viewport-fit-sides" content="cover">
<style>
/* Layout: navy brand bar on top, white nav rail on the left, light-grey workspace with white cards &#x2014; mirrors the CNS intro deck */
:root{
  --navy:#16265E; --navy-2:#1C325E; --ink:#24304A; --muted:#586377; --soft:#9AA6B6;
  --blue:#0090E0; --sky:#6FCBF5; --red:#C12E1F; --surface:#F4F7FA; --tint:#EAEFF9; --tint-2:#E4ECF8;
  --line:#DCE3EE; --white:#FFFFFF; --ok:#1E8E5A; --ok-bg:#E5F4EC; --warn:#B86A00; --warn-bg:#FFF3DF; --bad:#C12E1F; --bad-bg:#FBE9E7;
  --font:Arial, "Helvetica Neue", Helvetica, sans-serif;
  --r:10px; --shadow:0 1px 2px rgba(22,38,94,.06), 0 4px 14px rgba(22,38,94,.06);
  color-scheme:light;
}
*{box-sizing:border-box}
:where(svg){width:1.15em;height:1.15em;vertical-align:-.2em}
.drop svg,.empty svg{width:28px;height:28px;stroke:var(--blue)}
html,body{background:var(--surface);overflow-x:clip}
body{font-family:var(--font);color:var(--ink);font-size:14px;line-height:1.45}
body::before{content:"";position:fixed;inset:0 0 auto;height:env(safe-area-inset-top,0px);z-index:60;background:var(--navy)}
button{font-family:inherit;font-size:inherit;color:inherit;cursor:pointer}
input,select,textarea{font-family:inherit;font-size:inherit;color:var(--ink)}
a{color:var(--blue)}
:focus-visible{outline:2px solid var(--blue);outline-offset:2px}
h1,h2,h3,h4{color:var(--navy);margin:0;text-wrap:balance}
.eyebrow{font-size:11px;font-weight:700;letter-spacing:.18em;text-transform:uppercase;color:var(--blue)}
.muted{color:var(--muted)}
.small{font-size:12px}
.num{font-variant-numeric:tabular-nums}

/* Top bar */
.top{position:sticky;top:env(safe-area-inset-top,0px);z-index:50;background:var(--navy);color:#fff;display:flex;align-items:center;gap:16px;height:64px;
  padding-left:max(16px,env(safe-area-inset-left,0px));padding-right:max(16px,env(safe-area-inset-right,0px))}
.top .menu{display:none;background:none;border:0;color:#fff;padding:6px}
.brand{display:flex;align-items:center;gap:14px;text-decoration:none;color:#fff;flex-shrink:0}
.brand img{height:30px;width:auto}
.brand .sep{width:1px;height:26px;background:rgba(255,255,255,.25)}
.brand .pname{font-size:15px;font-weight:700;letter-spacing:.02em;white-space:nowrap}
.brand .pname span{display:block;font-size:10px;font-weight:400;letter-spacing:.2em;text-transform:uppercase;color:var(--sky)}
.gsearch{flex:1;max-width:560px;position:relative;margin-left:12px}
.gsearch input{width:100%;height:40px;border-radius:8px;border:1px solid rgba(255,255,255,.18);background:rgba(255,255,255,.08);color:#fff;padding:0 14px 0 40px}
.gsearch input::placeholder{color:rgba(255,255,255,.6)}
.gsearch input:focus{background:#fff;color:var(--ink);outline:none}
.gsearch input:focus::placeholder{color:var(--soft)}
.gsearch svg{position:absolute;left:12px;top:11px;width:18px;height:18px;stroke:rgba(255,255,255,.7)}
.gsearch input:focus + svg{stroke:var(--muted)}
.top-right{margin-left:auto;display:flex;align-items:center;gap:10px}
.demo-pill{font-size:11px;letter-spacing:.08em;text-transform:uppercase;border:1px solid rgba(255,255,255,.3);border-radius:999px;padding:4px 10px;color:var(--sky);white-space:nowrap}
.icon-btn{position:relative;background:rgba(255,255,255,.06);border:1px solid rgba(255,255,255,.14);border-radius:8px;height:38px;min-width:38px;display:inline-flex;align-items:center;justify-content:center;gap:6px;color:#fff;padding:0 10px}
.icon-btn svg{width:18px;height:18px}
.icon-btn .count{background:var(--red);color:#fff;border-radius:999px;font-size:10px;font-weight:700;padding:1px 6px}
.persona{display:flex;align-items:center;gap:10px;background:none;border:0;color:#fff;padding:4px;border-radius:8px;text-align:left}
.persona .who{font-size:13px;font-weight:700;line-height:1.2}
.persona .who span{display:block;font-weight:400;font-size:11px;color:rgba(255,255,255,.7)}
.av{width:34px;height:34px;border-radius:50%;display:inline-flex;align-items:center;justify-content:center;font-weight:700;font-size:12px;color:#fff;flex-shrink:0;background:var(--blue)}
.persona-menu{position:absolute;right:max(16px,env(safe-area-inset-right,0px));top:62px;background:#fff;color:var(--ink);border-radius:var(--r);box-shadow:0 12px 40px rgba(22,38,94,.22);width:290px;padding:8px;z-index:70}
.persona-menu .h{padding:8px 10px 6px}
.persona-menu button{display:flex;gap:10px;align-items:center;width:100%;background:none;border:0;border-radius:8px;padding:8px 10px;text-align:left}
.persona-menu button:hover,.persona-menu button.on{background:var(--tint)}
.persona-menu b{display:block;font-size:13px;color:var(--navy)}
.persona-menu small{color:var(--muted);font-size:11.5px}

/* Shell */
.shell{display:grid;grid-template-columns:252px minmax(0,1fr);min-height:calc(100vh - 64px)}
.side{background:#fff;border-right:1px solid var(--line);padding:18px 12px 24px;position:sticky;top:calc(64px + env(safe-area-inset-top,0px));height:calc(100vh - 64px - env(safe-area-inset-top,0px));overflow-y:auto}
.side .grp{margin:18px 10px 6px;display:flex;justify-content:space-between;align-items:center}
.side .grp:first-child{margin-top:0}
.nav a{display:flex;align-items:center;gap:11px;padding:9px 10px;border-radius:8px;color:var(--ink);text-decoration:none;font-size:13.5px}
.nav a svg{width:18px;height:18px;stroke:var(--muted);flex-shrink:0}
.nav a:hover{background:var(--surface)}
.nav a.on{background:var(--tint);color:var(--navy);font-weight:700}
.nav a.on svg{stroke:var(--blue)}
.nav a .ph{margin-left:auto}
.ph{font-size:10px;font-weight:700;letter-spacing:.06em;border-radius:4px;padding:2px 6px;white-space:nowrap}
.ph.p1{background:var(--tint);color:var(--navy)}
.ph.p2{background:#E3F4FC;color:#00649C}
.ph.p3{background:#FBE9E7;color:var(--red)}
.roadmap{margin:22px 10px 0;padding:12px;border:1px solid var(--line);border-radius:var(--r);background:var(--surface)}
.roadmap .seg{display:grid;grid-template-columns:repeat(3,1fr);gap:4px;margin-top:8px}
.roadmap .seg button{border:1px solid var(--line);background:#fff;border-radius:6px;padding:6px 0;font-size:11.5px;font-weight:700;color:var(--muted)}
.roadmap .seg button.on{background:var(--navy);border-color:var(--navy);color:#fff}
.roadmap p{margin:8px 0 0;font-size:11.5px;color:var(--muted)}
main{min-width:0;padding-block:24px 48px;padding-left:max(16px,min(32px,3vw));padding-right:max(16px,env(safe-area-inset-right,0px),min(32px,3vw))}
.wrap{max-width:1280px;margin:0 auto;display:flex;flex-direction:column;gap:28px}
.wrap>*,.panel,.two>*,.three>*{min-width:0}

/* Common blocks */
.sec-h{display:flex;align-items:flex-end;justify-content:space-between;gap:12px;margin-bottom:14px;flex-wrap:wrap}
.sec-h h2{font-size:20px}
.sec-h .eyebrow{margin-bottom:4px}
.link{background:none;border:0;color:var(--blue);font-weight:700;font-size:13px;padding:0;display:inline-flex;gap:4px;align-items:center}
.link svg{width:14px;height:14px}
.panel{background:#fff;border:1px solid var(--line);border-radius:var(--r);box-shadow:var(--shadow)}
.pad{padding:20px}
.btn{display:inline-flex;align-items:center;gap:8px;border-radius:8px;border:1px solid var(--line);background:#fff;padding:9px 14px;font-weight:700;font-size:13px;color:var(--navy);white-space:nowrap}
.btn svg{width:16px;height:16px}
.btn:hover{border-color:var(--blue)}
.btn.primary{background:var(--blue);border-color:var(--blue);color:#fff}
.btn.primary:hover{background:#007DC4}
.btn.navy{background:var(--navy);border-color:var(--navy);color:#fff}
.btn.ghost{background:transparent}
.btn[disabled]{opacity:.45;cursor:not-allowed}
.chip{display:inline-flex;align-items:center;gap:5px;font-size:11.5px;border-radius:999px;padding:3px 9px;background:var(--surface);border:1px solid var(--line);color:var(--muted);white-space:nowrap}
.badge{display:inline-flex;align-items:center;gap:4px;font-size:11px;font-weight:700;border-radius:4px;padding:2px 7px;white-space:nowrap}
.badge svg{width:12px;height:12px}
.b-ok{background:var(--ok-bg);color:var(--ok)}
.b-warn{background:var(--warn-bg);color:var(--warn)}
.b-bad{background:var(--bad-bg);color:var(--bad)}
.b-info{background:var(--tint);color:var(--navy)}
.b-lock{background:#EEF0F4;color:var(--muted)}
.tile-ic{width:40px;height:40px;border-radius:9px;background:linear-gradient(145deg,#2A5FB8,var(--navy));display:flex;align-items:center;justify-content:center;flex-shrink:0}
.tile-ic svg{width:21px;height:21px;stroke:#fff}
.tile-ic.sm{width:34px;height:34px;border-radius:8px}
.tile-ic.sm svg{width:18px;height:18px}
.tile-ic.blue{background:linear-gradient(145deg,#33B0F0,var(--blue))}
.tile-ic.red{background:linear-gradient(145deg,#E0574A,var(--red))}
.tile-ic.grey{background:linear-gradient(145deg,#8592A6,#586377)}

/* Announcement */
.announce{display:flex;align-items:center;gap:14px;background:#fff;border:1px solid var(--line);border-left:0;border-radius:var(--r);padding:10px 14px;box-shadow:var(--shadow);position:relative;overflow:hidden}
.announce::before{content:"";position:absolute;left:0;top:0;bottom:0;width:4px;background:var(--red)}
.announce .tag{font-size:10.5px;font-weight:700;letter-spacing:.14em;text-transform:uppercase;color:var(--red);white-space:nowrap}
.announce .amsg{flex:1;min-width:0;font-size:13.5px}
.announce .amsg b{color:var(--navy)}
.announce .dots{display:flex;gap:5px}
.announce .dots i{width:7px;height:7px;border-radius:50%;background:var(--line);display:block}
.announce .dots i.on{background:var(--navy)}

/* Hero */
.hero{position:relative;border-radius:14px;overflow:hidden;color:#fff;background:var(--navy)}
.hero .bg{position:absolute;inset:0;background-size:cover;background-position:center 60%}
.hero .bg::after{content:"";position:absolute;inset:0;background:linear-gradient(90deg,rgba(13,26,72,.96) 0%,rgba(16,32,84,.88) 45%,rgba(22,38,94,.35) 100%)}
.hero .in{position:relative;padding:28px 30px 26px;display:flex;flex-direction:column;gap:14px;max-width:820px}
.hero h1{color:#fff;font-size:30px;line-height:1.15}
.hero .rule{width:64px;height:3px;background:var(--red);border-radius:2px}
.hero p{margin:0;color:rgba(255,255,255,.82);font-size:14.5px;max-width:58ch}
.hsearch{display:flex;gap:8px;background:#fff;border-radius:10px;padding:6px;align-items:center;max-width:720px}
.hsearch svg{width:20px;height:20px;stroke:var(--muted);margin-left:8px;flex-shrink:0}
.hsearch input{flex:1;min-width:0;border:0;outline:none;height:38px;font-size:15px;background:transparent}
.qf{display:flex;gap:8px;flex-wrap:wrap;align-items:center}
.qf label{font-size:11px;letter-spacing:.14em;text-transform:uppercase;color:var(--sky);font-weight:700;margin-right:4px}
.qf select{height:34px;border-radius:8px;border:1px solid rgba(255,255,255,.25);background:rgba(255,255,255,.1);color:#fff;padding:0 10px;max-width:220px}
.qf select option{color:var(--ink)}
.hero .stats{display:flex;gap:28px;flex-wrap:wrap;margin-top:4px}
.hero .stats div{font-size:20px;font-weight:700}
.hero .stats span{display:block;font-size:11px;font-weight:400;color:rgba(255,255,255,.7);letter-spacing:.04em}
.quick{display:flex;gap:8px;flex-wrap:wrap}
.quick a{display:inline-flex;align-items:center;gap:7px;padding:7px 12px;border-radius:8px;background:#fff;border:1px solid var(--line);font-size:12.5px;font-weight:700;color:var(--navy);text-decoration:none}
.quick a svg{width:15px;height:15px;stroke:var(--blue)}
.quick a:hover{border-color:var(--blue)}

/* Category tiles */
.cats{display:grid;grid-template-columns:repeat(5,minmax(0,1fr));gap:12px}
.cat{display:flex;gap:12px;align-items:center;background:#fff;border:1px solid var(--line);border-radius:var(--r);padding:14px;text-align:left;box-shadow:var(--shadow);transition:border-color .15s, transform .15s}
.cat:hover{border-color:var(--blue);transform:translateY(-1px)}
.cat b{display:block;color:var(--navy);font-size:13px;line-height:1.25}
.cat span{font-size:11.5px;color:var(--muted)}
.cat.locked{opacity:.75}

/* Content cards */
.cards{display:grid;grid-template-columns:repeat(auto-fill,minmax(250px,1fr));gap:14px}
.cards.f6{grid-template-columns:repeat(3,minmax(0,1fr))}
@media (max-width:980px){.cards.f6{grid-template-columns:repeat(2,minmax(0,1fr))}}
@media (max-width:560px){.cards.f6{grid-template-columns:1fr}}
.card{background:#fff;border:1px solid var(--line);border-radius:var(--r);box-shadow:var(--shadow);display:flex;flex-direction:column;overflow:hidden;cursor:pointer;transition:border-color .15s, box-shadow .15s;text-align:left;padding:0}
.card:hover{border-color:var(--blue);box-shadow:0 6px 22px rgba(22,38,94,.12)}
.card .thumb{height:96px;position:relative;display:flex;align-items:flex-end;padding:12px;color:#fff;overflow:hidden}
.card .thumb .tt{font-size:10.5px;font-weight:700;letter-spacing:.14em;text-transform:uppercase;opacity:.9;position:relative}
.card .thumb .ext{position:absolute;top:10px;right:10px;font-size:10px;font-weight:700;background:rgba(255,255,255,.18);border-radius:4px;padding:2px 6px}
.card .thumb svg.big{position:absolute;right:-6px;bottom:-10px;width:80px;height:80px;stroke:rgba(255,255,255,.18);stroke-width:1.2}
.th-Presentation{background:linear-gradient(135deg,#16265E,#2A4A9A)}
.th-Whitepaper{background:linear-gradient(135deg,#0A6FB0,#0090E0)}
.th-Battle{background:linear-gradient(135deg,#7E1D14,#C12E1F)}
.th-Case{background:linear-gradient(135deg,#1C325E,#0090E0)}
.th-Datasheet{background:linear-gradient(135deg,#24304A,#4B5C7E)}
.th-Template{background:linear-gradient(135deg,#3A4B6E,#6C7E9F)}
.th-Video{background:linear-gradient(135deg,#0B1636,#16265E)}
.th-Link{background:linear-gradient(135deg,#4B5C7E,#9AA6B6)}
.th-Calculator{background:linear-gradient(135deg,#00649C,#6FCBF5)}
.th-Document{background:linear-gradient(135deg,#2F3D5C,#586377)}
.card .body{padding:12px 14px 14px;display:flex;flex-direction:column;gap:8px;flex:1}
.card h4{font-size:14px;line-height:1.3;color:var(--navy)}
.card .meta{font-size:12px;color:var(--muted);display:flex;gap:6px;flex-wrap:wrap;align-items:center}
.card .foot{display:flex;align-items:center;gap:6px;margin-top:auto;flex-wrap:wrap}
.star{margin-left:auto;background:none;border:0;padding:4px;border-radius:6px;display:inline-flex}
.star svg{width:18px;height:18px;stroke:var(--soft)}
.star.on svg{fill:#F2B01E;stroke:#F2B01E}
.star:hover svg{stroke:var(--navy)}

/* Rows / lists */
.list{display:flex;flex-direction:column}
.row{display:flex;gap:12px;align-items:center;padding:11px 14px;border-bottom:1px solid var(--line);cursor:pointer;background:#fff}
.row:last-child{border-bottom:0}
.row:hover{background:var(--surface)}
.row .t{flex:1;min-width:0}
.row .t b{display:block;color:var(--navy);font-size:13.5px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.row .t span{font-size:12px;color:var(--muted)}

/* Industry strip */
.kits{display:grid;grid-template-columns:repeat(7,minmax(0,1fr));gap:10px}
.kit{border-radius:var(--r);padding:14px 12px;color:#fff;text-align:left;border:0;min-height:112px;display:flex;flex-direction:column;justify-content:space-between;gap:10px;background:linear-gradient(160deg,#1C325E,#16265E);position:relative;overflow:hidden}
.kit:nth-child(2n){background:linear-gradient(160deg,#173A68,#16265E)}
.kit svg{width:24px;height:24px;stroke:var(--sky)}
.kit b{font-size:13.5px;display:block}
.kit span{font-size:11px;color:rgba(255,255,255,.7)}
.kit:hover{outline:2px solid var(--blue)}

/* Experts */
.experts{display:grid;grid-template-columns:repeat(auto-fill,minmax(260px,1fr));gap:12px}
.expert{display:flex;gap:12px;padding:14px;background:#fff;border:1px solid var(--line);border-radius:var(--r);align-items:flex-start;box-shadow:var(--shadow)}
.expert .av{width:44px;height:44px;font-size:14px;position:relative}
.expert .av i{position:absolute;right:-1px;bottom:-1px;width:12px;height:12px;border-radius:50%;border:2px solid #fff;background:var(--ok)}
.expert .av i.away{background:#F2B01E}
.expert .av i.busy{background:var(--red)}
.expert b{color:var(--navy);display:block}
.expert .r{font-size:12px;color:var(--muted)}
.expert .acts{display:flex;gap:6px;margin-top:8px;flex-wrap:wrap}
.expert .acts .btn{padding:6px 10px;font-size:12px}
.tags{display:flex;gap:4px;flex-wrap:wrap;margin-top:6px}

/* Search page */
.searchgrid{display:grid;grid-template-columns:240px minmax(0,1fr);gap:20px;align-items:start}
.facets{position:sticky;top:88px;display:flex;flex-direction:column;gap:4px;max-height:calc(100vh - 110px);overflow:auto;padding-right:4px}
.facet{border-bottom:1px solid var(--line);padding:10px 2px}
.facet h5{margin:0 0 6px;font-size:11px;letter-spacing:.14em;text-transform:uppercase;color:var(--muted);display:flex;justify-content:space-between}
.facet label{display:flex;align-items:center;gap:8px;font-size:13px;padding:3px 0;cursor:pointer}
.facet label span{margin-left:auto;color:var(--soft);font-size:11.5px}
.facet input{accent-color:var(--blue)}
.sbar{display:flex;gap:10px;align-items:center;flex-wrap:wrap;margin-bottom:14px}
.sbar .big{flex:1;min-width:220px;position:relative}
.sbar .big input{width:100%;height:44px;border:1px solid var(--line);border-radius:10px;padding:0 14px 0 42px;font-size:15px;background:#fff}
.sbar .big svg{position:absolute;left:14px;top:13px;width:18px;height:18px;stroke:var(--muted)}
.sbar select{height:44px;border:1px solid var(--line);border-radius:10px;padding:0 10px;background:#fff}
.active-f{display:flex;gap:6px;flex-wrap:wrap;margin-bottom:12px}
.active-f button{border:1px solid var(--blue);background:#E3F4FC;color:#00649C;border-radius:999px;font-size:12px;padding:3px 10px;display:inline-flex;gap:6px;align-items:center}
.active-f button svg{width:12px;height:12px}
.timing{font-size:12px;color:var(--muted)}
.empty{padding:40px;text-align:center;color:var(--muted)}

/* Modal */
.scrim{position:fixed;inset:0;background:rgba(11,22,54,.55);z-index:80;display:flex;justify-content:flex-end}
.drawer{width:min(860px,100%);height:100%;background:#fff;overflow-y:auto;display:flex;flex-direction:column;box-shadow:-10px 0 40px rgba(0,0,0,.2);padding-bottom:env(safe-area-inset-bottom,0px)}
.drawer .dh{display:flex;gap:14px;align-items:flex-start;padding:20px 24px 16px;border-bottom:1px solid var(--line);position:sticky;top:0;background:#fff;z-index:2}
.drawer .dh h2{font-size:20px;line-height:1.25}
.drawer .x{margin-left:auto;background:var(--surface);border:0;border-radius:8px;width:36px;height:36px;display:flex;align-items:center;justify-content:center;flex-shrink:0}
.drawer .x svg{width:18px;height:18px}
.drawer .db{padding:20px 24px 32px;display:flex;flex-direction:column;gap:20px}
.acts{display:flex;gap:8px;flex-wrap:wrap}
.meta-grid{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:1px;background:var(--line);border:1px solid var(--line);border-radius:var(--r);overflow:hidden}
.meta-grid div{background:#fff;padding:10px 12px;min-width:0}
.meta-grid dt{font-size:10.5px;letter-spacing:.12em;text-transform:uppercase;color:var(--muted);margin-bottom:3px}
.meta-grid dd{margin:0;font-size:13px;color:var(--ink);font-weight:700}
.notice{display:flex;gap:10px;padding:12px 14px;border-radius:8px;font-size:13px;align-items:flex-start}
.notice svg{width:18px;height:18px;flex-shrink:0;margin-top:1px}
.notice.warn{background:var(--warn-bg);color:#7A4600}
.notice.warn svg{stroke:var(--warn)}
.notice.bad{background:var(--bad-bg);color:#8A1F14}
.notice.bad svg{stroke:var(--red)}
.notice.info{background:var(--tint);color:var(--navy)}
.notice.info svg{stroke:var(--blue)}

/* Previews */
.pv{border-radius:var(--r);overflow:hidden;border:1px solid var(--line);background:var(--surface)}
.slide{aspect-ratio:16/9;max-width:100%;background:#fff;position:relative;overflow:hidden}
.slide.cover{background:linear-gradient(120deg,#0D1A48 0%,#16265E 55%,#1F3C86 100%);color:#fff;padding:6% 7%;display:flex;flex-direction:column;justify-content:center;gap:10px}
.slide.cover img{height:9%;width:auto;position:absolute;top:8%;left:7%}
.slide.cover .k{font-size:clamp(9px,1.4vw,12px);letter-spacing:.2em;color:var(--sky);font-weight:700}
.slide.cover h3{color:#fff;font-size:clamp(16px,3vw,30px)}
.slide.cover .rl{width:60px;height:3px;background:var(--red)}
.slide.cover p{margin:0;font-size:clamp(10px,1.4vw,13px);color:rgba(255,255,255,.8)}
.slide.cover::after{content:"";position:absolute;right:-12%;top:-30%;width:60%;height:160%;border-radius:50%;border:40px solid rgba(111,203,245,.07)}
.strip{display:flex;gap:8px;padding:10px;overflow-x:auto;background:#fff;border-top:1px solid var(--line)}
.strip .mini{flex:0 0 120px;aspect-ratio:16/9;border:1px solid var(--line);border-radius:4px;padding:6px;background:#fff;display:flex;flex-direction:column;gap:3px;cursor:pointer}
.strip .mini.on{outline:2px solid var(--blue)}
.strip .mini i{display:block;height:4px;border-radius:2px;background:var(--tint-2)}
.strip .mini i.h{background:var(--navy);width:60%;height:5px}
.strip .mini.dark{background:var(--navy)}
.strip .mini.dark i{background:rgba(255,255,255,.25)}
.slide.content{padding:5% 6%;display:flex;flex-direction:column;gap:3%}
.slide.content .k{font-size:10px;letter-spacing:.2em;color:var(--blue);font-weight:700}
.slide.content h3{font-size:clamp(14px,2.2vw,22px)}
.slide.content .boxes{display:grid;grid-template-columns:repeat(3,1fr);gap:3%;flex:1}
.slide.content .boxes div{background:var(--surface);border-radius:6px;padding:8%;display:flex;flex-direction:column;gap:6px}
.slide.content .boxes div i{width:28px;height:28px;border-radius:6px;background:var(--navy);display:block}
.slide.content .boxes div b{font-size:clamp(10px,1.3vw,13px);color:var(--navy)}
.slide.content .boxes div span{font-size:clamp(9px,1.1vw,11px);color:var(--muted)}
.slide .mark{position:absolute;right:4%;top:5%;font-weight:700;color:var(--red);font-size:11px;letter-spacing:.1em}
.doc{background:#fff;margin:16px auto;max-width:560px;padding:32px 36px;box-shadow:0 2px 10px rgba(0,0,0,.08);display:flex;flex-direction:column;gap:10px}
.doc .l{height:7px;border-radius:3px;background:var(--tint-2)}
.doc .l.s{width:70%}
.doc .l.h{height:12px;width:55%;background:var(--navy)}
.video{aspect-ratio:16/9;background:linear-gradient(120deg,#0B1636,#16265E);display:flex;align-items:center;justify-content:center;position:relative;color:#fff}
.video .play{width:64px;height:64px;border-radius:50%;background:rgba(255,255,255,.15);display:flex;align-items:center;justify-content:center;border:2px solid rgba(255,255,255,.5)}
.video .play svg{width:26px;height:26px;fill:#fff;stroke:none;margin-left:4px}
.video .bar{position:absolute;left:16px;right:16px;bottom:14px;height:4px;border-radius:2px;background:rgba(255,255,255,.2)}
.video .bar i{display:block;height:100%;width:32%;background:var(--blue);border-radius:2px}
.bc{background:#fff;padding:20px;display:flex;flex-direction:column;gap:14px}
.bc-head{display:flex;justify-content:space-between;gap:12px;flex-wrap:wrap;padding-bottom:12px;border-bottom:3px solid var(--red)}
.bc-grid{display:grid;grid-template-columns:1fr 1fr;gap:12px}
.bc-box{border:1px solid var(--line);border-radius:8px;padding:12px 14px}
.bc-box h5{margin:0 0 6px;font-size:11px;letter-spacing:.14em;text-transform:uppercase;color:var(--blue)}
.bc-box ul{margin:0;padding-left:18px;font-size:13px;display:flex;flex-direction:column;gap:4px}
.bc-box.win{background:#F2F8FD;border-color:#CFE0F5}
.bc-box.lock{background:#FAFAFB}
.obj{display:flex;flex-direction:column;gap:6px;font-size:13px}
.obj div{display:grid;grid-template-columns:minmax(0,1fr) minmax(0,1.4fr);gap:10px;padding:6px 0;border-bottom:1px dashed var(--line)}
.obj div:last-child{border-bottom:0}
.obj q{font-style:italic;color:var(--muted)}
.cs{background:#fff;padding:20px;display:grid;grid-template-columns:minmax(0,1.5fr) minmax(0,1fr);gap:20px}
.cs .facts{display:flex;flex-direction:column;gap:10px}
.cs .fact{display:flex;gap:10px;align-items:flex-start}
.cs .fact small{display:block;font-size:10px;letter-spacing:.14em;color:var(--blue);font-weight:700}
.cs .res{display:flex;flex-direction:column;gap:8px}
.cs .res div{background:var(--surface);border-radius:8px;padding:12px 14px;display:flex;gap:12px;align-items:center}
.cs .res b{font-size:22px;color:var(--red);min-width:84px}
.cs .res span{font-size:12px;color:var(--muted)}
.calc{background:#fff;padding:20px;display:grid;grid-template-columns:1fr 1fr;gap:16px}
.calc label{display:flex;flex-direction:column;gap:4px;font-size:12px;color:var(--muted)}
.calc input{height:36px;border:1px solid var(--line);border-radius:8px;padding:0 10px}
.calc .out{background:var(--navy);color:#fff;border-radius:10px;padding:16px;display:flex;flex-direction:column;gap:8px}
.calc .out b{font-size:26px;color:#fff}
.calc .out span{font-size:12px;color:rgba(255,255,255,.75)}
.rating{display:flex;gap:2px}
.rating svg{width:18px;height:18px;stroke:#F2B01E}
.rating svg.f{fill:#F2B01E}
.versions{font-size:13px}
.versions div{display:flex;gap:10px;padding:7px 0;border-bottom:1px solid var(--line)}
.versions div:last-child{border-bottom:0}
.versions b{color:var(--navy);min-width:40px}

/* Pages */
.page-h{display:flex;gap:16px;align-items:flex-start;flex-wrap:wrap}
.page-h h1{font-size:26px}
.page-h p{margin:6px 0 0;color:var(--muted);max-width:70ch}
.crumbs{font-size:12px;color:var(--muted);display:flex;gap:6px;align-items:center;margin-bottom:6px}
.crumbs svg{width:12px;height:12px;flex-shrink:0}
.crumbs a{color:var(--muted);text-decoration:none}
.crumbs a:hover{color:var(--blue)}
.banner{border-radius:14px;padding:26px 28px;color:#fff;background:linear-gradient(120deg,#0D1A48,#16265E 60%,#1F3C86);display:grid;grid-template-columns:minmax(0,1.4fr) minmax(0,1fr);gap:24px;position:relative;overflow:hidden}
.banner::after{content:"";position:absolute;right:-80px;top:-120px;width:360px;height:360px;border-radius:50%;border:50px solid rgba(111,203,245,.06)}
.banner h1{color:#fff;font-size:28px}
.banner p{color:rgba(255,255,255,.8);margin:8px 0 0}
.banner .eyebrow{color:var(--sky)}
.banner .kv{display:grid;grid-template-columns:1fr 1fr;gap:10px;position:relative;z-index:1}
.banner .kv div{background:rgba(255,255,255,.07);border:1px solid rgba(255,255,255,.12);border-radius:8px;padding:10px 12px}
.banner .kv b{display:block;font-size:20px}
.banner .kv span{font-size:11.5px;color:rgba(255,255,255,.72)}
.two{display:grid;grid-template-columns:minmax(0,1.6fr) minmax(0,1fr);gap:20px;align-items:start}
.three{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:16px}
.pain{display:flex;flex-direction:column;gap:10px}
.pain div{display:flex;gap:10px;font-size:13.5px}
.pain svg{width:18px;height:18px;stroke:var(--red);flex-shrink:0;margin-top:1px}
.reg{display:flex;flex-direction:column;gap:8px}
.reg div{padding:10px 12px;border-radius:8px;background:var(--surface);font-size:13px}
.reg b{color:var(--navy);display:block}
.tabs{display:flex;gap:4px;border-bottom:1px solid var(--line);margin-bottom:16px;overflow-x:auto}
.tabs button{background:none;border:0;padding:10px 14px;font-weight:700;color:var(--muted);border-bottom:2px solid transparent;white-space:nowrap}
.tabs button.on{color:var(--navy);border-bottom-color:var(--blue)}

/* Vendors */
.vgrid{display:grid;grid-template-columns:repeat(auto-fill,minmax(190px,1fr));gap:12px}
.vtile{background:#fff;border:1px solid var(--line);border-radius:var(--r);padding:16px;text-align:left;display:flex;flex-direction:column;gap:10px;box-shadow:var(--shadow)}
.vtile:hover{border-color:var(--blue)}
.wordmark{font-weight:700;font-size:18px;color:var(--navy);letter-spacing:-.01em;height:28px;display:flex;align-items:center}
.vtile .m{font-size:12px;color:var(--muted);display:flex;justify-content:space-between}
.tierh{display:flex;align-items:center;gap:10px;margin:18px 0 10px}
.tierh:first-child{margin-top:0}
.tierh .eyebrow{white-space:nowrap}
.tierh hr{flex:1;border:0;border-top:1px solid var(--line);margin:0}
.steps{display:flex;flex-direction:column;gap:0;counter-reset:s}
.steps div{display:flex;gap:12px;padding:10px 0;font-size:13.5px;border-bottom:1px solid var(--line)}
.steps div:last-child{border-bottom:0}
.steps div::before{counter-increment:s;content:counter(s);width:24px;height:24px;border-radius:50%;background:var(--navy);color:#fff;font-size:12px;font-weight:700;display:flex;align-items:center;justify-content:center;flex-shrink:0}
.promo{border-radius:var(--r);background:linear-gradient(120deg,#0090E0,#16265E);color:#fff;padding:18px;display:flex;flex-direction:column;gap:8px}
.promo b{font-size:18px}
.promo span{font-size:12.5px;color:rgba(255,255,255,.85)}

/* Onboarding */
.path{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:16px}
.stage{background:#fff;border:1px solid var(--line);border-radius:var(--r);overflow:hidden;box-shadow:var(--shadow)}
.stage .sh{padding:16px 18px;background:var(--navy);color:#fff}
.stage .sh b{font-size:17px;display:block}
.stage .sh span{font-size:12px;color:rgba(255,255,255,.75)}
.stage .prog{height:4px;background:rgba(255,255,255,.18);border-radius:2px;margin-top:10px}
.stage .prog i{display:block;height:100%;background:var(--sky);border-radius:2px}
.task{display:flex;gap:10px;padding:11px 16px;border-bottom:1px solid var(--line);align-items:flex-start}
.task:last-child{border-bottom:0}
.task input{margin-top:3px;accent-color:var(--ok);width:16px;height:16px}
.task .t{flex:1;font-size:13.5px}
.task .t button{background:none;border:0;padding:0;color:var(--navy);font-weight:700;text-align:left}
.task .t button:hover{color:var(--blue)}
.task .t span{display:block;font-size:12px;color:var(--muted)}
.task.done .t button{color:var(--muted);text-decoration:line-through}

/* Analytics */
.kpis{display:grid;grid-template-columns:repeat(5,minmax(0,1fr));gap:12px}
.kpi{background:#fff;border:1px solid var(--line);border-radius:var(--r);padding:14px 16px;box-shadow:var(--shadow)}
.kpi .l{font-size:11px;letter-spacing:.12em;text-transform:uppercase;color:var(--muted)}
.kpi .v{font-size:26px;font-weight:700;color:var(--navy);margin-top:6px}
.kpi .d{font-size:12px;margin-top:2px}
.kpi .d.up{color:var(--ok)}
.kpi .t{font-size:11.5px;color:var(--muted)}
.chart svg{width:100%;height:auto;display:block}
.bars{display:flex;flex-direction:column;gap:9px}
.bars .b{display:grid;grid-template-columns:minmax(0,1.6fr) minmax(0,1fr) 44px;gap:10px;align-items:center;font-size:12.5px}
.bars .b .n{white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.bars .b .tr{height:10px;background:var(--surface);border-radius:5px;overflow:hidden}
.bars .b .tr i{display:block;height:100%;background:var(--blue);border-radius:5px}
.bars.navy .b .tr i{background:var(--navy)}
.bars.red .b .tr i{background:var(--red)}
.bars .b .v{text-align:right;font-variant-numeric:tabular-nums;color:var(--muted)}
table.t{width:100%;border-collapse:collapse;font-size:13px}
table.t th{text-align:left;font-size:10.5px;letter-spacing:.12em;text-transform:uppercase;color:var(--muted);font-weight:700;padding:10px 12px;border-bottom:1px solid var(--line);background:var(--surface);white-space:nowrap}
table.t td{padding:10px 12px;border-bottom:1px solid var(--line);vertical-align:middle}
table.t tr:last-child td{border-bottom:0}
table.t td b{color:var(--navy)}
.tscroll{overflow-x:auto}
.health{display:grid;grid-template-columns:repeat(4,1fr);gap:10px}
.health div{border-radius:8px;padding:12px;text-align:center}
.health b{display:block;font-size:24px}
.health span{font-size:11.5px}

/* Governance */
.flow{display:grid;grid-template-columns:repeat(6,minmax(0,1fr));gap:8px}
.flow div{background:#fff;border:1px solid var(--line);border-radius:var(--r);padding:12px;position:relative}
.flow div b{display:block;font-size:24px;color:var(--navy)}
.flow div span{font-size:12px;color:var(--muted)}
.flow div::after{content:"";position:absolute;right:-7px;top:50%;width:10px;height:10px;border-top:2px solid var(--soft);border-right:2px solid var(--soft);transform:translateY(-50%) rotate(45deg);background:transparent}
.flow div:last-child::after{display:none}
.flow div.cur{border-color:var(--blue);background:#F2F8FD}
.form{display:grid;grid-template-columns:1fr 1fr;gap:14px}
.form label{display:flex;flex-direction:column;gap:5px;font-size:12px;font-weight:700;color:var(--navy)}
.form label em{color:var(--red);font-style:normal}
.form input,.form select{height:38px;border:1px solid var(--line);border-radius:8px;padding:0 10px;font-weight:400;background:#fff}
.form .full{grid-column:1/-1}
.form .err input,.form .err select{border-color:var(--red);background:#FFF8F7}
.form .hint{font-weight:400;color:var(--muted);font-size:11.5px}
.drop{border:2px dashed var(--line);border-radius:10px;padding:18px;text-align:center;color:var(--muted);font-size:13px;background:var(--surface)}

/* Salesforce */
.sf{display:grid;grid-template-columns:minmax(0,1.5fr) minmax(0,1fr);gap:16px;align-items:start}
.sf-rec{background:#fff;border:1px solid var(--line);border-radius:var(--r);overflow:hidden}
.sf-top{background:#F3F6FA;border-bottom:1px solid var(--line);padding:16px 18px;display:flex;gap:12px;align-items:center}
.sf-top .tile-ic{background:linear-gradient(145deg,#FF9A3C,#F27C1E)}
.sf-path{display:flex;padding:14px 18px;gap:3px;overflow-x:auto}
.sf-path span{flex:1;min-width:84px;text-align:center;font-size:12px;padding:8px 6px;background:var(--surface);color:var(--muted);clip-path:polygon(0 0,92% 0,100% 50%,92% 100%,0 100%,8% 50%);font-weight:700}
.sf-path span.done{background:#CFE0F5;color:var(--navy)}
.sf-path span.cur{background:var(--navy);color:#fff}
.sf-fields{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:1px;background:var(--line);border-top:1px solid var(--line)}
.sf-fields div{background:#fff;padding:10px 18px}
.sf-fields dt{font-size:11px;color:var(--muted)}
.sf-fields dd{margin:2px 0 0;font-weight:700;font-size:13px;color:var(--ink)}
.sp-panel{border:2px solid var(--blue);border-radius:var(--r);background:#fff;overflow:hidden}
.sp-panel .ph-h{background:var(--navy);color:#fff;padding:12px 14px;display:flex;align-items:center;gap:10px}
.sp-panel .ph-h img{height:18px}
.sp-panel .ph-h b{font-size:13px}
.sp-item{display:flex;gap:10px;padding:10px 14px;border-bottom:1px solid var(--line);align-items:center}
.sp-item .t{flex:1;min-width:0;cursor:pointer}
.sp-item .t b{display:block;font-size:13px;color:var(--navy);line-height:1.3}
.sp-item .t span{font-size:11.5px;color:var(--muted)}
.sp-item .btn{padding:5px 10px;font-size:12px}
.why{font-size:11px;color:#00649C;background:#E3F4FC;border-radius:4px;padding:1px 6px;margin-top:3px;display:inline-block}

/* Assistant */
.chat{display:grid;grid-template-columns:minmax(0,1fr) 300px;gap:16px;align-items:start}
.thread{background:#fff;border:1px solid var(--line);border-radius:var(--r);display:flex;flex-direction:column;min-height:560px}
.msgs{flex:1;padding:20px;display:flex;flex-direction:column;gap:16px;overflow-y:auto;max-height:620px}
.msg{display:flex;gap:10px;max-width:92%}
.msg.me{align-self:flex-end;flex-direction:row-reverse}
.msg .bub{padding:12px 14px;border-radius:12px;font-size:13.5px;line-height:1.55}
.msg.me .bub{background:var(--navy);color:#fff;border-top-right-radius:4px}
.msg.ai .bub{background:var(--surface);border:1px solid var(--line);border-top-left-radius:4px}
.msg.ai .bub p{margin:0 0 8px}
.msg.ai .bub p:last-child{margin:0}
.msg.ai .bub ul{margin:4px 0 8px;padding-left:18px}
.msg .ai-av{width:32px;height:32px;border-radius:8px;background:linear-gradient(145deg,var(--blue),var(--navy));display:flex;align-items:center;justify-content:center;flex-shrink:0}
.msg .ai-av svg{width:18px;height:18px;stroke:#fff}
.cite{display:inline-flex;align-items:center;gap:4px;font-size:11.5px;background:#fff;border:1px solid #CFE0F5;color:#00649C;border-radius:4px;padding:1px 7px;margin:2px 4px 2px 0;cursor:pointer}
.cite svg{width:11px;height:11px}
.sources{margin-top:8px;padding-top:8px;border-top:1px dashed var(--line);font-size:11.5px;color:var(--muted)}
.composer{border-top:1px solid var(--line);padding:12px;display:flex;gap:8px}
.composer input{flex:1;min-width:0;height:42px;border:1px solid var(--line);border-radius:8px;padding:0 12px}
.prompts{display:flex;flex-direction:column;gap:8px}
.prompts button{text-align:left;background:#fff;border:1px solid var(--line);border-radius:8px;padding:10px 12px;font-size:13px;color:var(--navy);display:flex;gap:8px;align-items:flex-start}
.prompts button svg{width:16px;height:16px;stroke:var(--blue);flex-shrink:0;margin-top:1px}
.prompts button:hover{border-color:var(--blue)}
.typing{display:flex;gap:4px;padding:4px 0}
.typing i{width:6px;height:6px;border-radius:50%;background:var(--soft);animation:b 1s infinite}
.typing i:nth-child(2){animation-delay:.15s}.typing i:nth-child(3){animation-delay:.3s}
@keyframes b{0%,100%{opacity:.3}50%{opacity:1}}

/* Opportunities strip */
.opps{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:12px}
.opp{background:#fff;border:1px solid var(--line);border-radius:var(--r);padding:14px;display:flex;flex-direction:column;gap:8px;box-shadow:var(--shadow)}
.opp .top2{display:flex;justify-content:space-between;gap:8px}
.opp b{color:var(--navy)}
.opp .amt{font-weight:700;color:var(--navy);font-variant-numeric:tabular-nums}
.opp .sugg{display:flex;flex-direction:column;gap:4px;border-top:1px solid var(--line);padding-top:8px}
.opp .sugg button{background:none;border:0;padding:2px 0;text-align:left;font-size:12.5px;color:var(--blue);display:flex;gap:6px;align-items:center}
.opp .sugg svg{width:13px;height:13px;stroke:var(--blue);flex-shrink:0}

/* Footer */
.foot{border-top:1px solid var(--line);padding-top:20px;display:flex;justify-content:space-between;gap:16px;flex-wrap:wrap;font-size:12.5px;color:var(--muted)}
.foot nav{display:flex;gap:16px;flex-wrap:wrap}
.foot a{color:var(--muted);text-decoration:none;display:inline-flex;gap:5px;align-items:center}
.foot a:hover{color:var(--blue)}
.foot svg{width:13px;height:13px}

/* Toast */
.toast{position:fixed;left:50%;bottom:calc(24px + env(safe-area-inset-bottom,0px));transform:translateX(-50%);background:var(--navy);color:#fff;padding:12px 18px;border-radius:10px;box-shadow:0 10px 30px rgba(0,0,0,.25);z-index:100;display:flex;gap:10px;align-items:center;font-size:13.5px;max-width:calc(100% - 32px)}
.toast svg{width:18px;height:18px;stroke:var(--sky);flex-shrink:0}

/* Responsive */
@media (max-width:1180px){.cats{grid-template-columns:repeat(3,minmax(0,1fr))}.kits{grid-template-columns:repeat(4,minmax(0,1fr))}.kpis{grid-template-columns:repeat(3,minmax(0,1fr))}.flow{grid-template-columns:repeat(3,minmax(0,1fr))}.flow div::after{display:none}}
@media (max-width:980px){
  .shell{grid-template-columns:1fr}
  .side{position:fixed;left:0;top:calc(64px + env(safe-area-inset-top,0px));z-index:45;width:min(290px,86vw);transform:translateX(-102%);transition:transform .2s;box-shadow:10px 0 30px rgba(0,0,0,.15);padding-left:max(12px,env(safe-area-inset-left,0px))}
  .side.open{transform:none}
  .top .menu{display:inline-flex}
  .two,.chat,.sf,.banner{grid-template-columns:1fr}
  .searchgrid{grid-template-columns:1fr}
  .facets{position:static;max-height:none;display:none}
  .facets.open{display:flex}
  .opps,.three,.path{grid-template-columns:1fr}
  .persona .who,.demo-pill{display:none}
}
@media (max-width:700px){
  .gsearch{display:none}
  .brand .pname{font-size:13px}
  .cats{grid-template-columns:repeat(2,minmax(0,1fr))}
  .kits{grid-template-columns:repeat(2,minmax(0,1fr))}
  .kpis{grid-template-columns:repeat(2,minmax(0,1fr))}
  .flow{grid-template-columns:repeat(2,minmax(0,1fr))}
  .meta-grid{grid-template-columns:1fr 1fr}
  .bc-grid,.cs,.calc,.form,.sf-fields{grid-template-columns:1fr}
  .health{grid-template-columns:1fr 1fr}
  .hero .in{padding:22px 18px}
  .hero h1{font-size:24px}
  .drawer .dh,.drawer .db{padding-left:16px;padding-right:16px}
  .cat{padding:12px;gap:10px}
  .cat .tile-ic{width:34px;height:34px}
  .announce .dots{display:none}
}
@media (max-width:480px){.brand .sep,.brand .pname{display:none}.top{gap:10px}}
@media (max-width:420px){.cats{grid-template-columns:1fr}}
@media (prefers-reduced-motion:reduce){*{transition:none!important;animation:none!important}}
[hidden]{display:none!important}
</style>
</head>
<body>
<header class="top">
  <button class="menu" id="menuBtn" aria-label="Open navigation"><svg viewBox="0 0 24 24" width="22" height="22" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><path d="M3 6h18M3 12h18M3 18h18"/></svg></button>
  <a class="brand" href="#home"><img src="data:image/png;base64,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" alt="CNS Technology"><i class="sep"></i><div class="pname">Sales Portal<span>Unified content hub</span></div></a>
  <form class="gsearch" id="gsearch" role="search"><input id="gq" type="search" placeholder="Search decks, battle cards, case studies, vendors&#x2026;" autocomplete="off"><svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round"><circle cx="11" cy="11" r="7"/><path d="M20 20l-3.5-3.5"/></svg></form>
  <div class="top-right">
    <span class="demo-pill">Demo &#xb7; synthetic data</span>
    <a class="icon-btn" href="#mykit" title="My Kit"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linejoin="round"><path d="M12 3l2.7 5.6 6.1.9-4.4 4.3 1 6.1L12 17l-5.4 2.9 1-6.1-4.4-4.3 6.1-.9z"/></svg><span class="count" id="kitCount">0</span></a>
    <button class="persona" id="personaBtn" aria-haspopup="true"><span class="av" id="pAv">OH</span><span class="who" id="pWho">Omar Haddad<span>Account Manager</span></span></button>
  </div>
</header>
<div id="personaMenu" class="persona-menu" hidden></div>

<div class="shell">
  <aside class="side" id="side"></aside>
  <main id="main"><div class="wrap" id="view"></div></main>
</div>
<div id="modal"></div>
<div id="toast" class="toast" hidden></div>

<script>
const LOGO = "data:image/png;base64,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", HERO = "data:image/jpeg;base64,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";
const TODAY = new Date(2026, 10, 19);

/* ---------- Icons ---------- */
const P = {
 home:'<path d="M3 10.5L12 3l9 7.5V20a1 1 0 0 1-1 1h-5v-6H9v6H4a1 1 0 0 1-1-1z"/>',
 search:'<circle cx="11" cy="11" r="7"/><path d="M20 20l-3.5-3.5"/>',
 grid:'<rect x="3" y="3" width="7" height="7" rx="1.5"/><rect x="14" y="3" width="7" height="7" rx="1.5"/><rect x="3" y="14" width="7" height="7" rx="1.5"/><rect x="14" y="14" width="7" height="7" rx="1.5"/>',
 building:'<path d="M4 21V5a1 1 0 0 1 1-1h9a1 1 0 0 1 1 1v16M15 9h4a1 1 0 0 1 1 1v11M8 8h3M8 12h3M8 16h3M3 21h18"/>',
 handshake:'<path d="M2 12l4-4 4 2 3-2 4 1 5 3M6 8v6l4 4 2-1 2 2 2-1 2 1 2-3-5-5"/>',
 users:'<circle cx="9" cy="8" r="3.5"/><path d="M2.5 20a6.5 6.5 0 0 1 13 0"/><circle cx="17" cy="9" r="2.5"/><path d="M16 14.5a5 5 0 0 1 5.5 5"/>',
 star:'<path d="M12 3l2.7 5.6 6.1.9-4.4 4.3 1 6.1L12 17l-5.4 2.9 1-6.1-4.4-4.3 6.1-.9z"/>',
 route:'<circle cx="6" cy="19" r="2"/><circle cx="18" cy="5" r="2"/><path d="M8 19h8.5a3.5 3.5 0 0 0 0-7h-9a3.5 3.5 0 0 1 0-7H16"/>',
 chart:'<path d="M3 3v18h18"/><path d="M7 15l4-5 3 3 5-7"/>',
 shield:'<path d="M12 3l8 3v6c0 4.5-3.4 8.2-8 9-4.6-.8-8-4.5-8-9V6z"/><path d="M8.5 12l2.5 2.5 4.5-5"/>',
 cloud:'<path d="M7 18a5 5 0 0 1-.6-10A6 6 0 0 1 18 8.5 4.5 4.5 0 0 1 17.5 18z"/>',
 spark:'<path d="M12 3l1.8 5.2L19 10l-5.2 1.8L12 17l-1.8-5.2L5 10l5.2-1.8zM19 15l.8 2.2L22 18l-2.2.8L19 21l-.8-2.2L16 18l2.2-.8z"/>',
 file:'<path d="M14 3H6a1 1 0 0 0-1 1v16a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V8z"/><path d="M14 3v5h5M9 13h6M9 17h6"/>',
 present:'<rect x="3" y="4" width="18" height="12" rx="1.5"/><path d="M12 16v4M8 20h8M7 12l3-3 2 2 4-4"/>',
 play:'<circle cx="12" cy="12" r="9"/><path d="M10 8.5v7l6-3.5z"/>',
 calc:'<rect x="5" y="3" width="14" height="18" rx="2"/><path d="M8 7h8M8 11h2M12 11h2M16 11v.01M8 15h2M12 15h2M16 15v3M8 18.5h6"/>',
 link:'<path d="M10 14a4 4 0 0 0 5.7 0l3-3a4 4 0 0 0-5.7-5.7l-1 1"/><path d="M14 10a4 4 0 0 0-5.7 0l-3 3a4 4 0 0 0 5.7 5.7l1-1"/>',
 award:'<circle cx="12" cy="9" r="6"/><path d="M8.5 14L7 21l5-3 5 3-1.5-7"/>',
 brief:'<rect x="3" y="7" width="18" height="13" rx="2"/><path d="M8 7V5a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2M3 13h18"/>',
 book:'<path d="M4 4.5A1.5 1.5 0 0 1 5.5 3H20v15H5.5A1.5 1.5 0 0 0 4 19.5z"/><path d="M4 19.5A1.5 1.5 0 0 0 5.5 21H20"/>',
 sword:'<path d="M14.5 3H21v6.5L10 20.5 3.5 14z"/><path d="M6.5 17.5L3 21M13 8l3 3"/>',
 layers:'<path d="M12 3l9 5-9 5-9-5z"/><path d="M3 13l9 5 9-5"/>',
 bulb:'<path d="M9 18h6M10 21h4M12 3a6 6 0 0 0-3.5 10.9c.6.5 1 1.2 1 2.1h5c0-.9.4-1.6 1-2.1A6 6 0 0 0 12 3z"/>',
 money:'<rect x="2" y="6" width="20" height="12" rx="2"/><circle cx="12" cy="12" r="2.5"/><path d="M6 9.5v5M18 9.5v5"/>',
 cap:'<path d="M2 9l10-5 10 5-10 5z"/><path d="M6 11v5c3 2 9 2 12 0v-5M22 9v6"/>',
 tool:'<path d="M14.7 6.3a4 4 0 0 0-5.4 5.4L3 18v3h3l6.3-6.3a4 4 0 0 0 5.4-5.4l-2.5 2.5-2.4-.6-.6-2.4z"/>',
 megaphone:'<path d="M3 10v4a1 1 0 0 0 1 1h3l8 5V4L7 9H4a1 1 0 0 0-1 1zM19 9a4 4 0 0 1 0 6"/>',
 download:'<path d="M12 3v12M7 10l5 5 5-5M4 20h16"/>',
 share:'<circle cx="6" cy="12" r="2.5"/><circle cx="18" cy="6" r="2.5"/><circle cx="18" cy="18" r="2.5"/><path d="M8.2 10.8l7.6-3.6M8.2 13.2l7.6 3.6"/>',
 onedrive:'<path d="M7 18a5 5 0 0 1-.6-10A6 6 0 0 1 18 8.5 4.5 4.5 0 0 1 17.5 18z"/><path d="M12 11v5M9.5 13.5L12 16l2.5-2.5"/>',
 x:'<path d="M6 6l12 12M18 6L6 18"/>',
 chev:'<path d="M9 6l6 6-6 6"/>',
 filter:'<path d="M3 5h18l-7 8v6l-4 2v-8z"/>',
 lock:'<rect x="5" y="11" width="14" height="10" rx="2"/><path d="M8 11V8a4 4 0 0 1 8 0v3"/>',
 clock:'<circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 2"/>',
 check:'<path d="M5 12.5l4.5 4.5L19 7.5"/>',
 checkc:'<circle cx="12" cy="12" r="9"/><path d="M8 12.5l3 3 5-6"/>',
 alert:'<path d="M12 3L2 20h20z"/><path d="M12 10v4M12 17v.01"/>',
 chat:'<path d="M4 5h16v11H9l-5 4z"/><path d="M8 9.5h8M8 12.5h5"/>',
 mail:'<rect x="3" y="5" width="18" height="14" rx="2"/><path d="M3 7l9 6 9-6"/>',
 plus:'<path d="M12 5v14M5 12h14"/>',
 upload:'<path d="M12 16V4M7 9l5-5 5 5M4 20h16"/>',
 eye:'<path d="M2 12s3.5-7 10-7 10 7 10 7-3.5 7-10 7S2 12 2 12z"/><circle cx="12" cy="12" r="3"/>',
 flag:'<path d="M5 21V4M5 4h11l-2 4 2 4H5"/>',
 send:'<path d="M4 12l16-8-6 16-3-7z"/>',
 globe:'<circle cx="12" cy="12" r="9"/><path d="M3 12h18M12 3c3 3 3 15 0 18M12 3c-3 3-3 15 0 18"/>',
 bank:'<path d="M3 9l9-5 9 5M5 9v9M9.5 9v9M14.5 9v9M19 9v9M3 21h18"/>',
 heart:'<path d="M12 20s-8-4.7-8-10.5A4.5 4.5 0 0 1 12 6.5a4.5 4.5 0 0 1 8 3C20 15.3 12 20 12 20z"/><path d="M8 12h2.5l1-2 2 4 1-2H16"/>',
 drop:'<path d="M12 3s6 7 6 11a6 6 0 0 1-12 0c0-4 6-11 6-11z"/>',
 bolt:'<path d="M13 2L4 14h7l-1 8 9-12h-7z"/>',
 target:'<circle cx="12" cy="12" r="9"/><circle cx="12" cy="12" r="5"/><circle cx="12" cy="12" r="1"/>',
 teams:'<rect x="3" y="6" width="12" height="12" rx="2"/><path d="M6.5 9.5h5M9 9.5V15M17 9h3a1 1 0 0 1 1 1v4a3 3 0 0 1-4 2.8"/><circle cx="18.5" cy="5.5" r="1.8"/>',
 copy:'<rect x="8" y="8" width="12" height="12" rx="2"/><path d="M16 8V5a1 1 0 0 0-1-1H5a1 1 0 0 0-1 1v10a1 1 0 0 0 1 1h3"/>',
 ext:'<path d="M14 4h6v6M20 4l-9 9M18 14v5a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V7a1 1 0 0 1 1-1h5"/>',
 trend:'<path d="M3 17l6-6 4 4 8-8M15 7h6v6"/>',
 db:'<ellipse cx="12" cy="5" rx="8" ry="3"/><path d="M4 5v14c0 1.7 3.6 3 8 3s8-1.3 8-3V5M4 12c0 1.7 3.6 3 8 3s8-1.3 8-3"/>',
 calendar:'<rect x="3" y="5" width="18" height="16" rx="2"/><path d="M3 10h18M8 3v4M16 3v4"/>',
};
const ic = (n, cls='') => `<svg class="${cls}" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">${P[n]||P.file}</svg>`;

/* ---------- Taxonomy ---------- */
const PRACTICES = {
  di:'Digital Infrastructure', cyber:'Cyber Security', cloud:'Cloud Solutions', apps:'Applications & Emerging Tech',
  dt:'Digital Transformation', bank:'Digital Banking (BFSI)', ms:'Managed Services', ai:'Data, AI & Software (Code81)'
};
const INDUSTRIES = {
  bfsi:{n:'BFSI',i:'bank'}, gov:{n:'Government',i:'building'}, og:{n:'Oil & Gas',i:'drop'}, def:{n:'Defence',i:'shield'},
  hc:{n:'Healthcare',i:'heart'}, eu:{n:'Energy & Utilities',i:'bolt'}, edu:{n:'Education',i:'cap'}, cross:{n:'Cross-industry',i:'globe'}
};
const CATS = [
  {id:'brand',n:'Company & Brand',i:'building',own:'Marketing'},
  {id:'creds',n:'Credentials & Compliance',i:'award',own:'Bids / Finance'},
  {id:'portfolio',n:'Portfolio & Solutions',i:'layers',own:'Practice Heads'},
  {id:'decks',n:'Sales Presentations',i:'present',own:'Marketing + Practices'},
  {id:'papers',n:'Whitepapers & Thought Leadership',i:'bulb',own:'Marketing'},
  {id:'battle',n:'Battle Cards & Competitive Intel',i:'sword',own:'Presales + Sales Leadership'},
  {id:'cases',n:'Case Studies & References',i:'trend',own:'Marketing'},
  {id:'bids',n:'Proposal & Bid Library',i:'brief',own:'Bids / Presales'},
  {id:'vendor',n:'Vendor & Partner Hub',i:'handshake',own:'Vendor Managers'},
  {id:'play',n:'Sales Playbooks & Process',i:'book',own:'Sales Leadership'},
  {id:'kits',n:'Industry Kits',i:'globe',own:'Practice Heads + Marketing'},
  {id:'pricing',n:'Pricing & Commercial',i:'money',own:'Finance + Sales Leadership',restricted:true},
  {id:'train',n:'Training & Onboarding',i:'cap',own:'Sales Enablement / HR'},
  {id:'tools',n:'Tools & Calculators',i:'tool',own:'Presales'},
  {id:'news',n:'News & Experts',i:'megaphone',own:'Marketing + Sales Leadership'},
];
const TYPE_IC = {Presentation:'present',Whitepaper:'bulb','Battle Card':'sword','Case Study':'trend',Datasheet:'file',Template:'copy',Video:'play',Link:'link',Calculator:'calc',Document:'file'};
const TYPE_TH = {Presentation:'Presentation',Whitepaper:'Whitepaper','Battle Card':'Battle','Case Study':'Case',Datasheet:'Datasheet',Template:'Template',Video:'Video',Link:'Link',Calculator:'Calculator',Document:'Document'};
const TYPE_EXT = {Presentation:'PPTX',Whitepaper:'PDF','Battle Card':'PDF','Case Study':'PDF',Datasheet:'PDF',Template:'DOCX',Video:'MP4',Link:'URL',Calculator:'XLSX',Document:'PDF'};
const STAGES = ['Prospect','Discover','Qualify','Propose','Negotiate','Close','Deliver'];

/* ---------- People (fictional) ---------- */
const PEOPLE = {
  layla:{n:'Layla Mansour',r:'Marketing Lead',c:'#C12E1F',loc:'Dubai',st:'on',pr:[],v:[]},
  rami:{n:'Rami Khoury',r:'Head of Digital Infrastructure',c:'#16265E',loc:'Abu Dhabi',st:'on',pr:['di'],v:['Cisco','NetApp','Infoblox','DataCore']},
  sara:{n:'Sara Al Hashimi',r:'Head of Cyber Security',c:'#0090E0',loc:'Dubai',st:'on',pr:['cyber'],v:['Forescout','Kaspersky','WatchGuard','Stormshield']},
  priya:{n:'Priya Nair',r:'Presales Architect \u00b7 Backup & DR',c:'#1C6E8C',loc:'Dubai',st:'busy',pr:['di','cloud'],v:['Veeam','Veritas','RackWare','Perpetuuiti']},
  daniel:{n:'Daniel Pereira',r:'Cloud Solutions Architect',c:'#2A5FB8',loc:'Dubai',st:'on',pr:['cloud'],v:['AWS','Microsoft','Dynatrace']},
  hana:{n:'Hana Yousef',r:'Bids & Proposals Lead',c:'#7E1D14',loc:'Abu Dhabi',st:'away',pr:[],v:[]},
  faisal:{n:'Faisal Rahman',r:'Vendor Manager \u00b7 Infrastructure & Security',c:'#4B5C7E',loc:'Dubai',st:'on',pr:['di','cyber'],v:['Cisco','Veeam','Forescout','NetApp','Kaspersky']},
  mariam:{n:'Mariam Al Balushi',r:'Account Director, Oman',c:'#00649C',loc:'Muscat',st:'on',pr:['bank'],v:['Temenos']},
  youssef:{n:'Youssef Adel',r:'AI Agents Lead, Code81',c:'#24304A',loc:'Dubai',st:'on',pr:['ai','dt'],v:['Microsoft']},
  tarek:{n:'Tarek Haddad',r:'Digital Banking Practice Lead',c:'#173A68',loc:'Dubai',st:'away',pr:['bank'],v:['Temenos','Finastra','IDEMIA']},
  noura:{n:'Noura Saeed',r:'Apps & Low-Code Architect',c:'#586377',loc:'Abu Dhabi',st:'on',pr:['apps','dt'],v:['Mendix','Nintex','novomind','Cube.ms']},
  ahmed:{n:'Ahmed Fathy',r:'Managed Services & NOC Manager',c:'#1C325E',loc:'Abu Dhabi',st:'on',pr:['ms'],v:['Dynatrace','Smarttech247']},
  mina:{n:'Mina George',r:'Sales Enablement Manager',c:'#0A6FB0',loc:'Dubai',st:'on',pr:[],v:[]},
  arjun:{n:'Arjun Menon',r:'Commercial Finance Manager',c:'#6C7483',loc:'Dubai',st:'away',pr:[],v:[]},
};
const initials = n => n.split(' ').filter(w=>/^[A-Z]/.test(w)).map(w=>w[0]).slice(0,2).join('');

/* ---------- Content (synthetic) ---------- */
// [id, title, cat, type, practices, vendors, industries, stages, audience c/i, lang E/A/B, owner, daysAgo, status a/x/r/d/e, conf P/I/C/H, views, flags]
const RAW = [
 ['corp-deck','CNS Corporate Master Deck 2026','brand','Presentation','all','','cross','Prospect,Discover','c','B','layla',12,'a','I',1240,'f'],
 ['cap-stmt','CNS Capability Statement','brand','Document','all','','cross','Prospect,Qualify','c','E','layla',40,'a','P',610,''],
 ['ghobash','Ghobash Group Profile','brand','Presentation','all','','cross','Prospect','c','B','layla',95,'a','P',220,''],
 ['ppt-tpl','CNS PowerPoint Master Template v4','brand','Template','all','','cross','','i','E','layla',30,'a','I',480,''],
 ['brand-kit','CNS Brand Guidelines & Logo Pack','brand','Template','all','','cross','','i','B','layla',160,'x','I',190,''],
 ['trade-lic','Trade Licence \u2013 Abu Dhabi (valid to Mar 2027)','creds','Document','all','','cross','Propose','c','B','hana',58,'a','C',402,''],
 ['iso27001','ISO/IEC 27001:2022 Certificate','creds','Document','all','','cross','Propose','c','E','hana',120,'a','C',351,''],
 ['iso-pack','ISO 9001, 20000-1 & 22301 Certificate Pack','creds','Document','all','','cross','Propose','c','E','hana',120,'a','C',214,''],
 ['cisco-cert','Cisco Gold Integrator Partner Certificate','creds','Document','di','Cisco','cross','Propose','c','E','faisal',330,'x','C',176,''],
 ['vat-bank','VAT Registration & Bank Reference Letter','creds','Document','all','','cross','Propose','i','E','arjun',75,'a','C',98,''],
 ['campus-brief','Secure Campus Networking \u2013 Solution Brief','portfolio','Datasheet','di','Cisco','edu,hc,gov','Discover,Qualify','c','E','rami',9,'a','P',305,''],
 ['veeam-ra','Veeam Data Protection \u2013 Reference Architecture','portfolio','Datasheet','di','Veeam','cross','Qualify,Propose','c','E','priya',21,'a','I',266,''],
 ['aws-lz','Hybrid Cloud Landing Zone on AWS \u2013 Solution Overview','portfolio','Datasheet','cloud','AWS','cross','Discover,Qualify','c','E','daniel',6,'a','P',188,''],
 ['mdr-svc','Managed Detection & Response (MDR) \u2013 Service Overview','portfolio','Datasheet','cyber,ms','Smarttech247','bfsi,gov,def','Discover,Qualify','c','B','sara',33,'a','P',241,''],
 ['ai-agents','Code81 AI Agents \u2013 Solution Overview','portfolio','Presentation','ai,dt','Microsoft','gov,bfsi,cross','Prospect,Discover','c','B','youssef',4,'a','P',402,'f'],
 ['netapp-ds','NetApp Hybrid Storage \u2013 Datasheet','portfolio','Datasheet','di','NetApp','cross','Qualify','c','E','rami',140,'a','P',87,''],
 ['veeam-deck','CNS Veeam Data Protection Overview','decks','Presentation','di','Veeam','bfsi,cross','Discover,Qualify,Propose','c','E','priya',14,'a','I',512,''],
 ['hc-net-deck','CNS Healthcare Network Modernisation Deck','decks','Presentation','di','Cisco,Infoblox','hc','Discover,Qualify,Propose','c','E','rami',8,'a','I',433,'f'],
 ['cyber-deck','Cyber Security Practice Deck 2026','decks','Presentation','cyber','Forescout,Kaspersky,WatchGuard','cross','Prospect,Discover','c','B','sara',26,'a','I',398,''],
 ['bank-ss','Digital Banking Self-Service Pitch','decks','Presentation','bank','Temenos,IDEMIA','bfsi','Discover,Propose','c','B','tarek',44,'a','I',276,''],
 ['gov-dt','Government Digital Transformation Deck (EN/AR)','decks','Presentation','dt,ai','Microsoft,Mendix','gov','Prospect,Discover','c','B','youssef',17,'a','I',351,''],
 ['fs-cobrand','Forescout NAC \u2013 CNS Co-branded Deck','decks','Presentation','cyber','Forescout','hc,gov,og','Discover,Qualify','c','E','sara',85,'x','I',212,''],
 ['og-ot','OT Security for Oil & Gas','decks','Presentation','cyber','Forescout,Stormshield','og,eu','Discover','c','E','sara',63,'a','I',143,''],
 ['mendix-deck','Low-Code Modernisation with Mendix','decks','Presentation','apps','Mendix','gov,cross','Discover','c','E','noura',52,'a','I',121,''],
 ['wp-sovai','Sovereign AI in the UAE: A Practical Guide','papers','Whitepaper','ai,dt','','gov,bfsi','Prospect,Discover','c','B','youssef',3,'a','P',264,'f'],
 ['wp-ransom','Ransomware Readiness for GCC Banks','papers','Whitepaper','cyber,di','Veeam','bfsi','Prospect,Discover','c','E','sara',48,'a','P',203,''],
 ['wp-zt','Zero Trust Network Access \u2013 CNS Point of View','papers','Whitepaper','cyber','Forescout','cross','Prospect','c','E','sara',210,'e','P',66,''],
 ['wp-tco','The CIO\u2019s Guide to Hybrid Cloud TCO','papers','Whitepaper','cloud','AWS,Dynatrace','cross','Discover,Qualify','c','E','daniel',72,'a','P',112,''],
 ['bc-falcon','Battle Card: CNS vs Falcon Integration Group','battle','Battle Card','all','','cross','Qualify,Propose,Negotiate','i','E','mina',19,'a','I',344,'f'],
 ['bc-forescout','Battle Card: Forescout vs Competing NAC Vendors','battle','Battle Card','cyber','Forescout','cross','Qualify,Propose','i','E','sara',11,'a','I',287,''],
 ['bc-veeam','Battle Card: Veeam vs Legacy Backup Platforms','battle','Battle Card','di','Veeam','cross','Qualify,Propose','i','E','priya',37,'a','I',231,''],
 ['bc-msp','Battle Card: CNS Managed Services vs Global Outsourcers','battle','Battle Card','ms','','gov,hc','Qualify,Propose,Negotiate','i','E','ahmed',66,'a','I',158,''],
 ['bc-obj','Objection Handling: \u201cCan a regional SI deliver at our scale?\u201d','battle','Battle Card','all','','cross','Qualify,Negotiate','i','E','mina',2,'r','I',0,''],
 ['cs-moei','Ministry of Energy & Infrastructure \u2013 AI Digital Branch, Fujairah','cases','Case Study','dt,ai','','gov','Discover,Propose','c','B','layla',15,'a','P',301,'f'],
 ['cs-ku','Khalifa University \u2013 AI Visitor Management','cases','Case Study','ai','','edu','Discover,Propose','c','E','layla',28,'a','P',176,''],
 ['cs-ehs','Emirates Health Services \u2013 Managed IT Services','cases','Case Study','ms','','hc','Discover,Propose','c','E','layla',22,'a','P',265,''],
 ['cs-fta','Federal Tax Authority \u2013 Enterprise AI Platform','cases','Case Study','ai,dt','','gov','Discover,Propose','c','E','layla',36,'a','P',193,''],
 ['cs-dmt','DMT \u2013 Integrated Application Support & Data Platform','cases','Case Study','ms,dt','','gov','Discover,Propose','c','E','layla',41,'a','P',158,''],
 ['cs-sanad','Sanad \u2013 Resilient, Proactive IT Operations','cases','Case Study','ms','','cross','Discover,Propose','c','E','layla',55,'a','P',134,''],
 ['cs-dhofar','Bank Dhofar \u2013 ATM Lifecycle Modernisation','cases','Case Study','bank','','bfsi','Discover,Propose','c','E','tarek',90,'a','P',118,''],
 ['cs-robo','HCI ROBO for 17 Remote Hospitals','cases','Case Study','di','','hc','Discover,Propose','c','E','rami',13,'a','P',209,''],
 ['cs-mohap','MOHAP \u2013 Infrastructure Modernisation Programme','cases','Case Study','di','Cisco','hc,gov','Discover,Propose','c','E','rami',61,'a','P',247,''],
 ['rfp-gov','RFP Response Template \u2013 Government','bids','Template','all','','gov','Propose','i','B','hana',18,'a','C',219,''],
 ['boiler','Boilerplate: Company Overview, Methodology & QA/HSE','bids','Document','all','','cross','Propose','i','E','hana',23,'a','C',287,''],
 ['cv-lib','CV Library \u2013 Presales & Delivery (42 CVs)','bids','Document','all','','cross','Propose','i','E','hana',10,'a','C',176,''],
 ['ia-matrix','Compliance Matrix \u2013 UAE IA & NESA Controls','bids','Document','cyber','','gov,bfsi,def','Propose','i','E','sara',47,'a','C',164,''],
 ['win-sdwan','Winning Proposal: Healthcare SD-WAN Rollout (2025)','bids','Document','di','Cisco','hc','Propose','i','E','hana',150,'a','C',142,''],
 ['sow-msa','SOW & MSA Templates','bids','Template','all','','cross','Negotiate,Close','i','E','hana',68,'a','C',121,''],
 ['cisco-ppg','Cisco Partner Programme Guide FY27','vendor','Document','di','Cisco','cross','','i','E','faisal',27,'a','I',92,''],
 ['veeam-promo','Veeam Q4 Promotion \u2013 VDP Bundle 20% off (ends 31 Dec)','vendor','Link','di','Veeam','cross','Propose,Negotiate','i','E','faisal',5,'x','I',117,''],
 ['fs-dealreg','Forescout Deal Registration Steps','vendor','Document','cyber','Forescout','cross','Qualify','i','E','faisal',16,'a','I',81,''],
 ['temenos-brief','Temenos Partner Brief & Joint Value Proposition','vendor','Document','bank','Temenos','bfsi','Discover','c','E','tarek',80,'a','I',64,''],
 ['dyna-ds','Dynatrace Observability \u2013 Datasheet','vendor','Datasheet','cloud,ms','Dynatrace','cross','Discover','c','E','daniel',39,'a','P',58,''],
 ['playbook','CNS Sales Playbook 2026','play','Document','all','','cross','Prospect,Discover,Qualify,Propose,Negotiate,Close','i','E','mina',20,'a','I',366,''],
 ['meddicc','MEDDICC Qualification Checklist','play','Template','all','','cross','Qualify','i','E','mina',46,'a','I',241,''],
 ['disc-q','Discovery Question Bank by Practice','play','Document','all','','cross','Discover','i','E','mina',31,'a','I',198,''],
 ['discount','Discount Authority Matrix','play','Document','all','','cross','Negotiate','i','E','arjun',60,'a','C',87,''],
 ['kit-hc','Healthcare Industry Kit \u2013 Overview & Regulations','kits','Document','all','','hc','Prospect,Discover','i','E','rami',7,'a','I',188,''],
 ['kit-bfsi','BFSI Regulatory Brief \u2013 CBUAE & CBO','kits','Document','bank,cyber','','bfsi','Discover','i','E','tarek',24,'a','I',152,''],
 ['kit-gov','Government Kit \u2013 UAE IA & DESC Requirements','kits','Document','cyber,dt','','gov,def','Discover','i','B','sara',29,'a','I',171,''],
 ['rate-card','Managed Services Rate Card 2026','pricing','Calculator','ms','','cross','Propose,Negotiate','i','E','arjun',34,'a','H',61,''],
 ['margins','Margin Guidelines by Vendor','pricing','Document','all','','cross','Negotiate','i','E','arjun',34,'a','H',44,''],
 ['vid-60','New Joiner: The CNS Portfolio in 60 Minutes','train','Video','all','','cross','','i','E','mina',25,'a','I',143,''],
 ['vid-banks','Recorded Session: Selling Cyber Security to Banks','train','Video','cyber,bank','Kaspersky,KnowBe4','bfsi','','i','E','sara',12,'a','I',96,''],
 ['cert-track','Vendor Certification Tracker','train','Link','all','','cross','','i','E','mina',1,'a','I',54,''],
 ['calc-tco','Backup TCO Calculator \u2013 Veeam vs Legacy','tools','Calculator','di','Veeam','cross','Qualify,Propose','i','E','priya',43,'a','I',139,''],
 ['calc-net','Campus Network Sizing Tool','tools','Calculator','di','Cisco','edu,hc,gov','Qualify','i','E','rami',57,'a','I',88,''],
 ['calc-ms','Managed Services ROI Calculator','tools','Calculator','ms','','cross','Propose','i','E','ahmed',38,'a','I',96,''],
 ['sf-link','Salesforce \u2013 My Open Opportunities','tools','Link','all','','cross','','i','E','mina',100,'a','I',402,''],
 ['news-noc','New win: 3-year NOC managed services contract with a federal entity','news','Link','ms','','gov','','i','E','layla',2,'a','I',212,''],
 ['events','Events & Vendor Webinars \u2013 Q4 2026 / Q1 2027','news','Link','all','','cross','','i','E','layla',6,'a','I',88,''],
];
const DESC = {
 'corp-deck':'The approved corporate pitch: 39 years in the Gulf, 1,000+ professionals, NOCs in Abu Dhabi and Dubai, practices, key clients and success stories. Use as the first meeting deck.',
 'veeam-deck':'Customer-facing overview of CNS backup and recovery services on Veeam: immutable backup, ransomware recovery, Veeam Data Platform bundles and CNS managed backup.',
 'hc-net-deck':'Network modernisation pitch for hospitals and health networks: secure campus, clinical Wi-Fi, segmentation for medical devices, and ADHICS-aligned design.',
 'bc-falcon':'How to position against a regional systems integrator that often competes on price in UAE government and healthcare tenders. Fictional competitor for the demo.',
 'bc-forescout':'Positioning Forescout agentless NAC and device visibility against agent-based NAC vendors in healthcare, OT and campus networks.',
 'cs-moei':'AI-driven digital branch with holograms, VR booths and service robots, plus a blockchain-enabled virtual service centre.',
 'cs-ehs':'End-to-end IT managed services across 120+ health facilities: service desk, end-user support, NOC operations, ITIL governance.',
 'cs-mohap':'Network and data-centre modernisation across federal hospitals and clinics with Cisco-based campus and SD-WAN.',
 'wp-sovai':'How UAE government entities can adopt AI while keeping data, models and operations under sovereign control. Written with Code81.',
 'ai-agents':'Code81 AI agents for citizen services, document processing and internal operations, deployed in-country.',
 'kit-hc':'Pain points, regulations (ADHICS, DoH, DHA, MOHAP), CNS solutions and references for healthcare customers.',
 'veeam-promo':'Veeam Data Platform bundle promotion for new logos. Register the deal before quoting. Ends 31 Dec 2026.',
 'playbook':'CNS sales methodology end to end: territory planning, MEDDICC qualification, deal reviews, approval workflow and handover to delivery.',
};
const kitSet = (s)=> s ? s.split(',') : [];
const ITEMS = RAW.map(r=>{
  const [id,title,cat,type,pr,ve,ind,st,aud,lang,owner,days,status,conf,views,flags] = r;
  const updated = new Date(TODAY); updated.setDate(updated.getDate()-days);
  const hash = [...id].reduce((a,c)=>a+c.charCodeAt(0),0);
  return {id,title,cat,type,
    practices: pr==='all' ? Object.keys(PRACTICES) : kitSet(pr), allPractices: pr==='all',
    vendors:kitSet(ve), industries:kitSet(ind), stages:kitSet(st),
    audience: aud==='c'?'Customer-facing':'Internal only', lang:{E:'English',A:'Arabic',B:'Bilingual'}[lang],
    owner, updated, days, status, reviewIn: status==='x' ? 6 + hash%22 : null,
    conf:{P:'Public',I:'Internal',C:'Confidential',H:'Highly Confidential'}[conf], views, featured: flags.includes('f'),
    restricted: cat==='pricing', desc: DESC[id] || null, version: 1 + hash%5 + '.' + hash%3, size: (0.4 + (hash%90)/10).toFixed(1)+' MB'};
});
const byId = Object.fromEntries(ITEMS.map(i=>[i.id,i]));
const ALL_VENDORS = [...new Set(ITEMS.flatMap(i=>i.vendors))].sort();

/* ---------- Vendors (tiers from the CNS intro deck; others demo) ---------- */
const VENDORS = [
 ['Microsoft','Strategic alliance','Cloud, AI & productivity','daniel'],['AWS','Strategic alliance','Cloud & infrastructure','daniel'],
 ['Cisco','Core solution partner','Networking & infrastructure','faisal'],['Google Cloud','Core solution partner','Cloud & data','daniel'],['Palo Alto Networks','Core solution partner','Network security','faisal'],
 ['Dell Technologies','Specialised partner','Compute & storage','faisal'],['Fortinet','Specialised partner','Network security','faisal'],['Red Hat','Specialised partner','Hybrid cloud & automation','daniel'],['Temenos','Specialised partner','Core & digital banking','tarek'],['Finastra','Specialised partner','Banking software','tarek'],
 ['Veeam','Technology partner','Backup & recovery','faisal'],['NetApp','Technology partner','Storage','faisal'],['Infoblox','Technology partner','DDI & DNS security','faisal'],['DataCore','Technology partner','Software-defined storage','faisal'],
 ['Veritas','Technology partner','Backup & recovery','faisal'],['RackWare','Technology partner','Cloud migration & DR','faisal'],['Perpetuuiti','Technology partner','Resilience automation','faisal'],['Dynatrace','Technology partner','Observability','daniel'],
 ['Forescout','Technology partner','NAC & device visibility','faisal'],['WatchGuard','Technology partner','Network & endpoint security','faisal'],['Stormshield','Technology partner','OT & network security','faisal'],['Kaspersky','Technology partner','Endpoint security','faisal'],
 ['KnowBe4','Technology partner','Security awareness','faisal'],['Deep Secure','Technology partner','Content threat removal','faisal'],['PowerDMARC','Technology partner','Email authentication','faisal'],['SecPod','Technology partner','Vulnerability management','faisal'],
 ['Smarttech247','Technology partner','MDR / SOC services','faisal'],['IDEMIA','Technology partner','Identity & biometrics','tarek'],['Nintex','Technology partner','Process automation','noura'],['Mendix','Technology partner','Low-code platform','noura'],
 ['novomind','Technology partner','Customer service platform','noura'],['Cube.ms','Technology partner','Engineering project management','noura'],
].map(([n,tier,area,mgr])=>({n,tier,area,mgr,slug:n.toLowerCase().replace(/[^a-z0-9]+/g,'-')}));
const vendorBySlug = Object.fromEntries(VENDORS.map(v=>[v.slug,v]));

/* ---------- Industry kits ---------- */
const KITS = {
 hc:{pains:['Clinical Wi-Fi and medical-device networks that grew without segmentation','ADHICS and DoH audit findings on access control and asset visibility','Ageing infrastructure across many remote hospitals and clinics','IT teams stretched across 24\u00d77 operations'],
     regs:[['ADHICS','Abu Dhabi Healthcare Information & Cyber Security Standard'],['DoH / DHA policies','Emirate-level health data and cloud rules'],['MOHAP','Federal health data protection requirements'],['UAE IA','Federal information assurance controls']],
     plays:['Secure campus & clinical Wi-Fi','Medical device visibility (Forescout)','HCI for remote hospitals','Managed IT & NOC services']},
 bfsi:{pains:['Ransomware and recovery-time expectations from the regulator','ATM and branch estates that are expensive to run','Pressure to launch digital channels fast','Third-party and cloud outsourcing rules'],
     regs:[['CBUAE','Central Bank of the UAE outsourcing, cyber and resilience rules'],['CBO','Central Bank of Oman technology risk guidelines'],['PCI DSS','Card data security'],['SWIFT CSP','Customer security programme']],
     plays:['Self-service & ATM modernisation','Immutable backup & cyber recovery','MDR / SOC services','Temenos digital banking']},
 gov:{pains:['Digital-first service targets and customer happiness KPIs','Data sovereignty for AI and cloud workloads','Legacy applications that are hard to change','Information assurance compliance'],
     regs:[['UAE IA','Federal information assurance standard'],['DESC ISR','Dubai Electronic Security Center information security regulation'],['ADHICS (health entities)','Abu Dhabi healthcare cyber standard'],['UAE PDPL','Personal data protection law']],
     plays:['AI digital branch & virtual service centre','Sovereign AI with Code81','Low-code modernisation','Managed application support']},
 og:{pains:['OT networks with no asset inventory','Convergence of IT and OT security','Remote sites with limited connectivity'],regs:[['IEC 62443','Industrial automation security'],['NCEMA','National emergency & continuity standard']],plays:['OT security (Forescout, Stormshield)','Resilient remote-site infrastructure']},
 def:{pains:['Air-gapped environments','Strict vendor vetting','Long programme lifecycles'],regs:[['UAE IA','Federal information assurance'],['Classified handling rules','Per entity']],plays:['Secure data transfer (Deep Secure)','Sovereign infrastructure']},
 eu:{pains:['Grid and plant OT exposure','Field workforce systems','Customer service at scale'],regs:[['IEC 62443','Industrial automation security'],['DESC ISR','For Dubai entities']],plays:['OT visibility','Customer service platforms (novomind)']},
 edu:{pains:['Campus networks for thousands of students','Visitor and identity management','Research data protection'],regs:[['CAA / MoE guidance','Accreditation-related IT requirements']],plays:['Secure campus networking','AI visitor management','Data & AI with Code81']},
};

/* ---------- App state ---------- */
const PERSONAS = [
 {id:'omar',n:'Omar Haddad',r:'Account Manager',c:'#0090E0',desc:'Owns 22 government & healthcare accounts',restricted:false,home:'Prepare for meetings'},
 {id:'priya',n:'Priya Nair',r:'Presales Engineer',c:'#1C6E8C',desc:'Backup, DR & cloud architect',restricted:false,home:'Build proposals faster'},
 {id:'karim',n:'Karim Saleh',r:'New Joiner (day 18)',c:'#586377',desc:'Joined the Dubai team on 2 Nov 2026',restricted:false,home:'Your 30-60-90 path'},
 {id:'head',n:'Head of Sales',r:'Sales Leadership',c:'#C12E1F',desc:'Pricing Restricted group member',restricted:true,home:'Team & content performance'},
 {id:'owner',n:'Sara Al Hashimi',r:'Content Owner \u00b7 Cyber',c:'#16265E',desc:'Publishes and approves Cyber content',restricted:false,home:'Your content health'},
];
const store = {
  get(k,d){try{const v=localStorage.getItem('cnsp:'+k);return v?JSON.parse(v):d}catch(e){return d}},
  set(k,v){try{localStorage.setItem('cnsp:'+k,JSON.stringify(v))}catch(e){}}
};
const S = {
  persona: store.get('persona','omar'),
  phase: store.get('phase',3),
  kit: new Set(store.get('kit',['corp-deck','hc-net-deck','bc-falcon','cs-ehs','trade-lic'])),
  done: new Set(store.get('done',['Days 1\u201330corp-deck','Days 1\u201330vid-60','Days 1\u201330brand-kit','Days 1\u201330playbook','Days 31\u201360cyber-deck'])),
  q:'', f:{cat:[],type:[],practice:[],vendor:[],industry:[],stage:[],lang:[]}, sort:'rel',
  annIdx:0, attached:new Set(['cs-mohap']), queue:null, chat:null, kitTab:'all', vendTab:'collateral',
};
const persona = ()=>PERSONAS.find(p=>p.id===S.persona)||PERSONAS[0];
const canSee = it => !it.restricted || persona().restricted;

/* ---------- Helpers ---------- */
const $ = s=>document.querySelector(s);
const esc = s=>String(s).replace(/[&<>"]/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;'}[c]));
const fmtDate = d=>d.toLocaleDateString('en-GB',{day:'numeric',month:'short',year:'numeric'});
const ago = days=> days===0?'today':days===1?'yesterday':days<30?`${days} days ago`:days<60?'1 month ago':`${Math.round(days/30)} months ago`;
const catName = id=>CATS.find(c=>c.id===id)?.n||id;
const prLabel = it=> it.allPractices ? 'All practices' : it.practices.map(p=>PRACTICES[p].replace(/ \(.*\)/,'')).join(', ');
function statusBadge(it){
  if(it.restricted && !canSee(it)) return `<span class="badge b-lock">${ic('lock')}Restricted</span>`;
  if(it.status==='a') return `<span class="badge b-ok">${ic('check')}Approved</span>`;
  if(it.status==='x') return `<span class="badge b-warn">${ic('clock')}Review in ${it.reviewIn}d</span>`;
  if(it.status==='r') return `<span class="badge b-info">${ic('eye')}In review</span>`;
  if(it.status==='d') return `<span class="badge b-info">Draft</span>`;
  if(it.status==='e') return `<span class="badge b-bad">${ic('alert')}Expired</span>`;
  return '';
}
function avatar(key, size){ const p = PEOPLE[key]; return `<span class="av" style="background:${p.c}${size?`;width:${size}px;height:${size}px`:''}">${initials(p.n)}</span>`; }
function phaseTag(p){ return `<span class="ph p${p}">${p===1?'MVP':'PHASE '+p}</span>`; }

function card(it){
  const locked = !canSee(it);
  return `<div class="card" role="button" tabindex="0" data-open="${it.id}">
    <div class="thumb th-${TYPE_TH[it.type]}"><span class="tt">${esc(it.type)}</span><span class="ext">${TYPE_EXT[it.type]}</span>${ic(TYPE_IC[it.type],'big')}</div>
    <div class="body">
      <h4>${esc(it.title)}</h4>
      <div class="meta">${esc(prLabel(it))}${it.vendors.length?` \u00b7 ${esc(it.vendors.join(', '))}`:''}</div>
      <div class="foot">${statusBadge(it)}${it.audience==='Internal only'&&!locked?`<span class="badge b-lock">${ic('lock')}Internal</span>`:''}<span class="small muted">${ago(it.days)}</span>
      <button class="star ${S.kit.has(it.id)?'on':''}" data-star="${it.id}" aria-label="Save to My Kit" title="Save to My Kit">${ic('star')}</button></div>
    </div></div>`;
}
function row(it, extra=''){
  return `<div class="row" role="button" tabindex="0" data-open="${it.id}">
    <span class="tile-ic sm ${it.type==='Battle Card'?'red':it.type==='Case Study'?'blue':''}">${ic(TYPE_IC[it.type])}</span>
    <div class="t"><b>${esc(it.title)}</b><span>${esc(it.type)} \u00b7 ${esc(prLabel(it))} \u00b7 updated ${ago(it.days)}</span></div>${extra}${statusBadge(it)}</div>`;
}
const visible = list => list.filter(i=>i.status!=='e' && i.status!=='r' && i.status!=='d');

/* ---------- Navigation ---------- */
const NAV = [
 {g:'Discover',items:[['home','Home','home',1],['search','Search & browse','search',1],['categories','All categories','grid',1],['kits','Industry Kits','globe',1],['vendors','Vendor Hubs','handshake',1],['experts','Experts Directory','users',1]]},
 {g:'For me',items:[['mykit','My Kit','star',1],['onboarding','30-60-90 Path','route',1]]},
 {g:'Govern & measure',items:[['governance','Content Governance','shield',2],['analytics','Usage Analytics','chart',2],['salesforce','Salesforce Panel','cloud',2]]},
 {g:'Assist',items:[['assistant','AI Sales Assistant','spark',3]]},
];
function renderSide(route){
  const base = route.split('-')[0];
  const map = {cat:'categories',kit:'kits',vendor:'vendors'};
  const cur = map[base] || route;
  let h='';
  NAV.forEach(g=>{
    const its = g.items.filter(i=>i[3]<=S.phase); if(!its.length) return;
    h+=`<div class="grp eyebrow">${g.g}</div><nav class="nav">`;
    its.forEach(([r,l,i,p])=>{ h+=`<a href="#${r}" class="${cur===r?'on':''}">${ic(i)}<span>${l}</span>${p>1?phaseTag(p):''}</a>`; });
    h+='</nav>';
  });
  h+=`<div class="roadmap"><div class="eyebrow">Roadmap view</div><div class="seg">${[1,2,3].map(p=>`<button data-phase="${p}" class="${S.phase===p?'on':''}">${p===1?'MVP':'+ P'+p}</button>`).join('')}</div>
   <p>${S.phase===1?'2-week MVP: browse, search, preview, share, My Kit, experts.':S.phase===2?'Adds governance, analytics and the Salesforce panel (weeks 3\u201312).':'Adds the AI assistant, semantic search and vendor sync (months 4\u20136).'}</p></div>`;
  $('#side').innerHTML=h;
}

/* ---------- Views ---------- */
const ANN = [
 ['New win','<b>3-year NOC managed services contract</b> signed with a federal entity. Reference deck and win story are in News &amp; Experts.','news-noc'],
 ['Vendor promotion','<b>Veeam Q4 bundle: 20% off Veeam Data Platform</b> for new logos until 31 Dec. Register the deal first.','veeam-promo'],
 ['New content','<b>Sovereign AI in the UAE</b> whitepaper is live, written with Code81. Great opener for government CIOs.','wp-sovai'],
];
function vHome(){
  const p = persona();
  const feat = ITEMS.filter(i=>i.featured).slice(0,6);
  const fresh = visible(ITEMS).filter(i=>i.days<=30 && canSee(i)).sort((a,b)=>a.days-b.days).slice(0,8);
  const a = ANN[S.annIdx%ANN.length];
  const hour = 9;
  const counts = Object.fromEntries(CATS.map(c=>[c.id,ITEMS.filter(i=>i.cat===c.id).length]));
  const forYou = {
    omar:['hc-net-deck','cs-mohap','bc-falcon','kit-hc'], priya:['boiler','cv-lib','win-sdwan','ia-matrix'],
    karim:['corp-deck','vid-60','playbook','meddicc'], head:['bc-falcon','playbook','discount','rate-card'], owner:['bc-forescout','fs-cobrand','wp-zt','bc-obj']
  }[p.id].map(id=>byId[id]);
  return `
  <div class="announce" role="status"><span class="tag">${a[0]}</span><div class="amsg">${a[1]}</div>
   <button class="link" data-open="${a[2]}">Open ${ic('chev')}</button><div class="dots">${ANN.map((_,i)=>`<i class="${i===S.annIdx%ANN.length?'on':''}"></i>`).join('')}</div></div>

  <section class="hero"><div class="bg" style="background-image:url(${HERO})"></div><div class="in">
    <div class="eyebrow" style="color:var(--sky)">CNS Unified Sales Portal</div>
    <h1>Good morning, ${esc(p.n.split(' ')[0]==='Head'?'there':p.n.split(' ')[0])}. Find any approved asset in seconds.</h1>
    <div class="rule"></div>
    <form class="hsearch" id="hsearch">${ic('search')}<input id="hq" type="search" placeholder="Try \u201cVeeam backup\u201d, \u201chealthcare case study\u201d or \u201ctrade licence\u201d" autocomplete="off"><button class="btn primary" type="submit">Search</button></form>
    <div class="qf"><label>Quick filters</label>
      <select id="qfP" aria-label="Practice"><option value="">Practice</option>${Object.entries(PRACTICES).map(([k,v])=>`<option value="${k}">${v}</option>`).join('')}</select>
      <select id="qfV" aria-label="Vendor"><option value="">Vendor</option>${ALL_VENDORS.map(v=>`<option>${v}</option>`).join('')}</select>
      <select id="qfI" aria-label="Industry"><option value="">Industry</option>${Object.entries(INDUSTRIES).map(([k,v])=>`<option value="${k}">${v.n}</option>`).join('')}</select>
    </div>
  </div></section>

  <div class="quick">
    <a href="#kit-hc">${ic('heart')}Healthcare Kit</a><a href="#cat-creds">${ic('award')}RFP credentials</a><a href="#cat-battle">${ic('sword')}Battle cards</a>
    <a href="#vendor-veeam">${ic('handshake')}Veeam hub</a><a href="#experts">${ic('teams')}Ask an expert</a><a href="#onboarding">${ic('route')}30-60-90 path</a>
    ${S.phase>=3?`<a href="#assistant">${ic('spark')}Ask the AI assistant</a>`:''}
  </div>

  <section><div class="sec-h"><div><div class="eyebrow">Browse</div><h2>15 content categories</h2></div><a class="link" href="#categories">View all ${ic('chev')}</a></div>
   <div class="cats">${CATS.map(c=>`<button class="cat ${c.restricted&&!persona().restricted?'locked':''}" data-go="cat-${c.id}"><span class="tile-ic ${c.id==='battle'?'red':c.id==='cases'?'blue':''}">${ic(c.restricted&&!persona().restricted?'lock':c.i)}</span><span><b>${c.n}</b><span>${counts[c.id]} item${counts[c.id]===1?'':'s'}${c.restricted?' \u00b7 restricted':''}</span></span></button>`).join('')}</div></section>

  ${S.phase>=3 && (p.id==='omar'||p.id==='head') ? oppStrip() : ''}

  <section><div class="sec-h"><div><div class="eyebrow">Picked by the Portal Admin</div><h2>Featured</h2></div></div><div class="cards f6">${feat.map(card).join('')}</div></section>

  <section class="two">
    <div><div class="sec-h"><div><div class="eyebrow">Latest approved</div><h2>New this month</h2></div><a class="link" data-go="search" data-sort="new">See all ${ic('chev')}</a></div>
      <div class="panel list">${fresh.map(i=>row(i)).join('')}</div></div>
    <div><div class="sec-h"><div><div class="eyebrow">For ${esc(p.r)}</div><h2>${esc(p.home)}</h2></div></div>
      <div class="panel list">${forYou.filter(canSee).map(i=>row(i)).join('')}</div>
      <div class="sec-h" style="margin-top:22px"><div><div class="eyebrow">Ask an expert</div><h2>Experts online now</h2></div><a class="link" href="#experts">Directory ${ic('chev')}</a></div>
      <div class="panel list">${['sara','rami','daniel','hana'].map(k=>{const e=PEOPLE[k];return `<div class="row" style="cursor:default">${avatar(k)}<div class="t"><b>${e.n}</b><span>${e.r}</span></div><button class="btn" data-teams="${k}" style="padding:6px 10px">${ic('teams')}Chat</button></div>`}).join('')}</div>
    </div>
  </section>

  <section><div class="sec-h"><div><div class="eyebrow">Curated bundles</div><h2>Industry Kits</h2></div><a class="link" href="#kits">All kits ${ic('chev')}</a></div>
   <div class="kits">${Object.entries(INDUSTRIES).filter(([k])=>k!=='cross').map(([k,v])=>`<button class="kit" data-go="kit-${k}">${ic(v.i)}<div><b>${v.n}</b><span>${ITEMS.filter(i=>i.industries.includes(k)).length} assets</span></div></button>`).join('')}</div></section>
  ${footer()}`;
}
function oppStrip(){
  const opps = [
   {a:'Al Noor Hospital Group',n:'Campus network & clinical Wi-Fi refresh',s:'Propose',v:'AED 4.2M',i:['hc-net-deck','cs-mohap','bc-forescout']},
   {a:'Emirates Federal Services Authority',n:'AI digital service centre',s:'Qualify',v:'AED 7.8M',i:['cs-moei','wp-sovai','ai-agents']},
   {a:'Gulf Coast Bank',n:'Immutable backup & cyber recovery',s:'Discover',v:'AED 1.6M',i:['veeam-deck','wp-ransom','calc-tco']},
  ];
  return `<section><div class="sec-h"><div><div class="eyebrow">From Salesforce \u00b7 ${phaseTag(3)}</div><h2>Your open opportunities, with suggested content</h2></div><a class="link" href="#salesforce">Salesforce panel ${ic('chev')}</a></div>
  <div class="opps">${opps.map(o=>`<div class="opp"><div class="top2"><span class="badge b-info">${o.s}</span><span class="amt">${o.v}</span></div><div><b>${o.a}</b><div class="small muted">${o.n}</div></div>
   <div class="sugg">${o.i.map(id=>`<button data-open="${id}">${ic(TYPE_IC[byId[id].type])}${esc(byId[id].title)}</button>`).join('')}</div></div>`).join('')}</div>
   <p class="small muted" style="margin:8px 0 0">Opportunity names are fictional demo data.</p></section>`;
}
function footer(){
  return `<footer class="foot"><nav>
   <a href="#salesforce">${ic('cloud')}Salesforce</a><a href="#vendors">${ic('ext')}Vendor partner portals</a><a href="#" data-toast="Quick guide opened (demo)">${ic('book')}Quick guide</a>
   <a href="#" data-toast="Thanks. Your content suggestion was sent to the Portal Admin (demo)">${ic('plus')}Suggest content</a></nav>
   <span>CNS Technology \u00b7 Part of Ghobash Group \u00b7 Internal, confidential \u00b7 Prototype built by Code81 with synthetic data</span></footer>`;
}

function vCategories(){
  return `<div class="page-h"><div><div class="eyebrow">Taxonomy</div><h1>All content categories</h1><p>Every asset sits in one of 15 categories and carries the same metadata: practice, vendor, industry, sales stage, audience, language and review date.</p></div></div>
  <div class="panel tscroll"><table class="t"><thead><tr><th>Category</th><th>Items</th><th>Owner</th><th>Review cycle</th><th>Sensitivity</th></tr></thead><tbody>
  ${CATS.map(c=>{const n=ITEMS.filter(i=>i.cat===c.id).length;const rc={brand:'6 months',creds:'On expiry',portfolio:'6 months',decks:'Quarterly',papers:'12 months',battle:'Quarterly',cases:'12 months',bids:'6 months',vendor:'Monthly',play:'6 months',kits:'6 months',pricing:'Quarterly',train:'6 months',tools:'6 months',news:'Ongoing'}[c.id];
   const sens={brand:'Internal / customer-facing',creds:'Confidential',portfolio:'Customer-facing',decks:'Customer-facing',papers:'Customer-facing',battle:'Internal only',cases:'Customer-facing',bids:'Confidential',vendor:'Internal / customer-facing',play:'Internal only',kits:'Internal',pricing:'Highly confidential',train:'Internal',tools:'Internal',news:'Internal'}[c.id];
   return `<tr style="cursor:pointer" data-go="cat-${c.id}"><td><div style="display:flex;gap:10px;align-items:center"><span class="tile-ic sm">${ic(c.i)}</span><b>${c.n}</b></div></td><td class="num">${n}</td><td>${c.own}</td><td>${rc}</td><td>${sens}</td></tr>`}).join('')}
  </tbody></table></div>${footer()}`;
}
function vCat(id){
  const c = CATS.find(x=>x.id===id); if(!c) return vCategories();
  const its = ITEMS.filter(i=>i.cat===id && i.status!=='r' && i.status!=='d');
  const locked = c.restricted && !persona().restricted;
  return `<div><div class="crumbs"><a href="#home">Home</a>${ic('chev')}<a href="#categories">Categories</a>${ic('chev')}<span>${c.n}</span></div>
   <div class="page-h"><span class="tile-ic ${id==='battle'?'red':''}">${ic(c.i)}</span><div><h1>${c.n}</h1><p>Owned by ${c.own}. ${its.length} items.</p></div>
   <div style="margin-left:auto" class="acts"><button class="btn" data-go="search" data-cat="${id}">${ic('filter')}Filter in search</button></div></div></div>
   ${locked?`<div class="notice bad">${ic('lock')}<div><b>Restricted content.</b> Pricing &amp; Commercial is visible only to the Pricing Restricted group. You can see titles but not open the files. Switch to the <b>Head of Sales</b> persona to see this as a permitted user.</div></div>`:''}
   ${id==='battle'?`<div class="notice info">${ic('lock')}<div>Battle cards are <b>internal only</b>. External sharing is blocked by DLP policy.</div></div>`:''}
   <div class="cards">${its.map(card).join('')}</div>${footer()}`;
}

/* Search */
function itemText(i){ return [i.title,i.type,catName(i.cat),i.vendors.join(' '),i.practices.map(p=>PRACTICES[p]).join(' '),i.industries.map(k=>INDUSTRIES[k].n).join(' '),i.desc||''].join(' ').toLowerCase(); }
const SYN = {backup:['recovery','veeam','veritas','data protection'],wifi:['wi-fi','campus','network'],'wi-fi':['campus','network'],licence:['license','trade'],license:['licence'],profile:['capability','corporate','overview'],ransomware:['backup','recovery'],nac:['forescout']};
function searchItems(){
  const q = S.q.trim().toLowerCase();
  const toks = q ? q.split(/\s+/).filter(Boolean) : [];
  let res = ITEMS.filter(i=>i.status!=='r'&&i.status!=='d').map(i=>{
    if(!toks.length) return {i,s:1};
    const t = i.title.toLowerCase(), all = itemText(i); let s=0;
    toks.forEach(k=>{ if(t.includes(k)) s+=4; else if(all.includes(k)) s+=1.5; else (SYN[k]||[]).forEach(y=>{ if(all.includes(y)) s+=0.8; }); });
    if(toks.every(k=>all.includes(k))) s+=3;
    return {i,s};
  }).filter(x=>x.s>0);
  const f=S.f;
  res = res.filter(({i})=>
    (!f.cat.length||f.cat.includes(i.cat)) && (!f.type.length||f.type.includes(i.type)) &&
    (!f.practice.length||f.practice.some(p=>i.practices.includes(p))) && (!f.vendor.length||f.vendor.some(v=>i.vendors.includes(v))) &&
    (!f.industry.length||f.industry.some(v=>i.industries.includes(v))) && (!f.stage.length||f.stage.some(v=>i.stages.includes(v))) &&
    (!f.lang.length||f.lang.includes(i.lang)));
  if(S.sort==='new') res.sort((a,b)=>a.i.days-b.i.days);
  else if(S.sort==='used') res.sort((a,b)=>b.i.views-a.i.views);
  else res.sort((a,b)=>b.s-a.s || b.i.views-a.i.views);
  return res.map(x=>x.i);
}
function vSearch(){
  const res = searchItems();
  const pool = ITEMS.filter(i=>i.status!=='r'&&i.status!=='d');
  const facet = (key,label,opts)=>`<div class="facet"><h5>${label}${S.f[key].length?`<button class="link" data-clear="${key}" style="font-size:11px">Clear</button>`:''}</h5>${opts.map(([v,l])=>{
     const n = pool.filter(i=>({cat:i.cat===v,type:i.type===v,practice:i.practices.includes(v),vendor:i.vendors.includes(v),industry:i.industries.includes(v),stage:i.stages.includes(v),lang:i.lang===v})[key]).length;
     return `<label><input type="checkbox" data-f="${key}" value="${esc(v)}" ${S.f[key].includes(v)?'checked':''}>${esc(l)}<span>${n}</span></label>`}).join('')}</div>`;
  const chips = Object.entries(S.f).flatMap(([k,vs])=>vs.map(v=>{
    const l = k==='cat'?catName(v):k==='practice'?PRACTICES[v]:k==='industry'?INDUSTRIES[v].n:v;
    return `<button data-rmf="${k}" data-v="${esc(v)}">${esc(l)}${ic('x')}</button>`;}));
  const ms = (0.18 + (S.q.length%7)/20).toFixed(2);
  return `<div class="page-h"><div><div class="eyebrow">Search &amp; discovery</div><h1>${S.q?`Results for \u201c${esc(S.q)}\u201d`:'Browse all content'}</h1></div></div>
  <div class="searchgrid">
   <aside class="facets" id="facets">
    ${facet('type','Content type',Object.keys(TYPE_IC).map(t=>[t,t]))}
    ${facet('practice','Practice',Object.entries(PRACTICES))}
    ${facet('industry','Industry',Object.entries(INDUSTRIES).map(([k,v])=>[k,v.n]))}
    ${facet('vendor','Vendor',ALL_VENDORS.map(v=>[v,v]))}
    ${facet('cat','Category',CATS.map(c=>[c.id,c.n]))}
    ${facet('stage','Sales stage',STAGES.map(s=>[s,s]))}
    ${facet('lang','Language',['English','Arabic','Bilingual'].map(s=>[s,s]))}
   </aside>
   <div style="min-width:0">
    <form class="sbar" id="sform"><div class="big">${ic('search')}<input id="sq" type="search" value="${esc(S.q)}" placeholder="Search titles, metadata and file text" autocomplete="off"></div>
     <select id="sort" aria-label="Sort"><option value="rel" ${S.sort==='rel'?'selected':''}>Sort: Relevance</option><option value="new" ${S.sort==='new'?'selected':''}>Sort: Newest</option><option value="used" ${S.sort==='used'?'selected':''} ${S.phase<2?'disabled':''}>Sort: Most used${S.phase<2?' (Phase 2)':''}</option></select>
     <button type="button" class="btn" id="facetToggle">${ic('filter')}Filters</button></form>
    ${chips.length?`<div class="active-f">${chips.join('')}<button data-clearall style="border-color:var(--line);background:#fff;color:var(--muted)">Clear all</button></div>`:''}
    <div class="sec-h" style="margin-bottom:10px"><span class="timing"><b style="color:var(--navy)">${res.length}</b> results \u00b7 ${ms}s \u00b7 searched titles, metadata and file text in SharePoint</span>
     ${S.phase>=3&&S.q?`<span class="chip">${ic('spark')}Semantic matches included</span>`:''}</div>
    ${res.length?`<div class="cards">${res.map(card).join('')}</div>`:`<div class="panel empty"><b style="color:var(--navy)">No results.</b><br>This search has been logged as a content gap for the content owners${S.phase>=2?' and appears in Usage Analytics':''}.<br><br><button class="btn" data-clearall>Clear filters</button></div>`}
   </div></div>`;
}

/* Industry kits */
function vKits(){
  return `<div class="page-h"><div><div class="eyebrow">Industry Kits</div><h1>Everything for one industry, in one place</h1><p>Each kit groups the pitch decks, case studies, battle cards, regulations and experts a seller needs before a customer meeting.</p></div></div>
  <div class="kits">${Object.entries(INDUSTRIES).filter(([k])=>k!=='cross').map(([k,v])=>`<button class="kit" data-go="kit-${k}" style="min-height:150px">${ic(v.i)}<div><b>${v.n}</b><span>${ITEMS.filter(i=>i.industries.includes(k)).length} assets \u00b7 ${(KITS[k].regs||[]).length} regulations</span></div></button>`).join('')}</div>
  ${footer()}`;
}
function vKit(k){
  const ind = INDUSTRIES[k]; const kd = KITS[k]; if(!ind||!kd) return vKits();
  const its = visible(ITEMS).filter(i=>i.industries.includes(k));
  const groups = [['Decks','Presentation'],['Case studies','Case Study'],['Battle cards','Battle Card']];
  const bcs = visible(ITEMS).filter(i=>i.type==='Battle Card' && (i.industries.includes(k)||i.industries.includes('cross'))).slice(0,3);
  const tabs = [['all','All'],...groups.map(g=>[g[1],g[0]]),['other','Briefs & tools']];
  const shown = S.kitTab==='all'?its: S.kitTab==='other'? its.filter(i=>!['Presentation','Case Study','Battle Card'].includes(i.type)) : S.kitTab==='Battle Card'? bcs : its.filter(i=>i.type===S.kitTab);
  const experts = Object.entries(PEOPLE).filter(([key,p])=>k==='hc'?['rami','sara','ahmed'].includes(key):k==='bfsi'?['tarek','mariam','sara'].includes(key):k==='gov'?['youssef','sara','noura'].includes(key):['rami','sara','daniel'].includes(key));
  return `<div><div class="crumbs"><a href="#home">Home</a>${ic('chev')}<a href="#kits">Industry Kits</a>${ic('chev')}<span>${ind.n}</span></div></div>
  <section class="banner"><div style="position:relative;z-index:1"><div class="eyebrow">Industry Kit</div><h1>${ind.n}</h1><p>Before your next ${ind.n.toLowerCase()} meeting: open the sector deck, pick a reference, check the battle card and share an approved link.</p>
   <div class="acts" style="margin-top:16px"><button class="btn primary" data-share-kit="${k}">${ic('share')}Share kit link</button>${S.phase>=3?`<button class="btn" data-go="assistant" data-ask="brief">${ic('spark')}Generate meeting brief</button>`:''}</div></div>
   <div class="kv"><div><b>${its.length}</b><span>approved assets</span></div><div><b>${its.filter(i=>i.type==='Case Study').length}</b><span>references</span></div><div><b>${kd.regs.length}</b><span>regulations covered</span></div><div><b>${experts.length}</b><span>named experts</span></div></div></section>
  <section class="three">
   <div class="panel pad"><div class="eyebrow" style="margin-bottom:10px">Customer pain points</div><div class="pain">${kd.pains.map(p=>`<div>${ic('target')}<span>${p}</span></div>`).join('')}</div></div>
   <div class="panel pad"><div class="eyebrow" style="margin-bottom:10px">Regulations to know</div><div class="reg">${kd.regs.map(r=>`<div><b>${r[0]}</b>${r[1]}</div>`).join('')}</div></div>
   <div class="panel pad"><div class="eyebrow" style="margin-bottom:10px">CNS plays</div><div class="pain">${kd.plays.map(p=>`<div>${ic('checkc')}<span>${p}</span></div>`).join('')}</div>
     <div class="eyebrow" style="margin:16px 0 8px">Experts</div>${experts.map(([key,p])=>`<div style="display:flex;gap:8px;align-items:center;margin-bottom:6px">${avatar(key,28)}<span class="small" style="flex:1"><b style="color:var(--navy)">${p.n}</b><br><span class="muted">${p.r}</span></span><button class="btn" data-teams="${key}" style="padding:4px 8px">${ic('teams')}</button></div>`).join('')}</div>
  </section>
  <section><div class="tabs">${tabs.map(([v,l])=>`<button class="${S.kitTab===v?'on':''}" data-kittab="${v}">${l}</button>`).join('')}</div>
  ${shown.length?`<div class="cards">${shown.map(card).join('')}</div>`:'<div class="panel empty">Nothing in this group yet. Content owners have been notified.</div>'}</section>
  ${footer()}`;
}

/* Vendors */
function vVendors(){
  const tiers = ['Strategic alliance','Core solution partner','Specialised partner','Technology partner'];
  return `<div class="page-h"><div><div class="eyebrow">Vendor &amp; Partner Hub</div><h1>Vendor hubs</h1><p>Collateral, promotions, deal-registration steps and the internal vendor manager for each partner. Tiers follow the CNS company introduction; the full list and tiers are still to be confirmed by CNS.</p></div></div>
  <div>${tiers.map(t=>`<div class="tierh"><span class="eyebrow">${t}</span><hr></div><div class="vgrid">${VENDORS.filter(v=>v.tier===t).map(v=>{const n=ITEMS.filter(i=>i.vendors.includes(v.n)).length;
   return `<button class="vtile" data-go="vendor-${v.slug}"><span class="wordmark">${esc(v.n)}</span><span class="small muted">${esc(v.area)}</span><span class="m"><span>${n} assets</span><span>${PEOPLE[v.mgr].n.split(' ')[0]}</span></span></button>`}).join('')}</div>`).join('')}</div>${footer()}`;
}
function vVendor(slug){
  const v = vendorBySlug[slug]; if(!v) return vVendors();
  const its = visible(ITEMS).filter(i=>i.vendors.includes(v.n));
  const m = PEOPLE[v.mgr];
  const promo = {Veeam:['20% off Veeam Data Platform bundles','New logos only. Register before quoting. Ends 31 Dec 2026.'],Forescout:['Free 30-day device visibility assessment','For healthcare and OT prospects. Ends 31 Jan 2027.'],Cisco:['Cisco Refresh: trade-in credits on Catalyst 9000','Up to 18% credit on qualifying campus refresh. Ends 25 Jan 2027.'],AWS:['AWS Migration Acceleration Program credits','Funding for assessed migrations above USD 100k ARR.']}[v.n];
  const tabs=[['collateral','Collateral'],['dealreg','Deal registration'],['certs','Certifications']];
  const sme = Object.entries(PEOPLE).filter(([k,p])=>p.v.includes(v.n) && k!==v.mgr).slice(0,3);
  let body='';
  if(S.vendTab==='collateral') body = its.length?`<div class="cards">${its.map(card).join('')}</div>`:`<div class="panel empty">No ${esc(v.n)} assets published yet. ${esc(m.n)} has been asked to add the top 5.</div>`;
  if(S.vendTab==='dealreg') body = `<div class="panel pad"><div class="steps">
    <div><span>Qualify the opportunity in Salesforce and tag Vendor = <b>${esc(v.n)}</b>.</span></div>
    <div><span>Register the deal on the ${esc(v.n)} partner portal with end-customer name, estimated value and close date.</span></div>
    <div><span>Send the registration ID to ${esc(m.n)} (vendor manager) to log it against the opportunity.</span></div>
    <div><span>Wait for vendor approval (usually 2\u20133 working days) before sharing special pricing.</span></div>
    <div><span>Renew the registration if the deal slips past its expiry date.</span></div></div>
    <a class="btn" style="margin-top:12px" href="#" data-toast="Opens the ${esc(v.n)} partner portal in a new tab (demo)">${ic('ext')}Open partner portal</a></div>`;
  if(S.vendTab==='certs') body = `<div class="panel tscroll"><table class="t"><thead><tr><th>Engineer</th><th>Certification</th><th>Expires</th><th>Status</th></tr></thead><tbody>
    ${[['Priya Nair','Professional','12 Aug 2027','ok'],['Rami Khoury','Expert','03 Feb 2027','ok'],['Ahmed Fathy','Associate','28 Dec 2026','warn'],['Daniel Pereira','Professional','15 May 2027','ok']].map(r=>`<tr><td><b>${r[0]}</b></td><td>${esc(v.n)} ${r[1]}</td><td class="num">${r[2]}</td><td><span class="badge ${r[3]==='ok'?'b-ok':'b-warn'}">${r[3]==='ok'?'Valid':'Expiring'}</span></td></tr>`).join('')}</tbody></table></div><p class="small muted">Certification tracker ${phaseTag(2)} \u00b7 names are demo data.</p>`;
  return `<div><div class="crumbs"><a href="#home">Home</a>${ic('chev')}<a href="#vendors">Vendor Hubs</a>${ic('chev')}<span>${esc(v.n)}</span></div></div>
  <section class="banner"><div style="position:relative;z-index:1"><div class="eyebrow">${esc(v.tier)}</div><h1>${esc(v.n)}</h1><p>${esc(v.area)}. ${its.length} approved assets. Vendor material is used within ${esc(v.n)}'s partner-programme terms.</p></div>
   <div class="kv"><div style="grid-column:1/-1;display:flex;gap:12px;align-items:center">${avatar(v.mgr,40)}<div style="flex:1"><b style="font-size:15px">${m.n}</b><span>Vendor manager \u00b7 ${m.loc}</span></div><button class="btn" data-teams="${v.mgr}">${ic('teams')}Chat</button></div>
   ${sme.map(([k,p])=>`<div style="display:flex;gap:8px;align-items:center">${avatar(k,28)}<span style="font-size:12px">${p.n.split(' ')[0]}<br><span style="opacity:.7">SME</span></span></div>`).join('')}</div></section>
  ${promo?`<div class="promo"><span class="eyebrow" style="color:var(--sky)">Current promotion</span><b>${promo[0]}</b><span>${promo[1]}</span></div>`:''}
  <section><div class="tabs">${tabs.map(([k,l])=>`<button class="${S.vendTab===k?'on':''}" data-vtab="${k}">${l}</button>`).join('')}</div>${body}</section>${footer()}`;
}

/* Experts */
function vExperts(){
  const q = (S.eq||'').toLowerCase();
  const list = Object.entries(PEOPLE).filter(([k,p])=>!q || (p.n+' '+p.r+' '+p.v.join(' ')+' '+p.pr.map(x=>PRACTICES[x]).join(' ')).toLowerCase().includes(q));
  return `<div class="page-h"><div><div class="eyebrow">News &amp; Experts</div><h1>Experts Directory</h1><p>The go-to person for each practice and vendor. One click opens a Teams chat. All names are fictional demo data.</p></div></div>
  <div class="sbar"><div class="big">${ic('search')}<input id="eq" type="search" value="${esc(S.eq||'')}" placeholder="Search by name, practice or vendor, e.g. \u201cForescout\u201d" autocomplete="off"></div></div>
  <div class="experts">${list.map(([k,p])=>`<div class="expert"><span class="av" style="background:${p.c}">${initials(p.n)}<i class="${p.st==='on'?'':p.st}"></i></span><div style="min-width:0;flex:1"><b>${p.n}</b><div class="r">${p.r} \u00b7 ${p.loc}</div>
   <div class="tags">${p.pr.map(x=>`<span class="chip">${PRACTICES[x].replace(/ \(.*\)/,'')}</span>`).join('')}${p.v.map(x=>`<span class="chip">${x}</span>`).join('')}</div>
   <div class="acts"><button class="btn primary" data-teams="${k}">${ic('teams')}Teams chat</button><button class="btn" data-copy="${p.n.toLowerCase().replace(/[^a-z]+/g,'.')}@cns-me.com" data-msg="Email address copied">${ic('mail')}Copy email</button></div></div></div>`).join('')||'<div class="panel empty">No expert matches. Try a vendor name.</div>'}</div>${footer()}`;
}

/* My Kit */
function vMyKit(){
  const its = [...S.kit].map(id=>byId[id]).filter(Boolean);
  return `<div class="page-h"><div><div class="eyebrow">Personal</div><h1>My Kit</h1><p>Your saved items. Synced to your Microsoft 365 profile, so the list follows you across laptop, phone and the Teams tab.</p></div></div>
  ${its.length?`<div class="cards">${its.map(card).join('')}</div>`:`<div class="panel empty">Nothing saved yet. Tap the ${ic('star')} on any card to add it here.</div>`}${footer()}`;
}

/* Onboarding */
const PATH = [
 {n:'Days 1\u201330',t:'Learn CNS',s:'Company, brand and how we sell',items:[['corp-deck','Present the corporate deck to your manager'],['vid-60','Watch: the CNS portfolio in 60 minutes'],['brand-kit','Read the brand guidelines'],['playbook','Read the Sales Playbook'],['meddicc','Complete a MEDDICC checklist on a live deal']]},
 {n:'Days 31\u201360',t:'Learn the portfolio',s:'Practices, vendors and competitors',items:[['cyber-deck','Cyber Security practice deck'],['veeam-deck','Veeam data protection overview'],['bc-falcon','Study the top regional SI battle card'],['kit-hc','Walk through the Healthcare Industry Kit'],['disc-q','Run a discovery call with the question bank']]},
 {n:'Days 61\u201390',t:'Sell with confidence',s:'Deliver the pitch unaided',items:[['cs-ehs','Learn two reference stories by heart'],['rfp-gov','Shadow presales on one RFP response'],['sf-link','Attach portal content to your first opportunity'],['events','Attend one vendor webinar'],['corp-deck','Deliver the corporate pitch to a customer unaided']]},
];
function vOnboarding(){
  const total = PATH.reduce((a,s)=>a+s.items.length,0);
  const done = PATH.reduce((a,s)=>a+s.items.filter(([id],j)=>S.done.has(s.n+id)).length,0);
  return `<div class="page-h"><div><div class="eyebrow">Training &amp; Onboarding</div><h1>Your 30-60-90 day path</h1><p>An ordered list of what to learn first. Goal: deliver the corporate pitch unaided within 4 weeks instead of 3 months.</p></div>
   <div class="panel pad" style="margin-left:auto;min-width:220px"><div class="eyebrow">Progress</div><div style="font-size:28px;font-weight:700;color:var(--navy)" class="num">${done} / ${total}</div><div class="bars"><div class="b" style="grid-template-columns:1fr"><div class="tr"><i style="width:${Math.round(done/total*100)}%"></i></div></div></div><div class="small muted" style="margin-top:6px">Completion tracking ${phaseTag(2)}</div></div></div>
  <div class="path">${PATH.map(s=>{const d=s.items.filter(([id])=>S.done.has(s.n+id)).length;return `<div class="stage"><div class="sh"><span class="eyebrow" style="color:var(--sky)">${s.n}</span><b>${s.t}</b><span>${s.s}</span><div class="prog"><i style="width:${d/s.items.length*100}%"></i></div></div>
   ${s.items.map(([id,l])=>{const k=s.n+id;return `<div class="task ${S.done.has(k)?'done':''}"><input type="checkbox" id="t-${k.replace(/[^a-z0-9]/gi,'')}" data-task="${k}" ${S.done.has(k)?'checked':''} aria-label="Mark done"><div class="t"><button data-open="${id}">${l}</button><span>${esc(byId[id].title)}</span></div></div>`}).join('')}</div>`}).join('')}</div>${footer()}`;
}

/* Analytics (Phase 2) */
function lineChart(vals, labels, max){
  const W=640,H=220,L=36,R=12,T=14,B=28; const iw=W-L-R, ih=H-T-B;
  const x=i=>L+i*(iw/(vals.length-1)), y=v=>T+ih-(v/max)*ih;
  const pts=vals.map((v,i)=>`${x(i)},${y(v)}`).join(' ');
  const grid=[0,20,40,60,80].filter(g=>g<=max).map(g=>`<line x1="${L}" x2="${W-R}" y1="${y(g)}" y2="${y(g)}" stroke="#DCE3EE" stroke-width="1"/><text x="${L-8}" y="${y(g)+4}" text-anchor="end" font-size="11" fill="#586377">${g}</text>`).join('');
  const target = `<line x1="${L}" x2="${W-R}" y1="${y(68*0.85)}" y2="${y(68*0.85)}" stroke="#C12E1F" stroke-dasharray="4 4" stroke-width="1.2"/><text x="${L+8}" y="${y(68*0.85)-6}" text-anchor="start" font-size="11" fill="#C12E1F">85% target (58)</text>`;
  const lab=labels.map((l,i)=>i%2===0?`<text x="${x(i)}" y="${H-8}" text-anchor="middle" font-size="11" fill="#586377">${l}</text>`:'').join('');
  const last=vals.length-1;
  return `<svg viewBox="0 0 ${W} ${H}" role="img" aria-label="Weekly active users">${grid}${target}
   <polygon points="${L},${y(0)} ${pts} ${x(last)},${y(0)}" fill="#0090E0" fill-opacity=".1"/>
   <polyline points="${pts}" fill="none" stroke="#0090E0" stroke-width="2.5" stroke-linejoin="round"/>
   <circle cx="${x(last)}" cy="${y(vals[last])}" r="5" fill="#16265E" stroke="#fff" stroke-width="2"/>
   <text x="${x(last)-8}" y="${y(vals[last])-10}" text-anchor="end" font-size="12" font-weight="700" fill="#16265E">${vals[last]}</text>${lab}</svg>`;
}
function bars(rows, cls=''){ const max=Math.max(...rows.map(r=>r[1])); return `<div class="bars ${cls}">${rows.map(r=>`<div class="b"><span class="n" title="${esc(r[0])}">${esc(r[0])}</span><span class="tr"><i style="width:${r[1]/max*100}%"></i></span><span class="v">${r[1].toLocaleString()}</span></div>`).join('')}</div>`; }
function vAnalytics(){
  const wau=[9,17,24,30,34,38,41,44,47,49,52,54], wl=['W36','W37','W38','W39','W40','W41','W42','W43','W44','W45','W46','W47'];
  const top=[...ITEMS].filter(canSee).sort((a,b)=>b.views-a.views).slice(0,7);
  return `<div class="page-h"><div><div class="eyebrow">Analytics \u00b7 ${phaseTag(2)}</div><h1>Usage analytics</h1><p>What sales use, what they can't find, and which content shows up on won deals. Refreshed daily from Microsoft 365 audit and usage data. Figures are synthetic.</p></div>
   <div style="margin-left:auto" class="acts"><select class="btn" aria-label="Period"><option>Last 30 days</option><option>Last 90 days</option></select></div></div>
  <div class="kpis">
   <div class="kpi"><div class="l">Monthly active users</div><div class="v num">58 / 68</div><div class="d up">85% \u00b7 target 85% met</div></div>
   <div class="kpi"><div class="l">Avg time to find</div><div class="v num">22 s</div><div class="d up">Target under 30 s</div></div>
   <div class="kpi"><div class="l">Views \u00b7 downloads</div><div class="v num">4,812</div><div class="d up">+18% vs prior 30 days</div></div>
   <div class="kpi"><div class="l">Approved &amp; in date</div><div class="v num">94%</div><div class="d" style="color:var(--warn)">7 items due for review</div></div>
   <div class="kpi"><div class="l">Opps with content</div><div class="v num">46%</div><div class="d up">Target 50% \u00b7 Salesforce</div></div>
  </div>
  <section class="two">
   <div class="panel pad chart"><div class="sec-h"><div><div class="eyebrow">Adoption</div><h2>Weekly active users</h2></div><span class="small muted">68 licensed sales users</span></div>${lineChart(wau,wl,80)}</div>
   <div class="panel pad"><div class="sec-h"><div><div class="eyebrow">Content health</div><h2>Needs attention</h2></div></div>
    <div class="health"><div style="background:var(--bad-bg);color:var(--bad)"><b>3</b><span>Expired</span></div><div style="background:var(--warn-bg);color:var(--warn)"><b>7</b><span>Review in 30 days</span></div><div style="background:var(--tint);color:var(--navy)"><b>2</b><span>No owner</span></div><div style="background:var(--surface);color:var(--muted)"><b>9</b><span>Never viewed</span></div></div>
    <p class="small muted" style="margin:12px 0 0">A weekly content-health email goes to each owner every Monday.</p>
    <div class="eyebrow" style="margin:16px 0 8px">Views by practice</div>${bars([['Digital Infrastructure',1420],['Cyber Security',1105],['Managed Services',688],['Data, AI & Software',612],['Digital Transformation',505],['Digital Banking',301],['Cloud Solutions',181]],'navy')}</div>
  </section>
  <section class="three">
   <div class="panel pad"><div class="eyebrow" style="margin-bottom:10px">Top content</div>${bars(top.map(i=>[i.title,i.views]))}</div>
   <div class="panel pad"><div class="eyebrow" style="margin-bottom:10px">Top search terms</div>${bars([['veeam',142],['company profile',118],['forescout',96],['trade licence',88],['healthcare',81],['iso 27001',64],['battle card',57]],'navy')}</div>
   <div class="panel pad"><div class="eyebrow" style="margin-bottom:10px;color:var(--red)">Searches with no results</div>${bars([['palo alto battle card',14],['arabic corporate deck',11],['oman price list',9],['sd-wan case study',7],['ot security references',5],['dell storage datasheet',4]],'red')}<p class="small muted" style="margin:10px 0 0">These are content gaps, routed to the owning practice.</p></div>
  </section>
  <section class="panel"><div class="pad" style="padding-bottom:6px"><div class="eyebrow">Content to revenue \u00b7 Salesforce</div><h2 style="font-size:18px;margin-top:4px">Top content on won opportunities (last 6 months)</h2></div>
   <div class="tscroll"><table class="t"><thead><tr><th>Asset</th><th>Won deals</th><th>Win rate when attached</th><th>Won value (AED)</th><th>Top industry</th></tr></thead><tbody>
   ${[['corp-deck',19,'41%','38.4M','Government'],['cs-ehs',9,'53%','21.7M','Healthcare'],['bc-falcon',8,'57%','17.2M','Government'],['veeam-deck',7,'46%','6.9M','BFSI'],['hc-net-deck',6,'50%','14.1M','Healthcare'],['cs-moei',5,'45%','12.6M','Government']].map(r=>`<tr style="cursor:pointer" data-open="${r[0]}"><td><b>${esc(byId[r[0]].title)}</b></td><td class="num">${r[1]}</td><td class="num">${r[2]}</td><td class="num">${r[3]}</td><td>${r[4]}</td></tr>`).join('')}</tbody></table></div></section>
  ${footer()}`;
}

/* Governance (Phase 2) */
function vGovernance(){
  if(!S.queue) S.queue = [
    {id:'bc-obj',who:'mina',sub:2,step:'Brand review',due:'21 Nov'},
    {id:'q1',title:'Cyber Security Practice Deck 2026 \u2013 v3.1 (Arabic)',type:'Presentation',who:'sara',sub:1,step:'Practice Head review',due:'22 Nov'},
    {id:'q2',title:'Case Study: Federal Hospital NAC Rollout',type:'Case Study',who:'layla',sub:3,step:'Customer approval check',due:'20 Nov'},
    {id:'q3',title:'Dynatrace + CNS Managed Observability Datasheet',type:'Datasheet',who:'daniel',sub:4,step:'Practice Head review',due:'19 Nov'},
  ];
  const expiring = ITEMS.filter(i=>i.status==='x'||i.status==='e');
  return `<div class="page-h"><div><div class="eyebrow">Content governance \u00b7 ${phaseTag(2)}</div><h1>Content governance</h1><p>Nothing customer-facing reaches sales without approval. Every item has a named owner and a review date. Power Automate runs the approvals and reminders.</p></div>
   <div style="margin-left:auto" class="acts"><button class="btn primary" data-scroll="upload">${ic('upload')}Upload content</button></div></div>
  <div class="flow">${[['Draft',4],['In review',S.queue.length],['Approved',ITEMS.filter(i=>i.status==='a').length],['Review due',ITEMS.filter(i=>i.status==='x').length],['Expired',ITEMS.filter(i=>i.status==='e').length],['Archived',112]].map((s,i)=>`<div class="${i===1?'cur':''}"><b class="num">${s[1]}</b><span>${s[0]}</span></div>`).join('')}</div>
  <section class="panel"><div class="pad" style="padding-bottom:6px"><div class="eyebrow">Approval queue</div><h2 style="font-size:18px;margin-top:4px">Waiting for your decision</h2><p class="small muted" style="margin:4px 0 0">Target: decision within 3 working days.</p></div>
   <div class="tscroll"><table class="t"><thead><tr><th>Item</th><th>Submitted by</th><th>Step</th><th>Due</th><th></th></tr></thead><tbody>
   ${S.queue.map(q=>{const it=byId[q.id];const t=it?it.title:q.title;const ty=it?it.type:q.type;return `<tr><td><b>${esc(t)}</b><div class="small muted">${ty}</div></td><td><div style="display:flex;gap:8px;align-items:center">${avatar(q.who,26)}<span>${PEOPLE[q.who].n}</span></div></td><td>${q.step}</td><td class="num">${q.due}</td>
    <td><div class="acts" style="flex-wrap:nowrap"><button class="btn" style="padding:6px 10px" data-approve="${q.id}">${ic('check')}Approve</button><button class="btn ghost" style="padding:6px 10px" data-reject="${q.id}">Request changes</button></div></td></tr>`}).join('')||'<tr><td colspan="5" class="empty">Queue is clear.</td></tr>'}
   </tbody></table></div></section>
  <section class="two">
   <div class="panel" id="upload"><div class="pad"><div class="eyebrow">Publish</div><h2 style="font-size:18px;margin:4px 0 14px">Upload with mandatory tags</h2>
    <form class="form" id="upForm" novalidate>
     <div class="drop full">${ic('upload')}<br><b style="color:var(--navy)">CNS_CyberSecurity_Forescout_BattleCard_2026-11.pdf</b><br><span class="small">Selected \u00b7 1.2 MB \u00b7 naming standard OK</span></div>
     <label class="full">Title <em>*</em><input id="f-title" value="Battle Card: Forescout vs Competing NAC Vendors"></label>
     <label>Category <em>*</em><select id="f-cat"><option value="">Select\u2026</option>${CATS.map(c=>`<option ${c.id==='battle'?'selected':''} value="${c.id}">${c.n}</option>`).join('')}</select></label>
     <label>Content type <em>*</em><select id="f-type"><option value="">Select\u2026</option>${Object.keys(TYPE_IC).map(t=>`<option ${t==='Battle Card'?'selected':''}>${t}</option>`).join('')}</select></label>
     <label>Practice <em>*</em><select id="f-pr"><option value="">Select\u2026</option>${Object.entries(PRACTICES).map(([k,v])=>`<option value="${k}">${v}</option>`).join('')}</select></label>
     <label>Vendor<select id="f-v"><option value="">None</option>${ALL_VENDORS.map(v=>`<option ${v==='Forescout'?'selected':''}>${v}</option>`).join('')}</select></label>
     <label>Audience <em>*</em><select id="f-aud"><option value="">Select\u2026</option><option>Internal only</option><option>Customer-facing</option></select></label>
     <label>Language <em>*</em><select id="f-lang"><option>English</option><option>Arabic</option><option>Bilingual</option></select></label>
     <label>Confidentiality <em>*</em><select id="f-conf"><option>Internal</option><option>Public</option><option>Confidential</option><option>Highly Confidential</option></select></label>
     <label>Review date<input id="f-rev" value="19 Feb 2027"><span class="hint">Auto: quarterly cycle for Battle Cards</span></label>
     <div class="full acts"><button class="btn primary" type="submit">${ic('send')}Submit for approval</button><span class="small muted" id="upMsg" style="align-self:center">Practice and Audience are still empty. Try submitting.</span></div>
    </form></div></div>
   <div class="panel"><div class="pad" style="padding-bottom:6px"><div class="eyebrow">Review due &amp; expired</div><h2 style="font-size:18px;margin-top:4px">Owners have been reminded</h2></div>
    <div class="list">${expiring.map(i=>row(i,`<span class="small muted" style="white-space:nowrap">${PEOPLE[i.owner].n.split(' ')[0]}</span>`)).join('')}</div></div>
  </section>${footer()}`;
}

/* Salesforce (Phase 2) */
function vSalesforce(){
  const rec = ['hc-net-deck','cs-mohap','cs-robo','bc-forescout','win-sdwan','calc-net','kit-hc'].map(id=>byId[id]);
  const why = {'hc-net-deck':'Industry + practice','cs-mohap':'Healthcare reference','cs-robo':'Healthcare reference','bc-forescout':'Competitor on deal','win-sdwan':'Stage = Propose','calc-net':'Vendor = Cisco','kit-hc':'Industry kit'};
  return `<div class="page-h"><div><div class="eyebrow">Salesforce integration \u00b7 ${phaseTag(2)}</div><h1>Sales Portal panel in Salesforce</h1><p>The panel sits on Opportunity and Account pages and recommends content from the opportunity's industry, practice, vendor and stage. One click attaches a link to the opportunity. The opportunity below is fictional.</p></div></div>
  <div class="sf">
   <div class="sf-rec">
    <div class="sf-top"><span class="tile-ic">${ic('target')}</span><div><div class="small muted">Opportunity</div><b style="font-size:17px;color:var(--navy)">Al Noor Hospital Group \u2013 Campus Network &amp; Clinical Wi-Fi Refresh</b></div></div>
    <div class="sf-path">${STAGES.slice(0,6).map((s,i)=>`<span class="${i<3?'done':i===3?'cur':''}">${s}</span>`).join('')}</div>
    <dl class="sf-fields" style="margin:0">${[['Account','Al Noor Hospital Group'],['Amount','AED 4,200,000'],['Close date','28 Feb 2027'],['Industry','Healthcare'],['Practice','Digital Infrastructure'],['Vendors','Cisco, Forescout'],['Owner','Omar Haddad'],['Competitor','Falcon Integration Group'],['Region','UAE \u00b7 Abu Dhabi']].map(f=>`<div><dt>${f[0]}</dt><dd>${f[1]}</dd></div>`).join('')}</dl>
    <div class="pad"><div class="eyebrow" style="margin-bottom:8px">Portal content attached to this opportunity (${S.attached.size})</div>
     ${S.attached.size?[...S.attached].map(id=>`<div class="row" data-open="${id}" style="padding:8px 0;border-bottom:1px solid var(--line)"><span class="tile-ic sm blue">${ic('link')}</span><div class="t"><b>${esc(byId[id].title)}</b><span>Attached by Omar Haddad \u00b7 logged on opportunity</span></div></div>`).join(''):'<p class="small muted">Nothing attached yet.</p>'}</div>
   </div>
   <div class="sp-panel"><div class="ph-h"><img src="${LOGO}" alt="CNS"><b>Sales Portal \u00b7 Recommended</b><span class="small" style="margin-left:auto;opacity:.75">0.9 s</span></div>
    ${rec.map(i=>`<div class="sp-item"><span class="tile-ic sm ${i.type==='Battle Card'?'red':i.type==='Case Study'?'blue':''}">${ic(TYPE_IC[i.type])}</span><div class="t" data-open="${i.id}"><b>${esc(i.title)}</b><span>${i.type}</span><br><span class="why">${why[i.id]}</span></div>
     <button class="btn ${S.attached.has(i.id)?'':'primary'}" data-attach="${i.id}">${S.attached.has(i.id)?ic('check')+'Attached':'Attach'}</button></div>`).join('')}
    <div class="pad small muted" style="padding:12px 14px">Recommendations update when the stage, industry or vendor changes.</div></div>
  </div>${footer()}`;
}

/* AI Assistant (Phase 3) */
const AI = {
 wifi:{q:'What is our best healthcare reference for a Wi-Fi and campus network deal?',a:`<p>The strongest fit is <b>MOHAP \u2013 Infrastructure Modernisation Programme</b>: Cisco-based campus and SD-WAN across federal hospitals and clinics, with 130 sites connected.</p><p>Back it up with:</p><ul><li><b>HCI ROBO for 17 Remote Hospitals</b> for remote-site infrastructure.</li><li><b>Emirates Health Services</b> for 24\u00d77 operations after go-live (99.95% availability, 38% fewer recurring incidents).</li></ul><p>For the pitch itself, use the <b>Healthcare Network Modernisation Deck</b>. If Falcon Integration Group is competing, open its battle card before the meeting.</p>`,c:['cs-mohap','cs-robo','cs-ehs','hc-net-deck','bc-falcon']},
 sum:{q:'Summarise the Sovereign AI whitepaper in under 200 words.',a:`<p><b>Sovereign AI in the UAE: A Practical Guide</b> argues that government entities can adopt AI quickly without giving up control of data, models or operations.</p><ul><li><b>Keep data in-country.</b> Host training data, vector stores and logs in a UAE region and classify them under UAE IA.</li><li><b>Choose the model by risk.</b> Use open-weight models on sovereign infrastructure for sensitive workloads and managed models for low-risk ones.</li><li><b>Ground every answer.</b> Retrieval on approved content, with citations and audit logs, reduces hallucination risk.</li><li><b>Start with services.</b> Citizen-facing agents for status enquiries and document checks show value inside 90 days.</li><li><b>Build skills locally.</b> Pair delivery with the CNS AI &amp; Cyber Security Academy.</li></ul><p>Suggested next step: the Code81 AI Agents overview and the FTA case study.</p>`,c:['wp-sovai','ai-agents','cs-fta']},
 rfp:{q:'Draft an RFP answer: "Describe your information security certifications and controls."',a:`<p><b>Draft response (for presales review):</b></p><p>CNS Technology holds ISO/IEC 27001:2022 certification for its information security management system, covering its operations, service desk and network operation centres in Abu Dhabi and Dubai. CNS is also certified to ISO 9001 (quality), ISO/IEC 20000-1 (IT service management) and ISO 22301 (business continuity).</p><p>Our controls are mapped to the UAE Information Assurance Standard and NESA requirements; the attached compliance matrix lists each control with its implementation evidence. Access to customer environments follows least-privilege principles with MFA, privileged access management and full audit logging. Security incidents are handled through a 24\u00d77 SOC process with defined escalation to the customer within agreed SLAs.</p><p class="small muted">Check the certificate scope and dates before submitting.</p>`,c:['iso27001','iso-pack','ia-matrix','boiler']},
 brief:{q:'Prepare a meeting brief for Al Noor Hospital Group.',a:`<p><b>Meeting brief \u00b7 Al Noor Hospital Group</b> (fictional account)</p><ul><li><b>Opportunity:</b> Campus network &amp; clinical Wi-Fi refresh \u00b7 AED 4.2M \u00b7 stage Propose \u00b7 close 28 Feb 2027.</li><li><b>Likely priorities:</b> ADHICS audit findings on device visibility, Wi-Fi coverage in new wards, 24\u00d77 support for 6 sites.</li><li><b>Lead with:</b> Healthcare Network Modernisation Deck, then the MOHAP and HCI ROBO references.</li><li><b>Competition:</b> Falcon Integration Group. Expect a lower price; position CNS NOCs, local delivery team and EHS operations record.</li><li><b>Ask in discovery:</b> how they inventory medical devices today; who owns the ADHICS remediation plan; budget split between CAPEX and managed service.</li><li><b>Bring:</b> Rami Khoury (Digital Infrastructure) and Sara Al Hashimi for the Forescout NAC conversation.</li></ul>`,c:['hc-net-deck','cs-mohap','cs-robo','bc-falcon','kit-hc','bc-forescout']},
 price:{q:'What margin should I use for Veeam deals?',a:null,c:['margins']},
};
function aiPriceAnswer(){
  return persona().restricted
   ? {a:`<p>Per the <b>Margin Guidelines by Vendor</b> (restricted), backup and recovery software deals follow the standard software band, with extra approval needed below the floor. Check the Discount Authority Matrix for who can approve.</p><p class="small muted">You can see this because you are in the Pricing Restricted group.</p>`,c:['margins','discount']}
   : {a:`<p>I can't share that. Margin guidance is in <b>Pricing &amp; Commercial</b>, which is restricted to the Pricing Restricted group, and I only answer from content you are allowed to open.</p><p>You can ask ${PEOPLE.arjun.n} (Commercial Finance) or your sales leader. The <b>Discount Authority Matrix</b> tells you who approves which discount levels.</p>`,c:['discount']};
}
function aiFree(q){
  S.q=q; const r=searchItems().filter(canSee).slice(0,4); S.q='';
  if(!r.length) return {a:`<p>I couldn't find approved content that answers this. I've logged it as a content gap for the owners. Try the Experts Directory for a quick answer.</p>`,c:[]};
  return {a:`<p>Here is what I found in approved portal content:</p><ul>${r.map(i=>`<li><b>${esc(i.title)}</b>: ${esc(i.desc || (i.type+' for '+prLabel(i)+'.'))}</li>`).join('')}</ul>`,c:r.map(i=>i.id)};
}
function vAssistant(){
  if(!S.chat) S.chat=[{me:true,t:AI.wifi.q},{me:false,a:AI.wifi.a,c:AI.wifi.c}];
  const prompts=[['wifi','search'],['sum','file'],['rfp','brief'],['brief','calendar'],['price','lock']];
  return `<div class="page-h"><div><div class="eyebrow">AI sales assistant \u00b7 ${phaseTag(3)}</div><h1>Ask the portal</h1><p>Answers come only from approved, permission-trimmed portal content, and every answer cites its sources. Prompts are logged for review. Responses here are scripted for the demo.</p></div></div>
  <div class="chat">
   <div class="thread"><div class="msgs" id="msgs">${S.chat.map(m=>m.me?`<div class="msg me"><div class="bub">${esc(m.t)}</div></div>`:m.typing?`<div class="msg ai"><span class="ai-av">${ic('spark')}</span><div class="bub"><div class="typing"><i></i><i></i><i></i></div></div></div>`:
    `<div class="msg ai"><span class="ai-av">${ic('spark')}</span><div class="bub">${m.a}${m.c.length?`<div class="sources">Sources: ${m.c.map(id=>`<span class="cite" data-open="${id}">${ic(TYPE_IC[byId[id].type])}${esc(byId[id].title)}</span>`).join('')}</div>`:''}</div></div>`).join('')}</div>
    <form class="composer" id="aiForm"><input id="aiq" placeholder="Ask about content, customers, competitors or RFP answers" autocomplete="off"><button class="btn primary" type="submit">${ic('send')}Ask</button></form></div>
   <div><div class="eyebrow" style="margin-bottom:10px">Try asking</div><div class="prompts">${prompts.map(([k,i])=>`<button data-ai="${k}">${ic(i)}${esc(AI[k].q)}</button>`).join('')}</div>
    <div class="notice info" style="margin-top:14px">${ic('shield')}<div>Signed in as <b>${esc(persona().n)}</b>. ${persona().restricted?'You can see pricing content.':'Pricing content is hidden from you and from the assistant.'}</div></div></div>
  </div>${footer()}`;
}
function askAI(key, text){
  const q = key? AI[key].q : text;
  S.chat.push({me:true,t:q}); S.chat.push({typing:true}); render();
  setTimeout(()=>{ S.chat.pop(); let r = key==='price'?aiPriceAnswer(): key? AI[key] : aiFree(text); S.chat.push({me:false,a:r.a,c:r.c}); render(); const m=$('#msgs'); if(m) m.scrollTop=m.scrollHeight; }, 900);
}

/* ---------- Detail drawer ---------- */
function preview(it){
  if(!canSee(it)) return `<div class="pv"><div class="empty">${ic('lock')}<br><b style="color:var(--navy)">You don't have access to this file.</b><br>It is restricted to the Pricing Restricted group.</div></div>`;
  if(it.type==='Presentation'||it.type==='Template'&&it.id==='ppt-tpl'){
    const sl = S.slide||0;
    const main = sl===0?`<div class="slide cover"><img src="${LOGO}" alt=""><div class="k">CNS TECHNOLOGY</div><h3>${esc(it.title.replace(/^CNS /,''))}</h3><div class="rl"></div><p>Intelligence. Secured. Sovereignty. Assured.</p></div>`
     : `<div class="slide content"><span class="mark">CNS</span><div class="k">${['','WHY CNS','OUR APPROACH','PROOF POINTS','NEXT STEPS'][sl]}</div><h3>${['','One partner across your entire IT environment','Structured delivery, accountable outcomes','Trusted in key sectors','How we get started'][sl]}</h3><div class="boxes">${[0,1,2].map(n=>`<div><i></i><b>${[['Infrastructure','Security','Data & AI'],['Understand','Design','Operate'],['50+ government entities','~70% of local banks','2 of 3 public health networks'],['Workshop','Assessment','Proposal']][sl-1][n]}</b><span>Approved content block from the master template.</span></div>`).join('')}</div></div>`;
    return `<div class="pv">${main}<div class="strip">${[0,1,2,3,4].map(n=>`<div class="mini ${n===0?'dark':''} ${n===sl?'on':''}" data-slide="${n}"><i class="h"></i><i></i><i style="width:70%"></i></div>`).join('')}<span class="small muted" style="align-self:center;white-space:nowrap;padding:0 8px">${sl+1} / 24 slides</span></div></div>`;
  }
  if(it.type==='Battle Card') return battleCard(it);
  if(it.type==='Case Study') return caseStudy(it);
  if(it.type==='Video') return `<div class="pv"><div class="video"><div class="play">${ic('play')}</div><div class="bar"><i></i></div></div></div>`;
  if(it.type==='Calculator') return calcPreview(it);
  return `<div class="pv"><div class="doc"><div class="l h"></div><div class="l"></div><div class="l"></div><div class="l s"></div><div style="height:8px"></div><div class="l"></div><div class="l"></div><div class="l"></div><div class="l s"></div><div style="height:8px"></div><div class="l" style="width:40%;background:var(--blue)"></div><div class="l"></div><div class="l s"></div></div></div>`;
}
function battleCard(it){
  const comp = it.id==='bc-falcon'?'Falcon Integration Group':it.id==='bc-forescout'?'Agent-based NAC vendors':it.id==='bc-veeam'?'Legacy backup platforms':it.id==='bc-msp'?'Global IT outsourcers':'Scale objection';
  return `<div class="pv"><div class="bc">
   <div class="bc-head"><div><div class="eyebrow" style="color:var(--red)">Battle card \u00b7 internal only</div><h3 style="font-size:19px;margin-top:4px">${esc(comp)}</h3><div class="small muted">${esc(prLabel(it))} \u00b7 Owner ${PEOPLE[it.owner].n} \u00b7 last reviewed ${fmtDate(it.updated)}</div></div><img src="${LOGO}" alt="" style="height:26px;filter:brightness(0) saturate(100%) invert(12%) sepia(54%) saturate(2700%) hue-rotate(218deg)"></div>
   <div class="bc-box"><h5>Who they are</h5><p style="margin:0;font-size:13px">${it.id==='bc-falcon'?'Mid-size UAE systems integrator (fictional), ~400 staff, strong in Cisco and Microsoft. Typical customers: federal entities and private hospitals.':'Competing approach that customers often already know. Strong brand recognition, but weaker on agentless visibility and local support.'}</p></div>
   <div class="bc-grid">
    <div class="bc-box"><h5>Where they win</h5><ul><li>Price-led tenders with a tight scope</li><li>Single-vendor Cisco deals</li><li>Existing incumbent relationships</li></ul></div>
    <div class="bc-box win"><h5>Where we win</h5><ul><li>39 years in the UAE, part of Ghobash Group</li><li>Multi-vendor depth across 40+ partners</li><li>NOCs in Abu Dhabi and Dubai, 24\u00d77</li><li>Code81 AI and software in the same contract</li></ul></div>
    <div class="bc-box"><h5>Landmines to lay</h5><ul><li>"Who runs operations after go-live, and from where?"</li><li>"How many certified engineers are based in the UAE?"</li><li>"Show a reference of similar size in your sector."</li></ul></div>
    <div class="bc-box lock"><h5>${ic('lock')} Pricing posture</h5><ul><li>Typically 8\u201312% below CNS on hardware</li><li>Recovers margin on change requests</li><li>Rarely bundles managed services</li></ul></div>
   </div>
   <div class="bc-box"><h5>Objection handling</h5><div class="obj">
    <div><q>"You're more expensive."</q><span>Compare 3-year TCO including operations; use the Managed Services ROI calculator.</span></div>
    <div><q>"We already work with them."</q><span>Offer a scoped assessment; lead with the EHS operations story.</span></div>
    <div><q>"Can you deliver at our scale?"</q><span>800+ local professionals, 450+ customers; MOHAP and EHS references.</span></div></div></div>
   <div class="bc-box"><h5>Proof points</h5><div>${['cs-ehs','cs-mohap','calc-ms'].map(id=>`<span class="cite" data-open="${id}">${ic(TYPE_IC[byId[id].type])}${esc(byId[id].title)}</span>`).join('')}</div></div>
  </div></div>`;
}
const CASES = {
 'cs-moei':['United Arab Emirates','Ministry of Energy & Infrastructure','Design and implementation of an AI digital branch in Fujairah and a blockchain-enabled virtual service centre.',[['100%','Automation of customer service transactions'],['60%','Reduction in manual processing time'],['40%','Operational cost reduction']]],
 'cs-ku':['United Arab Emirates','Khalifa University','AI-powered mobile visitor management covering the full visit journey, with computer vision and OCR for identity verification.',[['80%','Reduction in manual administrative effort'],['Same day','Process turnaround, down from days']]],
 'cs-ehs':['United Arab Emirates','Emirates Health Services','End-to-end IT managed services covering service desk, end-user support, NOC operations and ITIL governance for 120+ health facilities.',[['99.95%','Service availability'],['38%','Reduction in recurring incidents'],['35%','Operational cost reduction']]],
 'cs-fta':['United Arab Emirates','Federal Tax Authority','Enterprise AI use-case prioritisation and an MLOps-enabled AI platform unifying fragmented data sources.',[['Org-wide','AI capability operationalised'],['Faster','Deployment cycles through MLOps']]],
 'cs-dmt':['United Arab Emirates','Department of Municipalities and Transport','IT managed services for applications, data warehouse, data lake and data cloud, with knowledge management.',[['99.95%','Service availability'],['27%','Reduction in recurring incidents'],['25%','Faster ETL execution'],['30%','Operational cost reduction']]],
 'cs-sanad':['United Arab Emirates','Sanad','Service desk, monitoring, field support, infrastructure, network and application operations.',[['38%','Incident reduction (5,018 to 3,120)'],['70%','Alarms resolved automatically'],['99.99%','SLA compliance']]],
 'cs-dhofar':['Oman','Bank Dhofar','ATM estate modernisation and lifecycle management, replacing legacy infrastructure with a unified self-service platform.',[['Full fleet','ATMs replaced with new terminals'],['Zero','Disruption to legacy estate during transition']]],
 'cs-robo':['United Arab Emirates','Healthcare entity','Hyperconverged infrastructure with VMware for 17 remote hospital sites, with standard runbooks and central management.',[['17','Remote hospitals standardised'],['1','Repeatable HCI blueprint across all sites']]],
 'cs-mohap':['United Arab Emirates','Ministry of Health & Prevention','Network and data-centre modernisation across federal hospitals and clinics, with Cisco campus and SD-WAN.',[['130','Sites connected'],['24\u00d77','Operations from CNS NOCs']]],
};
function caseStudy(it){
  const c = CASES[it.id]||CASES['cs-ehs'];
  return `<div class="pv"><div class="cs"><div class="facts">
    <div class="eyebrow">Success story</div><h3 style="font-size:18px">${esc(it.title)}</h3>
    ${[['building','Country',c[0]],['bank','Client',c[1]],['file','Service scope',c[2]]].map(f=>`<div class="fact"><span class="tile-ic sm">${ic(f[0])}</span><div><small>${f[1].toUpperCase()}</small><span style="font-size:13px">${f[2]}</span></div></div>`).join('')}
    <div class="small muted">Reference contact allowed: ${it.id==='cs-ehs'||it.id==='cs-moei'?'Yes, via Marketing':'Ask the account owner'} \u00b7 Customer name approved for external use</div></div>
   <div class="res"><div class="eyebrow">Results achieved</div>${c[3].map(r=>`<div><b>${r[0]}</b><span>${r[1]}</span></div>`).join('')}</div></div></div>`;
}
function calcPreview(it){
  if(it.restricted && !canSee(it)) return '';
  return `<div class="pv"><div class="calc"><div style="display:flex;flex-direction:column;gap:10px">
   <label>Protected data (TB)<input id="c-tb" type="number" value="120"></label><label>Annual data growth (%)<input id="c-g" type="number" value="25"></label><label>Current annual cost (AED)<input id="c-cur" type="number" value="1450000"></label></div>
   <div class="out"><span>3-year saving with the CNS proposal</span><b id="c-out">AED 1.37M</b><span id="c-sub">31% lower 3-year TCO \u00b7 payback in 14 months</span><span style="opacity:.6">Demo calculator. Assumptions are illustrative.</span></div></div></div>`;
}
function openItem(id){
  const it = byId[id]; if(!it) return; S.slide=0; S.openId=id;
  const locked = !canSee(it);
  const related = ITEMS.filter(x=>x.id!==id && canSee(x) && x.status==='a' && (x.vendors.some(v=>it.vendors.includes(v)) || x.industries.some(v=>it.industries.includes(v)&&v!=='cross') || (!it.allPractices && x.practices.some(p=>it.practices.includes(p))&&!x.allPractices))).sort((a,b)=>b.views-a.views).slice(0,4);
  const p = PEOPLE[it.owner];
  $('#modal').innerHTML = `<div class="scrim" data-close><div class="drawer" role="dialog" aria-modal="true" aria-label="${esc(it.title)}">
   <div class="dh"><span class="tile-ic ${it.type==='Battle Card'?'red':it.type==='Case Study'?'blue':''}">${ic(TYPE_IC[it.type])}</span><div style="min-width:0"><div class="eyebrow">${esc(catName(it.cat))}</div><h2>${esc(it.title)}</h2>
    <div class="meta" style="display:flex;gap:6px;flex-wrap:wrap;margin-top:8px">${statusBadge(it)}<span class="chip">${it.type} \u00b7 ${TYPE_EXT[it.type]} \u00b7 ${it.size}</span><span class="chip">${it.audience==='Internal only'?ic('lock'):''}${it.audience}</span><span class="chip">v${it.version}</span></div></div>
    <button class="x" data-close aria-label="Close">${ic('x')}</button></div>
   <div class="db">
    ${it.status==='x'?`<div class="notice warn">${ic('clock')}<div>Review due in ${it.reviewIn} days. ${p.n} has been reminded to confirm, update or retire it.</div></div>`:''}
    ${it.status==='e'?`<div class="notice bad">${ic('alert')}<div>Expired. Hidden from default results. Don't send this to customers until the owner re-approves it.</div></div>`:''}
    <div id="pvwrap">${preview(it)}</div>
    ${it.desc?`<p style="margin:0;font-size:14px;max-width:70ch">${esc(it.desc)}</p>`:''}
    <div class="acts">
     <button class="btn primary" data-share="${id}" ${locked?'disabled':''}>${ic('link')}Copy share link</button>
     <button class="btn" data-toast="Opening in PowerPoint for the web (demo)" ${locked?'disabled':''}>${ic('eye')}Open full preview</button>
     <button class="btn" data-toast="Downloaded ${esc(it.title)}.${TYPE_EXT[it.type].toLowerCase()} (demo)" ${locked?'disabled':''}>${ic('download')}Download</button>
     <button class="btn" data-toast="Copied to OneDrive \u203a Sales Drafts. The master stays unchanged." ${locked?'disabled':''}>${ic('onedrive')}Copy to my OneDrive</button>
     <button class="btn ${S.kit.has(id)?'navy':''}" data-star="${id}">${ic('star')}${S.kit.has(id)?'In My Kit':'Save to My Kit'}</button>
     ${S.phase>=2?`<button class="btn" data-attach-sf="${id}">${ic('cloud')}Attach to opportunity</button>`:''}
     ${S.phase>=3&&!locked&&['Whitepaper','Presentation','Case Study'].includes(it.type)?`<button class="btn" data-sum="${id}">${ic('spark')}Summarise</button>`:''}
    </div>
    <div id="sumOut"></div>
    <dl class="meta-grid" style="margin:0">${[['Practice',prLabel(it)],['Vendor',it.vendors.join(', ')||'\u2014'],['Industry',it.industries.map(k=>INDUSTRIES[k].n).join(', ')],['Sales stage',it.stages.join(', ')||'Any'],['Language',it.lang],['Confidentiality',it.conf],['Owner',p.n],['Last updated',fmtDate(it.updated)],['Region','UAE, Oman, Kuwait, KSA']].map(m=>`<div><dt>${m[0]}</dt><dd>${esc(m[1])}</dd></div>`).join('')}</dl>
    <div class="two" style="grid-template-columns:1fr 1fr">
     <div><div class="eyebrow" style="margin-bottom:8px">Owner</div><div style="display:flex;gap:10px;align-items:center">${avatar(it.owner)}<div style="flex:1"><b style="color:var(--navy)">${p.n}</b><div class="small muted">${p.r}</div></div><button class="btn" data-teams="${it.owner}" style="padding:6px 10px">${ic('teams')}Ask</button></div>
      <div class="eyebrow" style="margin:16px 0 4px">Version history</div><div class="versions"><div><b>v${it.version}</b><span>Current \u00b7 approved ${fmtDate(it.updated)}</span></div><div><b class="muted">older</b><span class="muted">2 earlier versions, visible to owners only</span></div></div></div>
     <div>${S.phase>=2?`<div class="eyebrow" style="margin-bottom:8px">Feedback ${phaseTag(2)}</div><div style="display:flex;gap:10px;align-items:center"><div class="rating">${[1,2,3,4,5].map(n=>`<svg viewBox="0 0 24 24" class="${n<=4?'f':''}" stroke-width="1.6" fill="none">${P.star}</svg>`).join('')}</div><span class="small muted">4.4 \u00b7 23 ratings \u00b7 ${it.views} views</span></div>
      <div class="acts" style="margin-top:10px"><button class="btn" data-toast="Thanks. ${p.n} has been told this may be outdated.">${ic('flag')}Report outdated</button><button class="btn" data-toast="Comment posted (demo)">${ic('chat')}Comment</button></div>`:`<div class="eyebrow" style="margin-bottom:8px">Usage</div><p class="small muted" style="margin:0">${it.views} views since launch. Ratings and comments arrive in Phase 2.</p>`}</div>
    </div>
    ${related.length?`<div><div class="eyebrow" style="margin-bottom:8px">Related content</div><div class="panel list">${related.map(r=>row(r)).join('')}</div></div>`:''}
   </div></div></div>`;
  document.body.style.overflow='hidden';
  bindCalc();
}
function closeModal(){ $('#modal').innerHTML=''; document.body.style.overflow=''; S.openId=null; }
function bindCalc(){
  const tb=$('#c-tb'); if(!tb) return;
  const upd=()=>{ const cur=+$('#c-cur').value||0, g=(+$('#c-g').value||0)/100, t=+tb.value||0;
    const base = cur*(1+(1+g)+(1+g)**2); const nw = base*0.69 + t*900; const save=Math.max(0,base-nw);
    $('#c-out').textContent='AED '+(save/1e6).toFixed(2)+'M'; $('#c-sub').textContent=Math.round(save/base*100)+'% lower 3-year TCO \u00b7 payback in '+Math.max(6,Math.round(24-save/base*30))+' months'; };
  ['#c-tb','#c-g','#c-cur'].forEach(s=>$(s).addEventListener('input',upd)); upd();
}

/* ---------- Toast ---------- */
let tt;
function toast(msg, icon='checkc'){ const t=$('#toast'); t.innerHTML=ic(icon)+'<span>'+msg+'</span>'; t.hidden=false; clearTimeout(tt); tt=setTimeout(()=>t.hidden=true,3200); }

/* ---------- Router ---------- */
function route(){ return (location.hash||'#home').slice(1) || 'home'; }
function render(){
  const r = route(); let h;
  const need = {governance:2,analytics:2,salesforce:2,assistant:3}[r];
  if(need && need>S.phase){ S.phase=need; store.set('phase',need); }
  if(r==='home') h=vHome();
  else if(r==='search') h=vSearch();
  else if(r==='categories') h=vCategories();
  else if(r.startsWith('cat-')) h=vCat(r.slice(4));
  else if(r==='kits') h=vKits();
  else if(r.startsWith('kit-')) h=vKit(r.slice(4));
  else if(r==='vendors') h=vVendors();
  else if(r.startsWith('vendor-')) h=vVendor(r.slice(7));
  else if(r==='experts') h=vExperts();
  else if(r==='mykit') h=vMyKit();
  else if(r==='onboarding') h=vOnboarding();
  else if(r==='analytics') h=vAnalytics();
  else if(r==='governance') h=vGovernance();
  else if(r==='salesforce') h=vSalesforce();
  else if(r==='assistant') h=vAssistant();
  else h=vHome();
  $('#view').innerHTML=h; renderSide(r); renderPersona();
  $('#kitCount').textContent=S.kit.size;
}
function go(r){ if(location.hash==='#'+r) render(); else location.hash=r; window.scrollTo(0,0); $('#side').classList.remove('open'); }
window.addEventListener('hashchange',()=>{ S.kitTab='all'; S.vendTab='collateral'; render(); window.scrollTo(0,0); $('#side').classList.remove('open'); });

function renderPersona(){
  const p=persona(); $('#pAv').textContent=initials(p.n)||'HS'; $('#pAv').style.background=p.c;
  $('#pWho').innerHTML=`${esc(p.n)}<span>${esc(p.r)}</span>`;
  $('#personaMenu').innerHTML=`<div class="h eyebrow">View the portal as</div>${PERSONAS.map(x=>`<button class="${x.id===p.id?'on':''}" data-persona="${x.id}"><span class="av" style="background:${x.c}">${initials(x.n)||'HS'}</span><span><b>${x.n} \u00b7 ${x.r}</b><small>${x.desc}</small></span></button>`).join('')}<div class="small muted" style="padding:6px 10px">Demo personas from the BRD. Signed in with Microsoft 365 SSO.</div>`;
}

/* ---------- Events ---------- */
function shareItem(id){
  const it=byId[id];
  if(it.audience==='Internal only'){ toast('Internal link copied. External sharing is blocked: this item is internal only (DLP policy).','lock'); copyText(`https://cnsme.sharepoint.com/sites/SalesPortal/Content/${id}`); return; }
  copyText(`https://cnsme.sharepoint.com/:p:/s/SalesPortal/${id}`); toast('Share link copied. Recipients always get the current approved version.','link');
}
function copyText(t){ try{ navigator.clipboard.writeText(t).catch(()=>{}); }catch(e){} }
function applyFilterToSearch(key,val){ S.q=''; Object.keys(S.f).forEach(k=>S.f[k]=[]); S.f[key]=[val]; go('search'); }

document.addEventListener('click',e=>{
  const t=e.target.closest('[data-star],[data-open],[data-go],[data-close],[data-teams],[data-toast],[data-share],[data-phase],[data-persona],[data-clear],[data-clearall],[data-rmf],[data-kittab],[data-vtab],[data-attach],[data-attach-sf],[data-ai],[data-approve],[data-reject],[data-slide],[data-copy],[data-share-kit],[data-sum],[data-scroll]');
  if(!t){ if(!e.target.closest('#personaMenu,#personaBtn')) $('#personaMenu').hidden=true; return; }
  const d=t.dataset;
  if(d.star){ e.stopPropagation(); S.kit.has(d.star)?S.kit.delete(d.star):S.kit.add(d.star); store.set('kit',[...S.kit]); toast(S.kit.has(d.star)?'Saved to My Kit':'Removed from My Kit','star'); const open=S.openId; render(); if(open) openItem(open); return; }
  if(d.close!==undefined){ if(e.target===t || t.classList.contains('x')) closeModal(); return; }
  if(d.slide){ S.slide=+d.slide; const it=byId[S.openId]; $('#pvwrap').innerHTML=preview(it); return; }
  if(d.sum){ const it=byId[d.sum]; $('#sumOut').innerHTML=`<div class="notice info">${ic('spark')}<div><b>AI summary</b> (${phaseTag(3)})<br>${esc(it.desc||it.title)} Key points: approved for ${it.audience.toLowerCase()} use; best at the ${it.stages[0]||'Discover'} stage; pairs well with the ${prLabel(it)} references. <span class="muted">Source: this file.</span></div></div>`; return; }
  if(d.open){ e.preventDefault(); openItem(d.open); return; }
  if(d.teams){ toast(`Opening a Teams chat with ${PEOPLE[d.teams].n}\u2026`,'teams'); return; }
  if(d.toast!==undefined){ e.preventDefault(); toast(d.toast); return; }
  if(d.share){ shareItem(d.share); return; }
  if(d.shareKit){ copyText(`https://cnsme.sharepoint.com/sites/SalesPortal/kits/${d.shareKit}`); toast('Kit link copied for internal colleagues','link'); return; }
  if(d.copy){ copyText(d.copy); toast(d.msg||'Copied','copy'); return; }
  if(d.phase){ S.phase=+d.phase; store.set('phase',S.phase); const need={governance:2,analytics:2,salesforce:2,assistant:3}[route()]; if(need&&need>S.phase){ go('home'); } else render(); return; }
  if(d.persona){ S.persona=d.persona; store.set('persona',S.persona); $('#personaMenu').hidden=true; S.chat=null; render(); toast(`Viewing as ${persona().n}`,'users'); return; }
  if(d.clear){ S.f[d.clear]=[]; render(); return; }
  if(d.clearall!==undefined){ Object.keys(S.f).forEach(k=>S.f[k]=[]); S.q=''; render(); return; }
  if(d.rmf){ S.f[d.rmf]=S.f[d.rmf].filter(v=>v!==d.v); render(); return; }
  if(d.kittab){ S.kitTab=d.kittab; render(); return; }
  if(d.vtab){ S.vendTab=d.vtab; render(); return; }
  if(d.attach){ S.attached.has(d.attach)?S.attached.delete(d.attach):S.attached.add(d.attach); render(); if(S.attached.has(d.attach)) toast('Link attached and logged on the opportunity','cloud'); return; }
  if(d.attachSf){ S.attached.add(d.attachSf); toast('Attached to \u201cAl Noor Hospital Group \u2013 Campus Network\u201d in Salesforce','cloud'); return; }
  if(d.ai){ askAI(d.ai); return; }
  if(d.approve||d.reject){ const id=d.approve||d.reject; const q=S.queue.find(x=>x.id===id); S.queue=S.queue.filter(x=>x.id!==id); render(); toast(d.approve?'Approved. It is now visible to sales with the Approved badge.':`Sent back to ${PEOPLE[q.who].n} with your comments`, d.approve?'checkc':'chat'); return; }
  if(d.scroll){ document.getElementById(d.scroll)?.scrollIntoView({behavior:'smooth'}); return; }
  if(d.go){ if(d.cat){ applyFilterToSearch('cat',d.cat); return; } if(d.sort){ S.sort=d.sort; S.q=''; Object.keys(S.f).forEach(k=>S.f[k]=[]); } if(d.ask){ go('assistant'); setTimeout(()=>askAI(d.ask),50); return; } go(d.go); return; }
});
document.addEventListener('keydown',e=>{
  if(e.key==='Escape'){ closeModal(); $('#personaMenu').hidden=true; }
  if(e.key==='Enter' && e.target.matches('[data-open][role=button]')) openItem(e.target.dataset.open);
  if(e.key==='/' && !e.target.matches('input,textarea,select')){ e.preventDefault(); ($('#sq')||$('#hq')||$('#gq')).focus(); }
});
document.addEventListener('change',e=>{
  const t=e.target;
  if(t.dataset.f){ const k=t.dataset.f; if(t.checked) S.f[k].push(t.value); else S.f[k]=S.f[k].filter(v=>v!==t.value); render(); }
  if(t.id==='sort'){ S.sort=t.value; render(); }
  if(t.id==='qfP'&&t.value) applyFilterToSearch('practice',t.value);
  if(t.id==='qfV'&&t.value) applyFilterToSearch('vendor',t.value);
  if(t.id==='qfI'&&t.value) applyFilterToSearch('industry',t.value);
  if(t.dataset.task){ const k=t.dataset.task; t.checked?S.done.add(k):S.done.delete(k); store.set('done',[...S.done]); render(); if(t.checked) toast('Nice. Progress saved.','checkc'); }
});
document.addEventListener('input',e=>{
  if(e.target.id==='eq'){ S.eq=e.target.value; const pos=e.target.selectionStart; render(); const n=$('#eq'); n.focus(); n.setSelectionRange(pos,pos); }
});
document.addEventListener('submit',e=>{
  e.preventDefault(); const f=e.target;
  if(f.id==='gsearch'){ S.q=$('#gq').value; $('#gq').value=''; $('#gq').blur(); go('search'); }
  if(f.id==='hsearch'){ S.q=$('#hq').value; go('search'); }
  if(f.id==='sform'){ S.q=$('#sq').value; render(); }
  if(f.id==='aiForm'){ const v=$('#aiq').value.trim(); if(!v) return; const l=v.toLowerCase(); const k=/margin|price|pricing|rate card|discount/.test(l)?'price':null; askAI(k, k?null:v); }
  if(f.id==='upForm'){
    const req=['f-title','f-cat','f-type','f-pr','f-aud']; let miss=[];
    req.forEach(id=>{ const el=$('#'+id); const lab=el.closest('label'); if(!el.value){ lab.classList.add('err'); miss.push(lab.childNodes[0].textContent.trim()); } else lab.classList.remove('err'); });
    if(miss.length){ $('#upMsg').innerHTML=`<span style="color:var(--red)">Can't save yet. Fill in: ${miss.join(', ')}.</span>`; return; }
    $('#upMsg').innerHTML='<span style="color:var(--ok)">Submitted. Sent to Sara Al Hashimi (Practice Head) and Marketing for approval.</span>';
    S.queue.push({id:'q'+Date.now(),title:$('#f-title').value,type:$('#f-type').value,who:'sara',sub:0,step:'Practice Head review',due:'24 Nov'});
    setTimeout(render,1600);
  }
});
$('#personaBtn').addEventListener('click',e=>{ e.stopPropagation(); $('#personaMenu').hidden=!$('#personaMenu').hidden; });
$('#menuBtn').addEventListener('click',()=>$('#side').classList.toggle('open'));
document.addEventListener('click',e=>{ if(e.target.id==='facetToggle') $('#facets').classList.toggle('open'); });
setInterval(()=>{ if(route()==='home' && !S.openId && !document.activeElement.matches('input,select')){ S.annIdx++; const a=$('.announce'); if(a){ const x=ANN[S.annIdx%ANN.length]; a.querySelector('.tag').textContent=x[0]; a.querySelector(".amsg").innerHTML=x[1]; a.querySelector('.link').dataset.open=x[2]; a.querySelectorAll('.dots i').forEach((d,i)=>d.classList.toggle('on',i===S.annIdx%ANN.length)); } } }, 7000);
render();
</script>
<script>
document.addEventListener('click',function(e){var a=e.target.closest&&e.target.closest('a[href^="#"]');if(!a||e.defaultPrevented)return;var h=a.getAttribute('href');if(h==='#')return;e.preventDefault();if(location.hash===h){window.dispatchEvent(new HashChangeEvent('hashchange'));}else{location.hash=h.slice(1);}},true);
</script>
</body>
</html>
