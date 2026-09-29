#!/usr/bin/env python3
# Validates the Hanzi+ site: UTF-8, well-formed HTML, lang attrs, switcher/hreflang links,
# Apple links, no leftover English or template text.  Adapted from Tap&Stop site_tools/check_site.py.
# Usage: python3 check_site.py [site_dir]   (default: ../site next to this script)
import os, re, sys
from html.parser import HTMLParser
from urllib.parse import urlparse

SITE = os.path.abspath(sys.argv[1] if len(sys.argv) > 1 else os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "site"))
BASE = "https://ayoleynikov.github.io/hanziPlus/"
LANGS = ["en", "ru", "es", "pt-BR"]
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import gen_site  # for the expected Apple privacy URL per language
assert gen_site.LANGS == LANGS
VOID = {"meta", "link", "br", "img", "input", "hr", "area", "base", "col", "embed", "source", "track", "wbr"}
errors = []

class P(HTMLParser):
    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.stack, self.hrefs, self.alts, self.html_lang, self.title = [], [], [], None, ""
        self.nav_links, self.in_nav, self.text, self.in_title, self.in_skip = [], 0, [], False, 0
        self.blocks, self.cur = [], None
    def handle_starttag(self, tag, attrs):
        a = dict(attrs)
        if tag not in VOID: self.stack.append(tag)
        if tag == "html": self.html_lang = a.get("lang")
        if tag == "title": self.in_title = True
        if tag in ("script", "style"): self.in_skip += 1
        if tag == "nav": self.in_nav += 1
        if tag == "a" and "href" in a:
            self.hrefs.append(a["href"])
            if self.in_nav: self.nav_links.append((a["href"], a.get("hreflang")))
        if tag == "link" and a.get("rel") == "alternate": self.alts.append((a.get("hreflang"), a.get("href")))
        if tag == "link" and a.get("rel") == "canonical": self.alts.append(("canonical", a.get("href")))
        if tag in ("p", "h1", "h2") and not self.in_nav: self.cur = []
    def handle_startendtag(self, tag, attrs):
        self.handle_starttag(tag, attrs)
        if tag not in VOID and self.stack and self.stack[-1] == tag: self.stack.pop()
    def handle_endtag(self, tag):
        if tag in VOID: return
        if not self.stack or self.stack[-1] != tag:
            errors.append(f"{self.fname}: mismatched </{tag}> (open: {self.stack[-3:]}) at line {self.getpos()[0]}")
        else: self.stack.pop()
        if tag == "title": self.in_title = False
        if tag in ("script", "style"): self.in_skip -= 1
        if tag == "nav": self.in_nav -= 1
        if tag in ("p", "h1", "h2") and self.cur is not None:
            self.blocks.append("".join(self.cur).strip()); self.cur = None
    def handle_data(self, d):
        if self.in_title: self.title += d
        if self.cur is not None: self.cur.append(d)
        if not self.in_skip and not self.in_nav and not self.in_title: self.text.append(d)

def resolve(fdir, href):
    p = os.path.normpath(os.path.join(fdir, href))
    if href.endswith("/") or os.path.isdir(p): p = os.path.join(p, "index.html")
    return p

pages = {}
files = []
for root, _, fs in os.walk(SITE):
    for f in fs:
        files.append(os.path.join(root, f))
for path in sorted(files):
    relp = os.path.relpath(path, SITE)
    if not path.endswith(".html"):
        errors.append(f"unexpected non-HTML file {relp}"); continue
    raw = open(path, "rb").read()
    try: s = raw.decode("utf-8")
    except UnicodeDecodeError as e: errors.append(f"{relp}: not UTF-8 ({e})"); continue
    if raw.startswith(b"\xef\xbb\xbf"): errors.append(f"{relp}: has BOM")
    if not s.startswith("<!DOCTYPE html>"): errors.append(f"{relp}: missing doctype")
    if '<meta charset="utf-8">' not in s: errors.append(f"{relp}: missing meta charset")
    p = P(); p.fname = relp; p.feed(s); p.close()
    if p.stack: errors.append(f"{relp}: unclosed tags {p.stack}")
    pages[relp] = p
    lang = "en" if os.path.dirname(relp) == "" else os.path.dirname(relp)
    page = os.path.basename(relp)
    if lang not in LANGS: errors.append(f"{relp}: unknown lang folder")
    if p.html_lang != lang: errors.append(f"{relp}: <html lang={p.html_lang}> expected {lang}")
    if not p.title.strip(): errors.append(f"{relp}: empty title")
    fdir = os.path.dirname(path)
    for h in p.hrefs:
        if h.startswith(("mailto:", "https://www.apple.com/")): continue
        if re.match(r"^[a-z]+:", h): errors.append(f"{relp}: unexpected external link {h}"); continue
        t = resolve(fdir, h)
        if not os.path.isfile(t): errors.append(f"{relp}: broken link {h} -> {t}")
    # switcher: 4 links, one per language, pointing to same page type in that language
    if [hl for _, hl in p.nav_links] != LANGS: errors.append(f"{relp}: switcher languages {p.nav_links}")
    for h, hl in p.nav_links:
        t = os.path.relpath(resolve(fdir, h), SITE)
        exp = (page if hl == "en" else f"{hl}/{page}")
        if t != exp: errors.append(f"{relp}: switcher {hl} -> {t}, expected {exp}")
    # hreflang alternates + canonical -> map to local files
    hl_seen = []
    for hl, url in p.alts:
        if not url.startswith(BASE): errors.append(f"{relp}: bad alt url {url}"); continue
        local = url[len(BASE):] or "index.html"
        if local.endswith("/"): local += "index.html"
        if not os.path.isfile(os.path.join(SITE, local)): errors.append(f"{relp}: alt {hl} {url} has no file")
        if hl == "canonical":
            if local != relp: errors.append(f"{relp}: canonical {url} != self")
            continue
        exp = page if hl in ("en", "x-default") else f"{hl}/{page}"
        if local != exp: errors.append(f"{relp}: hreflang {hl} -> {local}, expected {exp}")
        hl_seen.append(hl)
    if hl_seen != LANGS + ["x-default"]: errors.append(f"{relp}: hreflang set {hl_seen}")
    # template leftovers / wrong app
    for bad in ("{a}", "{/a}", "{email}", "{", "}", "Bday", "birthday", "Tap&", "Tap-Stop", "Party Game", "TODO", "XXX", "&amp;amp;"):
        body_html = s.split("<body>", 1)[1] if "<body>" in s else s
        if bad in ("{", "}") and bad in body_html: errors.append(f"{relp}: stray brace in body")
        elif bad not in ("{", "}") and bad in s: errors.append(f"{relp}: leftover {bad!r}")
    if "Hanzi+" not in s: errors.append(f"{relp}: app name Hanzi+ missing")
    if "September 29, 2026" not in s and page == "privacy.html" and lang == "en": errors.append(f"{relp}: wrong date")
    for m in re.finditer(r"&(?!amp;|nbsp;|lt;|gt;|quot;|#\d+;)", re.sub(r"(?s)<script>.*?</script>", "", s)):
        errors.append(f"{relp}: bare '&' at offset {m.start()}"); break
    apple_links = [x for x in p.hrefs if x.startswith("https://www.apple.com/")]
    if page == "privacy.html":
        if apple_links != [gen_site.APPLE[lang]]: errors.append(f"{relp}: Apple links {apple_links}, expected [{gen_site.APPLE[lang]}]")
        if "2026" not in s: errors.append(f"{relp}: no 2026 date")
        if [x for x in p.hrefs if x.startswith("mailto:")] != ["mailto:Ayoleynikov@icloud.com"]: errors.append(f"{relp}: mailto link missing/duplicated")
        if s.count("<h2>") != len(gen_site.T["en"]["sections"]): errors.append(f"{relp}: wrong section count")
    else:
        if apple_links: errors.append(f"{relp}: unexpected Apple link on index")
        if "mailto:Ayoleynikov@icloud.com" not in s: errors.append(f"{relp}: no support email")
        if 'href="privacy.html"' not in s: errors.append(f"{relp}: no privacy link")
    if page == "privacy.html" and "location.replace" in s: errors.append(f"{relp}: privacy page must not redirect")
    if relp != "index.html" and "location.replace" in s: errors.append(f"{relp}: only the root landing page may redirect")
    if relp == "index.html" and "location.replace" not in s: errors.append(f"{relp}: first-visit language redirect missing")

# leftover English check
# Blocks that are legitimately identical to English in the target language:
SAME_OK = set()
SAME_ANY = {"Hanzi+"}  # brand line, same in every language
en_blocks = {page: set(b for b in pages[page].blocks if len(b) > 12) for page in ("index.html", "privacy.html")}
EN_WORDS = re.compile(r"\b(the|and|your|you|with|from|this|that|data|app|we|not|any|are|is|of|to|in|on)\b", re.I)
for relp, p in pages.items():
    if os.path.dirname(relp) == "": continue
    page = os.path.basename(relp)
    for b in p.blocks:
        if b in en_blocks[page] and (relp, b) not in SAME_OK and b not in SAME_ANY: errors.append(f"{relp}: English block left: {b[:60]}")
    body = " ".join(p.text)
    for keep in ("Ayoleynikov@icloud.com", "Hanzi+", "Game Center", "App Store", "iCloud", "iPhone"):
        body = body.replace(keep, "")
    hits = EN_WORDS.findall(body)
    # 'app' is used in es/pt-BR; 'in'/'is'... allow a handful of false positives
    allow = {"app", "in", "is", "to"}
    real = [h for h in hits if h.lower() not in allow]
    if len(real) > 3: errors.append(f"{relp}: suspicious English words {real[:15]}")

if len(pages) != 2 * len(LANGS): errors.append(f"expected {2*len(LANGS)} HTML files, found {len(pages)}")
print(f"checked {len(pages)} HTML files")
if errors:
    print("FAIL"); [print(" -", e) for e in errors]; sys.exit(1)
print("OK: all files UTF-8, well-formed, correct lang, all switcher/hreflang/internal links resolve, Apple links match language, no leftover English or template text")
