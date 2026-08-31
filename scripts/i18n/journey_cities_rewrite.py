#!/usr/bin/env python3
"""Rewrite Journey city, fact, and attraction copy into Localizable.xcstrings."""
from __future__ import annotations

from merge_xcstrings import merge


def q(en: str, ru: str, es: str, pt: str) -> dict[str, str]:
    return {"en": en, "ru": ru, "es": es, "pt-BR": pt}


def city(
    cid: str,
    *,
    introduction: dict,
    famous_for: dict,
    population: dict,
    best_season: dict,
    local_food: dict,
    local_achievement: dict,
    souvenir_name: dict,
) -> dict[str, dict[str, str]]:
    return {
        f"journey.city.{cid}.introduction": introduction,
        f"journey.city.{cid}.famousFor": famous_for,
        f"journey.city.{cid}.population": population,
        f"journey.city.{cid}.bestSeason": best_season,
        f"journey.city.{cid}.localFood": local_food,
        f"journey.city.{cid}.localAchievement": local_achievement,
        f"journey.city.{cid}.souvenirName": souvenir_name,
    }


def attraction(
    aid: str,
    *,
    name: dict,
    description: dict,
    detail: dict,
    tip: dict,
) -> dict[str, dict[str, str]]:
    return {
        f"journey.attraction.{aid}.name": name,
        f"journey.attraction.{aid}.description": description,
        f"journey.attraction.{aid}.detail": detail,
        f"journey.attraction.{aid}.tip": tip,
    }


CITIES: dict[str, dict[str, dict[str, str]]] = {}

CITIES.update(city(
    "beijing",
    introduction=q(
        "Imperial palaces, hutong lanes, and 3,000 years of stories — Beijing pulls you in fast.",
        "Императорские дворцы, хутуны и три тысячи лет истории — Пекин затягивает с первых шагов.",
        "Palacios imperiales, hutongs y tres mil años de historias: Pekín te atrapa al instante.",
        "Palácios imperiais, hutongs e três mil anos de histórias — Pequim prende você na hora.",
    ),
    famous_for=q(
        "Forbidden City, Great Wall, and Peking opera",
        "Запретный город, Великая стена и пекинская опера",
        "Ciudad Prohibida, Gran Muralla y ópera de Pekín",
        "Cidade Proibida, Grande Muralha e ópera de Pequim",
    ),
    population=q("21.5 million", "21,5 млн", "21,5 millones", "21,5 milhões"),
    best_season=q(
        "September – October (crisp autumn skies)",
        "Сентябрь – октябрь (ясная осенняя погода)",
        "Septiembre – octubre (cielos otoñales despejados)",
        "Setembro – outubro (céu limpo de outono)",
    ),
    local_food=q(
        "Peking duck, jianbing, zhajiangmian",
        "Утка по-пекински, цзяньбин, лапша чжацзянмянь",
        "Pato pekinés, jianbing y fideos zhajiangmian",
        "Pato à pequinesa, jianbing e macarrão zhajiangmian",
    ),
    local_achievement=q("Capital Explorer", "Исследователь столицы", "Explorador de la capital", "Explorador da capital"),
    souvenir_name=q("Lantern", "Фонарик", "Farolillo", "Lanterna"),
))

CITIES.update(city(
    "xian",
    introduction=q(
        "Thirteen dynasties left their mark here — and 8,000 clay soldiers still stand guard.",
        "Здесь правили тринадцать династий — и восемь тысяч глиняных воинов до сих пор стоят на страже.",
        "Trece dinastías dejaron huella aquí, y ocho mil soldados de arcilla siguen de guardia.",
        "Treze dinastias marcaram este lugar — e oito mil soldados de argila ainda guardam a cidade.",
    ),
    famous_for=q(
        "Terracotta Army, city walls, and Muslim Quarter food",
        "Терракотовая армия, городская стена и еда Мусульманского квартала",
        "Ejército de terracota, murallas y comida del Barrio Musulmán",
        "Exército de terracota, muralhas e comida do Bairro Muçulmano",
    ),
    population=q("13 million", "13 млн", "13 millones", "13 milhões"),
    best_season=q(
        "March – May & September – November",
        "Март – май и сентябрь – ноябрь",
        "Marzo – mayo y septiembre – noviembre",
        "Março – maio e setembro – novembro",
    ),
    local_food=q(
        "Biang biang noodles, roujiamo, yangrou paomo",
        "Лапша biang biang, roujiamo, ягнёнок в paomo",
        "Fideos biang biang, roujiamo y yangrou paomo",
        "Macarrão biang biang, roujiamo e yangrou paomo",
    ),
    local_achievement=q("Silk Road Scholar", "Знаток Шёлкового пути", "Erudito de la Ruta de la Seda", "Estudioso da Rota da Seda"),
    souvenir_name=q("Terracotta Warrior", "Терракотовый воин", "Guerrero de terracota", "Guerreiro de terracota"),
))

CITIES.update(city(
    "chengdu",
    introduction=q(
        "Pandas nap in the bamboo, tea houses hum with mahjong — Chengdu knows how to slow down.",
        "Панды дремлют в бамбуке, в чайных стучат костяшки маджонга — в Чэнду умеют не спешить.",
        "Pandas duermen entre bambúes y las casas de té suenan a mahjong: Chengdú sabe ir despacio.",
        "Pandas cochilam no bambu e casas de chá vibram com mahjong — Chengdu sabe desacelerar.",
    ),
    famous_for=q(
        "Giant pandas, spicy hot pot, and tea-house culture",
        "Большие панды, острый хого и чайные",
        "Pandas gigantes, hot pot picante y casas de té",
        "Pandas-gigantes, hot pot picante e casas de chá",
    ),
    population=q("21 million", "21 млн", "21 millones", "21 milhões"),
    best_season=q(
        "March – June & September – November",
        "Март – июнь и сентябрь – ноябрь",
        "Marzo – junio y septiembre – noviembre",
        "Março – junho e setembro – novembro",
    ),
    local_food=q(
        "Mapo tofu, hot pot, dan dan noodles",
        "Mapo doufu, хого, лапша dan dan",
        "Mapo tofu, hot pot y fideos dan dan",
        "Mapo tofu, hot pot e macarrão dan dan",
    ),
    local_achievement=q("Panda Friend", "Друг панд", "Amigo de los pandas", "Amigo dos pandas"),
    souvenir_name=q("Panda", "Панда", "Panda", "Panda"),
))

CITIES.update(city(
    "guiyang",
    introduction=q(
        "Cool mountain air, misty karst peaks, and noodles that bite back — welcome to Guizhou's capital.",
        "Прохладный горный воздух, туманные карсты и острая лапша — столица Гуйчжоу ждёт вас.",
        "Aire fresco de montaña, picos kársticos entre la niebla y fideos con carácter: bienvenido a la capital de Guizhou.",
        "Ar fresco de montanha, picos cársticos na névoa e macarrão picante — bem-vindo à capital de Guizhou.",
    ),
    famous_for=q(
        "Cool summers, karst landscapes, and Miao & Dong cultures",
        "Прохладное лето, карстовые пейзажи и культуры мяо и дун",
        "Veranos frescos, paisajes kársticos y culturas miao y dong",
        "Verões frescos, paisagens cársticas e culturas miao e dong",
    ),
    population=q("About 6 million", "Около 6 млн", "Unos 6 millones", "Cerca de 6 milhões"),
    best_season=q("March – October", "Март – октябрь", "Marzo – octubre", "Março – outubro"),
    local_food=q(
        "Sour soup fish, siwawa, changwang noodles",
        "Рыба в кислом супе, siwawa, лапша changwang",
        "Pescado en sopa agria, siwawa y fideos changwang",
        "Peixe na sopa azeda, siwawa e macarrão changwang",
    ),
    local_achievement=q("Highland Explorer", "Исследователь нагорья", "Explorador de las tierras altas", "Explorador das terras altas"),
    souvenir_name=q("Waterfall Crystal", "Кристалл водопада", "Cristal de cascada", "Cristal da cachoeira"),
))

CITIES.update(city(
    "guilin",
    introduction=q(
        "Karst peaks rise from the Li River like a living scroll — no filter needed.",
        "Карстовые вершины поднимаются из реки Ли, словно живой свиток — фильтры не нужны.",
        "Picos kársticos emergen del río Li como un pergamino vivo: no hace falta filtro.",
        "Picos cársticos surgem do rio Li como um pergaminho vivo — sem filtro.",
    ),
    famous_for=q(
        "Li River cruises, Yangshuo countryside, and rice terraces",
        "Круизы по реке Ли, Яншо и рисовые террасы",
        "Cruceros por el río Li, campo de Yangshuo y arrozales en terrazas",
        "Cruzeiros no rio Li, interior de Yangshuo e terraços de arroz",
    ),
    population=q("4.9 million", "4,9 млн", "4,9 millones", "4,9 milhões"),
    best_season=q("April – October", "Апрель – октябрь", "Abril – octubre", "Abril – outubro"),
    local_food=q(
        "Guilin rice noodles, beer fish, stuffed snails",
        "Лапша Guilin mi fen, рыба в пиве, фаршированные улитки",
        "Fideos de arroz de Guilin, pescado a la cerveza y caracoles rellenos",
        "Macarrão de arroz de Guilin, peixe na cerveja e caracóis recheados",
    ),
    local_achievement=q("River Wanderer", "Странник у реки", "Nómada del río", "Viajante do rio"),
    souvenir_name=q("Karst Peaks", "Карстовые вершины", "Picos kársticos", "Picos cársticos"),
))

CITIES.update(city(
    "shanghai",
    introduction=q(
        "Art Deco meets sci-fi skyline — Shanghai never stands still.",
        "Ар-деко встречается с фантастической панорамой — Шанхай никогда не замирает.",
        "Art déco y un horizonte de ciencia ficción: Shanghái nunca se detiene.",
        "Art déco encontra um horizonte futurista — Xangai nunca para.",
    ),
    famous_for=q(
        "The Bund, Pudong towers, and the maglev train",
        "Набережная Бунд, башни Пудуна и поезд на магнитной подушке",
        "El Bund, torres de Pudong y tren maglev",
        "O Bund, torres de Pudong e trem maglev",
    ),
    population=q("24.9 million", "24,9 млн", "24,9 millones", "24,9 milhões"),
    best_season=q(
        "March – May & September – November",
        "Март – май и сентябрь – ноябрь",
        "Marzo – mayo y septiembre – noviembre",
        "Março – maio e setembro – novembro",
    ),
    local_food=q(
        "Xiaolongbao, shengjianbao, hairy crab",
        "Сяолунбао, шэнцзяньбао, мохнатый краб",
        "Xiaolongbao, shengjianbao y cangrejo peludo",
        "Xiaolongbao, shengjianbao e caranguejo peludo",
    ),
    local_achievement=q("Metro Master", "Мастер метро", "Maestro del metro", "Mestre do metrô"),
    souvenir_name=q("Skyline", "Панорама города", "Horizonte", "Horizonte"),
))

CITIES.update(city(
    "hangzhou",
    introduction=q(
        "West Lake shimmers at dawn, Longjing tea steams by noon — Hangzhou is poetry you can walk through.",
        "Западное озеро мерцает на рассвете, чай лунцзин парит к полудню — Ханчжоу похож на стихи, по которым можно гулять.",
        "El Lago del Oeste brilla al amanecer y el té Longjing humea al mediodía: Hangzhou es poesía para caminar.",
        "O Lago Ocidental brilha ao amanhecer e o chá Longjing fuma ao meio-dia — Hangzhou é poesia para caminhar.",
    ),
    famous_for=q(
        "West Lake, Longjing tea, and silk",
        "Западное озеро, чай лунцзин и шёлк",
        "Lago del Oeste, té Longjing y seda",
        "Lago Ocidental, chá Longjing e seda",
    ),
    population=q("12.3 million", "12,3 млн", "12,3 millones", "12,3 milhões"),
    best_season=q(
        "March – May & September – October",
        "Март – май и сентябрь – октябрь",
        "Marzo – mayo y septiembre – octubre",
        "Março – maio e setembro – outubro",
    ),
    local_food=q(
        "West Lake fish, dongpo pork, Longjing shrimp",
        "Рыба Западного озера, свинина dongpo, креветки с лунцзин",
        "Pescado del Lago del Oeste, cerdo dongpo y gambas Longjing",
        "Peixe do Lago Ocidental, porco dongpo e camarões Longjing",
    ),
    local_achievement=q("West Lake Poet", "Поэт Западного озера", "Poeta del Lago del Oeste", "Poeta do Lago Ocidental"),
    souvenir_name=q("Longjing Tea", "Чай лунцзин", "Té Longjing", "Chá Longjing"),
))

CITIES.update(city(
    "suzhou",
    introduction=q(
        "Canals, classical gardens, and silk threads finer than hair — Suzhou is China's quiet masterpiece.",
        "Каналы, классические сады и шёлковые нити тоньше волоса — Сучжоу, тихий шедевр Китая.",
        "Canales, jardines clásicos e hilos de seda más finos que un cabello: Suzhou es la obra maestra serena de China.",
        "Canais, jardins clássicos e fios de seda mais finos que cabelo — Suzhou é a obra-prima tranquila da China.",
    ),
    famous_for=q(
        "Classical gardens, canal lanes, and silk embroidery",
        "Классические сады, каналы и шёлковая вышивка",
        "Jardines clásicos, calles junto a canales y bordado en seda",
        "Jardins clássicos, ruas à beira de canal e bordado em seda",
    ),
    population=q("12.7 million", "12,7 млн", "12,7 millones", "12,7 milhões"),
    best_season=q(
        "March – May & September – November",
        "Март – май и сентябрь – ноябрь",
        "Marzo – mayo y septiembre – noviembre",
        "Março – maio e setembro – novembro",
    ),
    local_food=q(
        "Squirrel mandarin fish, biluochun tea, sweet osmanthus cake",
        "Рыба «белка», чай билочунь, пирог с османтусом",
        "Pescado mandarín en forma de ardilla, té biluochun y pastel de osmanthus",
        "Peixe mandarim esquilo, chá biluochun e bolo de osmanto",
    ),
    local_achievement=q("Garden Poet", "Поэт садов", "Poeta de jardines", "Poeta dos jardins"),
    souvenir_name=q("Silk Fan", "Шёлковый веер", "Abanico de seda", "Leque de seda"),
))

CITIES.update(city(
    "harbin",
    introduction=q(
        "When winter hits −30°C, Harbin builds a city of ice — and the world shows up to stare.",
        "Когда мороз опускается до −30 °C, Харбин строит город изо льда — и весь мир приезжает смотреть.",
        "Cuando el invierno baja a −30 °C, Harbin levanta una ciudad de hielo y el mundo acude a mirar.",
        "Quando o inverno chega a −30 °C, Harbin ergue uma cidade de gelo — e o mundo vem ver.",
    ),
    famous_for=q(
        "Ice Festival, Russian architecture, and winter sports",
        "Ледовый фестиваль, русская архитектура и зимний спорт",
        "Festival del Hielo, arquitectura rusa y deportes de invierno",
        "Festival do Gelo, arquitetura russa e esportes de inverno",
    ),
    population=q("10 million", "10 млн", "10 millones", "10 milhões"),
    best_season=q(
        "December – February (Ice Festival)",
        "Декабрь – февраль (Ледовый фестиваль)",
        "Diciembre – febrero (Festival del Hielo)",
        "Dezembro – fevereiro (Festival do Gelo)",
    ),
    local_food=q(
        "Guo bao rou, Harbin sausage, frozen pear",
        "Guo bao rou, харбинская колбаса, замороженная груша",
        "Guo bao rou, salchicha de Harbin y pera helada",
        "Guo bao rou, linguiça de Harbin e pera congelada",
    ),
    local_achievement=q("Ice Explorer", "Ледяной исследователь", "Explorador del hielo", "Explorador do gelo"),
    souvenir_name=q("Ice Crystal", "Ледяной кристалл", "Cristal de hielo", "Cristal de gelo"),
))

CITIES.update(city(
    "guangzhou",
    introduction=q(
        "Steam rises from bamboo baskets at dawn — Guangzhou runs on dim sum and Pearl River energy.",
        "На рассвете над бамбуковыми корзинками поднимается пар — Гуанчжоу живёт димсамом и энергией Жемчужной реки.",
        "Al amanecer sube el vapor de las cestas de bambú: Cantón funciona a dim sum y energía del río de las Perlas.",
        "Ao amanhecer o vapor sobe das cestas de bambu — Guangzhou vive de dim sum e da energia do Rio das Pérolas.",
    ),
    famous_for=q(
        "Dim sum, Canton Tower, and Cantonese trade history",
        "Димсам, Canton Tower и торговая история Кантона",
        "Dim sum, Torre de Cantón e historia comercial cantonesa",
        "Dim sum, Torre de Cantão e história comercial cantonesa",
    ),
    population=q("About 19 million", "Около 19 млн", "Unos 19 millones", "Cerca de 19 milhões"),
    best_season=q("October – December", "Октябрь – декабрь", "Octubre – diciembre", "Outubro – dezembro"),
    local_food=q(
        "Dim sum, char siu, wonton noodles",
        "Димсам, char siu, лапша с вонтонами",
        "Dim sum, char siu y fideos wonton",
        "Dim sum, char siu e macarrão wonton",
    ),
    local_achievement=q("Cantonese Gourmet", "Знаток кантонской кухни", "Gourmet cantonés", "Gourmet cantonês"),
    souvenir_name=q("Dim Sum Teapot", "Чайник для димсама", "Tetera de dim sum", "Bule de dim sum"),
))

CITIES.update(city(
    "shenzhen",
    introduction=q(
        "Forty years ago it was a fishing village — now Shenzhen builds the future before your eyes.",
        "Сорок лет назад здесь была рыбацкая деревня — сегодня Шэньчжэнь строит будущее на ваших глазах.",
        "Hace cuarenta años era un pueblo pesquero; hoy Shenzhen construye el futuro ante tus ojos.",
        "Há quarenta anos era uma vila de pescadores — hoje Shenzhen constrói o futuro diante dos seus olhos.",
    ),
    famous_for=q(
        "Tech innovation, skyscrapers, and Shenzhen Bay",
        "Технологии, небоскрёбы и залив Шэньчжэнь",
        "Innovación tecnológica, rascacielos y bahía de Shenzhen",
        "Inovação tecnológica, arranha-céus e Baía de Shenzhen",
    ),
    population=q("About 18 million", "Около 18 млн", "Unos 18 millones", "Cerca de 18 milhões"),
    best_season=q("October – April", "Октябрь – апрель", "Octubre – abril", "Outubro – abril"),
    local_food=q(
        "Coconut chicken, Cantonese seafood, rice rolls",
        "Курица с кокосом, кантонские морепродукты, рисовые рулетики",
        "Pollo con coco, marisco cantonés y rollos de arroz",
        "Frango com coco, frutos do mar cantoneses e rolinhos de arroz",
    ),
    local_achievement=q("Future Builder", "Создатель будущего", "Constructor del futuro", "Construtor do futuro"),
    souvenir_name=q("Innovation Robot", "Робот-инноватор", "Robot de innovación", "Robô da inovação"),
))

CITIES.update(city(
    "hongkong",
    introduction=q(
        "Neon, harbor breeze, and dumplings at midnight — Hong Kong never really sleeps.",
        "Неон, морской бриз и пельмени в полночь — Гонконг по-настоящему не спит.",
        "Neón, brisa del puerto y dumplings a medianoche: Hong Kong nunca duerme del todo.",
        "Neon, brisa do porto e dumplings à meia-noite — Hong Kong nunca dorme de verdade.",
    ),
    famous_for=q(
        "Victoria Harbour, dim sum, and skyline views",
        "Гавань Виктория, димсам и панорама небоскрёбов",
        "Puerto Victoria, dim sum y vistas del horizonte",
        "Porto Victoria, dim sum e vista do horizonte",
    ),
    population=q("7.5 million", "7,5 млн", "7,5 millones", "7,5 milhões"),
    best_season=q("October – December", "Октябрь – декабрь", "Octubre – diciembre", "Outubro – dezembro"),
    local_food=q(
        "Dim sum, egg tarts, pineapple bun",
        "Димсам, яичные пирожные, ананасовая булочка",
        "Dim sum, tartas de huevo y bollo de piña",
        "Dim sum, tarte de ovo e pão de abacaxi",
    ),
    local_achievement=q("Harbor Voyager", "Морской путешественник", "Navegante del puerto", "Viajante do porto"),
    souvenir_name=q("Star Ferry", "Паром Star Ferry", "Star Ferry", "Star Ferry"),
))


FACTS: dict[str, dict[str, str]] = {
    "journey.fact.bj1": q(
        "The Forbidden City has nearly 9,000 rooms — yet no one knows the exact count.",
        "В Запретном городе почти 9 000 комнат — точное число до сих пор неизвестно.",
        "La Ciudad Prohibida tiene casi 9000 habitaciones, pero nadie sabe el número exacto.",
        "A Cidade Proibida tem quase 9 mil cômodos — ninguém sabe a contagem exata.",
    ),
    "journey.fact.bj2": q(
        "The Great Wall would stretch from Beijing to Paris if laid in a straight line.",
        "Если вытянуть Великую стену в линию, она дотянется от Пекина до Парижа.",
        "Si la Gran Muralla fuera recta, llegaría de Pekín a París.",
        "Se a Grande Muralha fosse reta, iria de Pequim a Paris.",
    ),
    "journey.fact.bj3": q(
        "Beijing opera performers train for years before painting their first face mask.",
        "Артисты пекинской оперы годами учатся, прежде чем нанести первую маску.",
        "Los artistas de la ópera de Pekín entrenan años antes de pintar su primera máscara.",
        "Artistas da ópera de Pequim treinam anos antes de pintar a primeira máscara.",
    ),
    "journey.fact.xa1": q(
        "Every Terracotta Warrior has a unique face — no two are alike.",
        "У каждого терракотового воина своё лицо — двух одинаковых не найти.",
        "Cada guerrero de terracota tiene un rostro único: no hay dos iguales.",
        "Cada guerreiro de terracota tem um rosto único — não há dois iguais.",
    ),
    "journey.fact.xa2": q(
        "Silk caravans once left Xi'an carrying spices west and gold east.",
        "Отсюда когда-то уходили караваны со специями на запад и золотом на восток.",
        "Caravanas de seda salían de Xi'an con especias al oeste y oro al este.",
        "Caravanas de seda saíam de Xi'an com especiarias a oeste e ouro a leste.",
    ),
    "journey.fact.xa3": q(
        "You can still cycle the full 14 km atop Xi'an's Ming-era city wall.",
        "По стене Сианя эпохи Мин до сих пор можно проехать на велосипеде все 14 км.",
        "Aún puedes recorrer en bici los 14 km completos sobre la muralla Ming de Xi'an.",
        "Ainda dá para pedalar os 14 km inteiros sobre a muralha Ming de Xi'an.",
    ),
    "journey.fact.cd1": q(
        "Giant pandas spend up to 14 hours a day eating bamboo.",
        "Большие панды могут есть бамбук до 14 часов в сутки.",
        "Los pandas gigantes pasan hasta 14 horas al día comiendo bambú.",
        "Pandas-gigantes passam até 14 horas por dia comendo bambu.",
    ),
    "journey.fact.cd2": q(
        "A single Chengdu tea house can host mahjong games that last an entire afternoon.",
        "В одной чайной Чэнду маджонг иногда играют целый день без перерыва.",
        "En una casa de té de Chengdú el mahjong puede durar toda la tarde.",
        "Numa casa de chá de Chengdu o mahjong pode durar a tarde inteira.",
    ),
    "journey.fact.cd3": q(
        "Sichuan pepper numbs your tongue before the chili heat kicks in.",
        "Сычуаньский перец сначала онемляет язык, а уже потом приходит жгучая острота.",
        "La pimienta de Sichuan adormece la lengua antes de que llegue el picante del chile.",
        "A pimenta de Sichuan adormece a língua antes do ardor do chili.",
    ),
    "journey.fact.gy1": q(
        "Guiyang is nicknamed China's \"forest city\" — parks cover much of the urban core.",
        "Гуйян называют «лесным городом» — парки занимают большую часть центра.",
        "Guiyang es la «ciudad forestal» de China: los parques cubren gran parte del centro.",
        "Guiyang é a «cidade-floresta» da China — parques cobrem boa parte do centro.",
    ),
    "journey.fact.gy2": q(
        "Huangguoshu Waterfall near Guiyang is wider than Niagara Falls.",
        "Водопад Хуангошу у Гуйяна шире Ниагары.",
        "La cascada Huangguoshu, cerca de Guiyang, es más ancha que las Cataratas del Niágara.",
        "A cachoeira Huangguoshu, perto de Guiyang, é mais larga que as Cataratas do Niágara.",
    ),
    "journey.fact.gy3": q(
        "Over 40 ethnic groups live in Guizhou — more than any other Chinese province.",
        "В Гуйчжоу проживает более 40 народов — больше, чем в любой другой провинции Китая.",
        "Más de 40 grupos étnicos viven en Guizhou, más que en cualquier otra provincia china.",
        "Mais de 40 grupos étnicos vivem em Guizhou — mais do que em qualquer outra província chinesa.",
    ),
    "journey.fact.gl1": q(
        "An ancient proverb calls Guilin's scenery the finest under heaven.",
        "Древняя пословица называет пейзажи Гуйлиня лучшими под небесами.",
        "Un antiguo proverbio llama a los paisajes de Guilin los mejores bajo el cielo.",
        "Um provérbio antigo chama a paisagem de Guilin a melhor sob o céu.",
    ),
    "journey.fact.gl2": q(
        "The view on China's 20-yuan note is a real spot on the Li River.",
        "Пейзаж с купюры в 20 юаней — реальный вид на реке Ли.",
        "El paisaje del billete de 20 yuanes es un lugar real del río Li.",
        "A paisagem da nota de 20 yuans é um ponto real no rio Li.",
    ),
    "journey.fact.gl3": q(
        "Photographers camp on Xianggong Hill for sunrise shots over the karst peaks.",
        "Фотографы ночуют на холме Сяньгун, чтобы снять рассвет над карстами.",
        "Fotógrafos acampan en la colina Xianggong para captar el amanecer sobre los picos kársticos.",
        "Fotógrafos acampam na colina Xianggong para registrar o nascer do sol sobre os picos cársticos.",
    ),
    "journey.fact.sh1": q(
        "Shanghai's maglev hits 431 km/h — faster than most Formula 1 cars.",
        "Шанхайский maglev разгоняется до 431 км/ч — быстрее большинства болидов «Формулы-1».",
        "El maglev de Shanghái alcanza 431 km/h, más rápido que la mayoría de los Fórmula 1.",
        "O maglev de Xangai chega a 431 km/h — mais rápido que a maioria dos carros de Fórmula 1.",
    ),
    "journey.fact.sh2": q(
        "The Bund packs 52 buildings spanning Gothic, Baroque, and Art Deco styles.",
        "На Бунде 52 здания в готическом, барокко и ар-деко стилях.",
        "El Bund concentra 52 edificios de estilos gótico, barroco y art déco.",
        "O Bund reúne 52 edifícios em estilos gótico, barroco e art déco.",
    ),
    "journey.fact.sh3": q(
        "A Huangpu River cruise at night turns both banks into a wall of light.",
        "Ночной круиз по Хуанпу превращает оба берега в стену огней.",
        "Un crucero nocturno por el Huangpu convierte ambas orillas en un muro de luces.",
        "Um cruzeiro noturno pelo Huangpu transforma as duas margens em um muro de luzes.",
    ),
    "journey.fact.hz1": q(
        "Emperor Qianlong once declared Longjing tea the finest in all of China.",
        "Император Цяньлун когда-то назвал чай лунцзин лучшим во всём Китае.",
        "El emperador Qianlong declaró el té Longjing el mejor de toda China.",
        "O imperador Qianlong declarou o chá Longjing o melhor de toda a China.",
    ),
    "journey.fact.hz2": q(
        "West Lake has ten officially named scenic spots — poets named most of them.",
        "У Западного озера десять официальных «живописных мест» — большинство назвали поэты.",
        "El Lago del Oeste tiene diez miradores oficiales, la mayoría bautizados por poetas.",
        "O Lago Ocidental tem dez mirantes oficiais — a maioria nomeada por poetas.",
    ),
    "journey.fact.hz3": q(
        "Marco Polo called Hangzhou the finest and noblest city in the world.",
        "Марко Поло называл Ханчжоу «прекраснейшим и благороднейшим городом мира».",
        "Marco Polo llamó a Hangzhou la ciudad más espléndida y noble del mundo.",
        "Marco Polo chamou Hangzhou a cidade mais esplêndida e nobre do mundo.",
    ),
    "journey.fact.sz1": q(
        "Suzhou's Humble Administrator's Garden took 16 years to build in the 1500s.",
        "Сад скромного чиновника строили шестнадцать лет — в XVI веке.",
        "El Jardín del Administrador Humilde tardó 16 años en construirse en el siglo XVI.",
        "O Jardim do Administrador Humilde levou 16 anos para ser construído, no século XVI.",
    ),
    "journey.fact.sz2": q(
        "One Suzhou silk embroidery piece can take an artisan over a year to finish.",
        "Одна шёлковая вышивка Сучжоу может занимать мастера больше года.",
        "Un solo bordado de seda de Suzhou puede llevar más de un año a un artesano.",
        "Uma peça de bordado em seda de Suzhou pode levar mais de um ano a um artesão.",
    ),
    "journey.fact.sz3": q(
        "Suzhou's old canals earned it the nickname Venice of the East.",
        "Старые каналы Сучжоу принесли ему прозвище «Восточная Венеция».",
        "Los antiguos canales de Suzhou le valieron el apodo de Venecia de Oriente.",
        "Os canais antigos de Suzhou renderam o apelido de Veneza do Oriente.",
    ),
    "journey.fact.hb1": q(
        "Harbin's Ice Festival carves over 200,000 cubic meters of ice each winter.",
        "На Ледовом фестивале Харбина каждую зиму используют более 200 000 м³ льда.",
        "El Festival del Hielo de Harbin talla más de 200 000 m³ de hielo cada invierno.",
        "O Festival do Gelo de Harbin esculpe mais de 200 mil m³ de gelo todo inverno.",
    ),
    "journey.fact.hb2": q(
        "Central Street's cobblestones were imported from Russia over a century ago.",
        "Брусчатку Центральной улицы привезли из России больше ста лет назад.",
        "Los adoquines de la Calle Central se importaron de Rusia hace más de un siglo.",
        "Os paralelepípedos da Rua Central foram importados da Rússia há mais de um século.",
    ),
    "journey.fact.hb3": q(
        "Harbin hosts the world's largest ice and snow sculpture festival.",
        "В Харбине проходит крупнейший в мире фестиваль ледяных и снежных скульптур.",
        "Harbin acoge el festival de esculturas de hielo y nieve más grande del mundo.",
        "Harbin sedeia o maior festival de esculturas de gelo e neve do mundo.",
    ),
    "journey.fact.gz1": q(
        "Yum cha in Guangzhou can mean an all-morning marathon of tea and dumplings.",
        "Ямча в Гуанчжоу — это марафон чая и пельменей на всё утро.",
        "El yum cha en Cantón puede ser un maratón matutino de té y dumplings.",
        "O yum cha em Guangzhou pode ser uma maratona matinal de chá e dumplings.",
    ),
    "journey.fact.gz2": q(
        "Canton Tower's twisted shape was inspired by a slender goddess from local legend.",
        "Форму Canton Tower вдохновила легенда о стройной богине.",
        "La forma retorcida de la Torre de Cantón se inspiró en una diosa esbelta de la leyenda local.",
        "O formato torcido da Torre de Cantão veio de uma deusa esguia da lenda local.",
    ),
    "journey.fact.gz3": q(
        "Guangzhou has traded with the world for over 2,000 years.",
        "Гуанчжоу торгует с миром уже более двух тысяч лет.",
        "Cantón ha comerciado con el mundo durante más de 2000 años.",
        "Guangzhou comercia com o mundo há mais de 2 mil anos.",
    ),
    "journey.fact.szh1": q(
        "Shenzhen produces roughly 90% of the world's consumer electronics.",
        "Шэньчжэнь производит около 90% мировой потребительской электроники.",
        "Shenzhen produce cerca del 90% de la electrónica de consumo del mundo.",
        "Shenzhen produz cerca de 90% da eletrônica de consumo do mundo.",
    ),
    "journey.fact.szh2": q(
        "Nearly half of Shenzhen is green space — parks, wetlands, and coastal trails.",
        "Почти половина Шэньчжэня — зелёные зоны: парки, болота и прибрежные тропы.",
        "Casi la mitad de Shenzhen es espacio verde: parques, humedales y senderos costeros.",
        "Quase metade de Shenzhen é área verde — parques, pântanos e trilhas litorâneas.",
    ),
    "journey.fact.szh3": q(
        "Shenzhen went from 30,000 residents in 1980 to a megacity of 18 million.",
        "С 1980 года Шэньчжэнь вырос с 30 000 жителей до мегаполиса на 18 миллионов.",
        "Shenzhen pasó de 30 000 habitantes en 1980 a una megaciudad de 18 millones.",
        "Shenzhen saltou de 30 mil habitantes em 1980 para uma megacidade de 18 milhões.",
    ),
    "journey.fact.hk1": q(
        "The Peak Tram has climbed Victoria Peak since 1888 — one of the world's oldest funiculars.",
        "Фуникулёр Peak Tram поднимается на пик Виктория с 1888 года — один из старейших в мире.",
        "El Peak Tram sube al Pico Victoria desde 1888, uno de los funiculares más antiguos del mundo.",
        "O Peak Tram sobe ao Pico Victoria desde 1888 — um dos funiculares mais antigos do mundo.",
    ),
    "journey.fact.hk2": q(
        "A Star Ferry ride costs less than a cup of coffee but delivers the best harbor view.",
        "Поездка на Star Ferry стоит дешевле чашки кофе, а вид на гавань — лучший в городе.",
        "Un viaje en Star Ferry cuesta menos que un café y ofrece la mejor vista del puerto.",
        "Uma viagem no Star Ferry custa menos que um café e traz a melhor vista do porto.",
    ),
    "journey.fact.hk3": q(
        "Hong Kong packs more skyscrapers than New York and Tokyo combined.",
        "В Гонконге больше небоскрёбов, чем в Нью-Йорке и Токио вместе взятых.",
        "Hong Kong tiene más rascacielos que Nueva York y Tokio juntas.",
        "Hong Kong tem mais arranha-céus do que Nova York e Tóquio juntas.",
    ),
}


ATTRACTIONS: dict[str, dict[str, dict[str, str]]] = {}

_ATTR = ATTRACTIONS.update

_ATTR(attraction(
    "bj-a1",
    name=q("Forbidden City", "Запретный город", "Ciudad Prohibida", "Cidade Proibida"),
    description=q(
        "The Ming-Qing imperial palace with nearly 9,000 rooms.",
        "Императорский дворец эпох Мин и Цин с почти 9 000 комнатами.",
        "Palacio imperial Ming-Qing con casi 9000 habitaciones.",
        "Palácio imperial Ming-Qing com quase 9 mil cômodos.",
    ),
    detail=q(
        "Twenty-four emperors ruled from these vermilion walls. Walk the central axis through throne halls and side courtyards where court rituals once played out daily.",
        "Отсюда правили двадцать четверо императоров. Пройдите по центральной оси через тронные залы и боковые дворики, где когда-то ежедневно шли придворные церемонии.",
        "Veinticuatro emperadores gobernaron desde estos muros bermellón. Recorre el eje central entre salones del trono y patios donde los rituales de corte se repetían cada día.",
        "Vinte e quatro imperadores governaram a partir destes muros vermelhos. Siga o eixo central pelos salões do trono e pátios onde rituais de corte aconteciam todos os dias.",
    ),
    tip=q(
        "Enter from Tiananmen West early to skip the longest queues.",
        "Заходите с западной стороны Тяньаньмэнь рано утром — очереди короче.",
        "Entra por Tiananmen Oeste temprano para evitar las colas más largas.",
        "Entre pelo Tiananmen Oeste cedo para evitar as filas mais longas.",
    ),
))

_ATTR(attraction(
    "bj-a2",
    name=q("Great Wall", "Великая стена", "Gran Muralla", "Grande Muralha"),
    description=q(
        "Ancient fortifications snaking across mountain ridges.",
        "Древние укрепления, извивающиеся по горным хребтам.",
        "Antiguas fortificaciones serpenteando por las crestas.",
        "Antigas fortificações serpenteando pelas cristas.",
    ),
    detail=q(
        "Mutianyu and Badaling are the easiest sections from Beijing. Watchtowers climb ridge after ridge — autumn foliage and spring blossoms make the most photogenic seasons.",
        "Мутяньюй и Бадалин — самые доступные участки от Пекина. Сторожевые башни тянутся по гребням; осенняя листва и весеннее цветение — лучшее время для фото.",
        "Mutianyu y Badaling son las secciones más accesibles desde Pekín. Torres de vigilancia suben cresta tras cresta; el follaje otoñal y la floración primaveral son ideales para fotos.",
        "Mutianyu e Badaling são os trechos mais acessíveis a partir de Pequim. Torres de vigia sobem crista após crista; folhagem de outono e flores na primavera são ótimas para fotos.",
    ),
    tip=q(
        "Visit Mutianyu on a weekday morning for shorter cable-car lines.",
        "Езжайте в Мутяньюй в будний день утром — очереди на канатку короче.",
        "Visita Mutianyu entre semana por la mañana para colas más cortas en el teleférico.",
        "Visite Mutianyu numa manhã de dia útil para filas menores no teleférico.",
    ),
))

_ATTR(attraction(
    "bj-a3",
    name=q("Temple of Heaven", "Храм Неба", "Templo del Cielo", "Templo do Céu"),
    description=q(
        "Where emperors prayed for good harvests under a circular blue roof.",
        "Место, где императоры молились об урожае под круглой синей крышей.",
        "Donde los emperadores rezaban por buenas cosechas bajo un techo azul circular.",
        "Onde imperadores rezavam por boas colheitas sob um teto azul circular.",
    ),
    detail=q(
        "The Hall of Prayer for Good Harvests is a masterpiece of Ming architecture — no nails, only timber joinery. The surrounding park fills with tai chi, erhu, and ballroom dancing at dawn.",
        "Зал молитв об урожае — шедевр архитектуры Мин без единого гвоздя. Вокруг на рассвете занимаются тайцзи, играют на эру и танцуют.",
        "El Salón de Oración por Buenas Cosechas es una obra maestra Ming sin un solo clavo. Al amanecer el parque se llena de tai chi, erhu y bailes.",
        "O Salão de Oração por Boas Colheitas é uma obra-prima Ming sem um único prego. Ao amanhecer o parque enche de tai chi, erhu e dança.",
    ),
    tip=q(
        "Arrive at opening time to watch locals practice tai chi in the park.",
        "Приходите к открытию — увидите, как местные занимаются тайцзи.",
        "Llega a la hora de apertura para ver tai chi en el parque.",
        "Chegue na abertura para ver moradores praticando tai chi no parque.",
    ),
))

_ATTR(attraction(
    "bj-a4",
    name=q("Peking Duck", "Утка по-пекински", "Pato pekinés", "Pato à pequinesa"),
    description=q(
        "Crispy skin, tender meat — Beijing's most famous dish.",
        "Хрустящая корочка и нежное мясо — главное блюдо Пекина.",
        "Piel crujiente y carne tierna: el plato más famoso de Pekín.",
        "Pele crocante e carne macia — o prato mais famoso de Pequim.",
    ),
    detail=q(
        "A skilled chef slices the duck tableside in under two minutes. Wrap shards of crispy skin in thin pancakes with scallion and sweet bean sauce — the ritual matters as much as the taste.",
        "Повар нарезает утку за столом меньше чем за две минуты. Заверните хрустящую корочку в тонкий блин с зелёным луком и сладким соусом — ритуал не менее важен, чем вкус.",
        "Un chef experto filetea el pato en la mesa en menos de dos minutos. Envuelve piel crujiente en panqueques finos con cebolleta y salsa dulce: el ritual importa tanto como el sabor.",
        "Um chef habilidoso fatia o pato à mesa em menos de dois minutos. Enrola a pele crocante em panquecas finas com cebolinha e molho doce — o ritual importa tanto quanto o sabor.",
    ),
    tip=q(
        "Book a table at a famous roast-duck restaurant at least a day ahead.",
        "Бронируйте стол в известной утиной хотя бы за день.",
        "Reserva mesa en un restaurante famoso de pato al menos un día antes.",
        "Reserve mesa em um restaurante famoso de pato com pelo menos um dia de antecedência.",
    ),
))

_ATTR(attraction(
    "bj-a5",
    name=q("798 Art District", "Арт-квартал 798", "Distrito artístico 798", "Distrito artístico 798"),
    description=q(
        "Former factory yards now packed with galleries and street art.",
        "Бывшие заводские дворы, превращённые в галереи и уличное искусство.",
        "Antiguos patios fabriles convertidos en galerías y arte callejero.",
        "Antigos pátios de fábrica transformados em galerias e arte de rua.",
    ),
    detail=q(
        "Red-brick Bauhaus workshops from the 1950s now host contemporary art, design shops, and weekend markets. Murals cover entire walls, and indie cafés fill the courtyards between shows.",
        "Краснокирпичные цеха 1950-х годов стали галереями, дизайнерскими магазинами и рынками по выходным. Стены покрыты муралами, а дворики заполнены кофейнями.",
        "Talleres de ladrillo rojo de los años 50 albergan arte contemporáneo, diseño y mercados de fin de semana. Muros enteros son murales y los patios se llenan de cafés independientes.",
        "Oficinas de tijolo vermelho dos anos 50 abrigam arte contemporânea, design e feiras de fim de semana. Muros inteiros viram murais e os pátios enchem de cafés independentes.",
    ),
    tip=q(
        "Weekday mornings are quietest; weekends bring pop-up markets.",
        "В будни утром тише всего; по выходным бывают ярмарки.",
        "Las mañanas entre semana son más tranquilas; los fines de semana hay mercados.",
        "Manhãs de dias úteis são mais tranquilas; nos fins de semana há feiras.",
    ),
))

# Xi'an
_ATTR(attraction(
    "xa-a1",
    name=q("Terracotta Army", "Терракотовая армия", "Ejército de Terracota", "Exército de Terracota"),
    description=q(
        "Thousands of life-size clay soldiers guarding an emperor's tomb.",
        "Тысячи глиняных воинов в натуральную величину охраняют гробницу императора.",
        "Miles de soldados de arcilla de tamaño real custodian la tumba de un emperador.",
        "Milhares de soldados de argila em tamanho real guardam a tumba de um imperador.",
    ),
    detail=q(
        "Discovered by farmers in 1974, the army was built to protect Qin Shi Huang in the afterlife. Each warrior has a unique face, hairstyle, and armor detail.",
        "Открытая в 1974 году фермерами, армия была создана, чтобы защищать Цинь Шихуана в загробном мире. У каждого воина своё лицо, причёска и доспехи.",
        "Descubierta por campesinos en 1974, el ejército protegía a Qin Shi Huang en el más allá. Cada guerrero tiene rostro, peinado y armadura únicos.",
        "Descoberto por fazendeiros em 1974, o exército protegia Qin Shi Huang no além. Cada guerreiro tem rosto, penteado e armadura únicos.",
    ),
    tip=q(
        "Hire a guide or audio tour — the pits are easier to understand with context.",
        "Возьмите гида или аудиогид — ямы легче понять с пояснениями.",
        "Contrata guía o audioguía: los fosos se entienden mejor con contexto.",
        "Contrate guia ou audioguia — as valas fazem mais sentido com contexto.",
    ),
))

_ATTR(attraction(
    "xa-a2",
    name=q("City Wall", "Городская стена", "Muralla de la ciudad", "Muralha da cidade"),
    description=q(
        "Cycle atop one of the world's best-preserved city walls.",
        "Прокатитесь по одной из лучше всего сохранившихся городских стен мира.",
        "Pedale sobre una de las murallas urbanas mejor conservadas del mundo.",
        "Pedale sobre uma das muralhas urbanas mais bem preservadas do mundo.",
    ),
    detail=q(
        "The Ming-era wall loops 14 km around old Xi'an. Rent a bike and ride the full circuit for bird's-eye views of bell towers, moats, and rooftop gardens below.",
        "Стена эпохи Мин опоясывает старый Сиань на 14 км. Арендуйте велосипед и объедьте круг — открываются виды на колокольни, рвы и садики на крышах.",
        "La muralla Ming rodea el Xi'an antiguo en 14 km. Alquila una bici y recorre el circuito completo con vistas a campanarios, fosos y jardines en azoteas.",
        "A muralha Ming contorna o Xi'an antigo em 14 km. Alugue uma bike e faça o circuito completo com vista para campanários, fossos e jardins nos telhados.",
    ),
    tip=q(
        "Go at sunset — the wall glows gold and the city lights switch on below.",
        "Приезжайте на закат — стена золотится, а внизу зажигаются огни.",
        "Ve al atardecer: la muralla se tiñe de oro y abajo se encienden las luces.",
        "Vá no pôr do sol — a muralha fica dourada e as luzes acendem embaixo.",
    ),
))

_ATTR(attraction(
    "xa-a3",
    name=q("Muslim Quarter", "Мусульманский квартал", "Barrio musulmán", "Bairro muçulmano"),
    description=q(
        "Alleyways sizzling with street food and centuries of culture.",
        "Переулки, где шипит уличная еда и живёт многовековая культура.",
        "Callejuelas chisporroteantes de comida callejera y siglos de cultura.",
        "Becos borbulhando de comida de rua e séculos de cultura.",
    ),
    detail=q(
        "Narrow lanes near the Great Mosque fill with lamb skewers, roujiamo burgers, and pomegranate juice presses. The area has been home to Hui Muslim communities since the Tang dynasty.",
        "Узкие улочки у Большой мечети полны шашлыков, roujiamo и гранатового сока. Здесь с династии Тан живут мусульмане-хуэй.",
        "Calles estrechas junto a la Gran Mezquita rebosan de brochetas de cordero, roujiamo y zumo de granada. Comunidades hui musulmanas viven aquí desde la dinastía Tang.",
        "Ruas estreitas perto da Grande Mesquita enchem de espetinhos de cordeiro, roujiamo e suco de romã. Comunidades muçulmanas hui vivem aqui desde a dinastia Tang.",
    ),
    tip=q(
        "Come hungry at dusk — lines shorten once the dinner rush peaks.",
        "Приходите голодными ближе к вечеру — после пика ужина очереди короче.",
        "Ve con hambre al anochecer: las colas se acortan tras el pico de la cena.",
        "Chegue com fome ao entardecer — as filas diminuem depois do pico do jantar.",
    ),
))

_ATTR(attraction(
    "xa-a4",
    name=q("Big Wild Goose Pagoda", "Большая пагода Диких гусей", "Gran Pagoda del Ganso Salvaje", "Grande Pagode do Ganso Selvagem"),
    description=q(
        "Tang-dynasty pagoda where Buddhist scriptures first arrived.",
        "Пагода эпохи Тан, куда впервые привезли буддийские свитки.",
        "Pagoda Tang donde llegaron por primera vez las escrituras budistas.",
        "Pagode Tang onde chegaram pela primeira vez os sutras budistas.",
    ),
    detail=q(
        "Monk Xuanzang stored Sanskrit texts here after his epic journey to India. Climb the seven stories for a sweeping view of modern Xi'an spreading below.",
        "Монах Сюаньцзан хранил здесь санскритские тексты после путешествия в Индию. Поднимитесь на семь ярусов — открывается вид на современный Сиань.",
        "El monje Xuanzang guardó aquí textos sánscritos tras su viaje a la India. Sube siete plantas para ver Xi'an moderno extendiéndose abajo.",
        "O monge Xuanzang guardou aqui textos em sânscrito após a viagem à Índia. Suba sete andares para ver Xi'an moderno se espalhando abaixo.",
    ),
    tip=q(
        "Visit the north square at night for Asia's largest musical fountain show.",
        "Вечером загляните на северную площадь — там музыкальный фонтан.",
        "Visita la plaza norte de noche para el mayor espectáculo de fuentes musicales de Asia.",
        "Visite a praça norte à noite para o maior show de fontes musicais da Ásia.",
    ),
))

_ATTR(attraction(
    "xa-a5",
    name=q("Tang Paradise", "Парк «Великий Тан»", "Tang Paradise", "Tang Paradise"),
    description=q(
        "Tang-dynasty theme park blazing with night lights.",
        "Тематический парк эпохи Тан с яркой ночной подсветкой.",
        "Parque temático de la dinastía Tang con luces nocturnas deslumbrantes.",
        "Parque temático da dinastia Tang com luzes noturnas deslumbrantes.",
    ),
    detail=q(
        "The park recreates Chang'an, the Tang capital, with palaces, lakes, and costumed performances. After dark, millions of LEDs turn the grounds into a glowing open-air stage.",
        "Парк воссоздаёт столицу Тан — Чанъань: дворцы, озёра, представления в костюмах. После заката миллионы светодиодов превращают его в светящуюся сцену под открытым небом.",
        "Recrea Chang'an, capital Tang, con palacios, lagos y espectáculos con trajes. Al anochecer, millones de LED convierten el parque en un escenario luminoso al aire libre.",
        "Recria Chang'an, capital Tang, com palácios, lagos e apresentações com trajes. Ao anoitecer, milhões de LEDs transformam o parque em um palco luminoso ao ar livre.",
    ),
    tip=q(
        "Book an evening ticket and arrive before sunset to watch the day-to-night transformation.",
        "Берите вечерний билет и приходите до заката — увидите смену дня и ночи.",
        "Reserva entrada nocturna y llega antes del atardecer para ver la transformación.",
        "Reserve ingresso noturno e chegue antes do pôr do sol para ver a transformação.",
    ),
))

# Chengdu
_ATTR(attraction(
    "cd-a1",
    name=q("Panda Base", "База больших панд", "Base de pandas", "Base de pandas"),
    description=q(
        "Watch giant pandas munch bamboo just meters away.",
        "Смотрите, как большие панды жуют бамбук в нескольких метрах от вас.",
        "Observa pandas gigantes masticando bambú a pocos metros.",
        "Veja pandas-gigantes mastigando bambu a poucos metros.",
    ),
    detail=q(
        "The Chengdu Research Base opens early when pandas are most active. Red pandas share the trails, and the nursery lets you peek at cubs during breeding season.",
        "База открывается рано — панды наиболее активны утром. Красных панд можно встретить на тропах, а в сезон размножения в питомнике видны малыши.",
        "La base abre temprano, cuando los pandas están más activos. Pandas rojos comparten senderos y en temporada de cría puedes ver cachorros en el vivero.",
        "A base abre cedo, quando os pandas estão mais ativos. Pandas-vermelhos compartilham trilhas e na temporada de reprodução dá para ver filhotes no berçário.",
    ),
    tip=q(
        "Arrive at 7:30 AM opening — pandas feed then and nap by noon.",
        "Приезжайте к открытию в 7:30 — панды кормят утром и дремлют к полудню.",
        "Llega a la apertura a las 7:30: comen por la mañana y duermen al mediodía.",
        "Chegue na abertura às 7:30 — eles comem de manhã e cochilam ao meio-dia.",
    ),
))

_ATTR(attraction(
    "cd-a2",
    name=q("Jinli Street", "Улица Цзиньли", "Calle Jinli", "Rua Jinli"),
    description=q(
        "Lantern-lit lane of snacks, crafts, and Sichuan opera.",
        "Улица с фонарями, закусками, ремёслами и сычуаньской оперой.",
        "Calle iluminada con farolillos, bocadillos, artesanía y ópera de Sichuan.",
        "Rua iluminada por lanternas, petiscos, artesanato e ópera de Sichuan.",
    ),
    detail=q(
        "This restored Qing-era street glows red at night with snack stalls and sugar paintings. Street performers and shadow-puppet shows keep the crowd moving until midnight.",
        "Восстановленная улица эпохи Цин ночью светится красным: ларьки с закусками и сахарные фигурки. Уличные артисты и теневой театр не дают заскучать до полуночи.",
        "Esta calle Qing restaurada brilla de rojo de noche con puestos y figuras de azúcar. Artistas callejeros y teatro de sombras animan la multitud hasta medianoche.",
        "Esta rua Qing restaurada brilha vermelha à noite com barracas e figuras de açúcar. Artistas de rua e teatro de sombras animam a multidão até meia-noite.",
    ),
    tip=q(
        "Visit after dark when lanterns switch on — daytime feels like a shopping mall.",
        "Приходите после заката, когда зажигают фонари — днём это похоже на торговый центр.",
        "Visita de noche cuando encienden farolillos; de día parece un centro comercial.",
        "Visite depois do anoitecer, quando acendem as lanternas — de dia parece shopping.",
    ),
))

_ATTR(attraction(
    "cd-a3",
    name=q("Hot Pot", "Сычуаньский хого", "Hot pot", "Hot pot"),
    description=q(
        "Bubbling chili broth that numbs and delights in equal measure.",
        "Кипящий острый бульон, который одновременно онемляет и радует.",
        "Caldo hirviendo picante que adormece y deleita a la vez.",
        "Caldo borbulhante picante que adormece e encanta ao mesmo tempo.",
    ),
    detail=q(
        "A split pot lets you choose fiery red oil or mild mushroom broth. Dip thin-sliced beef and lotus root, then cool your tongue with sesame paste or iced plum juice.",
        "С двойным котлом можно выбрать огненное масло или лёгкий грибной бульон. Окуните говядину и лотос, а язык остудите кунжутной пастой или сливовым соком.",
        "Una olla dividida permite caldo rojo ardiente o suave de hongos. Sumerge ternera y raíz de loto, y enfría la lengua con pasta de sésamo o zumo de ciruela.",
        "Uma panela dividida permite caldo vermelho ardente ou suave de cogumelos. Mergulhe carne e raiz de lótus e refresque a língua com pasta de gergelim ou suco de ameixa.",
    ),
    tip=q(
        "Ask for yuanyang (half-and-half) pot if your group mixes spice tolerance levels.",
        "Закажите котёл «юаньян» (половина-половина), если в компании разная любовь к острому.",
        "Pide olla yuanyang (mitad y mitad) si el grupo tolera picante distinto.",
        "Peça panela yuanyang (metade e metade) se o grupo tolera picância diferente.",
    ),
))

_ATTR(attraction(
    "cd-a4",
    name=q("Wuhou Shrine", "Храм Ухоу", "Templo Wuhou", "Templo Wuhou"),
    description=q(
        "Temple honoring heroes of the Three Kingdoms era.",
        "Храм в честь героев эпохи Троецарствия.",
        "Templo dedicado a los héroes de los Tres Reinos.",
        "Templo dedicado aos heróis dos Três Reinos.",
    ),
    detail=q(
        "Dedicated to strategist Zhuge Liang, the shrine sits beside the Tomb of Liu Bei. Red walls, ancient cypress trees, and stone steles tell tales of loyalty and battlefield cunning.",
        "Храм посвящён стратегу Чжугэ Ляну и стоит рядом с гробницей Лю Бэя. Алые стены, старые кипарисы и каменные стелы рассказывают о верности и военной хитрости.",
        "Dedicado al estratega Zhuge Liang, el templo está junto a la tumba de Liu Bei. Muros rojos, cipreses antiguos y estelas de piedra cuentan lealtad y astucia en batalla.",
        "Dedicado ao estrategista Zhuge Liang, fica ao lado do túmulo de Liu Bei. Muros vermelhos, ciprestes antigos e estelas de pedra contam lealdade e astúcia na batalha.",
    ),
    tip=q(
        "Combine with Jinli Street next door — one ticket covers both areas.",
        "Совместите с соседней Цзиньли — один билет на обе зоны.",
        "Combínalo con Jinli Street al lado: una entrada cubre ambas zonas.",
        "Combine com a Rua Jinli ao lado — um ingresso cobre as duas áreas.",
    ),
))

_ATTR(attraction(
    "cd-a5",
    name=q("Taikoo Li", "Тайкули", "Taikoo Li", "Taikoo Li"),
    description=q(
        "Open-air lanes where Qing courtyards meet flagship stores.",
        "Открытые переулки, где дворы эпохи Цин соседствуют с флагманскими магазинами.",
        "Calles al aire libre donde patios Qing se encuentran con tiendas insignia.",
        "Ruas ao ar livre onde pátios Qing encontram lojas flagship.",
    ),
    detail=q(
        "Built around the restored Daci Temple, Taikoo Li keeps Qing-era lanes while adding cocktail bars and the famous rooftop panda at IFS. Fashion and tea-house culture share the same block.",
        "Построен вокруг отреставрированного храма Дацзы: переулки эпохи Цин, коктейль-бары и знаменитая панда на крыше IFS. Мода и чайная культура живут на одной улице.",
        "Construido junto al templo Daci restaurado, conserva callejuelas Qing con bares y la famosa panda en la azotea del IFS. Moda y cultura del té comparten la misma manzana.",
        "Construído em torno do templo Daci restaurado, mantém becos Qing com bares e a famosa panda no terraço do IFS. Moda e cultura do chá dividem o mesmo quarteirão.",
    ),
    tip=q(
        "Visit the temple courtyard first, then explore side alleys for local desserts.",
        "Сначала загляните во двор храма, затем — в боковые улочки с десертами.",
        "Visita primero el patio del templo y luego callejones con postres locales.",
        "Visite primeiro o pátio do templo e depois becos com sobremesas locais.",
    ),
))

# Guiyang
_ATTR(attraction(
    "gy-a1",
    name=q("Jiaxiu Pavilion", "Павильон Цзясю", "Pabellón Jiaxiu", "Pavilhão Jiaxiu"),
    description=q(
        "Guiyang's riverside landmark glowing beautifully at night.",
        "Знаменитый павильон у реки, особенно красивый в ночной подсветке.",
        "El emblemático pabellón junto al río, precioso cuando se ilumina de noche.",
        "O famoso pavilhão à beira do rio, especialmente bonito iluminado à noite.",
    ),
    detail=q(
        "Built in 1598 on a rocky outcrop above the Nanming River, this triple-eaved pavilion is Guiyang's symbol. Red lanterns and golden reflections ripple across the water after dark.",
        "Построенный в 1598 году на скале над рекой Наньмин, трёхъярусный павильон — символ Гуйяна. После заката красные фонари и золотые блики пляшут на воде.",
        "Construido en 1598 sobre una roca junto al río Nanming, este pabellón de tres niveles es el símbolo de Guiyang. Farolillos rojos y reflejos dorados brillan en el agua al anochecer.",
        "Construído em 1598 sobre uma rocha às margens do rio Nanming, este pavilhão de três andares é o símbolo de Guiyang. Lanternas vermelhas e reflexos dourados dançam na água depois do anoitecer.",
    ),
    tip=q(
        "Cross the stone arch bridge at dusk when the pavilion lights switch on.",
        "Переходите каменный арочный мост на закате, когда включают подсветку павильона.",
        "Cruza el puente de piedra al atardecer, cuando encienden las luces del pabellón.",
        "Passe pela ponte de pedra ao pôr do sol, quando as luzes do pavilhão acendem.",
    ),
))

_ATTR(attraction(
    "gy-a2",
    name=q("Qianling Hill Park", "Парк горы Цяньлин", "Parque de la Colina Qianling", "Parque da Colina Qianling"),
    description=q(
        "Forested hills, temples, lake views, and playful macaques.",
        "Лесистые холмы, храмы, виды на озеро и озорные макаки.",
        "Colinas boscosas, templos, vistas al lago y macacos juguetones.",
        "Colinas arborizadas, templos, vista para o lago e macacos brincalhões.",
    ),
    detail=q(
        "Qianling Park wraps a forested hill with winding trails, a serene lake, and the ancient Hongfu Temple. Wild macaques roam freely — they are bold but harmless if you keep snacks hidden.",
        "Парк опоясывает лесистый холм с извилистыми тропами, тихим озером и древним храмом Хунфу. Здесь свободно живут макаки — они смелые, но безобидные, если спрятать еду.",
        "El parque rodea una colina boscosa con senderos, un lago tranquilo y el antiguo templo Hongfu. Macacos salvajes merodean libremente: son atrevidos pero inofensivos si ocultas la comida.",
        "O parque contorna uma colina arborizada com trilhas sinuosas, um lago tranquilo e o antigo templo Hongfu. Macacos selvagens circulam livremente — são ousados, mas inofensivos se você esconde os petiscos.",
    ),
    tip=q(
        "Keep food in your bag — the macaques will spot an open snack instantly.",
        "Держите еду в сумке — макаки мгновенно заметят открытую закуску.",
        "Guarda la comida en la bolsa: los macacos detectan un bocadillo al instante.",
        "Guarde a comida na bolsa — os macacos detectam um petisco aberto num instante.",
    ),
))

_ATTR(attraction(
    "gy-a3",
    name=q("Qingyan Ancient Town", "Древний город Цинъянь", "Ciudad antigua de Qingyan", "Cidade antiga de Qingyan"),
    description=q(
        "Stone lanes and historic architecture from the Ming era.",
        "Каменные улочки и историческая архитектура эпохи Мин.",
        "Callejuelas de piedra y arquitectura histórica de la época Ming.",
        "Ruelas de pedra e arquitetura histórica da era Ming.",
    ),
    detail=q(
        "This 600-year-old fortress town south of Guiyang keeps Ming-era stone walls, narrow lanes, and courtyard homes. Local snacks like rose candy and tofu pudding fill the market stalls.",
        "К югу от Гуйяна этот 600-летний крепостной город сохранил каменные стены эпохи Мин, узкие улочки и дома с двориками. На рынках — розовые конфеты и тофу-пудинг.",
        "Al sur de Guiyang, esta ciudad fortificada de 600 años conserva murallas Ming, callejuelas estrechas y casas con patios. Los puestos venden caramelos de rosa y tofu dulce.",
        "Ao sul de Guiyang, esta cidade fortificada de 600 anos mantém muralhas Ming, becos estreitos e casas com pátios. Barracas vendem doces de rosa e tofu doce.",
    ),
    tip=q(
        "Wear comfortable shoes — the stone lanes are steep and slippery when wet.",
        "Наденьте удобную обувь — каменные улочки крутые и скользкие в дождь.",
        "Lleva calzado cómodo: las calles de piedra son empinadas y resbaladizas con lluvia.",
        "Use calçado confortável — as ruas de pedra são íngremes e escorregadias quando molhadas.",
    ),
))

_ATTR(attraction(
    "gy-a4",
    name=q("Huaxi Wetland", "Водно-болотный парк Хуаси", "Humedal de Huaxi", "Área úmida de Huaxi"),
    description=q(
        "A peaceful green corridor of rivers, fields, and walking paths.",
        "Спокойный зелёный маршрут среди рек, полей и прогулочных дорожек.",
        "Un tranquilo corredor verde de ríos, campos y senderos.",
        "Um tranquilo corredor verde de rios, campos e trilhas.",
    ),
    detail=q(
        "Huaxi National Urban Wetland Park threads rivers, lotus ponds, and rice fields through the city's southern edge. Boardwalks and cycling paths make it a favorite morning escape for locals.",
        "Национальный городской парк Хуаси протягивает реки, пруды с лотосами и рисовые поля по южной окраине города. Настилы и велодорожки — любимое место для утренних прогулок.",
        "El parque urbano Huaxi entrelaza ríos, estanques de lotos y arrozales en el sur de la ciudad. Pasarelas y rutas ciclistas lo convierten en escape matutino favorito de los locales.",
        "O parque urbano Huaxi entrelaça rios, lagoas de lotus e arrozais na borda sul da cidade. Passarelas e ciclovias fazem dele o escape matinal favorito dos moradores.",
    ),
    tip=q(
        "Visit early morning for mist over the fields and fewer cyclists.",
        "Приезжайте рано утром — над полями туман и меньше велосипедистов.",
        "Visita temprano por la mañana: niebla sobre los campos y menos ciclistas.",
        "Visite no início da manhã para névoa sobre os campos e menos ciclistas.",
    ),
))

_ATTR(attraction(
    "gy-a5",
    name=q("Guizhou Provincial Museum", "Провинциальный музей Гуйчжоу", "Museo Provincial de Guizhou", "Museu Provincial de Guizhou"),
    description=q(
        "Guizhou's ethnic cultures, fossils, and ancient bronze drums.",
        "Культуры народов Гуйчжоу, окаменелости и древние бронзовые барабаны.",
        "Culturas étnicas de Guizhou, fósiles y antiguos tambores de bronce.",
        "Culturas étnicas de Guizhou, fósseis e antigos tambores de bronze.",
    ),
    detail=q(
        "The museum's striking modern building houses exhibits on Miao, Dong, and Bouyei minority cultures alongside prehistoric fossils and bronze drum collections. Free entry makes it an easy half-day visit.",
        "В современном здании музея — экспозиции о культурах народов мяо, дун и буи, доисторические окаменелости и коллекция бронзовых барабанов. Вход бесплатный — лёгкая прогулка на полдня.",
        "El moderno edificio alberga exposiciones de culturas miao, dong y bouyei, fósiles prehistóricos y tambores de bronce. Entrada gratuita: visita fácil de medio día.",
        "O moderno prédio abriga exposições das culturas miao, dong e bouyei, fósseis pré-históricos e tambores de bronze. Entrada gratuita — visita fácil de meio dia.",
    ),
    tip=q(
        "Start on the top floor for the ethnic costume gallery — it's the highlight.",
        "Начните с верхнего этажа — галерея национальных костюмов — главная находка.",
        "Empieza en el piso superior: la galería de trajes étnicos es lo mejor.",
        "Comece no andar superior — a galeria de trajes étnicos é o destaque.",
    ),
))

# Guilin
_ATTR(attraction(
    "gl-a1",
    name=q("Li River", "Река Ли", "Río Li", "Rio Li"),
    description=q(
        "Bamboo raft through iconic karst scenery.",
        "Путешествие на бамбуковом плоту среди знаменитых карстовых пейзажей.",
        "Paseo en balsa de bambú entre paisajes kársticos emblemáticos.",
        "Passeio de jangada de bambu entre paisagens cársticas icônicas.",
    ),
    detail=q(
        "The Li River cruise from Guilin to Yangshuo passes the landscape printed on China's 20-yuan note. Misty karst peaks, bamboo groves, and cormorant fishermen create a scene painters have chased for centuries.",
        "Круиз от Гуйлиня до Яншо проходит мимо пейзажа с купюры 20 юаней. Туманные карсты, бамбуковые рощи и рыбаки с бакланами — картина, которую художники ловили столетия.",
        "El crucero de Guilin a Yangshuo pasa por el paisaje del billete de 20 yuanes. Picos kársticos entre la niebla, bambúes y pescadores con cormoranes: escena que pintores persiguieron siglos.",
        "O cruzeiro de Guilin a Yangshuo passa pela paisagem da nota de 20 yuans. Picos cársticos na névoa, bambuzais e pescadores com corvos-marinhos — cena que pintores perseguiram por séculos.",
    ),
    tip=q(
        "Book the morning cruise — light is softer and the river is calmer.",
        "Берите утренний круиз — свет мягче и на реке тише.",
        "Reserva el crucero de mañana: la luz es más suave y el río más tranquilo.",
        "Reserve o cruzeiro da manhã — a luz é mais suave e o rio mais calmo.",
    ),
))

_ATTR(attraction(
    "gl-a2",
    name=q("Yangshuo", "Яншо", "Yangshuo", "Yangshuo"),
    description=q(
        "Countryside town surrounded by peaks.",
        "Небольшой город, окружённый горными вершинами.",
        "Pueblo rural rodeado de picos.",
        "Cidadezinha rural cercada por picos.",
    ),
    detail=q(
        "Yangshuo's West Street buzzes with cafés and live music, but the real magic is outside town. Cycle through rice paddies to Moon Hill or take a bamboo raft on the Yulong River.",
        "Улица Западная полна кафе и живой музыки, но главная магия — за городом. Прокатитесь по рисовым полям к Лунному холму или сплавьтесь на плоту по реке Юлун.",
        "La Calle Oeste rebosa cafés y música en vivo, pero la magia está fuera del pueblo. Pedalea entre arrozales hasta Moon Hill o navega en balsa por el río Yulong.",
        "A Rua Oeste vibra com cafés e música ao vivo, mas a magia está fora da cidade. Pedale entre arrozais até Moon Hill ou faça um passeio de jangada no rio Yulong.",
    ),
    tip=q(
        "Rent an electric bike and explore the Yulong River valley at your own pace.",
        "Арендуйте электробайк и исследуйте долину реки Юлун в своём темпе.",
        "Alquila una bici eléctrica y explora el valle del río Yulong a tu ritmo.",
        "Alugue uma bicicleta elétrica e explore o vale do rio Yulong no seu ritmo.",
    ),
))

_ATTR(attraction(
    "gl-a3",
    name=q("Reed Flute Cave", "Пещера Тростниковой флейты", "Cueva de la Flauta de Caña", "Caverna da Flauta de Junco"),
    description=q(
        "Illuminated limestone cavern.",
        "Известняковая пещера с красочной подсветкой.",
        "Caverna de piedra caliza iluminada.",
        "Caverna de calcário iluminada.",
    ),
    detail=q(
        "Named for reeds once used to make flutes at the entrance, this 240-meter cave dazzles with colored lights on stalactites and stalagmites. Crystal Palace Hall is the showstopper chamber.",
        "Названа по тростнику, из которого у входа делали флейты. Пещера 240 метров сияет цветной подсветкой на сталактитах и сталагмитах. Главная — зал «Хрустальный палец».",
        "Nombrada por las cañas con que se hacían flautas en la entrada, esta cueva de 240 metros brilla con luces de colores en estalactitas y estalagmitas. El salón Crystal Palace es el gran final.",
        "Nomeada pelos juncos usados para flautas na entrada, esta caverna de 240 metros brilha com luzes coloridas em estalactites e estalagmites. O salão Crystal Palace é o destaque.",
    ),
    tip=q(
        "Photography is allowed — bring a wide-angle lens for the cavern ceilings.",
        "Фотографировать можно — возьмите широкоугольный объектив для сводов.",
        "Se permite fotografiar: lleva un objetivo gran angular para los techos.",
        "Fotografia é permitida — leve uma lente grande-angular para os tetos.",
    ),
))

_ATTR(attraction(
    "gl-a4",
    name=q("Longji Terraces", "Рисовые террасы Лунцзи", "Terrazas de Longji", "Terraços de Longji"),
    description=q(
        "Dragon's Backbone rice terraces.",
        "Рисовые террасы «Драконий хребет».",
        "Arrozales en terrazas de la Espina del Dragón.",
        "Terraços de arroz da Espinha do Dragão.",
    ),
    detail=q(
        "Carved into hillsides since the 13th century, the Longji terraces ripple like dragon scales across the mountains. Spring brings mirror-like water, autumn paints the fields gold.",
        "Вырубленные на склонах с XIII века, террасы Лунцзи стелются по горам, как чешуя дракона. Весной вода зеркалит небо, осенью поля золотятся.",
        "Talladas en laderas desde el siglo XIII, las terrazas de Longji se extienden como escamas de dragón. En primavera el agua refleja el cielo; en otoño los campos se tiñen de oro.",
        "Talhados nas encostas desde o século XIII, os terraços de Longji se estendem como escamas de dragão. Na primavera a água reflete o céu; no outono os campos ficam dourados.",
    ),
    tip=q(
        "Stay overnight in a Zhuang or Yao village guesthouse for sunrise over the terraces.",
        "Переночуйте в гостевом доме деревни чжуан или яо — рассвет над террасами незабываем.",
        "Pernocta en una casa rural zhuang o yao para ver el amanecer sobre las terrazas.",
        "Pernoite em uma pousada de aldeia zhuang ou yao para o nascer do sol sobre os terraços.",
    ),
))

_ATTR(attraction(
    "gl-a5",
    name=q("Two Rivers & Four Lakes", "Два реки и четыре озёра", "Dos ríos y cuatro lagos", "Dois rios e quatro lagos"),
    description=q(
        "Night cruise through illuminated waterways in central Guilin.",
        "Ночной круиз по подсвечённым каналам центра Гуйлиня.",
        "Crucero nocturno por canales iluminados del centro de Guilin.",
        "Cruzeiro noturno pelos canais iluminados do centro de Guilin.",
    ),
    detail=q(
        "This urban waterway loop connects the Li and Peach Blossom rivers with four lakes via ancient bridges and pagodas. The evening boat tour lights up the shoreline like a floating lantern festival.",
        "Городской водный маршрут соединяет реки Ли и Персиковый цвет с четырьмя озёрами через древние мосты и пагоды. Вечерний круиз зажигает набережные, как плавучий фестиваль фонарей.",
        "Este circuito urbano une los ríos Li y Flor de Melocotón con cuatro lagos mediante puentes y pagodas antiguas. El crucero nocturno ilumina la orilla como un festival de farolillos flotante.",
        "Este circuito urbano liga os rios Li e Flor de Pêssego a quatro lagos por pontes e pagodes antigos. O cruzeiro noturno ilumina a margem como um festival de lanternas flutuante.",
    ),
    tip=q(
        "Book the last evening boat for the fullest light show on the bridges.",
        "Берите последний вечерний круиз — на мостах самая яркая световая программа.",
        "Reserva el último barco de la noche para el show de luces más completo en los puentes.",
        "Reserve o último barco da noite para o show de luzes mais completo nas pontes.",
    ),
))

# Shanghai
_ATTR(attraction(
    "sh-a1",
    name=q("The Bund", "Набережная Бунд", "El Bund", "O Bund"),
    description=q(
        "Colonial waterfront facing Pudong's towers.",
        "Историческая набережная напротив небоскрёбов Пудуна.",
        "Paseo colonial frente a las torres de Pudong.",
        "Orla colonial diante das torres de Pudong.",
    ),
    detail=q(
        "Fifty-two heritage buildings line the Huangpu River waterfront, facing Pudong's futuristic skyline across the water. The contrast between 1920s neoclassical facades and glass supertalls defines modern Shanghai.",
        "Пятьдесят два исторических здания вдоль набережной Хуанпу смотрят на футуристический Пудун через реку. Контраст неоклассики 1920-х и стеклянных небоскрёбов — лицо современного Шанхая.",
        "Cincuenta y dos edificios patrimoniales bordean el Huangpu frente al horizonte futurista de Pudong. El contraste entre fachadas neoclásicas de los años 20 y rascacielos de cristal define el Shanghái moderno.",
        "Cinquenta e dois edifícios históricos margeiam o Huangpu diante do horizonte futurista de Pudong. O contraste entre fachadas neoclássicas dos anos 20 e supertorres de vidro define a Xangai moderna.",
    ),
    tip=q(
        "Walk the Bund at night, then cross to Pudong for the skyline view back.",
        "Гуляйте по Бунду ночью, затем перейдите в Пудун — вид на набережную с другого берега.",
        "Recorre el Bund de noche y cruza a Pudong para ver el horizonte desde el otro lado.",
        "Caminhe no Bund à noite e cruze para Pudong para ver o horizonte do outro lado.",
    ),
))

_ATTR(attraction(
    "sh-a2",
    name=q("Oriental Pearl", "Восточная жемчужина", "Perla Oriental", "Pérola Oriental"),
    description=q(
        "Iconic TV tower on the Pudong skyline.",
        "Знаменитая телебашня в панораме Пудуна.",
        "Icónica torre de televisión del horizonte de Pudong.",
        "Icônica torre de TV no horizonte de Pudong.",
    ),
    detail=q(
        "The pink-and-silver spheres of the Oriental Pearl Tower punctuate Pudong's skyline since 1994. The observation decks and revolving restaurant offer 360-degree views of the entire megacity.",
        "Розовые и серебристые сферы Восточной жемчужины с 1994 года отмечают панораму Пудуна. Смотровые палубы и вращающийся ресторан открывают вид на весь мегаполис.",
        "Las esferas rosa y plateadas de la Torre de la Perla Oriental marcan el horizonte de Pudong desde 1994. Las plataformas y el restaurante giratorio ofrecen vistas de 360° de la megaciudad.",
        "As esferas rosa e prateadas da Torre Pérola Oriental marcam o horizonte de Pudong desde 1994. Os mirantes e o restaurante giratório oferecem vista de 360° da megacidade.",
    ),
    tip=q(
        "Visit the lower observation sphere at dusk — city lights switch on as you ascend.",
        "Поднимитесь на нижнюю смотровую на закате — огни зажигаются во время подъёма.",
        "Sube a la esfera inferior al atardecer: las luces se encienden mientras asciendes.",
        "Suba à esfera inferior ao pôr do sol — as luzes acendem enquanto você sobe.",
    ),
))

_ATTR(attraction(
    "sh-a3",
    name=q("Yu Garden", "Сад Юйюань", "Jardín Yuyuan", "Jardim Yuyuan"),
    description=q(
        "Classical Ming-era garden in Old City.",
        "Классический сад эпохи Мин в Старом городе.",
        "Jardín clásico de la época Ming en la Ciudad Vieja.",
        "Jardim clássico da era Ming na Cidade Antiga.",
    ),
    detail=q(
        "Built in 1559 by a Ming official, Yu Garden packs pavilions, rockeries, and dragon walls into just two hectares. The surrounding bazaar sells snacks, tea, and souvenirs in a maze of lanes.",
        "Построенный в 1559 году чиновником эпохи Мин, сад Юйюань в двух гектарах собрал павильоны, каменные горки и стены с драконами. Вокруг — базар с закусками, чаем и сувенирами в лабиринте улочек.",
        "Construido en 1559 por un funcionario Ming, el jardín Yuyuan concentra pabellones, rocallas y muros con dragones en solo dos hectáreas. El bazar circundante vende bocadillos, té y souvenirs en un laberinto de callejuelas.",
        "Construído em 1559 por um funcionário Ming, o Jardim Yuyuan concentra pavilhões, rochas ornamentais e muros com dragões em apenas dois hectares. O bazar ao redor vende petiscos, chá e souvenirs em um labirinto de becos.",
    ),
    tip=q(
        "Enter through the Huxinting Teahouse — the pond-side pavilion is picture-perfect.",
        "Зайдите через чайную Хусинтин — павильон у пруда идеален для фото.",
        "Entra por la casa de té Huxinting: el pabellón junto al estanque es perfecto para fotos.",
        "Entre pela casa de chá Huxinting — o pavilhão à beira do lago é perfeito para fotos.",
    ),
))

_ATTR(attraction(
    "sh-a4",
    name=q("Nanjing Road", "Нанкинская улица", "Calle Nanjing", "Rua Nanjing"),
    description=q(
        "Premier shopping street, dazzling at night.",
        "Главная торговая улица, сияющая огнями ночью.",
        "La principal calle comercial, deslumbrante por la noche.",
        "A principal rua comercial, deslumbrante à noite.",
    ),
    detail=q(
        "Stretching from the Bund to People's Square, Nanjing Road has been Shanghai's shopping spine for over a century. Neon signs, flagship stores, and street performers pack the pedestrian section after dark.",
        "От Бунда до Народной площади Нанкинская улица — торговая ось Шанхая уже больше века. Неон, флагманские магазины и уличные артисты заполняют пешеходную часть после заката.",
        "Desde el Bund hasta la Plaza del Pueblo, Nanjing Road lleva un siglo como eje comercial de Shanghái. Neones, tiendas insignia y artistas callejeros llenan la zona peatonal al anochecer.",
        "Do Bund à Praça do Povo, a Rua Nanjing é o eixo comercial de Xangai há mais de um século. Néon, lojas flagship e artistas de rua lotam a área pedestre depois do anoitecer.",
    ),
    tip=q(
        "Ride the historic Dangdang sightseeing tram through the neon-lit section.",
        "Прокатитесь на историческом трамвае Dangdang по неоновой части улицы.",
        "Sube al tranvía turístico histórico Dangdang por la sección iluminada de neón.",
        "Pegue o bonde turístico histórico Dangdang pela seção iluminada de néon.",
    ),
))

_ATTR(attraction(
    "sh-a5",
    name=q("West Bund", "Западный Бунд", "Bund Oeste", "Bund Oeste"),
    description=q(
        "Art galleries and riverfront parks on the Puxi waterfront.",
        "Галереи и парки на набережной Пуси.",
        "Galerías y parques junto al río en el Bund Oeste.",
        "Galerias e parques à beira do rio no Bund Oeste.",
    ),
    detail=q(
        "Once industrial docks, the West Bund now hosts the Long Museum, Yuz Museum, and open-air sculpture parks along the Huangpu. Sunset joggers and art walkers share the 8-km riverside promenade.",
        "Бывшие промышленные причалы Западного Бунда теперь — музеи Long и Yuz и парки скульптур вдоль Хуанпу. Бегуны и любители искусства делят 8-километровую набережную.",
        "Antiguos muelles industriales, el Bund Oeste alberga hoy el Long Museum, el Yuz Museum y parques de esculturas junto al Huangpu. Corredores y visitantes de arte comparten el paseo de 8 km.",
        "Antigos cais industriais, o Bund Oeste abriga hoje o Long Museum, o Yuz Museum e parques de esculturas ao longo do Huangpu. Corredores e visitantes de arte dividem o calçadão de 8 km.",
    ),
    tip=q(
        "Combine a gallery visit with an evening walk — the waterfront lights up after sunset.",
        "Совместите галерею с вечерней прогулкой — набережная зажигается после заката.",
        "Combina una galería con un paseo al anochecer: el paseo marítimo se ilumina tras el atardecer.",
        "Combine uma galeria com uma caminhada ao entardecer — a orla se ilumina depois do pôr do sol.",
    ),
))

# Hangzhou
_ATTR(attraction(
    "hz-a1",
    name=q("West Lake", "Западное озеро", "Lago del Oeste", "Lago Ocidental"),
    description=q(
        "Willow-lined shores and misty pagodas.",
        "Берега, поросшие ивами, и пагоды в тумане.",
        "Orillas con sauces y pagodas entre la niebla.",
        "Margens com salgueiros e pagodes entre a névoa.",
    ),
    detail=q(
        "West Lake's ten scenic spots have inspired poets for a thousand years. Willow-lined causeways, lotus ponds, and misty pagodas make a slow boat ride or lakeside stroll the perfect Hangzhou ritual.",
        "Десять знаменитых видов Западного озера вдохновляли поэтов тысячу лет. Ивовые дамбы, пруды с лотосами и пагоды в тумане — лодка или прогулка у воды — главный ритуал Ханчжоу.",
        "Los diez paisajes del Lago del Oeste inspiraron poetas durante mil años. Calzadas con sauces, estanques de lotos y pagodas entre la niebla: un paseo en barca o junto al agua es el ritual perfecto de Hangzhou.",
        "Os dez paisagens do Lago Ocidental inspiraram poetas por mil anos. Calçadas com salgueiros, lagoas de lotus e pagodes na névoa — um passeio de barco ou à beira da água é o ritual perfeito de Hangzhou.",
    ),
    tip=q(
        "Rent a bike and loop the lake — the flat 15-km path takes about two hours.",
        "Арендуйте велосипед и объедьте озеро — плоский 15-км маршрут займёт около двух часов.",
        "Alquila una bici y recorre el lago: el circuito plano de 15 km lleva unas dos horas.",
        "Alugue uma bicicleta e faça o circuito do lago — o trajeto plano de 15 km leva cerca de duas horas.",
    ),
))

_ATTR(attraction(
    "hz-a2",
    name=q("Leifeng Pagoda", "Пагода Лэйфэн", "Pagoda Leifeng", "Pagode Leifeng"),
    description=q(
        "Legendary tower overlooking the lake.",
        "Легендарная башня с видом на озеро.",
        "Torre legendaria con vistas al lago.",
        "Torre lendária com vista para o lago.",
    ),
    detail=q(
        "The Leifeng Pagoda legend tells of a white snake spirit imprisoned beneath its foundations. Rebuilt in 2002, the tower offers panoramic West Lake views from its summit.",
        "Легенда гласит, что под основанием пагоды Лэйфэн заточён дух белой змеи. Перестроенная в 2002 году, башня открывает панораму Западного озера с верхней смотровой.",
        "La leyenda cuenta que un espíritu de serpiente blanca quedó aprisionado bajo sus cimientos. Reconstruida en 2002, la torre ofrece vistas panorámicas del Lago del Oeste desde su cima.",
        "A lenda diz que um espírito de cobra branca ficou preso sob suas fundações. Reconstruída em 2002, a torre oferece vista panorâmica do Lago Ocidental do topo.",
    ),
    tip=q(
        "Climb at sunset for golden light on the lake and pagoda silhouettes.",
        "Поднимитесь на закате — золотой свет на озере и силуэты пагод.",
        "Sube al atardecer para luz dorada sobre el lago y siluetas de pagodas.",
        "Suba ao pôr do sol para luz dourada no lago e silhuetas de pagodes.",
    ),
))

_ATTR(attraction(
    "hz-a3",
    name=q("Tea Plantations", "Чайные плантации", "Plantaciones de té", "Plantações de chá"),
    description=q(
        "Rolling hills of Longjing tea bushes.",
        "Холмы, покрытые кустами чая лунцзин.",
        "Colinas cubiertas de arbustos de té Longjing.",
        "Colinas cobertas por arbustos de chá Longjing.",
    ),
    detail=q(
        "The hills of Meijiawu and Longjing village grow China's most prized green tea. Walk between rows of tea bushes, watch hand-picking in spring, and taste fresh Longjing brewed on the spot.",
        "На холмах Мейцзяу и в деревне Лунцзин выращивают самый ценный зелёный чай Китая. Идите между рядами кустов, смотрите ручной сбор весной и пробуйте лунцзин, заваренный на месте.",
        "Las colinas de Meijiawu y la aldea Longjing cultivan el té verde más apreciado de China. Camina entre filas de arbustos, observa la recolección manual en primavera y prueba Longjing recién infusionado.",
        "As colinas de Meijiawu e a aldeia Longjing cultivam o chá verde mais valorizado da China. Caminhe entre fileiras de arbustos, veja a colheita manual na primavera e prove Longjing fresco infundido ali.",
    ),
    tip=q(
        "Visit in April during the spring harvest — pickers are busiest and tea is freshest.",
        "Приезжайте в апреле на весенний сбор — сборщики в деле, чай самый свежий.",
        "Visita en abril durante la cosecha de primavera: más recolectores y té más fresco.",
        "Visite em abril durante a colheita de primavera — mais colhedores e chá mais fresco.",
    ),
))

_ATTR(attraction(
    "hz-a4",
    name=q("Lingyin Temple", "Храм Линъинь", "Templo Lingyin", "Templo Lingyin"),
    description=q(
        "Ancient Buddhist temple in forested hills.",
        "Древний буддийский храм среди лесистых холмов.",
        "Antiguo templo budista entre colinas boscosas.",
        "Antigo templo budista entre colinas arborizadas.",
    ),
    detail=q(
        "Founded in 326 AD, Lingyin Temple sits in a forested valley with Feilai Peak's rock carvings nearby. Giant camphor trees shade the courtyards, and incense smoke drifts through ancient halls.",
        "Основанный в 326 году, храм Линъинь стоит в лесной долине, рядом — скальные изваяния пика Фэйлай. Гигантские камфорные деревья затеняют дворы, а дым благовоний вьётся в древних залах.",
        "Fundado en el 326 d.C., el templo Lingyin se alza en un valle boscoso junto a las tallas de la cima Feilai. Gigantescos alcanfores sombrean los patios y el humo de incienso recorre salones antiguos.",
        "Fundado em 326 d.C., o templo Lingyin fica em um vale arborizado, perto das esculturas do pico Feilai. Gigantescos cânforas sombreiam os pátios e fumaça de incenso percorre salões antigos.",
    ),
    tip=q(
        "Walk the Feilai Peak trail first — the rock grottoes are quieter in the morning.",
        "Сначала пройдите тропу на пик Фэйлай — скальные гроты утром тише.",
        "Recorre primero el sendero de Feilai Peak: las grutas están más tranquilas por la mañana.",
        "Caminhe primeiro na trilha do pico Feilai — as grutas nas rochas são mais tranquilas de manhã.",
    ),
))

_ATTR(attraction(
    "hz-a5",
    name=q("Qianjiang CBD", "Деловой центр Цяньцзян", "CBD de Qianjiang", "CBD de Qianjiang"),
    description=q(
        "Hangzhou's modern skyline along the Qiantang River.",
        "Современная панорама Ханчжоу вдоль реки Цяньтан.",
        "El horizonte moderno de Hangzhou junto al río Qiantang.",
        "O horizonte moderno de Hangzhou às margens do rio Qiantang.",
    ),
    detail=q(
        "Qianjiang New Town showcases Hangzhou's tech-driven future with the golden International Conference Center and wave-shaped Civic Center. The riverside light show on weekends draws crowds from across the city.",
        "Новый район Цяньцзян демонстрирует технологическое будущее Ханчжоу: золотой Международный конференц-центр и волнистый Гражданский центр. По выходным световое шоу на набережной собирает толпы.",
        "Qianjiang New Town muestra el futuro tecnológico de Hangzhou con el dorado Centro de Conferencias Internacional y el Civic Center de forma de ola. El show de luces junto al río los fines de semana atrae multitudes.",
        "Qianjiang New Town mostra o futuro tecnológico de Hangzhou com o dourado Centro Internacional de Conferências e o Civic Center em forma de onda. O show de luzes à beira do rio nos fins de semana atrai multidões.",
    ),
    tip=q(
        "Watch the Qiantang River light show on Friday or Saturday evenings from the waterfront.",
        "Смотрите световое шоу на реке Цяньтан в пятницу или субботу с набережной.",
        "Ve el show de luces del río Qiantang los viernes o sábados desde el paseo marítimo.",
        "Veja o show de luzes do rio Qiantang nas sextas ou sábados à noite da orla.",
    ),
))

# Suzhou
_ATTR(attraction(
    "sz-a1",
    name=q("Humble Garden", "Сад скромного чиновника", "Jardín del Administrador Humilde", "Jardim do Administrador Humilde"),
    description=q(
        "Ming-era garden of ponds and pavilions.",
        "Сад эпохи Мин с прудами и павильонами.",
        "Jardín de la época Ming con estanques y pabellones.",
        "Jardim da era Ming com lagos e pavilhões.",
    ),
    detail=q(
        "One of China's four great gardens, the Humble Administrator's Garden layers ponds, rockeries, and pavilions across 52,000 square meters. Every turn reveals a new framed view — water, bamboo, and whitewashed walls.",
        "Один из четырёх великих садов Китая — сад скромного чиновника раскладывает пруды, каменные горки и павильоны на 52 000 квадратных метров. На каждом повороте — новый кадр: вода, бамбук и белые стены.",
        "Uno de los cuatro grandes jardines de China, el Jardín del Administrador Humilde superpone estanques, rocallas y pabellones en 52 000 metros cuadrados. Cada giro revela una nueva vista: agua, bambú y paredes blancas.",
        "Um dos quatro grandes jardins da China, o Jardim do Administrador Humilde empilha lagos, rochas ornamentais e pavilhões em 52 mil metros quadrados. Cada curva revela uma nova vista: água, bambu e paredes brancas.",
    ),
    tip=q(
        "Visit on a weekday morning — weekend crowds make the narrow paths feel packed.",
        "Приезжайте в будни утром — в выходные узкие дорожки переполнены.",
        "Visita un día laborable por la mañana: los fines de semana los caminos estrechos se llenan.",
        "Visite em dia de semana de manhã — nos fins de semana os caminhos estreitos ficam lotados.",
    ),
))

_ATTR(attraction(
    "sz-a2",
    name=q("Tiger Hill", "Тигровый холм", "Colina del Tigre", "Colina do Tigre"),
    description=q(
        "Leaning pagoda atop a legendary hill.",
        "Наклонная пагода на вершине легендарного холма.",
        "Pagoda inclinada sobre una colina legendaria.",
        "Pagode inclinado no alto de uma colina lendária.",
    ),
    detail=q(
        "Tiger Hill's 1,000-year-old Yunyan Pagoda leans noticeably like a smaller Pisa tower. Legend says a tiger appeared here after a white heron landed — the hill's name and mystique endure.",
        "Тысячелетняя пагода Юньянь на Тигровом холме заметно наклонена, как маленькая Пиза. Легенда гласит, что здесь появился тигр после белой цапли — название и мистика холма живы.",
        "La pagoda Yunyan de mil años en la Colina del Tigre se inclina como una Pisa pequeña. La leyenda dice que un tigre apareció aquí tras una garza blanca — el nombre y el misterio perduran.",
        "O pagode Yunyan de mil anos na Colina do Tigre inclina como uma Pisa menor. A lenda diz que um tigre apareceu aqui após uma garça branca — o nome e o mistério do morro persistem.",
    ),
    tip=q(
        "Climb to the pagoda base for the best angle on the lean — photos work best from the south side.",
        "Поднимитесь к основанию пагоды — с южной стороны наклон виден лучше всего.",
        "Sube a la base de la pagoda: desde el lado sur el inclinamiento se ve mejor en fotos.",
        "Suba à base do pagode — do lado sul o inclinamento aparece melhor nas fotos.",
    ),
))

_ATTR(attraction(
    "sz-a3",
    name=q("Pingjiang Road", "Улица Пинцзян", "Calle Pingjiang", "Rua Pingjiang"),
    description=q(
        "Canalside lane of teahouses and shops.",
        "Улица вдоль канала с чайными и магазинами.",
        "Calle junto al canal con casas de té y tiendas.",
        "Rua à beira do canal com casas de chá e lojas.",
    ),
    detail=q(
        "Pingjiang Historic Street threads 800 meters of stone lanes beside a canal lined with willows. Teahouses, craft shops, and Kunqu opera performances keep the old Suzhou atmosphere alive day and night.",
        "Историческая улица Пинцзян — 800 метров каменных улочек вдоль канала с ивами. Чайные, мастерские и представления оперы куньцю сохраняют атмосферу старого Сучжоу днём и ночью.",
        "La calle histórica Pingjiang recorre 800 metros de callejuelas de piedra junto a un canal con sauces. Casas de té, talleres y ópera Kunqu mantienen viva la atmósfera del Suzhou antiguo día y noche.",
        "A rua histórica Pingjiang percorre 800 metros de becos de pedra ao lado de um canal com salgueiros. Casas de chá, oficinas e ópera Kunqu mantêm viva a atmosfera do Suzhou antigo dia e noite.",
    ),
    tip=q(
        "Stop at a canal-side teahouse for biluochun tea — Suzhou's signature green brew.",
        "Загляните в чайную у канала — попробуйте билочунь, фирменный зелёный чай Сучжоу.",
        "Para en una casa de té junto al canal y prueba biluochun, el té verde emblemático de Suzhou.",
        "Pare em uma casa de chá à beira do canal e prove biluochun — o chá verde típico de Suzhou.",
    ),
))

_ATTR(attraction(
    "sz-a4",
    name=q("Silk Museum", "Музей шёлка", "Museo de la Seda", "Museu da Seda"),
    description=q(
        "Centuries of silk weaving tradition.",
        "Многовековые традиции шёлкового ткачества.",
        "Siglos de tradición en el tejido de la seda.",
        "Séculos de tradição na tecelagem da seda.",
    ),
    detail=q(
        "Suzhou Silk Museum traces silk production from silkworm cocoons to finished embroidery. Live weaving demonstrations and a replica of an ancient silk loom show how Suzhou became China's silk capital.",
        "Музей шёлка Сучжоу прослеживает путь от коконов до готовой вышивки. Демонстрации ткачества и копия древнего станка показывают, как Сучжоу стал шёлковой столицей Китая.",
        "El Museo de la Seda de Suzhou recorre la producción desde los capullos hasta el bordado terminado. Demostraciones de tejido en vivo y una réplica de telar antiguo muestran cómo Suzhou se convirtió en capital de la seda.",
        "O Museu da Seda de Suzhou traça a produção dos casulos até o bordado final. Demonstrações de tecelagem ao vivo e uma réplica de tear antigo mostram como Suzhou virou capital da seda da China.",
    ),
    tip=q(
        "Watch the silkworm feeding demo in the cultivation room — kids love it.",
        "Посмотрите демонстрацию кормления шелкопрядов — детям особенно интересно.",
        "Ve la demostración de alimentación de gusanos de seda: a los niños les encanta.",
        "Veja a demonstração de alimentação dos bichos-da-seda — os filhos adoram.",
    ),
))

_ATTR(attraction(
    "sz-a5",
    name=q("Jinji Lake", "Озеро Цзиньцзи", "Lago Jinji", "Lago Jinji"),
    description=q(
        "Modern lakefront with skyline views and night lights.",
        "Современная набережная с панорамой и ночной подсветкой.",
        "Orilla moderna con vistas al horizonte y luces nocturnas.",
        "Orla moderna com vista para o horizonte e luzes noturnas.",
    ),
    detail=q(
        "Jinji Lake is Suzhou's modern centerpiece — an artificial lake surrounded by the Suzhou Center mall, Ferris wheel, and waterfront promenades. Evening light shows and open-air concerts fill the lakeside calendar.",
        "Озеро Цзиньцзи — современный центр Сучжоу: искусственное озеро вокруг торгового центра Suzhou Center, колеса обозрения и набережных. Вечерние световые шоу и концерты заполняют календарь у воды.",
        "El Lago Jinji es el centro moderno de Suzhou: un lago artificial rodeado del Suzhou Center, una noria y paseos marítimos. Shows de luces y conciertos al aire libre llenan el calendario junto al agua.",
        "O Lago Jinji é o centro moderno de Suzhou — um lago artificial cercado pelo Suzhou Center, roda-gigante e calçadões. Shows de luzes e concertos ao ar livre lotam o calendário à beira da água.",
    ),
    tip=q(
        "Ride the Ferris wheel at dusk for sunset over the lake and city skyline.",
        "Прокатитесь на колесе обозрения на закате — вид на озеро и панораму города.",
        "Sube a la noria al atardecer para ver el sol sobre el lago y el horizonte urbano.",
        "Pegue a roda-gigante ao pôr do sol para ver o sol sobre o lago e o horizonte da cidade.",
    ),
))

# Harbin
_ATTR(attraction(
    "hb-a1",
    name=q("Ice Festival", "Ледовый фестиваль", "Festival del Hielo", "Festival do Gelo"),
    description=q(
        "Massive illuminated ice sculptures at night.",
        "Огромные ледяные скульптуры, подсвеченные ночью.",
        "Enormes esculturas de hielo iluminadas por la noche.",
        "Enormes esculturas de gelo iluminadas à noite.",
    ),
    detail=q(
        "Every January, Harbin Ice and Snow World builds a frozen city of palaces, towers, and slides from blocks of river ice. Millions of LED lights turn the sculptures into a glowing fantasyland that lasts until March.",
        "Каждый январь в Ледовом и снежном мире Харбина из речного льда строят замки, башни и горки. Миллионы светодиодов превращают скульптуры в светящийся фантастический город, который живёт до марта.",
        "Cada enero, el Mundo de Hielo y Nieve de Harbin construye una ciudad helada de palacios, torres y toboganes con bloques de hielo de río. Millones de LED convierten las esculturas en un mundo de fantasía luminoso hasta marzo.",
        "Todo janeiro, o Mundo de Gelo e Neve de Harbin constrói uma cidade congelada de palácios, torres e escorregadores com blocos de gelo de rio. Milhões de LEDs transformam as esculturas em um mundo de fantasia luminoso até março.",
    ),
    tip=q(
        "Dress in layers and rent padded boots on site — temperatures drop below −20°C at night.",
        "Одевайтесь слоями и арендуйте утеплённые ботинки на месте — ночью ниже −20 °C.",
        "Viste en capas y alquila botas acolchadas allí: de noche baja de −20 °C.",
        "Vista-se em camadas e alugue botas forradas no local — à noite cai abaixo de −20 °C.",
    ),
))

_ATTR(attraction(
    "hb-a2",
    name=q("Central Street", "Центральная улица", "Calle Central", "Rua Central"),
    description=q(
        "Historic cobblestone boulevard.",
        "Исторический бульвар, мощённый камнем.",
        "Histórico bulevar adoquinado.",
        "Histórico boulevard de paralelepípedos.",
    ),
    detail=q(
        "Built in 1898, Central Street stretches 1.4 km of cobblestones lined with Baroque and Renaissance facades. Russian bakeries, European delis, and ice-cream shops make it Harbin's most atmospheric walk.",
        "Построенная в 1898 году, Центральная улица — 1,4 км брусчатки с фасадами в стиле барокко и ренессанса. Русские булочные, европейские деликатесы и мороженое — самая атмосферная прогулка Харбина.",
        "Construida en 1898, la Calle Central recorre 1,4 km de adoquines con fachadas barrocas y renacentistas. Panaderías rusas, delicatessen europeas y heladerías: el paseo más atmosférico de Harbin.",
        "Construída em 1898, a Rua Central percorre 1,4 km de paralelepípedos com fachadas barrocas e renascentistas. Padarias russas, delicatessen europeas e sorveterias — o passeio mais atmosférico de Harbin.",
    ),
    tip=q(
        "Try the original Harbin sausage and Ma Die'er bread from the century-old shops.",
        "Попробуйте фирменную харбинскую колбасу и хлеб Ма Диеэр из столетних лавок.",
        "Prueba la salchicha original de Harbin y el pan Ma Die'er de las tiendas centenarias.",
        "Prove a salsicha original de Harbin e o pão Ma Die'er das lojas centenárias.",
    ),
))

_ATTR(attraction(
    "hb-a3",
    name=q("Saint Sophia", "Собор Святой Софии", "Santa Sofía", "Santa Sofia"),
    description=q(
        "Byzantine-style cathedral turned museum.",
        "Собор в византийском стиле, превращённый в музей.",
        "Catedral de estilo bizantino convertida en museo.",
        "Catedral em estilo bizantino transformada em museu.",
    ),
    detail=q(
        "Built in 1907, Saint Sophia Cathedral is the largest Byzantine-style church in the Far East. Its green dome and red brick walls now house a museum of Harbin's Russian architectural heritage.",
        "Построенный в 1907 году, собор Святой Софии — крупнейший византийский храм на Дальнем Востоке. Зелёный купол и красные кирпичные стены теперь — музей русской архитектуры Харбина.",
        "Construida en 1907, la catedral de Santa Sofía es la iglesia bizantina más grande del Lejano Oriente. Su cúpula verde y muros de ladrillo rojo albergan hoy un museo de la arquitectura rusa de Harbin.",
        "Construída em 1907, a catedral de Santa Sofia é a maior igreja bizantina do Extremo Oriente. Sua cúpula verde e paredes de tijolo vermelho abrigam hoje um museu da arquitetura russa de Harbin.",
    ),
    tip=q(
        "Photograph the cathedral from the square at night when floodlights highlight the dome.",
        "Фотографируйте собор с площади ночью — прожекторы подсвечивают купол.",
        "Fotografía la catedral desde la plaza de noche, cuando los focos resaltan la cúpula.",
        "Fotografe a catedral da praça à noite, quando os refletores destacam a cúpula.",
    ),
))

_ATTR(attraction(
    "hb-a4",
    name=q("Snow World", "Мир снега", "Mundo de Nieve", "Mundo da Neve"),
    description=q(
        "Fantasy snow castles and slides.",
        "Сказочные снежные замки и горки.",
        "Fantásticos castillos de nieve y toboganes.",
        "Fantásticos castelos de neve e escorregadores.",
    ),
    detail=q(
        "Harbin Snow World rivals the Ice Festival with massive snow sculptures and illuminated snow buildings. Giant snow slides and castle replicas draw families during the day, while colored lights transform the park at night.",
        "Снежный мир Харбина соперничает с Ледовым фестивалем: гигантские снежные скульптуры и подсвечённые снежные постройки. Большие горки и копии замков — для семей днём, цветные огни — ночью.",
        "El Mundo de Nieve de Harbin rivaliza con el Festival del Hielo con enormes esculturas y edificios de nieve iluminados. Toboganes gigantes y réplicas de castillos atraen familias de día; luces de colores transforman el parque de noche.",
        "O Mundo da Neve de Harbin rivaliza com o Festival do Gelo com enormes esculturas e construções de neve iluminadas. Escorregadores gigantes e réplicas de castelos atraem famílias de dia; luzes coloridas transformam o parque à noite.",
    ),
    tip=q(
        "Visit both Snow World and Ice Festival on separate evenings — each park takes two to three hours.",
        "Посетите Снежный мир и Ледовой фестиваль в разные вечера — каждый парк занимает два-три часа.",
        "Visita el Mundo de Nieve y el Festival del Hielo en noches distintas: cada parque lleva dos o tres horas.",
        "Visite o Mundo da Neve e o Festival do Gelo em noites diferentes — cada parque leva duas ou três horas.",
    ),
))

_ATTR(attraction(
    "hb-a5",
    name=q("Harbin Opera House", "Харбинский оперный театр", "Ópera de Harbin", "Ópera de Harbin"),
    description=q(
        "Striking modern opera house on the Songhua River.",
        "Эффектный современный оперный театр на реке Сунгари.",
        "Impactante ópera moderna junto al río Songhua.",
        "Impactante ópera moderna às margens do rio Songhua.",
    ),
    detail=q(
        "Designed by MAD Architects, the Harbin Opera House curves like frozen waves beside the Songhua River. The white granite exterior and warm wood interior host opera, ballet, and symphony performances year-round.",
        "Спроектированный MAD Architects, Харбинский оперный театр изгибается у реки Сунгари, как застывшие волны. Белый гранит снаружи и тёплое дерево внутри — опера, балет и симфонии круглый год.",
        "Diseñada por MAD Architects, la Ópera de Harbin se curva junto al río Songhua como olas congeladas. Granito blanco por fuera y madera cálida por dentro acogen ópera, ballet y sinfonías todo el año.",
        "Desenhada por MAD Architects, a Ópera de Harbin se curva junto ao rio Songhua como ondas congeladas. Granito branco por fora e madeira quente por dentro abrigam ópera, balé e sinfonias o ano inteiro.",
    ),
    tip=q(
        "Book a backstage tour on weekdays — the architecture is even more dramatic from inside.",
        "Закажите экскурсию за сценой в будни — архитектура изнутри ещё эффектнее.",
        "Reserva un tour entre bastidores entre semana: la arquitectura es más dramática desde dentro.",
        "Reserve um tour nos bastidores em dias úteis — a arquitetura é mais dramática por dentro.",
    ),
))

# Guangzhou
_ATTR(attraction(
    "gz-a1",
    name=q("Canton Tower", "Кантонская башня", "Torre de Cantón", "Torre de Cantão"),
    description=q(
        "A colorful landmark with panoramic views over the Pearl River.",
        "Яркая достопримечательность с панорамным видом на Жемчужную реку.",
        "Un colorido símbolo con vistas panorámicas al río de las Perlas.",
        "Um marco colorido com vista panorâmica para o Rio das Pérolas.",
    ),
    detail=q(
        "At 600 meters, Canton Tower is one of the world's tallest towers. Its twisted hyperboloid shape lights up in rainbow colors at night, and the bubble tram on the observation deck rotates slowly above the Pearl River.",
        "Высота 600 метров — Кантонская башня одна из самых высоких в мире. Скрученный гиперболоид ночью светится радугой, а пузырьковый вагончик на смотровой медленно вращается над Жемчужной рекой.",
        "Con 600 metros, la Torre de Cantón es una de las más altas del mundo. Su forma hiperboloide retorcida se ilumina en arcoíris de noche, y el tranvía burbuja en la plataforma gira lentamente sobre el río de las Perlas.",
        "Com 600 metros, a Torre de Cantão é uma das mais altas do mundo. Sua forma hiperboloide torcida se ilumina em arco-íris à noite, e o bonde bolha no mirante gira lentamente sobre o Rio das Pérolas.",
    ),
    tip=q(
        "Ride the bubble tram at dusk — the city lights switch on as the cabin climbs.",
        "Прокатитесь на пузырьковом вагончике на закате — огни зажигаются во время подъёма.",
        "Sube al tranvía burbuja al atardecer: las luces se encienden mientras asciende la cabina.",
        "Pegue o bonde bolha ao pôr do sol — as luzes acendem enquanto a cabine sobe.",
    ),
))

_ATTR(attraction(
    "gz-a2",
    name=q("Chen Clan Ancestral Hall", "Академия рода Чэнь", "Salón Ancestral del Clan Chen", "Salão Ancestral do Clã Chen"),
    description=q(
        "An ornate masterpiece of traditional Lingnan craftsmanship.",
        "Богато украшенный шедевр традиционного мастерства Линнаня.",
        "Una obra maestra ornamentada de la artesanía tradicional de Lingnan.",
        "Uma obra-prima ornamentada do artesanato tradicional de Lingnan.",
    ),
    detail=q(
        "Built in 1894 as a clan academy, this complex showcases exquisite wood, stone, and ceramic carvings across 19 halls. Every beam and bracket tells a story — dragons, flowers, and historical scenes in miniature detail.",
        "Построенная в 1894 году как академия рода, комплекс демонстрирует изящную резьбу по дереву, камню и керамике в 19 залах. На каждой балке — драконы, цветы и исторические сцены в мельчайших деталях.",
        "Construida en 1894 como academia del clan, el complejo exhibe tallas exquisitas en madera, piedra y cerámica en 19 salones. Cada viga cuenta una historia: dragones, flores y escenas históricas en miniatura.",
        "Construída em 1894 como academia do clã, o complexo exibe entalhes requintados em madeira, pedra e cerâmica em 19 salões. Cada viga conta uma história — dragões, flores e cenas históricas em miniatura.",
    ),
    tip=q(
        "Allow at least 90 minutes — the roof carvings alone deserve slow attention.",
        "Выделите минимум 90 минут — резьба на крышах сама по себе того стоит.",
        "Reserva al menos 90 minutos: las tallas del techo merecen atención pausada.",
        "Reserve pelo menos 90 minutos — os entalhes do telhado merecem atenção lenta.",
    ),
))

_ATTR(attraction(
    "gz-a3",
    name=q("Shamian Island", "Остров Шамянь", "Isla Shamian", "Ilha Shamian"),
    description=q(
        "Leafy streets lined with historic European-style buildings.",
        "Тенистые улицы с историческими зданиями в европейском стиле.",
        "Calles arboladas con edificios históricos de estilo europeo.",
        "Ruas arborizadas com edifícios históricos em estilo europeu.",
    ),
    detail=q(
        "This sandbank island was a foreign concession in the 19th century, and its colonial villas, churches, and tree-lined avenues feel like a slice of Europe in the Pearl River Delta. Cafés and sculpture gardens fill the quiet streets.",
        "Этот песчаный остров был иностранной концессией в XIX веке — колониальные виллы, церкви и аллеи с деревьями напоминают кусочек Европы в дельте Жемчужной реки. Кафе и скульптурные сады заполняют тихие улочки.",
        "Esta isla de arena fue concesión extranjera en el siglo XIX: villas coloniales, iglesias y avenidas arboladas parecen un trozo de Europa en el delta del río de las Perlas. Cafés y jardines de esculturas llenan las calles tranquilas.",
        "Esta ilha de areia foi concessão estrangeira no século XIX — vilas coloniais, igrejas e avenidas arborizadas parecem um pedaço de Europa no delta do Rio das Pérolas. Cafés e jardins de esculturas lotam as ruas tranquilas.",
    ),
    tip=q(
        "Walk the island on a weekday morning — weekends bring wedding photo crews to every corner.",
        "Гуляйте в будни утром — в выходные на каждом углу свадебные фотосессии.",
        "Recorre la isla un día laborable por la mañana: los fines de semana hay fotógrafos de bodas en cada rincón.",
        "Caminhe na ilha em dia de semana de manhã — nos fins de semana há fotógrafos de casamento em cada esquina.",
    ),
))

_ATTR(attraction(
    "gz-a4",
    name=q("Baiyun Mountain", "Гора Байюнь", "Montaña Baiyun", "Montanha Baiyun"),
    description=q(
        "Green trails and sweeping views above the city.",
        "Зелёные тропы и широкие панорамы города.",
        "Senderos verdes y amplias vistas sobre la ciudad.",
        "Trilhas verdes e amplas vistas da cidade.",
    ),
    detail=q(
        "Baiyun Mountain rises 382 meters above Guangzhou, offering forest trails, waterfalls, and a cable car to the summit. On clear days the view stretches across the entire Pearl River Delta megacity.",
        "Байюнь поднимается 382 метра над Гуанчжоу — лесные тропы, водопады и канатная дорога на вершину. В ясный день вид уходит на весь мегаполис дельты Жемчужной реки.",
        "Baiyun se eleva 382 metros sobre Cantón con senderos forestales, cascadas y teleférico a la cima. En días claros la vista abarca toda la megaciudad del delta del río de las Perlas.",
        "Baiyun se eleva 382 metros sobre Guangzhou com trilhas na floresta, cachoeiras e teleférico até o topo. Em dias claros a vista alcança toda a megacidade do delta do Rio das Pérolas.",
    ),
    tip=q(
        "Take the cable car up and walk down — the descent through the forest takes about an hour.",
        "Поднимитесь на канатной дороге и спуститесь пешком — спуск через лес около часа.",
        "Sube en teleférico y baja caminando: el descenso por el bosque lleva una hora.",
        "Suba no teleférico e desça a pé — a descida pela floresta leva cerca de uma hora.",
    ),
))

_ATTR(attraction(
    "gz-a5",
    name=q("Zhujiang New Town", "Новый город Чжуцзян", "Nueva Ciudad Zhujiang", "Nova Cidade Zhujiang"),
    description=q(
        "Guangzhou's glittering CBD along the Pearl River.",
        "Сияющий деловой центр Гуанчжоу вдоль Жемчужной реки.",
        "El brillante CBD de Cantón junto al río de las Perlas.",
        "O brilhante CBD de Guangzhou às margens do Rio das Pérolas.",
    ),
    detail=q(
        "Zhujiang New Town clusters Guangzhou's tallest towers, the Opera House, and the Library around a central axis. The evening light show on the riverfront buildings rivals any skyline spectacle in China.",
        "Новый город Чжуцзян собирает самые высокие башни Гуанчжоу, оперный театр и библиотеку вокруг центральной оси. Вечернее световое шоу на набережных не уступает любому в Китае.",
        "Zhujiang New Town concentra las torres más altas de Cantón, la Ópera y la Biblioteca en torno a un eje central. El show de luces nocturno en los edificios del paseo marítimo rivaliza con cualquier espectáculo urbano de China.",
        "Zhujiang New Town concentra as torres mais altas de Guangzhou, a Ópera e a Biblioteca em torno de um eixo central. O show de luzes noturno nos prédios da orla rivaliza com qualquer espetáculo urbano da China.",
    ),
    tip=q(
        "Watch the light show from Haixinsha Island — the view across the river is unobstructed.",
        "Смотрите световое шоу с острова Хайсинша — вид через реку без помех.",
        "Ve el show de luces desde la isla Haixinsha: la vista al otro lado del río es despejada.",
        "Veja o show de luzes da ilha Haixinsha — a vista do outro lado do rio é desimpedida.",
    ),
))

# Shenzhen
_ATTR(attraction(
    "szh-a1",
    name=q("Ping An Finance Centre", "Финансовый центр Пинань", "Centro Financiero Ping An", "Centro Financeiro Ping An"),
    description=q(
        "One of the world's tallest skyscrapers and a symbol of modern Shenzhen.",
        "Один из самых высоких небоскрёбов мира и символ современного Шэньчжэня.",
        "Uno de los rascacielos más altos del mundo y símbolo del Shenzhen moderno.",
        "Um dos arranha-céus mais altos do mundo e símbolo da Shenzhen moderna.",
    ),
    detail=q(
        "At 599 meters, Ping An Finance Centre is Shenzhen's tallest building and among the world's top five supertalls. The free Sky Lobby on floor 116 offers a dizzying view straight down through the atrium.",
        "Высота 599 метров — финансовый центр Пинань самое высокое здание Шэньчжэня и в пяти самых высоких небоскрёбов мира. Бесплатное смотровое лобби на 116 этаже — головокружительный вид вниз через атриум.",
        "Con 599 metros, el Centro Financiero Ping An es el edificio más alto de Shenzhen y entre los cinco supertorres más altos del mundo. El Sky Lobby gratuito en el piso 116 ofrece una vista vertiginosa hacia abajo por el atrio.",
        "Com 599 metros, o Centro Financeiro Ping An é o prédio mais alto de Shenzhen e entre os cinco supertorres mais altos do mundo. O Sky Lobby gratuito no andar 116 oferece vista vertiginosa para baixo pelo átrio.",
    ),
    tip=q(
        "Visit the free Sky Lobby on weekday mornings — queues are shortest before 10 AM.",
        "Загляните в бесплатное смотровое лобби в будни утром — очереди короче до 10:00.",
        "Visita el Sky Lobby gratuito entre semana por la mañana: las colas son más cortas antes de las 10.",
        "Visite o Sky Lobby gratuito em dias úteis de manhã — as filas são menores antes das 10h.",
    ),
))

_ATTR(attraction(
    "szh-a2",
    name=q("Shenzhen Bay", "Залив Шэньчжэнь", "Bahía de Shenzhen", "Baía de Shenzhen"),
    description=q(
        "A waterfront promenade with skyline and sunset views.",
        "Набережная с видами на городской силуэт и закаты.",
        "Un paseo marítimo con vistas al horizonte y al atardecer.",
        "Um calçadão à beira-mar com vista para o horizonte e o pôr do sol.",
    ),
    detail=q(
        "Shenzhen Bay Park stretches 13 km along the waterfront with cycling paths, mangrove wetlands, and views of Hong Kong across the water. Sunset here paints the skyline gold as joggers and families fill the promenade.",
        "Парк залива Шэньчжэнь тянется 13 км вдоль набережной — велодорожки, мангровые болота и вид на Гонконг через воду. На закате панорама золотится, а набережную заполняют бегуны и семьи.",
        "Shenzhen Bay Park se extiende 13 km junto al mar con rutas ciclistas, manglares y vistas de Hong Kong al otro lado. Al atardecer el horizonte se tiñe de oro mientras corredores y familias llenan el paseo.",
        "O Shenzhen Bay Park se estende 13 km à beira-mar com ciclovias, manguezais e vista de Hong Kong do outro lado. Ao pôr do sol o horizonte fica dourado enquanto corredores e famílias lotam o calçadão.",
    ),
    tip=q(
        "Rent a bike at the park entrance and ride west toward the mangrove section at dusk.",
        "Арендуйте велосипед у входа и катите на запад к мангровым болотам на закате.",
        "Alquila una bici en la entrada y pedalea hacia el oeste hasta los manglares al atardecer.",
        "Alugue uma bicicleta na entrada e pedale para oeste em direção aos manguezais ao pôr do sol.",
    ),
))

_ATTR(attraction(
    "szh-a3",
    name=q("Dafen Oil Painting Village", "Деревня художников Дафэнь", "Aldea de Pintura al Óleo de Dafen", "Vila de Pintura a Óleo de Dafen"),
    description=q(
        "A creative neighborhood filled with artists and galleries.",
        "Творческий квартал, полный художников и галерей.",
        "Un barrio creativo lleno de artistas y galerías.",
        "Um bairro criativo repleto de artistas e galerias.",
    ),
    detail=q(
        "Dafen Village once produced over half the world's commercial oil paintings. Today hundreds of studios and galleries line the streets, where artists copy masterpieces or create custom portraits on the spot.",
        "Деревня Дафэнь когда-то производила более половины коммерческих картин маслом в мире. Сегодня сотни студий и галерей — художники копируют шедевры или рисуют портреты на заказ прямо на месте.",
        "Dafen produjo en su día más de la mitad de las pinturas al óleo comerciales del mundo. Hoy cientos de estudios y galerías llenan las calles, donde artistas copian obras maestras o pintan retratos al instante.",
        "Dafen produziu mais da metade das pinturas a óleo comerciais do mundo. Hoje centenas de estúdios e galerias lotam as ruas, onde artistas copiam obras-primas ou pintam retratos sob encomenda ali mesmo.",
    ),
    tip=q(
        "Ask an artist to paint your photo — a custom portrait takes about 30 minutes.",
        "Попросите художника нарисовать ваше фото — портрет на заказ около 30 минут.",
        "Pide a un artista que pinte tu foto: un retrato personalizado lleva unos 30 minutos.",
        "Peça a um artista que pinte sua foto — um retrato personalizado leva cerca de 30 minutos.",
    ),
))

_ATTR(attraction(
    "szh-a4",
    name=q("OCT Loft", "Арт-квартал OCT Loft", "OCT Loft", "OCT Loft"),
    description=q(
        "A former industrial area transformed into a lively arts district.",
        "Бывшая промышленная зона, превращённая в оживлённый арт-квартал.",
        "Una antigua zona industrial convertida en un animado distrito artístico.",
        "Uma antiga área industrial transformada em um animado distrito artístico.",
    ),
    detail=q(
        "OCT Loft converted 1980s factory warehouses into galleries, design studios, and indie bookshops. Weekend markets, live music, and craft beer bars give the red-brick courtyards a creative buzz.",
        "OCT Loft превратил заводские склады 1980-х в галереи, дизайн-студии и независимые книжные. По выходным — рынки, живую музыку и бары с крафтовым пивом в краснокирпичных дворах.",
        "OCT Loft convirtió almacenes de fábrica de los años 80 en galerías, estudios de diseño y librerías independientes. Mercados de fin de semana, música en vivo y bares de cerveza artesanal animan los patios de ladrillo rojo.",
        "OCT Loft transformou armazéns de fábrica dos anos 80 em galerias, estúdios de design e livrarias independentes. Feiras de fim de semana, música ao vivo e bares de cerveja artesanal animam os pátios de tijolo vermelho.",
    ),
    tip=q(
        "Visit on Saturday afternoon when the weekend market and gallery openings peak.",
        "Приезжайте в субботу днём — пик выходного рынка и открытий галерей.",
        "Visita el sábado por la tarde, cuando el mercado de fin de semana y las aperturas de galerías alcanzan su pico.",
        "Visite no sábado à tarde, quando a feira de fim de semana e as aberturas de galerias atingem o pico.",
    ),
))

_ATTR(attraction(
    "szh-a5",
    name=q("Design Society", "Design Society", "Design Society", "Design Society"),
    description=q(
        "Shenzhen's flagship design museum at Sea World.",
        "Главный дизайн-музей Шэньчжэня в Sea World.",
        "El museo de diseño insignia de Shenzhen en Sea World.",
        "O museu de design flagship de Shenzhen no Sea World.",
    ),
    detail=q(
        "Designed by Fumihiko Maki, Design Society is China's first design museum, partnered with London's V&A. Rotating exhibitions cover architecture, fashion, and product design in a striking waterfront building.",
        "Спроектированный Фумихико Маки, Design Society — первый дизайн-музей Китая, партнёр лондонского V&A. Временные экспозиции об архитектуре, моде и промышленном дизайне в эффектном здании у воды.",
        "Diseñado por Fumihiko Maki, Design Society es el primer museo de diseño de China, en colaboración con el V&A de Londres. Exposiciones rotativas de arquitectura, moda y diseño de producto en un edificio impactante junto al mar.",
        "Desenhado por Fumihiko Maki, o Design Society é o primeiro museu de design da China, em parceria com o V&A de Londres. Exposições rotativas de arquitetura, moda e design de produto em um prédio marcante à beira-mar.",
    ),
    tip=q(
        "Check the V&A partnership exhibitions — they rotate every few months and are top quality.",
        "Смотрите экспозиции совместно с V&A — они меняются каждые несколько месяцев и очень качественные.",
        "Revisa las exposiciones en colaboración con el V&A: rotan cada pocos meses y son de gran calidad.",
        "Confira as exposições em parceria com o V&A — elas mudam a cada poucos meses e são de alta qualidade.",
    ),
))

# Hong Kong
_ATTR(attraction(
    "hk-a1",
    name=q("Victoria Peak", "Пик Виктория", "Pico Victoria", "Pico Victoria"),
    description=q(
        "Panoramic views over the harbor.",
        "Панорамные виды на гавань.",
        "Vistas panorámicas del puerto.",
        "Vista panorâmica do porto.",
    ),
    detail=q(
        "Victoria Peak rises 552 meters above Hong Kong Island, offering the city's most famous skyline view. The Peak Tram climbs steeply through jungle, and the Sky Terrace 428 overlooks the harbor, Kowloon, and distant islands.",
        "Пик Виктория поднимается 552 метра над островом Гонконг — самый знаменитый вид на панораму города. Фуникулёр Peak Tram круто поднимается через джунгли, а Sky Terrace 428 смотрит на гавань, Коулун и далёкие острова.",
        "El Pico Victoria se eleva 552 metros sobre la isla de Hong Kong con la vista más famosa del horizonte. El Peak Tram asciende empinado entre la jungla, y el Sky Terrace 428 domina el puerto, Kowloon y las islas lejanas.",
        "O Pico Victoria se eleva 552 metros sobre a ilha de Hong Kong com a vista mais famosa do horizonte. O Peak Tram sobe íngreme pela selva, e o Sky Terrace 428 domina o porto, Kowloon e ilhas distantes.",
    ),
    tip=q(
        "Ride the Peak Tram up and walk down the Lugard Road circuit for fewer crowds.",
        "Поднимитесь на Peak Tram и спуститесь по кольцевой дороге Лугард — меньше толп.",
        "Sube en el Peak Tram y baja por el circuito de Lugard Road para evitar multitudes.",
        "Suba no Peak Tram e desça pelo circuito da Lugard Road para evitar multidões.",
    ),
))

_ATTR(attraction(
    "hk-a2",
    name=q("Star Ferry", "Паром Star Ferry", "Star Ferry", "Star Ferry"),
    description=q(
        "Historic harbor crossing at sunset.",
        "Историческая переправа через гавань на закате.",
        "Histórico cruce del puerto al atardecer.",
        "Travessia histórica do porto ao pôr do sol.",
    ),
    detail=q(
        "Operating since 1888, the Star Ferry crosses Victoria Harbour between Central and Tsim Sha Tsui in about ten minutes. The ride costs less than a coffee but delivers Hong Kong's most iconic harbor panorama.",
        "С 1888 года паром Star Ferry пересекает гавань Виктория между Central и Цим Ша Цуй за десять минут. Поездка дешевле чашки кофе, а вид на гавань — самый знаковый в Гонконге.",
        "En funcionamiento desde 1888, el Star Ferry cruza el Puerto Victoria entre Central y Tsim Sha Tsui en unos diez minutos. El viaje cuesta menos que un café y ofrece la panorámica más icónica del puerto.",
        "Em operação desde 1888, o Star Ferry cruza o Porto Victoria entre Central e Tsim Sha Tsui em cerca de dez minutos. A viagem custa menos que um café e traz a panorâmica mais icônica do porto.",
    ),
    tip=q(
        "Take the Tsim Sha Tsui to Central route at sunset — sit on the upper deck starboard side.",
        "Берите маршрут Цим Ша Цуй — Central на закате, сидите на верхней палубе на правом борту.",
        "Toma la ruta Tsim Sha Tsui a Central al atardecer y siéntate en la cubierta superior a estribor.",
        "Pegue a rota Tsim Sha Tsui a Central ao pôr do sol e sente-se no convés superior à estibordo.",
    ),
))

_ATTR(attraction(
    "hk-a3",
    name=q("Temple Street", "Улица Темпл", "Calle Temple", "Rua Temple"),
    description=q(
        "Night market of street food, fortune tellers, and bargains.",
        "Ночной рынок с уличной едой, гадалками и торгом.",
        "Mercado nocturno de comida callejera, adivinos y gangas.",
        "Mercado noturno de comida de rua, cartomantes e pechinchas.",
    ),
    detail=q(
        "Temple Street Night Market lights up after dark with seafood stalls, dai pai dong eateries, and fortune tellers under red lanterns. Bargain for electronics, clothes, and opera masks in the lively Kowloon atmosphere.",
        "Ночной рынок на улице Темпл зажигается после заката: морепродукты, уличные кафе и гадалки под красными фонарями. Торгуйте за электронику, одежду и маски оперы в оживлённой атмосфере Коулуна.",
        "El mercado nocturno de Temple Street se enciende al anochecer con mariscos, dai pai dong y adivinos bajo farolillos rojos. Regatea electrónica, ropa y máscaras de ópera en el bullicio de Kowloon.",
        "O mercado noturno da Rua Temple acende depois do anoitecer com frutos do mar, dai pai dong e cartomantes sob lanternas vermelhas. Negocie eletrônicos, roupas e máscaras de ópera no clima agitado de Kowloon.",
    ),
    tip=q(
        "Eat at a dai pai dong stall — order typhoon shelter crab and clams with black bean sauce.",
        "Ешьте в уличном кафе — закажите краба в пряном соусе и моллюски с чёрными бобами.",
        "Come en un dai pai dong: pide cangrejo typhoon shelter y almejas con salsa de frijol negro.",
        "Coma em um dai pai dong — peça caranguejo typhoon shelter e mariscos com molho de feijão preto.",
    ),
))

_ATTR(attraction(
    "hk-a4",
    name=q("Dim Sum", "Димсам", "Dim sum", "Dim sum"),
    description=q(
        "Hong Kong's beloved brunch of steamed baskets and tea.",
        "Любимый бранч Гонконга — паровые корзинки и чай.",
        "El brunch favorito de Hong Kong: cestas al vapor y té.",
        "O brunch favorito de Hong Kong: cestas no vapor e chá.",
    ),
    detail=q(
        "Yum cha — drinking tea with dim sum — is Hong Kong's weekend ritual. Bamboo baskets deliver har gow shrimp dumplings, siu mai pork, and char siu buns while servers pour endless jasmine tea.",
        "Ямча — чай с димсамом — выходной ритуал Гонконга. Бамбуковые корзинки несут хар гау, сиу май и булочки с чар-сю, а официанты наливают бесконечный жасминовый чай.",
        "El yum cha — té con dim sum — es el ritual de fin de semana de Hong Kong. Cestas de bambú traen har gow, siu mai y bollos de char siu mientras sirven té de jazmín sin parar.",
        "O yum cha — chá com dim sum — é o ritual de fim de semana de Hong Kong. Cestas de bambu trazem har gow, siu mai e pães de char siu enquanto servem chá de jasmim sem parar.",
    ),
    tip=q(
        "Go early on Sunday morning — the best baskets sell out by 11 AM at popular teahouses.",
        "Приходите рано в воскресенье — в популярных чайных лучшие корзинки заканчиваются к 11:00.",
        "Ve temprano el domingo por la mañana: en las casas de té populares lo mejor se agota a las 11.",
        "Chegue cedo no domingo de manhã — nas casas de chá populares o melhor acaba às 11h.",
    ),
))

_ATTR(attraction(
    "hk-a5",
    name=q("M+ Museum", "Музей M+", "Museo M+", "Museu M+"),
    description=q(
        "Asia's flagship museum of visual culture on the waterfront.",
        "Главный музей визуальной культуры Азии на набережной.",
        "El museo insignia de cultura visual de Asia junto al mar.",
        "O museu flagship de cultura visual da Ásia à beira-mar.",
    ),
    detail=q(
        "M+ opened in 2021 as Hong Kong's museum of visual culture — art, design, architecture, and moving image. The Herzog & de Meuron building anchors the West Kowloon Cultural District with a bold skyline silhouette.",
        "M+ открылся в 2021 году как музей визуальной культуры Гонконга — искусство, дизайн, архитектура и кинематограф. Здание бюро Herzog & de Meuron — опора культурного района Западного Коулуна с ярким силуэтом в панораме.",
        "M+ abrió en 2021 como museo de cultura visual de Hong Kong: arte, diseño, arquitectura e imagen en movimiento. El edificio de Herzog & de Meuron ancla el distrito cultural de West Kowloon con un perfil audaz en el horizonte.",
        "M+ abriu em 2021 como museu de cultura visual de Hong Kong — arte, design, arquitetura e imagem em movimento. O prédio de Herzog & de Meuron ancora o distrito cultural de West Kowloon com um perfil marcante no horizonte.",
    ),
    tip=q(
        "Visit the rooftop garden for free — the harbor view rivals the galleries inside.",
        "Загляните на крышный сад бесплатно — вид на гавань не уступает экспозициям.",
        "Visita el jardín en la azotea gratis: la vista del puerto rivaliza con las galerías.",
        "Visite o jardim no terraço gratuitamente — a vista do porto rivaliza com as galerias.",
    ),
))


def main() -> None:
    strings: dict[str, dict[str, str]] = {}
    strings.update(CITIES)
    strings.update(FACTS)
    strings.update(ATTRACTIONS)
    added = merge(strings)
    print(f"Merged {len(strings)} Journey keys ({added} newly added)")


if __name__ == "__main__":
    main()
