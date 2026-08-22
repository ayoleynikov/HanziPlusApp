#!/usr/bin/env python3
"""Culture study-set translations (100 words). Keep Chinese cultural names, don't calque."""
from __future__ import annotations
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
from sidecar_lib import apply_rows

ROWS = []


def add(ru, es, pt, *examples):
    ROWS.append((ru, es, pt, examples))


add("Чуньцзе / китайский Новый год", "Año Nuevo Chino / Fiesta de la Primavera", "Ano Novo Chinês / Festival da Primavera",
    ("Чуньцзе — главный праздник китайцев.", "El Año Nuevo Chino es la fiesta más importante de China.", "O Ano Novo Chinês é a festa mais importante da China."),
    ("Мы едем в родной город на Чуньцзе.", "Volvemos al pueblo a pasar el Año Nuevo.", "Voltamos à cidade natal para o Ano Novo."))
add("красный конверт / хунбао", "sobre rojo / hongbao", "envelope vermelho / hongbao",
    ("Старшие дают детям красные конверты.", "Los mayores dan sobres rojos a los niños.", "Os mais velhos dão envelopes vermelhos às crianças."),
    ("Спасибо за хунбао.", "Gracias por el sobre rojo.", "Obrigado pelo envelope vermelho."))
add("новогодний ужин / няньефань", "cena de Nochevieja lunar", "ceia da véspera do Ano Novo",
    ("Вся семья собирается на новогодний ужин.", "Toda la familia cena junta en Nochevieja.", "A família toda janta junta na véspera."),
    ("Новогодний стол очень обильный.", "La cena de reunión es muy abundante.", "A ceia de reunião é muito farta."))
add("весенние парные надписи / чуньлянь", "dísticos de Año Nuevo / chunlian", "dísticos de Ano Novo / chunlian",
    ("На дверь наклеили чуньлянь.", "Pegaron dísticos en la puerta.", "Colaram dísticos na porta."),
    ("Эти надписи написаны очень аккуратно.", "Este dístico está escrito con mucha pulcritud.", "Este dístico está escrito com muita capricho."))
add("фейерверк", "fuegos artificiales", "fogos de artifício",
    ("В канун Нового года смотрят фейерверк.", "En Nochevieja se ven fuegos artificiales.", "Na véspera se ve fogos de artifício."),
    ("В городе запрещено запускать фейерверк.", "La ciudad prohíbe los fuegos artificiales.", "A cidade proíbe fogos de artifício."))
add("ходить с новогодними поздравлениями / байнянь", "visitar para desear el Año Nuevo", "visitar para desejar o Ano Novo",
    ("В первый день года ходят поздравлять родственников.", "El primer día se visita a los parientes.", "No primeiro dia se visita os parentes."),
    ("Поздравляю вас с Новым годом.", "Le deseo un feliz Año Nuevo.", "Desejo a você um feliz Ano Novo."))
add("фонарь / фонарик", "linterna / farolillo", "lanterna / lampião",
    ("На улицах полно красных фонарей.", "La calle está llena de farolillos rojos.", "A rua está cheia de lanternas vermelhas."),
    ("Этот фонарь очень красивый.", "Este farolillo es muy bonito.", "Esta lanterna é muito bonita."))
add("танец дракона", "danza del dragón", "dança do dragão",
    ("На Чуньцзе показывают танец дракона.", "En el Año Nuevo hay danza del dragón.", "No Ano Novo há dança do dragão."),
    ("Команда танца дракона очень зрелищная.", "La troupe del dragón es espectacular.", "O grupo da dança do dragão é espetacular."))
add("воссоединение семьи / туанъюань", "reunión familiar", "reunião familiar",
    ("Чуньцзе — день семейного воссоединения.", "El Año Nuevo es tiempo de reunión familiar.", "O Ano Novo é tempo de reunião familiar."),
    ("Главное — чтобы семья была вместе.", "Lo más importante es reunirse en familia.", "O mais importante é a família estar junta."))
add("встречать Новый год не ложась спать / шоусы", "velar la Nochevieja lunar", "passar a virada em claro",
    ("В канун Нового года мы не ложимся до полуночи.", "Velamos la Nochevieja lunar.", "Passamos a véspera em claro."),
    ("Бдим до полуночи.", "Velamos hasta medianoche.", "Ficamos acordados até meia-noite."))
add("праздник лодок-драконов / Дуаньу", "Festival del Bote del Dragón", "Festival das Barcas-Dragão",
    ("Дуаньу — пятый день пятого лунного месяца.", "El Festival del Bote del Dragón es el 5 del 5.º mes lunar.", "O Festival das Barcas-Dragão é no 5.º dia do 5.º mês lunar."),
    ("На Дуаньу едят цзунцзы.", "En el festival se comen zongzi.", "No festival se come zongzi."))
add("цзунцзы (рисовые треугольники в листьях)", "zongzi (bollo de arroz glutinoso)", "zongzi (bolinho de arroz glutinoso)",
    ("Я люблю мясные цзунцзы.", "Me gustan los zongzi salados.", "Gosto de zongzi salgado."),
    ("Мама сварила кастрюлю цзунцзы.", "Mamá hizo una olla de zongzi.", "A mamãe fez uma panela de zongzi."))
add("лодка-дракон", "bote del dragón", "barca-dragão",
    ("Гонки лодок-драконов очень напряжённые.", "La regata de botes del dragón es intensa.", "A corrida de barcas-dragão é intensa."),
    ("Их команда гребёт очень быстро.", "Su equipo rema muy rápido.", "O time deles rema muito rápido."))
add("Цюй Юань", "Qu Yuan", "Qu Yuan",
    ("Дуаньу посвящён памяти Цюй Юаня.", "El festival conmemora a Qu Yuan.", "O festival homenageia Qu Yuan."),
    ("Цюй Юань был великим поэтом.", "Qu Yuan fue un gran poeta.", "Qu Yuan foi um grande poeta."))
add("полынь / айцао", "artemisa / mugwort", "artemísia / mugwort",
    ("Над дверью вешают полынь от нечисти.", "Se cuelga artemisa en la puerta para ahuyentar el mal.", "Pendura-se artemísia na porta para afastar o mal."),
    ("У полыни особый запах.", "La artemisa tiene un aroma especial.", "A artemísia tem um cheiro especial."))
add("ароматный мешочек / сяннан", "saquito aromático", "saquinho aromático",
    ("Дети носят ароматные мешочки.", "Los niños llevan saquitos aromáticos.", "As crianças usam saquinhos aromáticos."),
    ("Этот мешочек сделан вручную.", "Este saquito es hecho a mano.", "Este saquinho é feito à mão."))
add("гонка лодок-драконов", "regata de botes del dragón", "corrida de barcas-dragão",
    ("Завтра гонка лодок-драконов.", "Mañana hay una regata de botes del dragón.", "Amanhã tem corrida de barcas-dragão."),
    ("Гонки — традиционное мероприятие.", "La regata es una actividad tradicional.", "A corrida é uma atividade tradicional."))
add("вино с реальгаром / сюнхуанцзю", "vino de rejalgar", "vinho de realgar",
    ("Пить вино с реальгаром — обычай Дуаньу.", "Beber vino de rejalgar es una costumbre del festival.", "Beber vinho de realgar é um costume do festival."),
    ("Сейчас его пьют редко.", "Ahora rara vez se bebe vino de rejalgar.", "Agora raramente se bebe vinho de realgar."))
add("пятицветный шнурок", "cuerda de cinco colores", "cordão de cinco cores",
    ("Детям завязывают пятицветный шнурок.", "Se ata un cordón de cinco colores a los niños.", "Amarra-se um cordão de cinco cores nas crianças."),
    ("Шнурок символизирует благополучие.", "El cordón simboliza la seguridad.", "O cordão simboliza proteção."))
add("грести", "remar", "remar",
    ("Гребцы гребут слаженно.", "Los remeros reman al unísono.", "Os remadores remam em uníssono."),
    ("Грести нужно с силой.", "Remar exige mucha fuerza.", "Remar exige muita força."))
add("праздник фонарей / Юаньсяо", "Festival de los Faroles", "Festival das Lanternas",
    ("Юаньсяо — последний день Чуньцзе.", "El Festival de los Faroles cierra el Año Nuevo.", "O Festival das Lanternas fecha o Ano Novo."),
    ("На Юаньсяо смотрят фонари.", "En el festival se contemplan faroles.", "No festival se admiram lanternas."))
add("декоративный фонарь / хуадэн", "farol decorativo", "lanterna decorativa",
    ("В парке разные фонари.", "En el parque hay faroles de todo tipo.", "No parque há lanternas de todo tipo."),
    ("Этот фонарь в форме кролика.", "Este farol tiene forma de conejo.", "Esta lanterna tem forma de coelho."))
add("отгадывать загадки на фонарях", "adivinar acertijos de faroles", "adivinhar charadas das lanternas",
    ("На ярмарке фонарей мы отгадываем загадки.", "En la feria adivinamos acertijos de faroles.", "Na feira adivinhamos charadas das lanternas."),
    ("Эта загадка очень сложная.", "Este acertijo es muy difícil.", "Esta charada é muito difícil."))
add("танъюань (сладкие рисовые шарики)", "tangyuan (bolitas de arroz glutinoso)", "tangyuan (bolinho de arroz glutinoso)",
    ("На Юаньсяо едят танъюань.", "En el Festival de los Faroles se comen tangyuan.", "No Festival das Lanternas se come tangyuan."),
    ("Кунжутные танъюань очень вкусные.", "Los tangyuan de sésamo están riquísimos.", "Tangyuan de gergelim está uma delícia."))
add("ярмарка фонарей", "feria de faroles", "feira de lanternas",
    ("Ярмарка фонарей очень оживлённая.", "La feria de faroles está muy animada.", "A feira de lanternas está bem animada."),
    ("Вся семья идёт на ярмарку фонарей.", "Toda la familia va a la feria de faroles.", "A família toda vai à feira de lanternas."))
add("вращающийся фонарь / цзоумадэн", "farol giratorio", "lanterna giratória",
    ("Картинки внутри вращающегося фонаря движутся.", "Las figuras del farol giratorio se mueven.", "As figuras da lanterna giratória se movem."),
    ("Этот вращающийся фонарь очень искусный.", "Este farol giratorio es muy ingenioso.", "Esta lanterna giratória é muito engenhosa."))
add("небесный фонарик / кунминдэн", "farol volador / farol Kongming", "lanterna voadora / lanterna Kongming",
    ("Люди запускают фонарики и загадывают желания.", "La gente suelta faroles voladores para pedir deseos.", "As pessoas soltam lanternas voadoras para fazer pedidos."),
    ("Фонарики медленно поднимаются в небо.", "Los faroles suben despacio al cielo.", "As lanternas sobem devagar no céu."))
add("любоваться луной", "contemplar la luna", "admirar a lua",
    ("В ночь Юаньсяо вместе любуются луной.", "En la noche del festival contemplamos la luna juntos.", "Na noite do festival admiramos a lua juntos."),
    ("Мы любуемся луной с балкона.", "Contemplamos la luna desde el balcón.", "Admiramos a lua da varanda."))
add("ходить по мосту (обычай праздника)", "paseo por el puente (costumbre festiva)", "caminhada na ponte (costume festivo)",
    ("Посмотрите обычай хождения по мосту.", "Mire el paseo por el puente del festival.", "Veja a caminhada na ponte do festival."),
    ("Этот обычай очень важен.", "Este paseo por el puente es importante.", "Esta caminhada na ponte é importante."))
add("шествие с фонарями", "paseo de faroles", "procissão de lanternas",
    ("Вечером все гуляют среди фонарей.", "Por la noche todos pasean entre faroles.", "À noite todos passeiam entre as lanternas."),
    ("Шествие с фонарями — обычай Юаньсяо.", "Pasear entre faroles es una costumbre del festival.", "Passear entre lanternas é um costume do festival."))
add("праздник середины осени / Чжунцю", "Festival del Medio Otoño", "Festival do Meio Outono",
    ("Чжунцю — 15-й день 8-го лунного месяца.", "El Festival del Medio Otoño es el 15 del 8.º mes lunar.", "O Festival do Meio Outono é no dia 15 do 8.º mês lunar."),
    ("На Чжунцю семья собирается вместе.", "Las familias se reúnen en el Festival del Medio Otoño.", "As famílias se reúnem no Festival do Meio Outono."))
add("лунный пряник / юэбин", "pastel de luna / mooncake", "bolo da lua / mooncake",
    ("На Чжунцю едят юэбин.", "En el Festival del Medio Otoño se comen pasteles de luna.", "No Festival do Meio Outono se come bolo da lua."),
    ("Юэбин с лотосовой пастой очень популярны.", "Los pasteles de luna de loto son populares.", "Bolo da lua de lótus é popular."))
add("османтус / цветок гуйхуа", "flor de osmanthus / guihua", "flor de osmanthus / guihua",
    ("На Чжунцю османтус очень душистый.", "En el Medio Otoño el osmanthus es muy fragante.", "No Meio Outono o osmanthus é muito perfumado."),
    ("В юэбине чувствуется вкус османтуса.", "El pastel de luna tiene sabor a osmanthus.", "O bolo da lua tem sabor de osmanthus."))
add("Чанъэ (лунная богиня)", "Chang'e (diosa de la luna)", "Chang'e (deusa da lua)",
    ("Чанъэ, улетевшая на луну, — легенда Чжунцю.", "Chang'e volando a la luna es una leyenda del festival.", "Chang'e voando à lua é uma lenda do festival."),
    ("Дети слушают историю о Чанъэ.", "Los niños escuchan la historia de Chang'e.", "As crianças ouvem a história de Chang'e."))
add("Нефритовый заяц", "Conejo de Jade", "Coelho de Jade",
    ("Нефритовый заяц живёт во дворце на луне.", "El Conejo de Jade vive en el palacio lunar.", "O Coelho de Jade vive no palácio da lua."),
    ("На юэбинах часто печатают зайца.", "Los pasteles de luna suelen llevar el Conejo de Jade.", "Bolos da lua costumam ter o Coelho de Jade."))
add("Дворец Гуанхань (лунный дворец)", "Palacio Guanghan / palacio de la luna", "Palácio Guanghan / palácio da lua",
    ("По легенде Чанъэ живёт во дворце Гуанхань.", "La leyenda dice que Chang'e vive en el Palacio Guanghan.", "A lenda diz que Chang'e vive no Palácio Guanghan."),
    ("Гуанхань — имя лунного дворца.", "Guanghan es el nombre del palacio lunar.", "Guanghan é o nome do palácio lunar."))
add("середина осени (литературно)", "mediados de otoño (literario)", "meio do outono (literário)",
    ("В ночь середины осени луна очень круглая.", "En la noche de mediados de otoño la luna está muy llena.", "Na noite do meio do outono a lua está bem cheia."),
    ("Середина осени — прекрасное время для воссоединения.", "Mediados de otoño es un gran momento para reunirse.", "O meio do outono é um belo momento para se reunir."))
add("скучать / тосковать", "echar de menos", "sentir saudade / sentir falta",
    ("На Чжунцю я скучаю по семье.", "En el Festival del Medio Otoño extraño a mi familia.", "No Festival do Meio Outono sinto falta da família."),
    ("Яркая луна навевает тоску по родине.", "La luna brillante hace extrañar el pueblo natal.", "A lua brilhante traz saudade da terra natal."))
add("родная земля / малая родина", "pueblo natal / tierra natal", "terra natal / cidade natal",
    ("В ночь Чжунцю я думаю о родине.", "En la noche del festival extraño mi tierra natal.", "Na noite do festival sinto saudade da terra natal."),
    ("Яркая луна светит на родную землю.", "La luna brillante ilumina mi tierra natal.", "A lua brilhante ilumina a terra natal."))
add("полнота / благополучие / завершённость", "plenitud / redondez (simbólica)", "plenitude / completude",
    ("Луна символизирует полноту и благополучие.", "La luna llena simboliza la plenitud.", "A lua cheia simboliza a plenitude."),
    ("Желаю всем полного счастья на Чжунцю.", "Les deseo un Medio Otoño pleno.", "Desejo a todos um Meio Outono pleno."))
add("панда", "panda", "panda",
    ("Панда — национальное сокровище Китая.", "El panda es un tesoro nacional de China.", "O panda é um tesouro nacional da China."),
    ("Дети любят смотреть на панд.", "A los niños les encanta ver pandas.", "Crianças adoram ver pandas."))
add("бамбук", "bambú", "bambu",
    ("Панды в основном едят бамбук.", "Los pandas comen sobre todo bambú.", "Pandas comem principalmente bambu."),
    ("Эта бамбуковая роща очень густая.", "Este bosque de bambú es muy denso.", "Este bosque de bambu é bem denso."))
add("Чэнду", "Chengdu", "Chengdu",
    ("Чэнду — отличное место, чтобы увидеть панд.", "Chengdu es un gran lugar para ver pandas.", "Chengdu é um ótimo lugar para ver pandas."),
    ("База панд в Чэнду очень известна.", "La base de pandas de Chengdu es famosa.", "A base de pandas de Chengdu é famosa."))
add("база / заповедник", "base / reserva", "base / reserva",
    ("На базе много панд.", "En la base hay muchos pandas.", "Na base há muitos pandas."),
    ("В заповеднике нельзя шуметь.", "En la reserva hay que guardar silencio.", "Na reserva é preciso silêncio."))
add("охрана / разведение (животных)", "conservación / cría", "conservação / criação",
    ("Охрана панд очень важна.", "La conservación del panda es muy importante.", "A conservação do panda é muito importante."),
    ("Смотрители ухаживают за детёнышами панд.", "Los cuidadores atienden a los oseznos.", "Os tratadores cuidam dos filhotes de panda."))
add("чёрно-белый", "blanco y negro", "preto e branco",
    ("Панда чёрно-белая.", "El panda es blanco y negro.", "O panda é preto e branco."),
    ("Чёрно-белая расцветка очень милая.", "El color blanco y negro es adorable.", "A cor preto e branco é fofa."))
add("неуклюжая милота / простодушие", "torpeza adorable", "jeito desajeitado e fofo",
    ("У панд обаятельная неуклюжесть.", "Los pandas tienen un encanto torpe adorable.", "Pandas têm um jeito desajeitado adorável."),
    ("Он весь такой простодушный и милый.", "Está lleno de torpeza adorable.", "Está cheio de jeito fofo e desajeitado."))
add("лазить по деревьям", "trepar a los árboles", "subir em árvore",
    ("Маленькая панда учится лазить по деревьям.", "Un panda joven está aprendiendo a trepar.", "Um panda jovem está aprendendo a subir em árvore."),
    ("Панды лазают по деревьям ловко.", "Los pandas trepan con agilidad.", "Pandas sobem em árvore com agilidade."))
add("кататься / валяться", "revolcarse", "rolar / se revirar",
    ("Панда катается по земле.", "El panda se revuelca en el suelo.", "O panda rola no chão."),
    ("Когда радуется, он катается.", "Cuando está contento, se revuelca.", "Quando está feliz, ele rola."))
add("находящийся под угрозой исчезновения", "en peligro de extinción", "em risco de extinção",
    ("Панды когда-то были под угрозой.", "Los pandas estuvieron en peligro de extinção.", "Pandas já estiveram em risco de extinção."),
    ("Защищать исчезающих животных — дело каждого.", "Proteger a los animales en peligro es tarea de todos.", "Proteger animais em risco é dever de todos."))
add("чайная церемония / чадао", "ceremonia del té", "cerimônia do chá",
    ("Японская чайная церемония произошла из Китая.", "La ceremonia del té japonesa nació en China.", "A cerimônia do chá japonesa nasceu na China."),
    ("Она изучает традиционную китайскую чайную церемонию.", "Estudia la ceremonia del té china tradicional.", "Ela estuda a cerimônia do chá chinesa tradicional."))
add("чайное искусство / чаи", "arte del té", "arte do chá",
    ("Представление чайного искусства очень изящное.", "La exhibición del arte del té es elegante.", "A apresentação da arte do chá é elegante."),
    ("Она прекрасно владеет чайным искусством.", "Domina el arte del té.", "Ela domina a arte do chá."))
add("чайный набор / чайная посуда", "juego de té / utensilios", "conjunto de chá / utensílios",
    ("Этот набор из Цзиндэчжэня.", "Este juego de té es de Jingdezhen.", "Este conjunto de chá é de Jingdezhen."),
    ("Чайную посуду нужно хорошо мыть.", "Los utensilios de té hay que lavarlos bien.", "Os utensílios de chá precisam ser bem lavados."))
add("подносить чай (с уважением)", "ofrecer té con respeto", "oferecer chá com respeito",
    ("Молодожёны подносят чай старшим.", "Los recién casados ofrecen té a los mayores.", "Os recém-casados oferecem chá aos mais velhos."),
    ("Подносить чай — знак уважения.", "Ofrecer té muestra respeto.", "Oferecer chá demonstra respeito."))
add("дегустировать чай / смаковать чай", "catar / saborear el té", "provar / saborear o chá",
    ("Пейте чай не спеша.", "Saboree el té despacio.", "Saboreie o chá com calma."),
    ("Для дегустации чая нужна тишина в душе.", "Catar té requiere una mente serena.", "Provar chá pede uma mente calma."))
add("лунцзин (чай «колодец дракона»)", "té Longjing", "chá Longjing",
    ("Лунцзин — знаменитый чай Ханчжоу.", "El Longjing es un té famoso de Hangzhou.", "Longjing é um chá famoso de Hangzhou."),
    ("Лунцзин до Цинмина очень дорогой.", "El Longjing anterior a Qingming es muy caro.", "O Longjing antes de Qingming é muito caro."))
add("Тегуаньинь (улун)", "Tieguanyin (oolong)", "Tieguanyin (oolong)",
    ("Тегуаньинь — знаменитый чай Фуцзяни.", "El Tieguanyin es un té famoso de Fujian.", "Tieguanyin é um chá famoso de Fujian."),
    ("У этого Тегуаньинь прекрасное сладкое послевкусие.", "Este Tieguanyin tiene un rico retrogusto dulce.", "Este Tieguanyin tem um belo gosto doce no final."))
add("чайная / чайный дом", "casa de té", "casa de chá",
    ("Старые пекинцы любят чайные.", "A los viejos pekineses les encantan las casas de té.", "Os velhos pequineses adoram casas de chá."),
    ("В чайной можно слушать сяньшэн.", "En la casa de té se puede oír crosstalk.", "Na casa de chá dá para ouvir xiangsheng."))
add("знакомиться за чаем / дружить через чай", "hacer amigos con té", "fazer amigos em torno do chá",
    ("Дружить за чаем — китайская традиция.", "Hacer amigos con té es una tradición china.", "Fazer amigos em torno do chá é uma tradição chinesa."),
    ("Сегодня за чаем отлично поговорили.", "Hoy nos vimos con té y charlamos muy bien.", "Hoje nos vimos em torno do chá e conversamos muito bem."))
add("сладкое послевкусие (чая) / хуэйгань", "retrogusto dulce (del té)", "gosto doce residual (do chá)",
    ("У хорошего чая есть сладкое послевкусие.", "Un buen té deja un retrogusto dulce.", "Um bom chá deixa um gosto doce residual."),
    ("Послевкусие этого чая долгое.", "El retrogusto de este té dura mucho.", "O gosto residual deste chá dura bastante."))
add("Великая стена", "Gran Muralla", "Grande Muralha",
    ("Великая стена — чудо света.", "La Gran Muralla es una maravilla del mundo.", "A Grande Muralha é uma maravilha do mundo."),
    ("Мы ходили по Великой стене пешком.", "Hicimos senderismo en la Gran Muralla.", "Fizemos trilha na Grande Muralha."))
add("Запретный город / Гугун", "Ciudad Prohibida", "Cidade Proibida",
    ("Запретный город в центре Пекина.", "La Ciudad Prohibida está en el centro de Pekín.", "A Cidade Proibida fica no centro de Pequim."),
    ("Гугуну больше шестисот лет.", "La Ciudad Prohibida tiene más de 600 años.", "A Cidade Proibida tem mais de 600 anos."))
add("Тяньаньмэнь", "Tiananmen", "Tiananmen",
    ("Площадь Тяньаньмэнь очень большая.", "La plaza de Tiananmen es enorme.", "A praça Tiananmen é enorme."),
    ("Тяньаньмэнь — символ Пекина.", "Tiananmen es un símbolo de Pekín.", "Tiananmen é um símbolo de Pequim."))
add("Западное озеро / Сиху", "Lago del Oeste / Xihu", "Lago do Oeste / Xihu",
    ("Пейзаж Западного озера как картина.", "El paisaje del Lago del Oeste es de postal.", "A paisagem do Lago do Oeste é de cartão-postal."),
    ("Мы гуляли вдоль Западного озера.", "Paseamos junto al Lago del Oeste.", "Passeamos à beira do Lago do Oeste."))
add("терракотовая армия", "ejército de terracota", "exército de terracota",
    ("Терракотовая армия в Сиане.", "El ejército de terracota está en Xi'an.", "O exército de terracota fica em Xi'an."),
    ("Терракотовая армия очень величественна.", "El ejército de terracota es espectacular.", "O exército de terracota é espetacular."))
add("гора Хуаншань", "monte Huang / Huangshan", "monte Huang / Huangshan",
    ("Хуаншань славится причудливыми соснами и скалами.", "Huangshan es famosa por sus pinos y rocas extraños.", "Huangshan é famosa por pinheiros e rochas estranhos."),
    ("Мы поднялись на Хуаншань встретить рассвет.", "Subimos Huangshan a ver el amanecer.", "Subimos Huangshan para ver o nascer do sol."))
add("Гуйлинь", "Guilin", "Guilin",
    ("Пейзажи Гуйлиня — лучшие под небесами.", "Los paisajes de Guilin son los más bellos bajo el cielo.", "As paisagens de Guilin são as mais belas sob o céu."),
    ("Мы ездили в Гуйлинь кататься по Лицзян.", "Fuimos a Guilin a navegar el río Li.", "Fomos a Guilin navegar o rio Li."))
add("дворец Потала", "Palacio de Potala", "Palácio de Potala",
    ("Дворец Потала в Лхасе.", "El Palacio de Potala está en Lhasa.", "O Palácio de Potala fica em Lhasa."),
    ("Потала очень величественна.", "El Palacio de Potala es imponente.", "O Palácio de Potala é imponente."))
add("набережная Вайтань (Шанхай)", "el Bund (Shanghái)", "o Bund (Xangai)",
    ("Ночной вид Вайтаня очень красив.", "El Bund de noche es precioso.", "O Bund à noite é lindo."),
    ("Мы ходили на Вайтань смотреть Восточную жемчужину.", "Fuimos al Bund a ver la Perla de Oriente.", "Fomos ao Bund ver a Pérola do Oriente."))
add("сады Сучжоу", "jardines de Suzhou", "jardins de Suzhou",
    ("Сады Сучжоу очень изысканные.", "Los jardines de Suzhou son exquisitos.", "Os jardins de Suzhou são requintados."),
    ("Сад скромного чиновника — знаменитый сад Сучжоу.", "El Jardín del Administrador Humilde es un jardín famoso de Suzhou.", "O Jardim do Administrador Humilde é um jardim famoso de Suzhou."))
add("китайский зодиак / шэнсяо", "zodíaco chino", "zodíaco chinês",
    ("Какой у тебя знак зодиака?", "¿Cuál es tu signo del zodíaco chino?", "Qual é o seu signo do zodíaco chinês?"),
    ("Знаков зодиака двенадцать.", "Hay doce signos del zodíaco.", "Há doze signos do zodíaco."))
add("Крыса (зодиак)", "Rata (zodíaco)", "Rato (zodíaco)",
    ("Рождённые в год Крысы очень умные.", "Los nacidos en el Año de la Rata son listos.", "Quem nasce no Ano do Rato é esperto."),
    ("Крыса — первый знак зодиака.", "La Rata es el primer signo del zodíaco.", "O Rato é o primeiro signo do zodíaco."))
add("Дракон (зодиак)", "Dragón (zodíaco)", "Dragão (zodíaco)",
    ("Дракон — самый важный знак китайского зодиака.", "El Dragón es el signo más importante del zodíaco chino.", "O Dragão é o signo mais importante do zodíaco chinês."),
    ("Рождённые в год Дракона очень энергичные.", "Los nacidos en el Año del Dragón son enérgicos.", "Quem nasce no Ano do Dragão é energético."))
add("Тигр (зодиак)", "Tigre (zodíaco)", "Tigre (zodíaco)",
    ("В год Тигра рождается много детей.", "En el Año del Tigre nacen muchos niños.", "No Ano do Tigre nascem muitas crianças."),
    ("Рождённые в год Тигра очень смелые.", "Los nacidos en el Año del Tigre son valientes.", "Quem nasce no Ano do Tigre é corajoso."))
add("Кролик (зодиак)", "Conejo (zodíaco)", "Coelho (zodíaco)",
    ("Рождённые в год Кролика мягкие характером.", "Los nacidos en el Año del Conejo son gentiles.", "Quem nasce no Ano do Coelho é gentil."),
    ("В этом году у знака Кролика хорошая удача.", "El signo Conejo tiene buena fortuna este año.", "O signo Coelho tem boa sorte este ano."))
add("Змея (зодиак)", "Serpiente (zodíaco)", "Serpente (zodíaco)",
    ("Рождённые в год Змеи очень мудрые.", "Los nacidos en el Año de la Serpiente son sabios.", "Quem nasce no Ano da Serpente é sábio."),
    ("Змея в зодиаке шестая.", "La Serpiente es sexta en el zodíaco.", "A Serpente é a sexta no zodíaco."))
add("Лошадь (зодиак)", "Caballo (zodíaco)", "Cavalo (zodíaco)",
    ("Рождённые в год Лошади любят свободу.", "Los nacidos en el Año del Caballo aman la libertad.", "Quem nasce no Ano do Cavalo ama a liberdade."),
    ("Лошадь символизирует успех.", "El Caballo simboliza el éxito.", "O Cavalo simboliza o sucesso."))
add("Коза / Овца (зодиак)", "Cabra (zodíaco)", "Cabra (zodíaco)",
    ("Рождённые в год Козы очень нежные.", "Los nacidos en el Año de la Cabra son tiernos.", "Quem nasce no Ano da Cabra é terno."),
    ("В год Козы родилось немало людей.", "Nacieron bastantes personas en el Año de la Cabra.", "Nasceram bastante pessoas no Ano da Cabra."))
add("Обезьяна (зодиак)", "Mono (zodíaco)", "Macaco (zodíaco)",
    ("Рождённые в год Обезьяны очень сообразительные.", "Los nacidos en el Año del Mono son astutos.", "Quem nasce no Ano do Macaco é esperto."),
    ("В год Обезьяны все хотят смышлёных детей.", "En años del Mono la gente desea hijos listos.", "Em anos do Macaco as pessoas querem filhos espertos."))
add("Свинья (зодиак)", "Cerdo (zodíaco)", "Porco (zodíaco)",
    ("Рождённые в год Свиньи удачливы.", "Los nacidos en el Año del Cerdo tienen buena fortuna.", "Quem nasce no Ano do Porco tem boa sorte."),
    ("Свинья — последний знак зодиака.", "El Cerdo es el último signo del zodíaco.", "O Porco é o último signo do zodíaco."))
add("каллиграфия", "caligrafía", "caligrafia",
    ("Каллиграфия — традиционное китайское искусство.", "La caligrafía es un arte tradicional chino.", "A caligrafia é uma arte tradicional chinesa."),
    ("Он занимается каллиграфией уже десять лет.", "Lleva diez años practicando caligrafía.", "Ele pratica caligrafia há dez anos."))
add("гохуа / китайская живопись", "pintura china / guohua", "pintura chinesa / guohua",
    ("Эта картина гохуа — пейзаж.", "Esta pintura china es un paisaje.", "Esta pintura chinesa é uma paisagem."),
    ("Гохуа пишут кистью и тушью.", "La pintura china usa pincel y tinta.", "A pintura chinesa usa pincel e tinta."))
add("пекинская опера", "ópera de Pekín", "ópera de Pequim",
    ("Грим пекинской оперы очень характерный.", "El maquillaje de la ópera de Pekín es muy distintivo.", "A maquiagem da ópera de Pequim é bem característica."),
    ("Мы ходили слушать пекинскую оперу.", "Fuimos a oír ópera de Pekín.", "Fomos ouvir ópera de Pequim."))
add("вырезание из бумаги", "recorte de papel", "recorte em papel",
    ("На окне красные вырезки из бумаги.", "En la ventana hay recortes de papel rojos.", "Na janela há recortes de papel vermelhos."),
    ("Вырезание из бумаги — народное искусство.", "El recorte de papel es un arte popular.", "O recorte em papel é uma arte popular."))
add("вышивка", "bordado", "bordado",
    ("Сучжоуская вышивка очень знаменита.", "El bordado de Suzhou es muy famoso.", "O bordado de Suzhou é muito famoso."),
    ("Эта вышивка очень тонкая.", "Este bordado es muy fino.", "Este bordado é muito fino."))
add("фарфор / керамика", "porcelana / cerámica", "porcelana / cerâmica",
    ("Фарфор Цзиндэчжэня известен во всём мире.", "La porcelana de Jingdezhen es famosa en el mundo.", "A porcelana de Jingdezhen é famosa no mundo."),
    ("Эта керамическая ваза очень изящная.", "Este jarrón de cerámica es exquisito.", "Este vaso de cerâmica é requintado."))
add("эрху (двухструнная скрипка)", "erhu (fiddle de dos cuerdas)", "erhu (rabeca de duas cordas)",
    ("Она играет на эрху.", "Toca el erhu.", "Ela toca erhu."),
    ("Звук эрху очень трогательный.", "El sonido del erhu es muy emotivo.", "O som do erhu é muito emocionante."))
add("гучжэн (цитра)", "guzheng (cítara)", "guzheng (cítara)",
    ("Она учит гучжэн с детства.", "Estudia guzheng desde niña.", "Ela estuda guzheng desde criança."),
    ("Мелодии гучжэн очень изящные.", "La música de guzheng es muy elegante.", "A música de guzheng é muito elegante."))
add("сяншэн / комический диалог", "xiangsheng / diálogo cómico", "xiangsheng / diálogo cômico",
    ("Сяншэн заставляет хохотать.", "El xiangsheng hace reír a carcajadas.", "O xiangsheng faz rir à toa."),
    ("Мы слушали сяншэн в чайной.", "Oímos xiangsheng en una casa de té.", "Ouvimos xiangsheng numa casa de chá."))
add("ушу / боевые искусства", "wushu / artes marciales", "wushu / artes marciais",
    ("Ушу — традиционный китайский спорт.", "El wushu es un deporte tradicional chino.", "O wushu é um esporte tradicional chinês."),
    ("Он занимается ушу с детства.", "Practica artes marciales desde niño.", "Ele pratica artes marciais desde criança."))
add("кунгфу / мастерство", "kung fu", "kung fu",
    ("Китайское кунгфу известно во всём мире.", "El kung fu chino es famoso en el mundo.", "O kung fu chinês é famoso no mundo."),
    ("Он занимается кунгфу десять лет.", "Lleva diez años entrenando kung fu.", "Ele treina kung fu há dez anos."))
add("тайцзицюань / тайцзи", "tai chi", "tai chi",
    ("Движения тайцзи очень медленные.", "Los movimientos del tai chi son lentos.", "Os movimentos do tai chi são lentos."),
    ("Пожилые часто делают тайцзи в парке.", "Los mayores suelen practicar tai chi en el parque.", "Idosos costumam praticar tai chi no parque."))
add("юнчунь / вин-чун", "wing chun", "wing chun",
    ("Вин-чун родом из Гуандуна.", "El wing chun viene de Guangdong.", "O wing chun vem de Guangdong."),
    ("Вин-чун делает упор на ближний бой.", "El wing chun se centra en el combate cercano.", "O wing chun foca no combate curto."))
add("храм Шаолинь", "templo Shaolin", "templo Shaolin",
    ("Шаолинь — колыбель кунгфу.", "El templo Shaolin es la cuna del kung fu.", "O templo Shaolin é o berço do kung fu."),
    ("Мы ездили в Шаолинь на экскурсию.", "Visitamos el templo Shaolin.", "Visitamos o templo Shaolin."))
add("мастер / шифу", "maestro / shifu", "mestre / shifu",
    ("Мастер многому меня научил.", "El maestro me enseñó mucho.", "O mestre me ensinou muito."),
    ("Мастер, покажите, пожалуйста.", "Maestro, demuestre, por favor.", "Mestre, demonstre, por favor."))
add("ученик / последователь", "discípulo / alumno", "discípulo / aluno",
    ("Он ученик храма Шаолинь.", "Es discípulo del templo Shaolin.", "Ele é discípulo do templo Shaolin."),
    ("Ученики должны усердно тренироваться.", "Los discípulos deben entrenar con seriedad.", "Os discípulos devem treinar com seriedade."))
add("тренироваться (в боевых искусствах)", "entrenar (artes marciales)", "treinar (artes marciais)",
    ("Каждый день тренируемся по два часа.", "Se entrena dos horas al día.", "Treina-se duas horas por dia."),
    ("Тренировки требуют постоянства.", "El entrenamiento requiere constancia.", "O treino exige constância."))
add("форма / таолу (комплекс движений)", "forma / rutina (marcial)", "forma / rotina (marcial)",
    ("Этот комплекс очень сложный.", "Esta forma es muy difícil.", "Esta forma é muito difícil."),
    ("Он показал комплекс кулачной техники.", "Interpretó una forma de puño.", "Ele apresentou uma forma de soco."))
add("внутренняя работа / нэйгун", "habilidad interna / neigong", "habilidade interna / neigong",
    ("Нэйгун требует долгой практики.", "La habilidad interna requiere un cultivo largo.", "A habilidade interna exige cultivo longo."),
    ("У него глубокий нэйгун.", "Su habilidad interna es profunda.", "A habilidade interna dele é profunda."))
add("поединок / сравнение мастерства", "combate marcial / desafío", "combate marcial / desafio",
    ("Они соревнуются в поединке.", "Están en un combate marcial.", "Eles estão num combate marcial."),
    ("В поединке останавливаются, коснувшись противника.", "En el combate se detiene al contacto.", "No combate para-se no contato."))

apply_rows("culture", ROWS)
print("culture rows", len(ROWS))
