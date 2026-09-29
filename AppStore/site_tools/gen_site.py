#!/usr/bin/env python3
# Generates the Hanzi+ static site (landing + privacy policy) in 4 languages.
# Adapted from Tap&Stop AppStore/site_tools/gen_site.py (itself based on bday-site-tools).
# Usage: python3 gen_site.py [site_dir]   (default: ../site next to this script)
import html, os, sys

APP = "Hanzi+"
BASE = "https://ayoleynikov.github.io/hanziPlus/"
EMAIL_ADDR = "Ayoleynikov@icloud.com"
EMAIL = f'<a href="mailto:{EMAIL_ADDR}">{EMAIL_ADDR}</a>'
APPLE_EN = "https://www.apple.com/legal/privacy/"

# Same 4 languages as the app's Localizable.xcstrings; "en" lives at the site root.
LANGS = ["en", "ru", "es", "pt-BR"]
NATIVE = {"en": "English", "ru": "Русский", "es": "Español", "pt-BR": "Português (Brasil)"}
NAV_LABEL = {"en": "Language", "ru": "Язык", "es": "Idioma", "pt-BR": "Idioma"}
# Apple's privacy policy in the matching language.
APPLE = {"en": APPLE_EN,
         "ru": "https://www.apple.com/legal/privacy/ru/",
         "es": "https://www.apple.com/legal/privacy/es/",
         "pt-BR": "https://www.apple.com/legal/privacy/br/"}

# Keys: title, tagline, privacy, support, updated, intro, sections = [(h, p), ...].
# {a}...{/a} = link to Apple's privacy policy, {email} = mailto link. Text is HTML-escaped on output.
# Section order (same in every language): 1 no collection, 2 on-device storage, 3 permissions and
# device features (on-device speech), 4 Apple services, 5 deleting data, 6 children, 7 changes, 8 contact.
# Facts (verified in code, Sep 29 2026): no networking, no SDKs, no analytics/ads/tracking/StoreKit/iCloud,
# no permission prompts; all state lives in UserDefaults (no files written); AVSpeechSynthesizer (zh-CN) for
# pronunciation; UIPasteboard write-only on "Copy Chinese"; Settings > "Reset All Progress" clears learning data
# (not onboarding answers, recent searches or language choice).
T = {}
T["en"] = dict(
    title="Hanzi+ Privacy Policy",
    tagline="Learn Mandarin Chinese a little every day: lessons, flashcards, games, and travel phrases with pronunciation.",
    privacy="Privacy Policy", support="Support:",
    updated="Last updated: September 29, 2026",
    intro="Hanzi+ is an app for learning Mandarin Chinese with lessons, flashcards, games, and travel phrases. This policy explains what happens to your information when you use the app.",
    sections=[
        ("We do not collect your data", "Hanzi+ has no accounts, no servers of its own, no analytics, no advertising, no in-app purchases, and no tracking. It contains no third-party code and does not send anything over the internet. The developer never receives, sees, or stores anything you do or enter in the app."),
        ("What the app stores on your device", "To keep track of your learning, the app saves some information on your device: your progress in lessons and the daily lesson, the words you have learned and your review schedule, streaks and daily statistics, game scores, daily challenges and play history, your Journey progress and achievements, favorite words and travel phrases, recent searches and recently viewed words, the answers you gave when setting up the app (your goal, Chinese level, daily study time, and an optional travel date), and your language choice. This information stays on your device and is never sent to the developer or anyone else."),
        ("Permissions and device features", "Hanzi+ does not ask for any permissions. It does not use the camera, microphone, photos, contacts, location, or notifications, and it never records your voice. Chinese pronunciation is read aloud by Apple’s built-in speech synthesis, which runs on your device. When you tap “Copy Chinese” on a travel phrase, the Chinese text is placed on your device’s clipboard so you can paste it elsewhere; the app does not read your clipboard. Sounds are standard system sounds, and vibration uses the iPhone’s built-in haptic feedback."),
        ("Apple services", "Hanzi+ does not use Game Center, does not store anything in iCloud, and has no in-app purchases. Downloading and updating the app through the App Store, as well as device backups such as iCloud Backup (which may include the app’s data if you have backups turned on), are handled by Apple under {a}Apple’s Privacy Policy{/a}. If you have chosen to share analytics with app developers in your iPhone settings, Apple may provide the developer with anonymous, aggregated statistics such as crash reports; these do not identify you."),
        ("Deleting your data", "To erase your learning data, open Settings in the app and tap “Reset All Progress”: this clears learned words, lesson and Journey progress, game scores, favorites, and statistics. Deleting the app removes all of its data from your device, including your setup answers, recent searches, and language choice."),
        ("Children", "Hanzi+ does not collect any information from anyone, including children."),
        ("Changes", "If this policy changes, the new version will be published on this page with a new date."),
        ("Contact", "Questions? Write to {email}."),
    ])
T["ru"] = dict(
    title="Политика конфиденциальности Hanzi+",
    tagline="Учите китайский понемногу каждый день: уроки, карточки, игры и фразы для путешествий с произношением.",
    privacy="Политика конфиденциальности", support="Поддержка:",
    updated="Обновлено: 29 сентября 2026 г.",
    intro="Hanzi+ — приложение для изучения китайского языка (путунхуа) с уроками, карточками, играми и фразами для путешествий. Здесь описано, что происходит с вашими данными, когда вы пользуетесь приложением.",
    sections=[
        ("Мы не собираем ваши данные", "В Hanzi+ нет аккаунтов, собственных серверов, аналитики, рекламы, встроенных покупок и отслеживания. В приложении нет стороннего кода, и оно ничего не передаёт через интернет. Разработчик не получает, не видит и не хранит ничего из того, что вы делаете или вводите в приложении."),
        ("Что приложение хранит на устройстве", "Чтобы отслеживать ваше обучение, приложение сохраняет на устройстве некоторые данные: прогресс в уроках и ежедневном уроке, изученные слова и график повторений, серии занятий и ежедневную статистику, результаты игр, ежедневные задания и историю игр, прогресс в разделе «Путь» и достижения, избранные слова и фразы для путешествий, недавние поиски и недавно просмотренные слова, ответы, которые вы дали при первой настройке (цель, уровень китайского, время занятий в день и дату поездки, если вы её указали), а также выбранный язык. Эти данные остаются на вашем устройстве и никогда не передаются разработчику или кому-либо ещё."),
        ("Разрешения и функции устройства", "Hanzi+ не запрашивает никаких разрешений. Приложение не использует камеру, микрофон, фото, контакты, геолокацию и уведомления и никогда не записывает ваш голос. Китайское произношение озвучивает встроенный синтезатор речи Apple, который работает прямо на устройстве. Когда вы нажимаете «Скопировать китайский» у фразы для путешествий, китайский текст попадает в буфер обмена устройства, чтобы вы могли вставить его в другое место; приложение не читает буфер обмена. Звуки — стандартные системные, а вибрация — встроенный тактильный отклик iPhone."),
        ("Сервисы Apple", "Hanzi+ не использует Game Center, ничего не хранит в iCloud и не содержит встроенных покупок. Загрузку и обновление приложения через App Store, а также резервные копии устройства, например резервную копию iCloud (в неё могут попасть данные приложения, если резервное копирование включено), обеспечивает Apple в соответствии с {a}Политикой конфиденциальности Apple{/a}. Если в настройках iPhone вы разрешили делиться аналитикой с разработчиками приложений, Apple может предоставлять разработчику анонимную обобщённую статистику, например отчёты о сбоях; по ней нельзя установить вашу личность."),
        ("Удаление данных", "Чтобы стереть данные обучения, откройте «Настройки» в приложении и нажмите «Сбросить весь прогресс»: будут удалены изученные слова, прогресс уроков и раздела «Путь», результаты игр, избранное и статистика. При удалении приложения все его данные удаляются с устройства, включая ответы первой настройки, недавние поиски и выбранный язык."),
        ("Дети", "Hanzi+ не собирает никакой информации ни о ком, включая детей."),
        ("Изменения", "Если политика изменится, новая версия появится на этой странице с новой датой."),
        ("Связь", "Вопросы можно задать по адресу {email}."),
    ])
T["es"] = dict(
    title="Política de privacidad de Hanzi+",
    tagline="Aprende chino mandarín un poco cada día: lecciones, tarjetas, juegos y frases de viaje con pronunciación.",
    privacy="Política de privacidad", support="Soporte:",
    updated="Última actualización: 29 de septiembre de 2026",
    intro="Hanzi+ es una app para aprender chino mandarín con lecciones, tarjetas, juegos y frases de viaje. Esta política explica qué ocurre con tu información cuando usas la app.",
    sections=[
        ("No recopilamos tus datos", "Hanzi+ no tiene cuentas, ni servidores propios, ni analíticas, ni publicidad, ni compras dentro de la app, ni seguimiento. No incluye código de terceros y no envía nada por internet. El desarrollador nunca recibe, ve ni almacena nada de lo que haces o introduces en la app."),
        ("Qué guarda la app en tu dispositivo", "Para llevar el control de tu aprendizaje, la app guarda algunos datos en tu dispositivo: tu progreso en las lecciones y en la lección diaria, las palabras que has aprendido y tu calendario de repaso, las rachas y estadísticas diarias, las puntuaciones de los juegos, los retos diarios y el historial de partidas, tu progreso en «Viaje» y tus logros, las palabras y frases de viaje favoritas, las búsquedas recientes y las palabras vistas recientemente, las respuestas que diste al configurar la app (tu objetivo, tu nivel de chino, tu tiempo de estudio diario y, si la indicaste, la fecha de tu viaje) y el idioma elegido. Esta información permanece en tu dispositivo y nunca se envía al desarrollador ni a nadie más."),
        ("Permisos y funciones del dispositivo", "Hanzi+ no solicita ningún permiso. No utiliza la cámara, el micrófono, las fotos, los contactos, la ubicación ni las notificaciones, y nunca graba tu voz. La pronunciación en chino la lee en voz alta la síntesis de voz integrada de Apple, que funciona en tu dispositivo. Cuando tocas «Copiar chino» en una frase de viaje, el texto en chino se copia al portapapeles de tu dispositivo para que puedas pegarlo en otro lugar; la app no lee tu portapapeles. Los sonidos son sonidos estándar del sistema y la vibración usa la respuesta háptica integrada del iPhone."),
        ("Servicios de Apple", "Hanzi+ no utiliza Game Center, no guarda nada en iCloud y no tiene compras dentro de la app. La descarga y actualización de la app a través del App Store, así como las copias de seguridad del dispositivo, como la copia de seguridad de iCloud (que puede incluir los datos de la app si tienes activadas las copias de seguridad), corren a cargo de Apple conforme a la {a}Política de privacidad de Apple{/a}. Si en los ajustes del iPhone has elegido compartir análisis con los desarrolladores de apps, Apple puede facilitar al desarrollador estadísticas anónimas y agregadas, como informes de fallos, que no te identifican."),
        ("Eliminar tus datos", "Para borrar tus datos de aprendizaje, abre «Ajustes» en la app y toca «Restablecer todo el progreso»: se borrarán las palabras aprendidas, el progreso de las lecciones y de «Viaje», las puntuaciones de los juegos, los favoritos y las estadísticas. Al eliminar la app, todos sus datos se borran de tu dispositivo, incluidas las respuestas de la configuración inicial, las búsquedas recientes y el idioma elegido."),
        ("Niños", "Hanzi+ no recopila ninguna información de nadie, incluidos los niños."),
        ("Cambios", "Si esta política cambia, la nueva versión se publicará en esta página con una nueva fecha."),
        ("Contacto", "¿Tienes preguntas? Escribe a {email}."),
    ])
T["pt-BR"] = dict(
    title="Política de Privacidade do Hanzi+",
    tagline="Aprenda chinês mandarim um pouco por dia: lições, flashcards, jogos e frases de viagem com pronúncia.",
    privacy="Política de Privacidade", support="Suporte:",
    updated="Última atualização: 29 de setembro de 2026",
    intro="O Hanzi+ é um app para aprender chinês mandarim com lições, flashcards, jogos e frases de viagem. Esta política explica o que acontece com suas informações quando você usa o app.",
    sections=[
        ("Não coletamos seus dados", "O Hanzi+ não tem contas, servidores próprios, análises, publicidade, compras dentro do app nem rastreamento. Ele não contém código de terceiros e não envia nada pela internet. O desenvolvedor nunca recebe, vê ou armazena nada do que você faz ou insere no app."),
        ("O que o app armazena no seu dispositivo", "Para acompanhar seu aprendizado, o app salva algumas informações no seu dispositivo: seu progresso nas lições e na lição diária, as palavras que você aprendeu e sua agenda de revisão, sequências e estatísticas diárias, pontuações dos jogos, desafios diários e histórico de partidas, seu progresso na “Jornada” e suas conquistas, palavras e frases de viagem favoritas, buscas recentes e palavras vistas recentemente, as respostas que você deu ao configurar o app (seu objetivo, nível de chinês, tempo de estudo diário e, se informada, a data da viagem) e o idioma escolhido. Essas informações ficam no seu dispositivo e nunca são enviadas ao desenvolvedor nem a mais ninguém."),
        ("Permissões e recursos do dispositivo", "O Hanzi+ não pede nenhuma permissão. Ele não usa a câmera, o microfone, as fotos, os contatos, a localização nem as notificações, e nunca grava sua voz. A pronúncia em chinês é lida em voz alta pela síntese de voz integrada da Apple, que funciona no seu dispositivo. Quando você toca em “Copiar chinês” em uma frase de viagem, o texto em chinês é copiado para a área de transferência do dispositivo para que você possa colá-lo em outro lugar; o app não lê sua área de transferência. Os sons são sons padrão do sistema e a vibração usa o retorno tátil integrado do iPhone."),
        ("Serviços da Apple", "O Hanzi+ não usa o Game Center, não armazena nada no iCloud e não tem compras dentro do app. O download e a atualização do app pela App Store, assim como os backups do dispositivo, como o Backup do iCloud (que pode incluir os dados do app se os backups estiverem ativados), são gerenciados pela Apple de acordo com a {a}Política de Privacidade da Apple{/a}. Se você optou por compartilhar análises com desenvolvedores de apps nos ajustes do iPhone, a Apple pode fornecer ao desenvolvedor estatísticas anônimas e agregadas, como relatórios de falhas, que não identificam você."),
        ("Como apagar seus dados", "Para apagar seus dados de aprendizado, abra “Configurações” no app e toque em “Redefinir todo o progresso”: isso apaga as palavras aprendidas, o progresso das lições e da “Jornada”, as pontuações dos jogos, os favoritos e as estatísticas. Ao apagar o app, todos os dados dele são removidos do seu dispositivo, incluindo as respostas da configuração inicial, as buscas recentes e o idioma escolhido."),
        ("Crianças", "O Hanzi+ não coleta nenhuma informação de ninguém, incluindo crianças."),
        ("Alterações", "Se esta política mudar, a nova versão será publicada nesta página com uma nova data."),
        ("Contato", "Dúvidas? Escreva para {email}."),
    ])

assert set(T) == set(LANGS), set(LANGS) ^ set(T)
assert set(APPLE) == set(LANGS)
for _l, _t in T.items():
    assert len(_t["sections"]) == len(T["en"]["sections"]), _l
    for _h, _p in _t["sections"]:
        assert _p.count("{a}") == _p.count("{/a}") <= 1, (_l, _h)
    assert sum(p.count("{a}") for _, p in _t["sections"]) == 1, _l
    assert sum(p.count("{email}") for _, p in _t["sections"]) == 1, _l


def h(s):
    return html.escape(s, quote=False)


def dir_of(lang):
    return "" if lang == "en" else lang + "/"


def rel(from_lang, to_lang, page):
    # page: "index" or "privacy"
    up = "" if from_lang == "en" else "../"
    target = dir_of(to_lang)
    if page == "index":
        path = up + target
        return path if path else "./"
    return up + target + "privacy.html"


def head_links(page):
    out = []
    for l in LANGS:
        url = BASE + dir_of(l) + ("" if page == "index" else "privacy.html")
        out.append(f'<link rel="alternate" hreflang="{l}" href="{url}">')
    url = BASE + ("" if page == "index" else "privacy.html")
    out.append(f'<link rel="alternate" hreflang="x-default" href="{url}">')
    return "\n".join(out)


def canonical(lang, page):
    return f'<link rel="canonical" href="{BASE + dir_of(lang) + ("" if page == "index" else "privacy.html")}">'


def switcher(lang, page, indent):
    lines = [f'{indent}<nav class="lang" aria-label="{NAV_LABEL[lang]}">']
    for l in LANGS:
        cur = ' aria-current="page"' if l == lang else ""
        lines.append(f'{indent}  <a href="{rel(lang, l, page)}" hreflang="{l}" lang="{l}"{cur}>{NATIVE[l]}</a>')
    lines.append(f'{indent}</nav>')
    return "\n".join(lines)


REDIRECT = """<script>
  // First visit only: open the index in the browser's language (never on privacy pages).
  (function () {
    try {
      if (localStorage.getItem("hanziplus-site-seen")) return;
      localStorage.setItem("hanziplus-site-seen", "1");
      var base = location.href.replace(/[^\\/]*([?#].*)?$/, "");
      if (document.referrer && document.referrer.indexOf(base) === 0) return;
      var map = { en: "en", ru: "ru", es: "es", pt: "pt-BR" };
      var list = navigator.languages || [navigator.language || ""];
      for (var i = 0; i < list.length; i++) {
        var t = map[String(list[i] || "").toLowerCase().slice(0, 2)];
        if (t) { if (t !== "en") location.replace(t + "/"); return; }
      }
    } catch (e) {}
  })();
</script>
"""

COMMON_CSS = """  :root {{ color-scheme: light dark; --fg:#1d1d1f; --muted:#6e6e73; --bg:#fbfbfd; --accent:#c8321e; }}
  @media (prefers-color-scheme: dark) {{ :root {{ --fg:#f5f5f7; --muted:#a1a1a6; --bg:#08080a; --accent:#ff6a4d; }} }}
  body {{ margin:0; font:17px/1.55 -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; background:var(--bg); color:var(--fg); }}
  a {{ color:var(--accent); }}"""


def index_page(lang):
    t = T[lang]
    redirect = REDIRECT if lang == "en" else ""
    return f"""<!DOCTYPE html>
<html lang="{lang}">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>{h(APP)}</title>
<meta name="description" content="{h(t['tagline'])}">
{canonical(lang, 'index')}
{head_links('index')}
{redirect}<style>
{COMMON_CSS.format()}
  body {{ display:grid; place-items:center; min-height:100vh; text-align:center; padding:20px; box-sizing:border-box; }}
  .mark {{ width:80px; height:80px; margin:0 auto 16px; border-radius:20px; background:linear-gradient(135deg,#e8452c,#b3201a); color:#fff; display:grid; place-items:center; font-size:44px; font-weight:700; box-shadow:0 6px 20px rgba(200,50,30,.35); }}
  h1 {{ font-size:40px; margin:0 0 12px; color:var(--accent); font-weight:800; }}
  .tagline {{ max-width:520px; margin:0 auto 16px; }}
  .lang {{ margin:32px auto 0; max-width:560px; font-size:13px; line-height:1.9; }}
  .lang a {{ margin:0 6px; text-decoration:none; opacity:.7; white-space:nowrap; }}
  .lang a:hover {{ text-decoration:underline; opacity:1; }}
  .lang a[aria-current="page"] {{ font-weight:600; opacity:1; }}
</style>
</head>
<body>
<div>
  <div class="mark" aria-hidden="true">汉</div>
  <h1>{h(APP)}</h1>
  <p class="tagline">{h(t['tagline'])}</p>
  <p><a href="privacy.html">{h(t['privacy'])}</a></p>
  <p>{h(t['support'])} {EMAIL}</p>
{switcher(lang, 'index', '  ')}
</div>
</body>
</html>
"""


def privacy_page(lang):
    t = T[lang]
    apple = APPLE[lang]
    body = []
    body.append(f"    <h1>{h(t['title'])}</h1>")
    body.append(f'    <p class="muted">{h(t["updated"])}</p>')
    body.append(f"    <p>{h(t['intro'])}</p>")
    for hd, p in t["sections"]:
        p = h(p).replace("{a}", f'<a href="{apple}">').replace("{/a}", "</a>").replace("{email}", EMAIL)
        body.append("")
        body.append(f"    <h2>{h(hd)}</h2>")
        body.append(f"    <p>{p}</p>")
    body = "\n".join(body)
    return f"""<!DOCTYPE html>
<html lang="{lang}">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>{h(t['title'])}</title>
{canonical(lang, 'privacy')}
{head_links('privacy')}
<style>
{COMMON_CSS.format()}
  main {{ max-width:720px; margin:0 auto; padding:32px 20px 64px; }}
  .lang {{ display:flex; flex-wrap:wrap; gap:2px 12px; justify-content:flex-end; font-size:13px; }}
  .lang a {{ color:var(--muted); text-decoration:none; white-space:nowrap; }}
  .lang a:hover {{ color:var(--fg); text-decoration:underline; }}
  .lang a[aria-current="page"] {{ color:var(--accent); font-weight:600; }}
  h1 {{ font-size:32px; margin:24px 0 4px; }}
  h2 {{ font-size:20px; margin:28px 0 8px; }}
  .muted {{ color:var(--muted); font-size:15px; }}
  .home {{ margin-top:40px; font-size:15px; }}
</style>
</head>
<body>
<main>
{switcher(lang, 'privacy', '  ')}

  <section>
{body}
  </section>
  <p class="home"><a href="./">{h(APP)}</a></p>
</main>
</body>
</html>
"""


def main():
    here = os.path.dirname(os.path.abspath(__file__))
    site = sys.argv[1] if len(sys.argv) > 1 else os.path.join(here, "..", "site")
    site = os.path.abspath(site)
    count = 0
    for lang in LANGS:
        d = os.path.join(site, dir_of(lang))
        os.makedirs(d, exist_ok=True)
        for name, fn in (("index.html", index_page), ("privacy.html", privacy_page)):
            with open(os.path.join(d, name), "w", encoding="utf-8", newline="\n") as f:
                f.write(fn(lang))
            count += 1
    print(f"wrote {count} files to {site}")


if __name__ == "__main__":
    main()
