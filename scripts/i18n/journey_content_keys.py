#!/usr/bin/env python3
"""Merge complete Journey UI, fact, and attraction translations."""
from __future__ import annotations

from merge_xcstrings import merge


def q(en: str, ru: str, es: str, pt: str) -> dict[str, str]:
    return {"en": en, "ru": ru, "es": es, "pt-BR": pt}


STRINGS = {
    "common.words": q("Words", "Слова", "Palabras", "Palavras"),
    "journey.stats.games": q("Games", "Игры", "Juegos", "Jogos"),
    "journey.cities_explored %lld %lld": q(
        "%lld of %lld cities explored", "Исследовано городов: %lld из %lld",
        "%lld de %lld ciudades exploradas", "%lld de %lld cidades exploradas",
    ),
    "journey.collectibles_collected %lld %lld": q(
        "%lld of %lld collectibles collected", "Собрано сувениров: %lld из %lld",
        "%lld de %lld objetos coleccionados", "%lld de %lld itens coletados",
    ),
    "journey.map.route_title": q(
        "Your Route Across China", "Ваш маршрут по Китаю",
        "Tu ruta por China", "Sua rota pela China",
    ),
    "journey.map.chapter_complete": q(
        "Chapter complete", "Глава завершена", "Capítulo completado", "Capítulo concluído",
    ),
    "journey.map.explored %lld": q(
        "%lld%% explored", "Исследовано: %lld%%", "%lld%% explorado", "%lld%% explorado",
    ),
    "journey.souvenirs.empty_title": q(
        "No Souvenirs Yet", "Сувениров пока нет", "Aún no hay recuerdos", "Ainda não há souvenirs",
    ),
    "journey.mini.duration_xp %lld": q(
        "~25 sec · +%lld XP", "≈25 сек · +%lld XP", "≈25 s · +%lld XP", "≈25 s · +%lld XP",
    ),
    "journey.mini.seconds %lld": q("%lld sec", "%lld сек", "%lld s", "%lld s"),
    "journey.req.daily_streak %lld": q(
        "Complete the daily challenge %lld days in a row",
        "Выполнять ежедневное задание %lld дней подряд",
        "Completa el desafío diario durante %lld días seguidos",
        "Conclua o desafio diário por %lld dias seguidos",
    ),
    "journey.req.achievement": q(
        "Earn the required achievement", "Получить нужное достижение",
        "Consigue el logro requerido", "Conquiste a realização necessária",
    ),

    # Beijing
    "journey.fact.bj1": q(
        "The Forbidden City has nearly 9,000 rooms.",
        "В Запретном городе насчитывается почти 9 000 помещений.",
        "La Ciudad Prohibida tiene casi 9000 estancias.",
        "A Cidade Proibida tem quase 9 mil cômodos.",
    ),
    "journey.fact.bj2": q(
        "The Great Wall stretches over 21,000 km across northern China.",
        "Великая Китайская стена протянулась более чем на 21 000 км по северу страны.",
        "La Gran Muralla recorre más de 21 000 km por el norte de China.",
        "A Grande Muralha se estende por mais de 21 mil km no norte da China.",
    ),
    "journey.fact.bj3": q(
        "Beijing opera is one of China's most celebrated art forms.",
        "Пекинская опера — один из самых известных видов искусства Китая.",
        "La ópera de Pekín es una de las artes más célebres de China.",
        "A ópera de Pequim é uma das artes mais celebradas da China.",
    ),
    "journey.attraction.bj-a1.name": q("Forbidden City", "Запретный город", "Ciudad Prohibida", "Cidade Proibida"),
    "journey.attraction.bj-a1.description": q("Imperial palace of the Ming and Qing dynasties.", "Императорский дворец династий Мин и Цин.", "Palacio imperial de las dinastías Ming y Qing.", "Palácio imperial das dinastias Ming e Qing."),
    "journey.attraction.bj-a2.name": q("Great Wall", "Великая Китайская стена", "Gran Muralla", "Grande Muralha"),
    "journey.attraction.bj-a2.description": q("Ancient fortification winding through mountains.", "Древнее укрепление, извивающееся среди гор.", "Antigua fortificación que serpentea entre montañas.", "Antiga fortificação que serpenteia pelas montanhas."),
    "journey.attraction.bj-a3.name": q("Temple of Heaven", "Храм Неба", "Templo del Cielo", "Templo do Céu"),
    "journey.attraction.bj-a3.description": q("Sacred site where emperors prayed for harvests.", "Священное место, где императоры молились об урожае.", "Lugar sagrado donde los emperadores rezaban por las cosechas.", "Local sagrado onde os imperadores rezavam por boas colheitas."),
    "journey.attraction.bj-a4.name": q("Peking Duck", "Утка по-пекински", "Pato pekinés", "Pato à pequinesa"),
    "journey.attraction.bj-a4.description": q("Crispy-skinned duck, Beijing's signature dish.", "Утка с хрустящей корочкой — фирменное блюдо Пекина.", "Pato de piel crujiente, el plato emblemático de Pekín.", "Pato de pele crocante, prato emblemático de Pequim."),

    # Xi'an
    "journey.fact.xa1": q("Over 8,000 Terracotta Warriors guard Emperor Qin's tomb.", "Более 8 000 терракотовых воинов охраняют гробницу императора Цинь.", "Más de 8000 guerreros de terracota custodian la tumba del emperador Qin.", "Mais de 8 mil guerreiros de terracota guardam a tumba do imperador Qin."),
    "journey.fact.xa2": q("The Silk Road began here, connecting China to the Mediterranean.", "Здесь начинался Шёлковый путь, соединявший Китай со Средиземноморьем.", "Aquí comenzaba la Ruta de la Seda, que conectaba China con el Mediterráneo.", "A Rota da Seda começava aqui, ligando a China ao Mediterrâneo."),
    "journey.fact.xa3": q("Xi'an's city wall is one of the best preserved in the world.", "Городская стена Сианя — одна из лучше всего сохранившихся в мире.", "La muralla de Xi'an es una de las mejor conservadas del mundo.", "A muralha de Xi'an é uma das mais bem preservadas do mundo."),
    "journey.attraction.xa-a1.name": q("Terracotta Army", "Терракотовая армия", "Ejército de Terracota", "Exército de Terracota"),
    "journey.attraction.xa-a1.description": q("Life-size clay soldiers buried with China's first emperor.", "Глиняные воины в натуральную величину, погребённые с первым императором Китая.", "Soldados de arcilla de tamaño natural enterrados con el primer emperador de China.", "Soldados de argila em tamanho natural enterrados com o primeiro imperador da China."),
    "journey.attraction.xa-a2.name": q("City Wall", "Городская стена", "Muralla de la ciudad", "Muralha da cidade"),
    "journey.attraction.xa-a2.description": q("Cycle atop Ming-era fortifications.", "Прокатитесь на велосипеде по укреплениям эпохи Мин.", "Recorre en bicicleta las fortificaciones de la época Ming.", "Pedale pelas fortificações da era Ming."),
    "journey.attraction.xa-a3.name": q("Muslim Quarter", "Мусульманский квартал", "Barrio musulmán", "Bairro muçulmano"),
    "journey.attraction.xa-a3.description": q("Vibrant lanes of street food and culture.", "Оживлённые улицы, полные еды и культуры.", "Animadas callejuelas llenas de comida y cultura.", "Ruas vibrantes repletas de comida e cultura."),
    "journey.attraction.xa-a4.name": q("Big Wild Goose Pagoda", "Большая пагода Диких гусей", "Gran Pagoda del Ganso Salvaje", "Grande Pagode do Ganso Selvagem"),
    "journey.attraction.xa-a4.description": q("Buddhist pagoda from the Tang dynasty.", "Буддийская пагода времён династии Тан.", "Pagoda budista de la dinastía Tang.", "Pagode budista da dinastia Tang."),

    # Chengdu
    "journey.fact.cd1": q("Chengdu is home to the world-famous giant panda breeding center.", "В Чэнду находится всемирно известный центр разведения больших панд.", "Chengdú alberga el famoso centro de cría del panda gigante.", "Chengdu abriga o mundialmente famoso centro de reprodução de pandas-gigantes."),
    "journey.fact.cd2": q("Tea houses here are social hubs where locals play mahjong for hours.", "Местные чайные — центры общения, где жители часами играют в маджонг.", "Las casas de té son centros sociales donde se juega al mahjong durante horas.", "As casas de chá são pontos de encontro onde os moradores jogam mahjong por horas."),
    "journey.fact.cd3": q("Sichuan cuisine is legendary for its bold, numbing spice.", "Сычуаньская кухня знаменита яркой, обжигающе-пряной остротой.", "La cocina de Sichuan es célebre por su sabor intenso y picante adormecedor.", "A culinária de Sichuan é famosa pelo sabor intenso e picante que adormece a boca."),
    "journey.attraction.cd-a1.name": q("Panda Base", "База больших панд", "Base de pandas", "Base de pandas"),
    "journey.attraction.cd-a1.description": q("Meet giant pandas up close.", "Увидьте больших панд совсем близко.", "Conoce de cerca a los pandas gigantes.", "Veja pandas-gigantes bem de perto."),
    "journey.attraction.cd-a2.name": q("Jinli Street", "Улица Цзиньли", "Calle Jinli", "Rua Jinli"),
    "journey.attraction.cd-a2.description": q("Ancient-style pedestrian lane at night.", "Пешеходная улица в старинном стиле, особенно красивая ночью.", "Calle peatonal de estilo antiguo, especialmente bella de noche.", "Rua de pedestres em estilo antigo, especialmente bonita à noite."),
    "journey.attraction.cd-a3.name": q("Hot Pot", "Сычуаньский хого", "Hot pot", "Hot pot"),
    "journey.attraction.cd-a3.description": q("Simmering spicy broth, Chengdu style.", "Кипящий острый бульон по-чэндуски.", "Caldo picante hirviendo al estilo de Chengdú.", "Caldo picante borbulhante ao estilo de Chengdu."),
    "journey.attraction.cd-a4.name": q("Wuhou Shrine", "Храм Ухоу", "Templo Wuhou", "Templo Wuhou"),
    "journey.attraction.cd-a4.description": q("Temple honoring Three Kingdoms heroes.", "Храм в честь героев эпохи Троецарствия.", "Templo dedicado a los héroes de los Tres Reinos.", "Templo dedicado aos heróis dos Três Reinos."),

    # Guilin
    "journey.fact.gl1": q("“Guilin's scenery is the finest under heaven” — ancient Chinese proverb.", "«Пейзажи Гуйлиня — лучшие под небесами» — древняя китайская пословица.", "«Los paisajes de Guilin son los mejores bajo el cielo», antiguo proverbio chino.", "“A paisagem de Guilin é a melhor sob o céu”, antigo provérbio chinês."),
    "journey.fact.gl2": q("Li River cruises pass landscapes printed on the 20 yuan note.", "Круизы по реке Ли проходят мимо пейзажей, изображённых на купюре в 20 юаней.", "Los cruceros por el río Li pasan por el paisaje del billete de 20 yuanes.", "Os cruzeiros pelo rio Li passam pela paisagem da nota de 20 yuans."),
    "journey.fact.gl3": q("Photographers flock here for sunrise over the karst peaks.", "Фотографы приезжают сюда ради рассвета над карстовыми вершинами.", "Los fotógrafos acuden para captar el amanecer sobre los picos kársticos.", "Fotógrafos vêm registrar o nascer do sol sobre os picos cársticos."),
    "journey.attraction.gl-a1.name": q("Li River", "Река Ли", "Río Li", "Rio Li"),
    "journey.attraction.gl-a1.description": q("Bamboo raft through iconic karst scenery.", "Путешествие на бамбуковом плоту среди знаменитых карстовых пейзажей.", "Paseo en balsa de bambú entre paisajes kársticos emblemáticos.", "Passeio de jangada de bambu entre paisagens cársticas icônicas."),
    "journey.attraction.gl-a2.name": q("Yangshuo", "Яншо", "Yangshuo", "Yangshuo"),
    "journey.attraction.gl-a2.description": q("Countryside town surrounded by peaks.", "Небольшой город, окружённый горными вершинами.", "Pueblo rural rodeado de picos.", "Cidadezinha rural cercada por picos."),
    "journey.attraction.gl-a3.name": q("Reed Flute Cave", "Пещера Тростниковой флейты", "Cueva de la Flauta de Caña", "Caverna da Flauta de Junco"),
    "journey.attraction.gl-a3.description": q("Illuminated limestone cavern.", "Известняковая пещера с красочной подсветкой.", "Caverna de piedra caliza iluminada.", "Caverna de calcário iluminada."),
    "journey.attraction.gl-a4.name": q("Longji Terraces", "Рисовые террасы Лунцзи", "Terrazas de Longji", "Terraços de Longji"),
    "journey.attraction.gl-a4.description": q("Dragon's Backbone rice terraces.", "Рисовые террасы «Драконий хребет».", "Arrozales en terrazas de la Espina del Dragón.", "Terraços de arroz da Espinha do Dragão."),

    # Shanghai
    "journey.fact.sh1": q("Shanghai has one of the world's fastest maglev trains — 431 km/h.", "В Шанхае ходит один из самых быстрых поездов на магнитной подушке — 431 км/ч.", "Shanghái tiene uno de los trenes maglev más rápidos del mundo: 431 km/h.", "Xangai tem um dos trens maglev mais rápidos do mundo: 431 km/h."),
    "journey.fact.sh2": q("The Bund showcases 52 buildings of diverse architectural styles.", "На набережной Бунд расположены 52 здания разных архитектурных стилей.", "El Bund reúne 52 edificios de diversos estilos arquitectónicos.", "O Bund reúne 52 edifícios de diversos estilos arquitetônicos."),
    "journey.fact.sh3": q("Huangpu River cruises offer stunning night views of both banks.", "Круизы по реке Хуанпу открывают великолепные ночные виды на оба берега.", "Los cruceros por el río Huangpu ofrecen magníficas vistas nocturnas de ambas orillas.", "Os cruzeiros pelo rio Huangpu oferecem belas vistas noturnas das duas margens."),
    "journey.attraction.sh-a1.name": q("The Bund", "Набережная Бунд", "El Bund", "O Bund"),
    "journey.attraction.sh-a1.description": q("Colonial waterfront facing Pudong's towers.", "Историческая набережная напротив небоскрёбов Пудуна.", "Paseo colonial frente a las torres de Pudong.", "Orla colonial diante das torres de Pudong."),
    "journey.attraction.sh-a2.name": q("Oriental Pearl", "Восточная жемчужина", "Perla Oriental", "Pérola Oriental"),
    "journey.attraction.sh-a2.description": q("Iconic TV tower on the Pudong skyline.", "Знаменитая телебашня в панораме Пудуна.", "Icónica torre de televisión del horizonte de Pudong.", "Icônica torre de TV no horizonte de Pudong."),
    "journey.attraction.sh-a3.name": q("Yu Garden", "Сад Юйюань", "Jardín Yuyuan", "Jardim Yuyuan"),
    "journey.attraction.sh-a3.description": q("Classical Ming-era garden in Old City.", "Классический сад эпохи Мин в Старом городе.", "Jardín clásico de la época Ming en la Ciudad Vieja.", "Jardim clássico da era Ming na Cidade Antiga."),
    "journey.attraction.sh-a4.name": q("Nanjing Road", "Нанкинская улица", "Calle Nanjing", "Rua Nanjing"),
    "journey.attraction.sh-a4.description": q("Premier shopping street, dazzling at night.", "Главная торговая улица, сияющая огнями ночью.", "La principal calle comercial, deslumbrante por la noche.", "A principal rua comercial, deslumbrante à noite."),

    # Hangzhou
    "journey.fact.hz1": q("Longjing tea from Hangzhou is among China's most prized green teas.", "Чай лунцзин из Ханчжоу — один из самых ценных зелёных чаёв Китая.", "El té Longjing de Hangzhou es uno de los tés verdes más apreciados de China.", "O chá Longjing de Hangzhou está entre os chás verdes mais valorizados da China."),
    "journey.fact.hz2": q("West Lake is a UNESCO World Heritage site with ten scenic spots.", "Западное озеро входит в список ЮНЕСКО и славится десятью знаменитыми видами.", "El Lago del Oeste es Patrimonio de la Humanidad y tiene diez paisajes célebres.", "O Lago Ocidental é Patrimônio Mundial e possui dez paisagens célebres."),
    "journey.fact.hz3": q("Marco Polo called Hangzhou “the finest city in the world.”", "Марко Поло называл Ханчжоу «прекраснейшим городом мира».", "Marco Polo llamó a Hangzhou «la ciudad más espléndida del mundo».", "Marco Polo chamou Hangzhou de “a cidade mais esplêndida do mundo”."),
    "journey.attraction.hz-a1.name": q("West Lake", "Западное озеро", "Lago del Oeste", "Lago Ocidental"),
    "journey.attraction.hz-a1.description": q("Willow-lined shores and misty pagodas.", "Берега, поросшие ивами, и пагоды в тумане.", "Orillas con sauces y pagodas entre la niebla.", "Margens com salgueiros e pagodes entre a névoa."),
    "journey.attraction.hz-a2.name": q("Leifeng Pagoda", "Пагода Лэйфэн", "Pagoda Leifeng", "Pagode Leifeng"),
    "journey.attraction.hz-a2.description": q("Legendary tower overlooking the lake.", "Легендарная башня с видом на озеро.", "Torre legendaria con vistas al lago.", "Torre lendária com vista para o lago."),
    "journey.attraction.hz-a3.name": q("Tea Plantations", "Чайные плантации", "Plantaciones de té", "Plantações de chá"),
    "journey.attraction.hz-a3.description": q("Rolling hills of Longjing tea bushes.", "Холмы, покрытые кустами чая лунцзин.", "Colinas cubiertas de arbustos de té Longjing.", "Colinas cobertas por arbustos de chá Longjing."),
    "journey.attraction.hz-a4.name": q("Lingyin Temple", "Храм Линъинь", "Templo Lingyin", "Templo Lingyin"),
    "journey.attraction.hz-a4.description": q("Ancient Buddhist temple in forested hills.", "Древний буддийский храм среди лесистых холмов.", "Antiguo templo budista entre colinas boscosas.", "Antigo templo budista entre colinas arborizadas."),

    # Suzhou
    "journey.fact.sz1": q("The Humble Administrator's Garden is one of China's four great gardens.", "Сад скромного чиновника входит в четвёрку великих садов Китая.", "El Jardín del Administrador Humilde es uno de los cuatro grandes jardines de China.", "O Jardim do Administrador Humilde é um dos quatro grandes jardins da China."),
    "journey.fact.sz2": q("Suzhou silk embroidery can take months to complete a single piece.", "На создание одной шёлковой вышивки Сучжоу могут уйти месяцы.", "Una sola pieza de bordado de seda de Suzhou puede tardar meses en terminarse.", "Uma única peça de bordado em seda de Suzhou pode levar meses para ficar pronta."),
    "journey.fact.sz3": q("Ancient canals weave through the old town like Venetian waterways.", "Древние каналы пронизывают старый город, словно в Венеции.", "Antiguos canales atraviesan el casco histórico como vías venecianas.", "Canais antigos cortam a cidade velha como vias venezianas."),
    "journey.attraction.sz-a1.name": q("Humble Garden", "Сад скромного чиновника", "Jardín del Administrador Humilde", "Jardim do Administrador Humilde"),
    "journey.attraction.sz-a1.description": q("Ming-era garden of ponds and pavilions.", "Сад эпохи Мин с прудами и павильонами.", "Jardín de la época Ming con estanques y pabellones.", "Jardim da era Ming com lagos e pavilhões."),
    "journey.attraction.sz-a2.name": q("Tiger Hill", "Тигровый холм", "Colina del Tigre", "Colina do Tigre"),
    "journey.attraction.sz-a2.description": q("Leaning pagoda atop a legendary hill.", "Наклонная пагода на вершине легендарного холма.", "Pagoda inclinada sobre una colina legendaria.", "Pagode inclinado no alto de uma colina lendária."),
    "journey.attraction.sz-a3.name": q("Pingjiang Road", "Улица Пинцзян", "Calle Pingjiang", "Rua Pingjiang"),
    "journey.attraction.sz-a3.description": q("Canalside lane of teahouses and shops.", "Улица вдоль канала с чайными и магазинами.", "Calle junto al canal con casas de té y tiendas.", "Rua à beira do canal com casas de chá e lojas."),
    "journey.attraction.sz-a4.name": q("Silk Museum", "Музей шёлка", "Museo de la Seda", "Museu da Seda"),
    "journey.attraction.sz-a4.description": q("Centuries of silk weaving tradition.", "Многовековые традиции шёлкового ткачества.", "Siglos de tradición en el tejido de la seda.", "Séculos de tradição na tecelagem da seda."),

    # Harbin
    "journey.fact.hb1": q("The Ice Festival uses over 200,000 cubic meters of ice each year.", "Ежегодно для Ледового фестиваля используют более 200 000 кубометров льда.", "Cada año, el Festival del Hielo utiliza más de 200 000 metros cúbicos de hielo.", "Todos os anos, o Festival do Gelo usa mais de 200 mil metros cúbicos de gelo."),
    "journey.fact.hb2": q("Central Street features beautiful Russian-style architecture.", "Центральная улица известна красивой архитектурой в русском стиле.", "La Calle Central destaca por su hermosa arquitectura de estilo ruso.", "A Rua Central se destaca pela bela arquitetura em estilo russo."),
    "journey.fact.hb3": q("Winter temperatures can drop below −30°C in Harbin.", "Зимой температура в Харбине может опускаться ниже −30 °C.", "En invierno, la temperatura de Harbin puede bajar de −30 °C.", "No inverno, a temperatura em Harbin pode cair abaixo de −30 °C."),
    "journey.attraction.hb-a1.name": q("Ice Festival", "Ледовый фестиваль", "Festival del Hielo", "Festival do Gelo"),
    "journey.attraction.hb-a1.description": q("Massive illuminated ice sculptures at night.", "Огромные ледяные скульптуры, подсвеченные ночью.", "Enormes esculturas de hielo iluminadas por la noche.", "Enormes esculturas de gelo iluminadas à noite."),
    "journey.attraction.hb-a2.name": q("Central Street", "Центральная улица", "Calle Central", "Rua Central"),
    "journey.attraction.hb-a2.description": q("Historic cobblestone boulevard.", "Исторический бульвар, мощённый камнем.", "Histórico bulevar adoquinado.", "Histórico boulevard de paralelepípedos."),
    "journey.attraction.hb-a3.name": q("Saint Sophia", "Собор Святой Софии", "Santa Sofía", "Santa Sofia"),
    "journey.attraction.hb-a3.description": q("Byzantine-style cathedral turned museum.", "Собор в византийском стиле, превращённый в музей.", "Catedral de estilo bizantino convertida en museo.", "Catedral em estilo bizantino transformada em museu."),
    "journey.attraction.hb-a4.name": q("Snow World", "Мир снега", "Mundo de Nieve", "Mundo da Neve"),
    "journey.attraction.hb-a4.description": q("Fantasy snow castles and slides.", "Сказочные снежные замки и горки.", "Fantásticos castillos de nieve y toboganes.", "Fantásticos castelos de neve e escorregadores."),

    # Guiyang
    "journey.city.guiyang.name": q("Guiyang", "Гуйян", "Guiyang", "Guiyang"),
    "journey.city.guiyang.province": q("Guizhou", "Гуйчжоу", "Guizhou", "Guizhou"),
    "journey.city.guiyang.population": q("About 6 million", "Около 6 млн", "Alrededor de 6 millones", "Cerca de 6 milhões"),
    "journey.city.guiyang.introduction": q("Discover Guiyang — a cool highland capital surrounded by forests, waterfalls, and dramatic karst scenery.", "Откройте Гуйян — прохладную высокогорную столицу среди лесов, водопадов и впечатляющих карстовых пейзажей.", "Descubre Guiyang, una fresca capital de montaña rodeada de bosques, cascadas y espectaculares paisajes kársticos.", "Descubra Guiyang, uma capital fresca nas montanhas, cercada por florestas, cachoeiras e paisagens cársticas impressionantes."),
    "journey.city.guiyang.famousFor": q("Cool summers, mountain landscapes, and Guizhou's ethnic cultures", "Прохладное лето, горные пейзажи и культуры народов Гуйчжоу", "Veranos frescos, paisajes montañosos y culturas étnicas de Guizhou", "Verões frescos, paisagens montanhosas e culturas étnicas de Guizhou"),
    "journey.city.guiyang.bestSeason": q("March – October", "Март – октябрь", "Marzo – octubre", "Março – outubro"),
    "journey.city.guiyang.localFood": q("Sour soup fish, siwawa, changwang noodles", "Рыба в кислом супе, сывава, лапша чанван", "Pescado en sopa agria, siwawa y fideos changwang", "Peixe na sopa azeda, siwawa e macarrão changwang"),
    "journey.city.guiyang.localAchievement": q("Highland Explorer", "Исследователь нагорья", "Explorador de las tierras altas", "Explorador das terras altas"),
    "journey.city.guiyang.souvenirName": q("Waterfall Crystal", "Кристалл водопада", "Cristal de la cascada", "Cristal da cachoeira"),
    "journey.city.guiyang.mini.title": q("Find the Waterfall", "Найдите водопад", "Encuentra la cascada", "Encontre a cachoeira"),
    "journey.city.guiyang.mini.instruction": q("Follow the river and tap the hidden waterfall!", "Проследите путь реки и нажмите на спрятанный водопад!", "Sigue el río y toca la cascada escondida.", "Siga o rio e toque na cachoeira escondida!"),
    "journey.fact.gy1": q("Forests and parks cover a remarkable share of Guiyang's urban landscape.", "Леса и парки занимают значительную часть городской территории Гуйяна.", "Los bosques y parques ocupan una parte notable del paisaje urbano de Guiyang.", "Florestas e parques ocupam uma parte marcante da paisagem urbana de Guiyang."),
    "journey.fact.gy2": q("Guizhou's famous Huangguoshu Waterfall is one of Asia's largest waterfalls.", "Знаменитый водопад Хуангошу в Гуйчжоу — один из крупнейших в Азии.", "La famosa cascada Huangguoshu de Guizhou es una de las mayores de Asia.", "A famosa cachoeira Huangguoshu, em Guizhou, é uma das maiores da Ásia."),
    "journey.fact.gy3": q("Guiyang is a gateway to villages of the Miao, Dong, and other ethnic groups.", "Гуйян служит воротами к деревням мяо, дун и других народов.", "Guiyang es la puerta de entrada a aldeas de los pueblos miao, dong y otros grupos étnicos.", "Guiyang é a porta de entrada para aldeias dos povos miao, dong e outros grupos étnicos."),
    "journey.attraction.gy-a1.name": q("Jiaxiu Pavilion", "Павильон Цзясю", "Pabellón Jiaxiu", "Pavilhão Jiaxiu"),
    "journey.attraction.gy-a1.description": q("Guiyang's riverside landmark glowing beautifully at night.", "Знаменитый павильон у реки, особенно красивый в ночной подсветке.", "El emblemático pabellón junto al río, precioso cuando se ilumina de noche.", "O famoso pavilhão à beira do rio, especialmente bonito iluminado à noite."),
    "journey.attraction.gy-a2.name": q("Qianling Hill Park", "Парк горы Цяньлин", "Parque de la Colina Qianling", "Parque da Colina Qianling"),
    "journey.attraction.gy-a2.description": q("Forested hills, temples, lake views, and playful macaques.", "Лесистые холмы, храмы, виды на озеро и озорные макаки.", "Colinas boscosas, templos, vistas al lago y macacos juguetones.", "Colinas arborizadas, templos, vista para o lago e macacos brincalhões."),
    "journey.attraction.gy-a3.name": q("Qingyan Ancient Town", "Древний город Цинъянь", "Ciudad antigua de Qingyan", "Cidade antiga de Qingyan"),
    "journey.attraction.gy-a3.description": q("Stone lanes and historic architecture from the Ming era.", "Каменные улочки и историческая архитектура эпохи Мин.", "Callejuelas de piedra y arquitectura histórica de la época Ming.", "Ruelas de pedra e arquitetura histórica da era Ming."),
    "journey.attraction.gy-a4.name": q("Huaxi Wetland", "Водно-болотный парк Хуаси", "Humedal de Huaxi", "Área úmida de Huaxi"),
    "journey.attraction.gy-a4.description": q("A peaceful green corridor of rivers, fields, and walking paths.", "Спокойный зелёный маршрут среди рек, полей и прогулочных дорожек.", "Un tranquilo corredor verde de ríos, campos y senderos.", "Um tranquilo corredor verde de rios, campos e trilhas."),

    # Guangzhou
    "journey.city.guangzhou.name": q("Guangzhou", "Гуанчжоу", "Cantón", "Guangzhou"),
    "journey.city.guangzhou.province": q("Guangdong", "Гуандун", "Guangdong", "Guangdong"),
    "journey.city.guangzhou.population": q("About 19 million", "Около 19 млн", "Alrededor de 19 millones", "Cerca de 19 milhões"),
    "journey.city.guangzhou.introduction": q("Welcome to Guangzhou — a dynamic Pearl River metropolis and the heartland of Cantonese culture.", "Добро пожаловать в Гуанчжоу — динамичный мегаполис на Жемчужной реке и сердце кантонской культуры.", "Bienvenido a Cantón, una dinámica metrópolis del río de las Perlas y corazón de la cultura cantonesa.", "Bem-vindo a Guangzhou, uma metrópole dinâmica às margens do Rio das Pérolas e coração da cultura cantonesa."),
    "journey.city.guangzhou.famousFor": q("Dim sum, Canton Tower, historic trade, and Cantonese culture", "Димсам, Кантонская башня, торговая история и кантонская культура", "Dim sum, Torre de Cantón, comercio histórico y cultura cantonesa", "Dim sum, Torre de Cantão, comércio histórico e cultura cantonesa"),
    "journey.city.guangzhou.bestSeason": q("October – December", "Октябрь – декабрь", "Octubre – diciembre", "Outubro – dezembro"),
    "journey.city.guangzhou.localFood": q("Dim sum, char siu, wonton noodles", "Димсам, чар-сю, лапша с вонтонами", "Dim sum, char siu y fideos wonton", "Dim sum, char siu e macarrão wonton"),
    "journey.city.guangzhou.localAchievement": q("Cantonese Gourmet", "Знаток кантонской кухни", "Gourmet cantonés", "Gourmet cantonês"),
    "journey.city.guangzhou.souvenirName": q("Dim Sum Teapot", "Чайник для димсама", "Tetera de dim sum", "Bule de dim sum"),
    "journey.city.guangzhou.mini.title": q("Serve the Dim Sum", "Подайте димсам", "Sirve el dim sum", "Sirva o dim sum"),
    "journey.city.guangzhou.mini.instruction": q("Tap the matching bamboo baskets to complete the tea table!", "Нажимайте на одинаковые бамбуковые корзинки, чтобы накрыть чайный стол!", "Toca las cestas de bambú iguales para completar la mesa de té.", "Toque nas cestas de bambu iguais para completar a mesa de chá!"),
    "journey.fact.gz1": q("The Cantonese tradition of yum cha pairs tea with baskets of dim sum.", "Кантонская традиция ямча объединяет чаепитие с бамбуковыми корзинками димсама.", "La tradición cantonesa del yum cha combina el té con cestas de dim sum.", "A tradição cantonesa do yum cha combina chá com cestas de dim sum."),
    "journey.fact.gz2": q("Canton Tower rises 600 meters above the Pearl River skyline.", "Кантонская башня поднимается на 600 метров над панорамой Жемчужной реки.", "La Torre de Cantón se eleva 600 metros sobre el perfil del río de las Perlas.", "A Torre de Cantão se eleva 600 metros sobre o horizonte do Rio das Pérolas."),
    "journey.fact.gz3": q("Guangzhou has been a major trading port since the ancient Maritime Silk Road.", "Гуанчжоу был важным торговым портом ещё во времена древнего Морского шёлкового пути.", "Cantón es un importante puerto comercial desde la antigua Ruta Marítima de la Seda.", "Guangzhou é um importante porto comercial desde a antiga Rota Marítima da Seda."),
    "journey.attraction.gz-a1.name": q("Canton Tower", "Кантонская башня", "Torre de Cantón", "Torre de Cantão"),
    "journey.attraction.gz-a1.description": q("A colorful landmark with panoramic views over the Pearl River.", "Яркая достопримечательность с панорамным видом на Жемчужную реку.", "Un colorido símbolo con vistas panorámicas al río de las Perlas.", "Um marco colorido com vista panorâmica para o Rio das Pérolas."),
    "journey.attraction.gz-a2.name": q("Chen Clan Ancestral Hall", "Академия рода Чэнь", "Salón Ancestral del Clan Chen", "Salão Ancestral do Clã Chen"),
    "journey.attraction.gz-a2.description": q("An ornate masterpiece of traditional Lingnan craftsmanship.", "Богато украшенный шедевр традиционного мастерства Линнаня.", "Una obra maestra ornamentada de la artesanía tradicional de Lingnan.", "Uma obra-prima ornamentada do artesanato tradicional de Lingnan."),
    "journey.attraction.gz-a3.name": q("Shamian Island", "Остров Шамянь", "Isla Shamian", "Ilha Shamian"),
    "journey.attraction.gz-a3.description": q("Leafy streets lined with historic European-style buildings.", "Тенистые улицы с историческими зданиями в европейском стиле.", "Calles arboladas con edificios históricos de estilo europeo.", "Ruas arborizadas com edifícios históricos em estilo europeu."),
    "journey.attraction.gz-a4.name": q("Baiyun Mountain", "Гора Байюнь", "Montaña Baiyun", "Montanha Baiyun"),
    "journey.attraction.gz-a4.description": q("Green trails and sweeping views above the city.", "Зелёные тропы и широкие панорамы города.", "Senderos verdes y amplias vistas sobre la ciudad.", "Trilhas verdes e amplas vistas da cidade."),

    # Shenzhen
    "journey.city.shenzhen.name": q("Shenzhen", "Шэньчжэнь", "Shenzhen", "Shenzhen"),
    "journey.city.shenzhen.province": q("Guangdong", "Гуандун", "Guangdong", "Guangdong"),
    "journey.city.shenzhen.population": q("About 18 million", "Около 18 млн", "Alrededor de 18 millones", "Cerca de 18 milhões"),
    "journey.city.shenzhen.introduction": q("Explore Shenzhen — China's bold innovation city, where futuristic towers meet a green subtropical coast.", "Исследуйте Шэньчжэнь — смелый город инноваций, где футуристические башни встречаются с зелёным субтропическим побережьем.", "Explora Shenzhen, la audaz ciudad china de la innovación, donde las torres futuristas se encuentran con una verde costa subtropical.", "Explore Shenzhen, a ousada cidade chinesa da inovação, onde torres futuristas encontram uma costa subtropical verde."),
    "journey.city.shenzhen.famousFor": q("Technology, modern architecture, creative districts, and Shenzhen Bay", "Технологии, современная архитектура, творческие кварталы и залив Шэньчжэнь", "Tecnología, arquitectura moderna, barrios creativos y bahía de Shenzhen", "Tecnologia, arquitetura moderna, bairros criativos e Baía de Shenzhen"),
    "journey.city.shenzhen.bestSeason": q("October – April", "Октябрь – апрель", "Octubre – abril", "Outubro – abril"),
    "journey.city.shenzhen.localFood": q("Coconut chicken, Cantonese seafood, rice rolls", "Курица с кокосом, кантонские морепродукты, рисовые рулетики", "Pollo con coco, marisco cantonés y rollos de arroz", "Frango com coco, frutos do mar cantoneses e rolinhos de arroz"),
    "journey.city.shenzhen.localAchievement": q("Future Builder", "Создатель будущего", "Constructor del futuro", "Construtor do futuro"),
    "journey.city.shenzhen.souvenirName": q("Innovation Robot", "Робот-инноватор", "Robot de innovación", "Robô da inovação"),
    "journey.city.shenzhen.mini.title": q("Build the Skyline", "Постройте панораму", "Construye el horizonte", "Construa o horizonte"),
    "journey.city.shenzhen.mini.instruction": q("Stack the glowing towers to complete Shenzhen's skyline!", "Расставьте сияющие башни и соберите панораму Шэньчжэня!", "Apila las torres luminosas para completar el horizonte de Shenzhen.", "Empilhe as torres iluminadas para completar o horizonte de Shenzhen!"),
    "journey.fact.szh1": q("Shenzhen is one of the world's leading centers for hardware and technology innovation.", "Шэньчжэнь — один из ведущих мировых центров разработки электроники и технологических инноваций.", "Shenzhen es uno de los principales centros mundiales de hardware e innovación tecnológica.", "Shenzhen é um dos principais centros mundiais de hardware e inovação tecnológica."),
    "journey.fact.szh2": q("Nearly half of Shenzhen's urban area is covered by parks and ecological spaces.", "Почти половину городской территории Шэньчжэня занимают парки и природные зоны.", "Casi la mitad del área urbana de Shenzhen está cubierta por parques y espacios ecológicos.", "Quase metade da área urbana de Shenzhen é coberta por parques e espaços ecológicos."),
    "journey.fact.szh3": q("The city has grown from a small town into a megacity since 1980.", "С 1980 года небольшой город превратился в огромный современный мегаполис.", "Desde 1980, la ciudad ha pasado de ser una pequeña localidad a convertirse en una megaciudad.", "Desde 1980, a cidade passou de uma pequena vila a uma megacidade."),
    "journey.attraction.szh-a1.name": q("Ping An Finance Centre", "Финансовый центр Пинань", "Centro Financiero Ping An", "Centro Financeiro Ping An"),
    "journey.attraction.szh-a1.description": q("One of the world's tallest skyscrapers and a symbol of modern Shenzhen.", "Один из самых высоких небоскрёбов мира и символ современного Шэньчжэня.", "Uno de los rascacielos más altos del mundo y símbolo del Shenzhen moderno.", "Um dos arranha-céus mais altos do mundo e símbolo da Shenzhen moderna."),
    "journey.attraction.szh-a2.name": q("Shenzhen Bay", "Залив Шэньчжэнь", "Bahía de Shenzhen", "Baía de Shenzhen"),
    "journey.attraction.szh-a2.description": q("A waterfront promenade with skyline and sunset views.", "Набережная с видами на городской силуэт и закаты.", "Un paseo marítimo con vistas al horizonte y al atardecer.", "Um calçadão à beira-mar com vista para o horizonte e o pôr do sol."),
    "journey.attraction.szh-a3.name": q("Dafen Oil Painting Village", "Деревня художников Дафэнь", "Aldea de Pintura al Óleo de Dafen", "Vila de Pintura a Óleo de Dafen"),
    "journey.attraction.szh-a3.description": q("A creative neighborhood filled with artists and galleries.", "Творческий квартал, полный художников и галерей.", "Un barrio creativo lleno de artistas y galerías.", "Um bairro criativo repleto de artistas e galerias."),
    "journey.attraction.szh-a4.name": q("OCT Loft", "Арт-квартал OCT Loft", "OCT Loft", "OCT Loft"),
    "journey.attraction.szh-a4.description": q("A former industrial area transformed into a lively arts district.", "Бывшая промышленная зона, превращённая в оживлённый арт-квартал.", "Una antigua zona industrial convertida en un animado distrito artístico.", "Uma antiga área industrial transformada em um animado distrito artístico."),

    # Hong Kong
    "journey.fact.hk1": q("The Peak Tram has operated since 1888 — one of the world's oldest funiculars.", "Фуникулёр Peak Tram работает с 1888 года и считается одним из старейших в мире.", "El Peak Tram funciona desde 1888 y es uno de los funiculares más antiguos del mundo.", "O Peak Tram funciona desde 1888 e é um dos funiculares mais antigos do mundo."),
    "journey.fact.hk2": q("The Star Ferry has crossed Victoria Harbour since 1888.", "Паромы Star Ferry пересекают гавань Виктория с 1888 года.", "El Star Ferry cruza el Puerto Victoria desde 1888.", "O Star Ferry cruza o Porto Victoria desde 1888."),
    "journey.fact.hk3": q("Hong Kong has more skyscrapers than any other city on Earth.", "В Гонконге больше небоскрёбов, чем в любом другом городе мира.", "Hong Kong tiene más rascacielos que cualquier otra ciudad del mundo.", "Hong Kong tem mais arranha-céus do que qualquer outra cidade do mundo."),
    "journey.attraction.hk-a1.name": q("Victoria Peak", "Пик Виктория", "Pico Victoria", "Pico Victoria"),
    "journey.attraction.hk-a1.description": q("Panoramic views over the harbor.", "Панорамные виды на гавань.", "Vistas panorámicas del puerto.", "Vista panorâmica do porto."),
    "journey.attraction.hk-a2.name": q("Star Ferry", "Паром Star Ferry", "Star Ferry", "Star Ferry"),
    "journey.attraction.hk-a2.description": q("Historic harbor crossing at sunset.", "Историческая переправа через гавань на закате.", "Histórico cruce del puerto al atardecer.", "Travessia histórica do porto ao pôr do sol."),
    "journey.attraction.hk-a3.name": q("Temple Street", "Темпл-стрит", "Temple Street", "Temple Street"),
    "journey.attraction.hk-a3.description": q("Night market of food and fortune tellers.", "Ночной рынок с уличной едой и предсказателями судьбы.", "Mercado nocturno de comida y adivinos.", "Mercado noturno de comida e adivinhos."),
    "journey.attraction.hk-a4.name": q("Dim Sum", "Димсам", "Dim sum", "Dim sum"),
    "journey.attraction.hk-a4.description": q("Steamed baskets of Cantonese delights.", "Бамбуковые корзинки с кантонскими блюдами на пару.", "Cestas al vapor llenas de delicias cantonesas.", "Cestas no vapor repletas de delícias cantonesas."),
}


if __name__ == "__main__":
    added = merge(STRINGS)
    print(f"Merged {len(STRINGS)} Journey keys ({added} newly added)")
