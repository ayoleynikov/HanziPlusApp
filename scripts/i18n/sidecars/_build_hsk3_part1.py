#!/usr/bin/env python3
"""HSK 3 translations 0–99. Pedagogical glosses, not junk CEDICT."""
from __future__ import annotations

ROWS = []


def add(ru, es, pt, *examples):
    ROWS.append((ru, es, pt, examples))


add("междометие (а / ну / ах)", "interjección (ah / eh)", "interjeição (ah / né)",
    ("Ах, сегодня такая хорошая погода!", "¡Ah, hoy hace un tiempo precioso!", "Ah, hoje o tempo está lindo!"),
    ("Что ты сказал?", "¿Qué dijiste?", "O que você disse?"))
add("низкий (о росте)", "bajo (estatura)", "baixo (estatura)",
    ("Младший брат немного ниже меня.", "Mi hermano menor es un poco más bajo que yo.", "Meu irmão mais novo é um pouco mais baixo do que eu."),
    ("Этот дом очень низкий.", "Esta casa es muy baja.", "Esta casa é muito baixa."))
add("хобби / увлечение", "afición / hobby", "hobby / passatempo",
    ("Какое у тебя хобби?", "¿Cuál es tu afición?", "Qual é o seu hobby?"),
    ("Чтение — моё главное увлечение.", "Leer es mi principal afición.", "Ler é o meu principal passatempo."))
add("тихий / спокойный", "tranquilo / silencioso", "quieto / silencioso",
    ("В библиотеке очень тихо.", "En la biblioteca hay un silencio total.", "Na biblioteca está extremamente silencioso."),
    ("Прошу всех немного помолчать.", "Silencio un momento, por favor.", "Silêncio um momento, por favor."))
add("тётя / домработница", "tía / empleada del hogar", "tia / faxineira",
    ("Здравствуйте, тётя!", "¡Hola, tía!", "Oi, tia!"),
    ("Мы наняли тётю убирать комнаты.", "Contratamos a una señora para limpiar las habitaciones.", "Contratamos uma tia para limpar os quartos."))
add("конструкция «ба» / счётчик предметов с ручкой", "partícula ba / clasificador de objetos con mango", "partícula ba / classificador de objetos com cabo",
    ("Закройте, пожалуйста, дверь.", "Cierre la puerta, por favor.", "Feche a porta, por favor."),
    ("Здесь есть стул.", "Hay una silla aquí.", "Tem uma cadeira aqui."))
add("класс / смена / группа", "clase / turno / grupo", "turma / turno / grupo",
    ("В нашем классе двадцать учеников.", "Nuestra clase tiene veinte estudiantes.", "Nossa turma tem vinte alunos."),
    ("Он сегодня не на работе.", "Hoy no trabaja.", "Hoje ele não vai trabalhar."))
add("переносить / переезжать", "mudar / mover", "mudar / carregar",
    ("На следующей неделе мы переезжаем.", "La semana que viene nos mudamos.", "Na semana que vem vamos nos mudar."),
    ("Помогите, пожалуйста, перенести этот стол.", "Ayúdeme a mover esta mesa, por favor.", "Me ajude a carregar esta mesa, por favor."))
add("половина", "mitad / y media", "metade / e meia",
    ("Сейчас половина четвёртого.", "Ahora son las tres y media.", "Agora são três e meia."),
    ("Я съел половину яблока.", "Me comí media manzana.", "Comi metade da maçã."))
add("способ / метод / выход", "manera / método / solución", "jeito / método / solução",
    ("У меня есть хороший способ.", "Tengo una buena solución.", "Tenho um bom jeito."),
    ("У этой проблемы нет другого решения.", "No hay otra solución para este problema.", "Não há outra solução para esse problema."))
add("помогать / выручать", "echar una mano / ayudar", "dar uma mão / ajudar",
    ("Можешь помочь?", "¿Puedes echarme una mano?", "Pode me dar uma mão?"),
    ("Спасибо за помощь.", "Gracias por tu ayuda.", "Obrigado pela ajuda."))
add("офис / кабинет", "oficina / despacho", "escritório",
    ("Менеджер на совещании в кабинете.", "El gerente está en una reunión en la oficina.", "O gerente está em reunião no escritório."),
    ("Это мой офис.", "Esta es mi oficina.", "Este é o meu escritório."))
add("сумка / пакет / заворачивать", "bolso / paquete / envolver", "bolsa / pacote / embrulhar",
    ("Эта сумка очень красивая.", "Este bolso es muy bonito.", "Esta bolsa é muito bonita."),
    ("Что в сумке?", "¿Qué hay en el bolso?", "O que tem na bolsa?"))
add("сытый", "lleno / harto (de comida)", "cheio / satisfeito",
    ("Я уже сыт.", "Ya estoy lleno.", "Já estou cheio."),
    ("Наелся — отдохни.", "Después de llenarte, descansa un poco.", "Depois de ficar cheio, descanse um pouco."))
add("страдательный залог / одеяло", "partícula pasiva / colcha", "partícula passiva / edredom",
    ("Чашку разбил я.", "La taza fue rota por mí.", "O copo foi quebrado por mim."),
    ("Его похвалил учитель.", "Fue elogiado por el profesor.", "Ele foi elogiado pelo professor."))
add("север / север страны", "norte / el norte", "norte / o norte",
    ("На севере зимой очень холодно.", "En el norte el invierno es muy frío.", "No norte o inverno é muito frio."),
    ("Он с севера.", "Viene del norte.", "Ele é do norte."))
add("изменение / меняться", "cambio / cambiar", "mudança / mudar",
    ("Здесь очень многое изменилось.", "Los cambios aquí son enormes.", "As mudanças aqui são enormes."),
    ("Погода постоянно меняется.", "El tiempo cambia sin parar.", "O tempo muda o tempo todo."))
add("выражать / означать", "expresar / indicar", "expressar / indicar",
    ("Что означает это слово?", "¿Qué expresa esta palabra?", "O que esta palavra expressa?"),
    ("Он улыбкой выразил благодарность.", "Expresó su agradecimiento con una sonrisa.", "Ele expressou gratidão com um sorriso."))
add("выступление / выступать", "espectáculo / actuar", "apresentação / se apresentar",
    ("Сегодняшнее выступление было великолепным.", "La actuación de hoy fue excelente.", "A apresentação de hoje foi excelente."),
    ("Они танцуют на сцене.", "Están bailando en el escenario.", "Elas estão dançando no palco."))
add("другие люди / другие", "los demás / otras personas", "os outros / outras pessoas",
    ("Пожалуйста, не мешайте другим.", "Por favor, no moleste a los demás.", "Por favor, não incomode os outros."),
    ("Другие считают, что идея хорошая.", "Los demás piensan que la idea es buena.", "Os outros acham que a ideia é boa."))
add("сравнивать / сравнительно", "comparar / relativamente", "comparar / relativamente",
    ("Этот вопрос сравнительно простой.", "Esta pregunta es relativamente sencilla.", "Esta pergunta é relativamente simples."),
    ("Сегодня сравнительно холодно.", "Hoy hace relativamente frío.", "Hoje está relativamente frio."))
add("гостиница", "hostal / hotel", "pousada / hotel",
    ("Мы живём в гостинице.", "Nos alojamos en un hotel.", "Estamos hospedados num hotel."),
    ("В этой гостинице хорошее обслуживание.", "Este hotel tiene muy buen servicio.", "Este hotel tem um serviço muito bom."))
add("холодильник", "nevera / refrigerador", "geladeira",
    ("Молоко в холодильнике.", "La leche está en la nevera.", "O leite está na geladeira."),
    ("Хочу купить новый холодильник.", "Quiero comprar una nevera nueva.", "Quero comprar uma geladeira nova."))
add("соревнование / матч", "competición / partido", "competição / partida",
    ("Завтра футбольный матч.", "Mañana hay un partido de fútbol.", "Amanhã tem partida de futebol."),
    ("Он занял первое место на соревновании.", "Ganó el primer puesto en la competición.", "Ele ficou em primeiro na competição."))
add("должен / необходимо", "deber / tener que", "dever / ter que",
    ("Ты должен закончить вовремя.", "Debes terminar a tiempo.", "Você tem que terminar no prazo."),
    ("Чтобы учить китайский, нужно много практиковаться.", "Para aprender chino hay que practicar mucho.", "Para aprender chinês é preciso praticar muito."))
add("нос", "nariz", "nariz",
    ("У меня немного болит нос.", "Me duele un poco la nariz.", "Meu nariz dói um pouco."),
    ("У собаки очень чуткий нос.", "La nariz del perro es muy sensible.", "O nariz do cachorro é muito sensível."))
add("не только (... но и)", "no solo (... sino también)", "não só (... mas também)",
    ("Он не только говорит по-китайски, но и очень хорошо.", "No solo habla chino, sino que lo habla muy bien.", "Ele não só fala chinês, como fala muito bem."),
    ("Этот вопрос не только сложный, но и важный.", "Esta pregunta no solo es difícil, sino también importante.", "Essa pergunta não é só difícil, mas também importante."))
add("только / лишь тогда / только что", "recién / solo / apenas", "só / só então / só agora",
    ("Ему всего восемь лет.", "Solo tiene ocho años.", "Ele só tem oito anos."),
    ("Я только что добрался домой.", "Acabo de llegar a casa.", "Acabei de chegar em casa."))
add("меню", "menú / carta", "cardápio / menu",
    ("Официант, меню, пожалуйста.", "Camarero, la carta, por favor.", "Garçom, o cardápio, por favor."),
    ("В меню много блюд.", "Hay muchos platos en el menú.", "Há muitos pratos no cardápio."))
add("участвовать / присутствовать", "participar / asistir", "participar / comparecer",
    ("Я иду на завтрашнее совещание.", "Asistiré a la reunión de mañana.", "Vou participar da reunião de amanhã."),
    ("Многие участвовали в этом мероприятии.", "Mucha gente participó en este evento.", "Muita gente participou deste evento."))
add("трава", "hierba / césped", "grama / capim",
    ("На траве много цветов.", "Hay muchas flores en el césped.", "Há muitas flores na grama."),
    ("Корова ест траву.", "La vaca está comiendo hierba.", "A vaca está comendo capim."))
add("этаж / слой", "piso / capa", "andar / camada",
    ("Я живу на пятом этаже.", "Vivo en el quinto piso.", "Moro no quinto andar."),
    ("У торта три слоя.", "El pastel tiene tres capas.", "O bolo tem três camadas."))
add("плохой / не хватать / почти", "malo / faltar / por poco", "ruim / faltar / quase",
    ("Сегодня результат чуть хуже.", "Hoy la nota es un poco peor.", "Hoje a nota está um pouco pior."),
    ("Наши мнения различаются.", "Nuestras opiniones difieren.", "Nossas opiniões diferem."))
add("супермаркет", "supermercado", "supermercado",
    ("Я иду в супермаркет за покупками.", "Voy al supermercado a comprar algo.", "Vou ao supermercado comprar umas coisas."),
    ("Этот супермаркет очень большой.", "Este supermercado es enorme.", "Este supermercado é enorme."))
add("успеваемость / результат", "notas / rendimiento", "notas / desempenho",
    ("У него хорошая успеваемость.", "Su rendimiento académico es muy bueno.", "O desempenho dele na escola é muito bom."),
    ("Результаты этого экзамена неплохие.", "Los resultados de este examen no están mal.", "Os resultados desta prova não estão ruins."))
add("город", "ciudad", "cidade",
    ("Пекин — большой город.", "Pekín es una gran ciudad.", "Pequim é uma cidade grande."),
    ("Мне больше нравятся маленькие города.", "Prefiero las ciudades pequeñas.", "Prefiro cidades pequenas."))
add("рубашка", "camisa", "camisa",
    ("На нём белая рубашка.", "Llevaba una camisa blanca.", "Ele estava de camisa branca."),
    ("Эта рубашка хорошо сидит.", "Esta camisa queda muy bien.", "Esta camisa fica muito bem."))
add("опаздывать", "llegar tarde", "chegar atrasado",
    ("Извините, я опоздал.", "Perdón, llegué tarde.", "Desculpe, cheguei atrasado."),
    ("На урок не опаздывайте.", "No llegues tarde a clase.", "Não chegue atrasado à aula."))
add("кроме / помимо", "además de / excepto", "além de / exceto",
    ("Кроме китайского я ещё учу английский.", "Además de chino, también estudio inglés.", "Além de chinês, também estudo inglês."),
    ("Кроме него все уже пришли.", "Excepto él, ya llegaron todos.", "Exceto ele, todo mundo já chegou."))
add("весна", "primavera", "primavera",
    ("Пришла весна, расцвели цветы.", "Llegó la primavera y florecieron las flores.", "Chegou a primavera e as flores desabrocharam."),
    ("Больше всего я люблю весну.", "La primavera es mi estación favorita.", "A primavera é a estação que eu mais gosto."))
add("появляться / возникать", "aparecer / surgir", "aparecer / surgir",
    ("На экране компьютера появилась проблема.", "Apareció un problema en la pantalla.", "Apareceu um problema na tela do computador."),
    ("Он наконец появился.", "Por fin apareció.", "Ele finalmente apareceu."))
add("умный", "inteligente / listo", "inteligente / esperto",
    ("Этот ребёнок очень умный.", "Este niño es extremadamente inteligente.", "Esta criança é extremamente inteligente."),
    ("Он умный ученик.", "Es un estudiante listo.", "Ele é um aluno esperto."))
add("брать с собой / вести", "llevar / traer", "levar / trazer",
    ("Не забудь взять зонт.", "No olvides llevar el paraguas.", "Não esqueça de levar o guarda-chuva."),
    ("Сегодня я не взял деньги.", "Hoy no traje dinero.", "Hoje eu não trouxe dinheiro."))
add("торт / пирог", "pastel / tarta", "bolo",
    ("С днём рождения! Это твой торт.", "¡Feliz cumpleaños! Este es tu pastel.", "Feliz aniversário! Este é o seu bolo."),
    ("Этот торт очень вкусный.", "Este pastel está riquísimo.", "Este bolo está uma delícia."))
add("конечно / разумеется", "claro / por supuesto", "claro / com certeza",
    ("Конечно, я готов помочь.", "Claro que estoy dispuesto a ayudarte.", "Claro que estou disposto a ajudar."),
    ("Этот вопрос, конечно, простой.", "Este problema, por supuesto, es sencillo.", "Essa pergunta, claro, é simples."))
add("беспокоиться / волноваться", "preocuparse", "se preocupar",
    ("Не волнуйся, всё будет хорошо.", "No te preocupes, todo irá bien.", "Não se preocupe, vai dar tudo certo."),
    ("Мама очень переживает из-за моего экзамена.", "Mamá está muy preocupada por mi examen.", "A mamãe está muito preocupada com a minha prova."))
add("убирать / чистить", "limpiar", "limpar",
    ("Я убираю комнату.", "Estoy limpiando la habitación.", "Estou limpando o quarto."),
    ("Пожалуйста, уберите класс.", "Limpien el aula, por favor.", "Limpe a sala, por favor."))
add("планировать / план", "planear / plan", "planejar / plano",
    ("Какие планы на выходные?", "¿Qué planes tienes para el fin de semana?", "Quais são seus planos para o fim de semana?"),
    ("Я планирую поехать в Пекин.", "Planeo viajar a Pekín.", "Pretendo viajar para Pequim."))
add("частица образа действия (de)", "partícula adverbial", "partícula adverbial",
    ("Он радостно сказал.", "Dijo alegremente.", "Ele disse alegremente."),
    ("Иди медленно, не торопись.", "Camina despacio, no te apures.", "Ande devagar, sem pressa."))
add("лампа / свет", "lámpara / luz", "lâmpada / luz",
    ("Выключите, пожалуйста, свет.", "Apague la luz, por favor.", "Apague a luz, por favor."),
    ("В комнате горит свет.", "La luz de la habitación está encendida.", "A luz do quarto está acesa."))
add("низкий", "bajo", "baixo",
    ("Это здание очень низкое.", "Este edificio es muy bajo.", "Este prédio é muito baixo."),
    ("Сегодня температура очень низкая.", "Hoy la temperatura es muy baja.", "Hoje a temperatura está muito baixa."))
add("лифт", "ascensor / elevador", "elevador",
    ("Поедем на лифте наверх.", "Subamos en el ascensor.", "Vamos de elevador para cima."),
    ("Лифт сломался, придётся по лестнице.", "El ascensor está roto, solo quedan las escaleras.", "O elevador quebrou, só resta a escada."))
add("электронный", "electrónico", "eletrônico",
    ("Это электронный словарь.", "Este es un diccionario electrónico.", "Este é um dicionário eletrônico."),
    ("Дайте, пожалуйста, ваш адрес электронной почты.", "Deme su correo electrónico, por favor.", "Me dê o seu e-mail, por favor."))
add("место / местность", "lugar / sitio", "lugar / lugarzinho",
    ("Это хорошее место.", "Este es un buen lugar.", "Este é um bom lugar."),
    ("Куда ты хочешь пойти?", "¿A qué lugar quieres ir?", "Para que lugar você quer ir?"))
add("метро", "metro / subway", "metrô",
    ("Я езжу на работу на метро.", "Voy al trabajo en metro.", "Vou ao trabalho de metrô."),
    ("Станция метро прямо впереди.", "La estación de metro está justo delante.", "A estação de metrô fica logo à frente."))
add("карта", "mapa", "mapa",
    ("Найдите, пожалуйста, Пекин на карте.", "Encuentre Pekín en el mapa, por favor.", "Encontre Pequim no mapa, por favor."),
    ("Я пользуюсь навигацией в телефоне.", "Uso el mapa del móvil para navegar.", "Uso o mapa do celular para navegar."))
add("восток", "este / oriente", "leste / leste",
    ("Солнце встаёт на востоке.", "El sol sale por el este.", "O sol nasce no leste."),
    ("Мой дом на востоке города.", "Mi casa está en el este de la ciudad.", "Minha casa fica no leste da cidade."))
add("зима", "invierno", "inverno",
    ("Зимой часто идёт снег.", "En invierno suele nevar.", "No inverno costuma nevar."),
    ("Зима на севере очень длинная.", "El invierno del norte es muy largo.", "O inverno no norte é bem longo."))
add("животное", "animal", "animal",
    ("В зоопарке много животных.", "Hay muchos animales en el zoológico.", "Há muitos animais no zoológico."),
    ("Какие животные тебе нравятся?", "¿Qué animales te gustan?", "De quais animais você gosta?"))
add("короткий / краткий", "corto / breve", "curto / breve",
    ("Эти брюки слишком короткие.", "Estos pantalones son demasiado cortos.", "Esta calça é curta demais."),
    ("Сегодняшнее собрание было коротким.", "La reunión de hoy fue muy breve.", "A reunião de hoje foi bem curta."))
add("отрезок / абзац / период", "párrafo / tramo / período", "parágrafo / trecho / período",
    ("Прочитайте, пожалуйста, этот абзац.", "Lea este párrafo, por favor.", "Leia este parágrafo, por favor."),
    ("В последнее время я очень занят.", "En este período estoy muy ocupado.", "Neste período estou muito ocupado."))
add("тренироваться / закаляться", "hacer ejercicio / entrenar", "fazer exercício / treinar",
    ("Каждый день я хожу в парк заниматься спортом.", "Voy al parque a hacer ejercicio todos los días.", "Todo dia eu vou ao parque fazer exercício."),
    ("Больше двигаться полезно для здоровья.", "Hacer más ejercicio es bueno para el cuerpo.", "Fazer mais exercício faz bem ao corpo."))
add("как же / насколько", "qué tan / cuán", "como é / tão",
    ("Какой здесь красивый вид!", "¡Qué hermoso es el paisaje de aquí!", "Como o cenário daqui é bonito!"),
    ("Как же он хочет домой.", "Cuánto echa de menos su casa.", "Como ele quer ir para casa."))
add("голодный", "hambriento", "com fome",
    ("Я голоден, хочу есть.", "Tengo hambre y quiero comer.", "Estou com fome e quero comer."),
    ("Не мори себя голодом.", "No te quedes con hambre.", "Não fique com fome."))
add("ухо", "oreja / oído", "orelha / ouvido",
    ("У меня немного болит ухо.", "Me duele un poco la oreja.", "Minha orelha dói um pouco."),
    ("Слушайте внимательно ушами.", "Escuchen con atención.", "Escutem com atenção."))
add("и к тому же / причём", "y además / y también", "e ainda / e também",
    ("Он умный и к тому же старательный.", "Es inteligente y además trabajador.", "Ele é inteligente e ainda se esforça."),
    ("Этот способ простой и при этом эффективный.", "Este método es sencillo y además eficaz.", "Este método é simples e ainda eficaz."))
add("класть / отпускать / отпускать на каникулы", "poner / soltar / dar vacaciones", "colocar / soltar / dar férias",
    ("Положите книгу на стол.", "Ponga el libro sobre la mesa, por favor.", "Coloque o livro na mesa, por favor."),
    ("Мы скоро уходим на каникулы.", "Estamos a punto de irnos de vacaciones.", "Estamos quase saindo de férias."))
add("удобный / удобно", "conveniente / práctico", "conveniente / prático",
    ("Ехать на метро очень удобно.", "Ir en metro es muy conveniente.", "Ir de metrô é muito conveniente."),
    ("Вам сейчас удобно говорить?", "¿Te viene bien hablar ahora?", "Está conveniente falar agora?"))
add("не волноваться / быть спокойным", "quedar tranquilo / no preocuparse", "ficar tranquilo / não se preocupar",
    ("Не волнуйтесь, это дело оставьте мне.", "Quédese tranquilo, déjeme este asunto.", "Fique tranquilo, deixe este assunto comigo."),
    ("Увидев, что с ним всё в порядке, я успокоился.", "Al ver que estaba bien, me quedé tranquilo.", "Ao ver que ele estava bem, fiquei tranquilo."))
add("температура / жар", "fiebre / tener fiebre", "febre / estar com febre",
    ("У ребёнка температура.", "El niño tiene fiebre.", "A criança está com febre."),
    ("У меня жар 39 градусов.", "Tengo 39 de fiebre.", "Estou com 39 de febre."))
add("обнаруживать / открывать", "descubrir / notar", "descobrir / perceber",
    ("Я обнаружил проблему.", "Descubrí un problema.", "Descobri um problema."),
    ("Где ты это нашёл?", "¿Dónde lo encontraste?", "Onde você encontrou?"))
add("делить / минута / балл", "dividir / minuto / punto", "dividir / minuto / ponto",
    ("Разделите яблоко пополам.", "Divida la manzana por la mitad, por favor.", "Divida a maçã ao meio, por favor."),
    ("Сейчас три часа пятнадцать минут.", "Ahora son las tres y quince.", "Agora são três e quinze."))
add("поблизости / окрестности", "cerca / alrededores", "perto / redondezas",
    ("Рядом с моим домом есть парк.", "Hay un parque cerca de mi casa.", "Tem um parque perto da minha casa."),
    ("Есть ли поблизости рестораны?", "¿Hay restaurantes cerca?", "Tem restaurante por perto?"))
add("повторять / готовиться (к экзамену)", "repasar / revisar", "revisar / estudar de novo",
    ("Я повторяю материал к завтрашнему экзамену.", "Estoy repasando el material del examen de mañana.", "Estou revisando o conteúdo da prova de amanhã."),
    ("После урока обязательно хорошо повторите.", "Después de clase hay que repasar bien.", "Depois da aula é preciso revisar bem."))
add("сметь / осмеливаться", "atreverse / osar", "ousar / ter coragem",
    ("Смеешь попробовать?", "¿Te atreves a intentarlo?", "Você ousa tentar?"),
    ("Я не осмеливаюсь идти один.", "No me atrevo a ir solo.", "Não tenho coragem de ir sozinho."))
add("только что / недавно", "hace un momento / recién", "agora há pouco / há pouco",
    ("Кто только что приходил?", "¿Quién vino hace un momento?", "Quem veio agora há pouco?"),
    ("Я только что его видел.", "Lo vi hace un momento.", "Eu o vi agora há pouco."))
add("чистый", "limpio", "limpo",
    ("Комнату убрали до блеска.", "La habitación quedó muy limpia.", "O quarto ficou extremamente limpo."),
    ("Наденьте чистую одежду.", "Póngase ropa limpia, por favor.", "Vista roupa limpa, por favor."))
add("простудиться / простуда", "resfriarse / resfriado", "pegar um resfriado / gripe leve",
    ("Сегодня я простудился, немного температура.", "Hoy me resfrié y tengo un poco de fiebre.", "Hoje peguei um resfriado e estou com um pouco de febre."),
    ("Холодно, не простудитесь.", "Hace frío, cuidado de no resfriarte.", "Está frio, cuidado para não pegar resfriado."))
add("с / следовать за", "con / seguir", "com / seguir",
    ("Я хочу с тобой поговорить.", "Quiero hablar contigo.", "Quero conversar com você."),
    ("Идите за мной, пожалуйста.", "Sígame, por favor.", "Venha comigo, por favor."))
add("ещё более / более", "aún más / más", "ainda mais / mais",
    ("Сегодня ещё холоднее.", "Hoy hace aún más frío.", "Hoje está ainda mais frio."),
    ("Мне нужно больше практики.", "Necesito más práctica.", "Preciso de mais prática."))
add("согласно / на основании", "según / de acuerdo con", "segundo / de acordo com",
    ("Ответьте на вопросы по тексту.", "Responda según el artículo.", "Responda de acordo com o texto."),
    ("По прогнозу завтра будет дождь.", "Según el pronóstico, mañana lloverá.", "Segundo a previsão, amanhã vai chover."))
add("парк", "parque", "parque",
    ("Многие гуляют в парке.", "Mucha gente pasea en el parque.", "Muita gente passeia no parque."),
    ("Пойдём в парк погулять.", "Vamos al parque a divertirnos.", "Vamos ao parque brincar."))
add("дуть (о ветре) / скрести", "soplar (viento) / raspar", "ventar / raspar",
    ("Сегодня сильный ветер.", "Hoy hace mucho viento.", "Hoje está ventando muito."),
    ("На улице ветрено.", "Afuera está ventoso.", "Lá fora está ventando."))
add("закрывать / выключать", "cerrar / apagar", "fechar / desligar",
    ("Выключите, пожалуйста, телевизор.", "Apague la televisión, por favor.", "Desligue a TV, por favor."),
    ("Перед уходом не забудьте закрыть окна.", "Antes de salir, recuerde cerrar las ventanas.", "Antes de sair, lembre-se de fechar as janelas."))
add("отношение / связь", "relación / vínculo", "relação / vínculo",
    ("У нас с ним очень хорошие отношения.", "Mi relación con él es muy buena.", "Minha relação com ele é muito boa."),
    ("Это дело ко мне не относится.", "Este asunto no tiene nada que ver conmigo.", "Esse assunto não tem nada a ver comigo."))
add("заботиться / проявлять внимание", "preocuparse por / cuidar", "se importar / cuidar",
    ("Спасибо, что заботишься обо мне.", "Gracias por preocuparte por mí.", "Obrigado por se importar comigo."),
    ("Родители очень заботятся о детях.", "Los padres se preocupan mucho por los hijos.", "Os pais se importam muito com os filhos."))
add("о / относительно", "sobre / acerca de", "sobre / a respeito de",
    ("По этому вопросу у меня другое мнение.", "Sobre esta cuestión tengo otra opinión.", "Sobre esta questão tenho outra opinião."),
    ("Дайте материалы о Китае.", "Deme materiales sobre China, por favor.", "Me dê materiais sobre a China, por favor."))
add("страна / государство", "país / nación", "país / nação",
    ("Китай — великая страна.", "China es un gran país.", "A China é um grande país."),
    ("В каких странах ты бывал?", "¿A qué países has ido?", "A quais países você já foi?"))
add("прошлое / пройти / подойти", "el pasado / pasar / ir allá", "o passado / passar / ir até",
    ("Прошлое пусть останется в прошлом.", "Deja que lo pasado quede en el pasado.", "Deixe o passado no passado."),
    ("Подойдите, пожалуйста, посмотрите.", "Pase allá y mire, por favor.", "Vá até lá e dê uma olhada, por favor."))
add("сок", "zumo / jugo", "suco",
    ("Хочу стакан сока.", "Quiero un vaso de jugo.", "Quero um copo de suco."),
    ("Это свежий сок.", "Este es jugo fresco.", "Este é suco fresco."))
add("история / рассказ", "historia / cuento", "história / conto",
    ("Бабушка рассказала мне историю.", "La abuela me contó un cuento.", "A vovó me contou uma história."),
    ("Это интересная история.", "Esta es una historia interesante.", "Esta é uma história interessante."))
add("бояться / страх", "tener miedo / temer", "ter medo / temer",
    ("Я боюсь ходить один в темноте.", "Tengo miedo de caminar solo de noche.", "Tenho medo de andar sozinho no escuro."),
    ("Не бойся, я рядом.", "No tengas miedo, estoy aquí.", "Não tenha medo, eu estou aqui."))
add("или / всё же", "o / todavía", "ou / ainda",
    ("Хочешь чай или кофе?", "¿Quieres té o café?", "Você quer chá ou café?"),
    ("Он всё ещё студент.", "Sigue siendo estudiante.", "Ele ainda é estudante."))
add("рейс / авиарейс", "vuelo", "voo",
    ("Мой рейс в три часа дня.", "Mi vuelo es a las 3 de la tarde.", "Meu voo é às 15h."),
    ("Рейс задержали из-за погоды.", "El vuelo se retrasó por el tiempo.", "O voo atrasou por causa do tempo."))
add("река", "río", "rio",
    ("Эта река очень длинная.", "Este río es muy largo.", "Este rio é muito longo."),
    ("Мы гуляем у реки.", "Paseamos junto al río.", "Estamos passeando à beira do rio."))
add("доска / классная доска", "pizarra / pizarrón", "lousa / quadro-negro",
    ("Учитель пишет на доске.", "El profesor escribe en la pizarra.", "O professor está escrevendo na lousa."),
    ("Смотрите, пожалуйста, на доску.", "Miren la pizarra, por favor.", "Olhem para a lousa, por favor."))
add("цветок / тратить", "flor / gastar", "flor / gastar",
    ("На столе горшок с цветами.", "Hay una maceta de flores sobre la mesa.", "Tem um vaso de flores na mesa."),
    ("На одежду я потратил не так уж много денег.", "No gasté demasiado en la ropa.", "Não gastei tanto com a roupa."))
add("рисунок / рисовать / картина", "dibujo / pintar / cuadro", "desenho / pintar / quadro",
    ("Он очень хорошо рисует.", "Dibuja muy bien.", "Ele desenha muito bem."),
    ("На стене висит картина.", "Hay un cuadro colgado en la pared.", "Tem um quadro pendurado na parede."))
add("плохой / сломанный", "malo / roto", "ruim / quebrado",
    ("Мой телефон сломался.", "Se me rompió el móvil.", "Meu celular quebrou."),
    ("Слишком много сладкого портит зубы.", "Comer demasiados dulces estropea los dientes.", "Comer doce demais estraga os dentes."))
add("менять / обменивать", "cambiar / canjear", "trocar / câmbio",
    ("Хочу обменять немного юаней.", "Quiero cambiar un poco de yuanes.", "Quero trocar um pouco de yuans."),
    ("Переоденьтесь в чистую одежду.", "Cámbiese a ropa limpia, por favor.", "Troque para uma roupa limpa, por favor."))
