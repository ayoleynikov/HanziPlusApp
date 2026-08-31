#!/usr/bin/env python3
"""Add Journey attraction detail/tip keys and new modern spots."""
from __future__ import annotations

from merge_xcstrings import merge


def q(en: str, ru: str, es: str, pt: str) -> dict[str, str]:
    return {"en": en, "ru": ru, "es": es, "pt-BR": pt}


UI = {
    "journey.section.must_visit_subtitle": q(
        "Hand-illustrated guides to classic landmarks and modern must-sees. Tap a card for more.",
        "Нарисованные гиды по классике и современным местам. Нажмите на карточку, чтобы узнать больше.",
        "Guías ilustradas de lugares clásicos y modernos. Toca una tarjeta para saber más.",
        "Guias ilustradas de pontos clássicos e modernos. Toque em um cartão para saber mais.",
    ),
    "journey.attraction.era.classic": q("Classic", "Классика", "Clásico", "Clássico"),
    "journey.attraction.era.modern": q("Modern", "Современное", "Moderno", "Moderno"),
    "journey.attraction.era.timeless": q("Must-try", "Обязательно", "Imprescindible", "Imperdível"),
    "journey.attraction.about": q("About this place", "О месте", "Sobre este lugar", "Sobre este lugar"),
    "journey.attraction.tip_title": q("Visitor tip", "Совет путешественнику", "Consejo para visitantes", "Dica para visitantes"),
    "journey.attraction.read_more": q("Read more", "Подробнее", "Leer más", "Saiba mais"),
    "journey.attraction.tip_fallback": q(
        "Visit early morning or late afternoon for fewer crowds and softer light.",
        "Приходите рано утром или ближе к вечеру — меньше людей и мягче свет.",
        "Visita temprano por la mañana o al atardecer para evitar multitudes y disfrutar de mejor luz.",
        "Visite cedo de manhã ou no fim da tarde para evitar multidões e aproveitar uma luz mais suave.",
    ),
}

NEW_ATTRACTIONS = {
    "bj-a5": {
        "name": q("798 Art District", "Арт-квартал 798", "Distrito artístico 798", "Distrito artístico 798"),
        "description": q(
            "Former factory zone turned into galleries, cafés, and street art.",
            "Бывшие заводские корпуса, превращённые в галереи, кафе и уличное искусство.",
            "Antigua zona fabril convertida en galerías, cafés y arte callejero.",
            "Antiga zona fabril transformada em galerias, cafés e arte de rua.",
        ),
        "detail": q(
            "Once a Cold War–era electronics factory, 798 is now Beijing's creative heart. Red-brick workshops host contemporary art, design shops, and weekend markets. Murals cover entire walls, and indie cafés fill the courtyards between exhibitions.",
            "Когда-то завод эпохи холодной войны, сегодня 798 — творческое сердце Пекина. Краснокирпичные цеха с галереями, дизайнерскими магазинами и рынками по выходным. Фасады покрыты муралами, а дворики заполнены кофейнями.",
            "Antigua fábrica de la Guerra Fría, 798 es hoy el corazón creativo de Pekín. Talleres de ladrillo rojo albergan arte contemporáneo, diseño y mercados de fin de semana, con murales y cafés en los patios.",
            "Antiga fábrica da Guerra Fria, 798 é hoje o coração criativo de Pequim. Oficinas de tijolo vermelho abrigam arte contemporânea, design e mercados de fim de semana, com murais e cafés nos pátios.",
        ),
        "tip": q(
            "Go on a weekend for pop-up markets, but weekday mornings are best for quiet gallery visits.",
            "В выходные здесь ярмарки, но в будни утром в галереях спокойнее всего.",
            "Los fines de semana hay mercados, pero entre semana por la mañana las galerías están más tranquilas.",
            "Nos fins de semana há feiras, mas nas manhãs de dias úteis as galerias ficam mais tranquilas.",
        ),
    },
    "xa-a5": {
        "name": q("Tang Paradise", "Парк «Великий Тан»", "Tang Paradise", "Tang Paradise"),
        "description": q(
            "Immersive Tang-dynasty theme park with dazzling night lights.",
            "Тематический парк эпохи Тан с потрясающей ночной подсветкой.",
            "Parque temático de la dinastía Tang con espectaculares luces nocturnas.",
            "Parque temático da dinastia Tang com luzes noturnas deslumbrantes.",
        ),
        "detail": q(
            "Datang Everbright City recreates Chang'an, the Tang capital, with palaces, lakes, and costumed performances. After dark, millions of LEDs turn the park into a glowing open-air stage — popular with young travelers and photographers.",
            "Парк воссоздаёт столицу Тан — Чанъань: дворцы, озёра, представления в костюмах. После заката миллионы светодиодов превращают его в светящуюся сцену под открытым небом.",
            "Recrea Chang'an, la capital Tang, con palacios, lagos y espectáculos. Al anochecer, millones de LED convierten el parque en un escenario luminoso al aire libre.",
            "Recria Chang'an, a capital Tang, com palácios, lagos e apresentações. Ao anoitecer, milhões de LEDs transformam o parque em um palco luminoso ao ar livre.",
        ),
        "tip": q(
            "Book an evening slot and arrive before sunset to see the park transform from day to night.",
            "Берите вечерний билет и приходите до заката — увидите, как парк меняется с днём на ночь.",
            "Reserva entrada nocturna y llega antes del atardecer para ver la transformación del parque.",
            "Reserve ingresso noturno e chegue antes do pôr do sol para ver a transformação do parque.",
        ),
    },
    "cd-a5": {
        "name": q("Taikoo Li", "Тайкули", "Taikoo Li", "Taikoo Li"),
        "description": q(
            "Trendy open-air mall blending heritage courtyards with global brands.",
            "Модный открытый квартал, сочетающий старинные дворы и мировые бренды.",
            "Centro comercial al aire libre que mezcla patios patrimoniales y marcas globales.",
            "Shopping ao ar livre que combina pátios históricos e marcas globais.",
        ),
        "detail": q(
            "Built around the restored Daci Temple, Taikoo Li keeps Qing-era lanes while adding flagship stores, cocktail bars, and the famous IFS panda perched on the roof. It's where Chengdu's fashion crowd meets tea-house culture.",
            "Построен вокруг отреставрированного храма Дацзы: цинские переулки, флагманские магазины, коктейль-бары и знаменитая панда на крыше IFS. Здесь мода встречается с чайной культурой.",
            "Construido junto al templo Daci restaurado, combina callejuelas Qing con tiendas insignia, bares y la famosa panda del IFS. Donde la moda se encuentra con la cultura del té.",
            "Construído em torno do templo Daci restaurado, une becos Qing a lojas flagship, bares e a famosa panda do IFS. Onde a moda encontra a cultura do chá.",
        ),
        "tip": q(
            "Visit the temple courtyard first, then explore side alleys for local dessert shops.",
            "Сначала загляните во двор храма, затем — в боковые улочки с десертами.",
            "Visita primero el patio del templo y luego explora callejones con postres locales.",
            "Visite primeiro o pátio do templo e depois explore becos com sobremesas locais.",
        ),
    },
    "gy-a5": {
        "name": q("Guizhou Provincial Museum", "Провинциальный музей Гуйчжоу", "Museo Provincial de Guizhou", "Museu Provincial de Guizhou"),
        "description": q(
            "Striking modern museum showcasing Miao, Dong, and local heritage.",
            "Современный музей с экспозициями о культурах мяо, дун и Гуйчжоу.",
            "Museo moderno dedicado a las culturas miao, dong y el patrimonio local.",
            "Museu moderno dedicado às culturas miao, dong e ao patrimônio local.",
        ),
        "detail": q(
            "The museum's flowing white form echoes Guizhou's mountains. Inside, silver headdresses, batik textiles, and interactive exhibits explain the province's ethnic diversity — a perfect rainy-day stop before heading to villages.",
            "Белое здание напоминает горы провинции. Внутри — серебряные головные уборы, батик и интерактивные экспозиции о народах Гуйчжоу. Отличный план на дождливый день.",
            "Su forma blanca evoca las montañas de la provincia. En el interior, tocados de plata, batik y exposiciones interactivas explican la diversidad étnica — ideal para un día lluvioso.",
            "Sua forma branca lembra as montanhas da província. Por dentro, adornos de prata, batik e exposições interativas explicam a diversidade étnica — ideal para um dia chuvoso.",
        ),
        "tip": q(
            "Free entry with ID; allow 2 hours and pair it with a walk at nearby Huaxi Wetland.",
            "Вход бесплатный по документу; заложите 2 часа и совместите с прогулкой по Хуаси.",
            "Entrada gratuita con documento; dedica 2 horas y combínalo con Huaxi Wetland.",
            "Entrada gratuita com documento; reserve 2 horas e combine com o pântano de Huaxi.",
        ),
    },
    "gl-a5": {
        "name": q("Two Rivers & Four Lakes", "Два русла и четыре озера", "Dos ríos y cuatro lagos", "Dois rios e quatro lagos"),
        "description": q(
            "Lit-up waterways and bridges threading through downtown Guilin.",
            "Подсвеченные каналы и мосты в центре Гуйлиня.",
            "Canales iluminados y puentes en el centro de Guilin.",
            "Canais iluminados e pontes no centro de Guilin.",
        ),
        "detail": q(
            "This urban water system links the Li and Taohua rivers with four lakes. At night, golden lights reflect off pagodas and cypress trees — a relaxed alternative to countryside rafting when you stay in the city.",
            "Система связывает реки Ли и Таохуа с четырьмя озёрами. Ночью огни отражаются в воде у пагод и кипарисов — спокойная альтернатива рафтингу, если вы в городе.",
            "Une los ríos Li y Taohua con cuatro lagos. De noche, las luces doradas se reflejan en pagodas y cipreses — una alternativa tranquila al rafting rural.",
            "Liga os rios Li e Taohua a quatro lagos. À noite, luzes douradas refletem em pagodes e ciprestes — alternativa tranquila ao rafting no campo.",
        ),
        "tip": q(
            "Take an evening boat ride; the Riyue Twin Pagodas look best from the water.",
            "Вечерняя прогулка на лодке — пагоды Близнецов лучше всего видны с воды.",
            "Haz un paseo en barco al atardecer; las pagodas gemelas se ven mejor desde el agua.",
            "Faça um passeio de barco ao entardecer; as pagodes gêmeas ficam melhores da água.",
        ),
    },
    "sh-a5": {
        "name": q("West Bund", "Вест Бунд", "West Bund", "West Bund"),
        "description": q(
            "Riverside art museums, design fairs, and creative waterfront walks.",
            "Набережная с музеями, ярмарками дизайна и творческими прогулками.",
            "Museos de arte, ferias de diseño y paseos creativos junto al río.",
            "Museus de arte, feiras de design e passeios criativos à beira do rio.",
        ),
        "detail": q(
            "Shanghai's West Bund turned old industrial docks into a museum mile. The Centre Pompidou partnership, Long Museum, and seasonal art fairs draw global creatives — with coffee shops facing the Huangpu River.",
            "Бывшие причалы превратились в «музейную милю»: Centre Pompidou, Long Museum, сезонные ярмарки и кофейни с видом на Хуанпу.",
            "Antiguos muelles industriales convertidos en una milla de museos: Centre Pompidou, Long Museum, ferias estacionales y cafés frente al Huangpu.",
            "Antigos cais industriais viraram uma milha de museus: Centre Pompidou, Long Museum, feiras sazonais e cafés de frente para o Huangpu.",
        ),
        "tip": q(
            "Check the events calendar — many exhibitions and markets are free on weekends.",
            "Смотрите афишу — многие выставки и ярмарки по выходным бесплатны.",
            "Consulta el calendario de eventos: muchas exposiciones y mercados son gratis los fines de semana.",
            "Confira o calendário de eventos — muitas exposições e feiras são gratuitas nos fins de semana.",
        ),
    },
    "hz-a5": {
        "name": q("Qianjiang CBD", "Цяньцзян СБД", "CBD de Qianjiang", "CBD de Qianjiang"),
        "description": q(
            "Hangzhou's futuristic skyline beside the Qiantang River.",
            "Футуристическая панорама Ханчжоу у реки Цяньтан.",
            "El horizonte futurista de Hangzhou junto al río Qiantang.",
            "O horizonte futurista de Hangzhou às margens do rio Qiantang.",
        ),
        "detail": q(
            "Home to the golden InterContinental and wave-shaped civic center, Qianjiang New Town shows Hangzhou beyond West Lake. Light shows on the river and wide pedestrian plazas make it a favorite evening stroll.",
            "Золотой InterContinental и волнообразный центр — Ханчжоу за пределами Западного озера. Световые шоу на реке и широкие площади для вечерних прогулок.",
            "El InterContinental dorado y el centro cívico ondulado muestran Hangzhou más allá del Lago del Oeste, con espectáculos de luz en el río.",
            "O InterContinental dourado e o centro cívico ondulado mostram Hangzhou além do Lago Ocidental, com shows de luz no rio.",
        ),
        "tip": q(
            "Visit on a clear evening after rain — the glass towers reflect dramatic clouds.",
            "Приходите вечером после дождя — стеклянные башни отражают облака.",
            "Visita una tarde despejada tras la lluvia: las torres de cristal reflejan nubes dramáticas.",
            "Visite numa noite clara após a chuva — as torres de vidro refletem nuvens dramáticas.",
        ),
    },
    "sz-a5": {
        "name": q("Jinji Lake", "Озеро Цзиньцзи", "Lago Jinji", "Lago Jinji"),
        "description": q(
            "Modern lakeside district with the iconic Suzhou Center skyline.",
            "Современный район у озера с панорамой Suzhou Center.",
            "Distrito moderno junto al lago con el horizonte del Suzhou Center.",
            "Distrito moderno à beira do lago com o horizonte do Suzhou Center.",
        ),
        "detail": q(
            "Suzhou's SIP district balances classical gardens with a contemporary core. Jinji Lake offers cycling paths, lakeside concerts, and the twisted Suzhou Center tower — proof the city innovates while honoring tradition.",
            "Район SIP сочетает классические сады с современным ядром: велодорожки, концерты у воды и башня Suzhou Center — город развивается, сохраняя традиции.",
            "El distrito SIP equilibra jardines clásicos con un núcleo contemporáneo: ciclovías, conciertos junto al lago y la torre Suzhou Center.",
            "O distrito SIP equilibra jardins clássicos com um núcleo contemporâneo: ciclovias, concertos à beira do lago e a torre Suzhou Center.",
        ),
        "tip": q(
            "Rent a bike and circle the lake; the music fountain show runs on weekends.",
            "Возьмите велосипед и объедьте озеро; по выходным работает музыкальный фонтан.",
            "Alquila una bici y rodea el lago; los fines de semana hay espectáculo de fuentes.",
            "Alugue uma bicicleta e contorne o lago; nos fins de semana há show de fontes.",
        ),
    },
    "hb-a5": {
        "name": q("Harbin Opera House", "Харбинский оперный театр", "Ópera de Harbin", "Ópera de Harbin"),
        "description": q(
            "Sweeping contemporary architecture on the Songhua River.",
            "Волнообразная современная архитектура на берегу Сунгари.",
            "Arquitectura contemporánea de líneas fluidas junto al río Songhua.",
            "Arquitetura contemporânea de linhas fluidas às margens do rio Songhua.",
        ),
        "detail": q(
            "Designed by MAD Architects, the opera house looks like snow dunes frozen mid-wind. White aluminum panels curve around two concert halls, offering river views from the rooftop walkway.",
            "Проект MAD Architects напоминает застывшие снежные дюны. Белый алюминий обволакивает два концертных зала, с крыши открывается вид на Сунгари.",
            "Diseñada por MAD Architects, parece dunas de nieve congeladas. Paneles blancos envuelven dos salas de conciertos con vistas al río desde la azotea.",
            "Projetada pela MAD Architects, parece dunas de neve congeladas. Painéis brancos envolvem duas salas de concerto com vista para o rio no terraço.",
        ),
        "tip": q(
            "Even without a show ticket, the exterior plaza is open for photos — dress warmly in winter.",
            "Даже без билета на спектакль можно гулять у здания — зимой одевайтесь теплее.",
            "Aunque no tengas entrada, la plaza exterior es ideal para fotos — abrígate bien en invierno.",
            "Mesmo sem ingresso, a praça externa é ótima para fotos — agasalhe-se bem no inverno.",
        ),
    },
    "gz-a5": {
        "name": q("Zhujiang New Town", "Новый город Чжуцзян", "Nueva Ciudad de Zhujiang", "Nova Cidade de Zhujiang"),
        "description": q(
            "Guangzhou's sleek CBD of towers, malls, and riverside light shows.",
            "Стильный деловой район с башнями, торговыми центрами и световыми шоу у реки.",
            "El elegante CBD de Cantón con torres, centros comerciales y espectáculos de luz junto al río.",
            "O elegante CBD de Guangzhou com torres, shoppings e shows de luz à beira do rio.",
        ),
        "detail": q(
            "Zhujiang New Town clusters IFC, K11 art mall, and the Guangzhou Library. Every evening the Pearl River light show syncs skyscraper LEDs — best viewed from Haixinsha Island.",
            "Здесь IFC, арт-молл K11 и библиотека. Каждый вечер световое шоу на Жемчужной реке синхронизирует небоскрёбы — лучший вид с острова Хайсинша.",
            "Reúne IFC, el centro K11 y la biblioteca. Cada noche el espectáculo de luces del río de las Perlas sincroniza los LED de los rascacielos — mejor vista desde Haixinsha.",
            "Reúne IFC, o shopping K11 e a biblioteca. Toda noite o show de luzes do Rio das Pérolas sincroniza os LEDs dos arranha-céus — melhor vista da ilha Haixinsha.",
        ),
        "tip": q(
            "Take Metro Line 3 to Zhujiang New Town; arrive 30 minutes before the river light show.",
            "Метро линия 3 до Zhujiang New Town; приезжайте за 30 минут до светового шоу.",
            "Toma la línea 3 de metro hasta Zhujiang New Town; llega 30 minutos antes del espectáculo.",
            "Pegue o metrô linha 3 até Zhujiang New Town; chegue 30 minutos antes do show.",
        ),
    },
    "szh-a5": {
        "name": q("Design Society", "Design Society", "Design Society", "Design Society"),
        "description": q(
            "Cutting-edge design museum in Shekou by the sea.",
            "Передовой музей дизайна в Шэкоу у моря.",
            "Museo de diseño de vanguardia en Shekou, junto al mar.",
            "Museu de design de vanguarda em Shekou, à beira-mar.",
        ),
        "detail": q(
            "A partnership with London's V&A Museum, Design Society hosts rotating exhibitions on architecture, fashion, and tech. The sea-facing terrace and Sea World nightlife district are steps away.",
            "Партнёрство с лондонским V&A: выставки об архитектуре, моде и технологиях. Рядом терраса с видом на море и ночной район Sea World.",
            "En colaboración con el V&A de Londres, expone arquitectura, moda y tecnología. La terraza frente al mar y el distrito nocturno Sea World están a un paso.",
            "Em parceria com o V&A de Londres, expõe arquitetura, moda e tecnologia. O terraço de frente para o mar e o distrito noturno Sea World ficam ao lado.",
        ),
        "tip": q(
            "Combine with a sunset walk at Shekou Sea World — many cafés have harbor views.",
            "Совместите с закатом в Sea World — во многих кафе вид на гавань.",
            "Combínalo con un paseo al atardecer en Sea World: muchos cafés tienen vistas al puerto.",
            "Combine com um pôr do sol no Sea World — muitos cafés têm vista para o porto.",
        ),
    },
    "hk-a5": {
        "name": q("M+ Museum", "Музей M+", "Museo M+", "Museu M+"),
        "description": q(
            "Asia's flagship museum of visual culture in West Kowloon.",
            "Главный музей визуальной культуры Азии в Вест Коулуне.",
            "El principal museo de cultura visual de Asia en West Kowloon.",
            "O principal museu de cultura visual da Ásia em West Kowloon.",
        ),
        "detail": q(
            "M+ opened in West Kowloon Cultural District with a bold terracotta-hued facade. Collections span Chinese contemporary art, design, architecture, and moving image — with Victoria Harbour views from the rooftop garden.",
            "Открылся в культурном районе Вест Коулун с терракотовым фасадом. Коллекции — от современного китайского искусства до дизайна и кино, с садом на крыше и видом на гавань.",
            "Inaugurado en West Kowloon con una fachada terracota audaz. Colecciones de arte chino contemporáneo, diseño y cine, con jardín en la azotea y vistas al puerto.",
            "Inaugurado em West Kowloon com fachada terracota ousada. Coleções de arte chinesa contemporânea, design e cinema, com jardim no terraço e vista para o porto.",
        ),
        "tip": q(
            "Reserve tickets online for weekends; the harbour-side Art Park is free and perfect at sunset.",
            "На выходные билеты лучше брать онлайн; прибрежный Art Park бесплатен и красив на закате.",
            "Reserva entradas online para fines de semana; el Art Park junto al puerto es gratis y ideal al atardecer.",
            "Reserve ingressos online para fins de semana; o Art Park à beira do porto é gratuito e ideal no pôr do sol.",
        ),
    },
}

# Detail/tip for existing attractions (keyed by id suffix from catalog)
EXISTING_EXTRAS = {
    "bj-a1": {
        "detail": q(
            "Built from 1406 to 1420, the Forbidden City served 24 emperors. Vermilion walls, golden roofs, and ceremonial halls stretch across 72 hectares — plan at least half a day for the main axis and side courtyards.",
            "Строился с 1406 по 1420 год, здесь жили 24 императора. Алые стены, золотые крыши и церемониальные залы на 72 гектарах — заложите минимум полдня.",
            "Construida entre 1406 y 1420, albergó a 24 emperadores. Muros bermellón, techos dorados y salas ceremoniales en 72 hectáreas — reserva al menos medio día.",
            "Construída entre 1406 e 1420, abrigou 24 imperadores. Muros vermelhos, telhados dourados e salões cerimoniais em 72 hectares — reserve pelo menos meio dia.",
        ),
        "tip": q("Enter from Tiananmen West early; audio guide helps decode hall names.", "Входите с западной стороны Тяньаньмэнь утром; аудиогид поможет с названиями залов.", "Entra por Tiananmen Oeste temprano; una audioguía ayuda con los nombres de los salones.", "Entre pelo Tiananmen Oeste cedo; um audioguia ajuda com os nomes dos salões."),
    },
    "bj-a2": {
        "detail": q(
            "Mutianyu and Badaling are the most visited sections near Beijing. Watchtowers climb ridge after ridge — spring blossoms and autumn foliage make the most photogenic seasons.",
            "Мутяньюй и Бадалин — популярнейшие участки у Пекина. Сторожевые башни тянутся по гребням; весна и осень — лучшее время для фото.",
            "Mutianyu y Badaling son las secciones más visitadas cerca de Pekín. Las torres de vigilancia suben cresta tras cresta; primavera y otoño son las mejores estaciones.",
            "Mutianyu e Badaling são as seções mais visitadas perto de Pequim. As torres de vigia sobem crista após crista; primavera e outono são as melhores estações.",
        ),
        "tip": q("Weekday mornings mean shorter cable-car queues at Mutianyu.", "В будни утром очереди на канатку в Мутяньюй короче.", "Entre semana por la mañana hay menos cola en el teleférico de Mutianyu.", "Nos dias úteis de manhã a fila do teleférico de Mutianyu é menor."),
    },
}


def expand_existing_from_catalog() -> dict:
    """Disabled — full attraction detail/tip copy lives in journey_cities_rewrite.py."""
    return {}


def main() -> None:
    strings = dict(UI)
    for aid, fields in NEW_ATTRACTIONS.items():
        strings[f"journey.attraction.{aid}.name"] = fields["name"]
        strings[f"journey.attraction.{aid}.description"] = fields["description"]
        strings[f"journey.attraction.{aid}.detail"] = fields["detail"]
        strings[f"journey.attraction.{aid}.tip"] = fields["tip"]
    strings.update(expand_existing_from_catalog())
    added = merge(strings)
    print(f"Merged {len(strings)} attraction extras ({added} newly added)")


if __name__ == "__main__":
    main()
