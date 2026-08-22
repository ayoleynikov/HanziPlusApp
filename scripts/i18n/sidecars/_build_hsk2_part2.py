#!/usr/bin/env python3
"""HSK 2 translations 75–149."""
from __future__ import annotations

ROWS = []


def add(ru, es, pt, *examples):
    ROWS.append((ru, es, pt, examples))


add("билет", "boleto / entrada", "ingresso / passagem",
    ("Я купил два билета в кино.", "Compré dos entradas de cine.", "Comprei dois ingressos de cinema."),
    ("Предъявите, пожалуйста, билет на поезд.", "Muestre su billete de tren, por favor.", "Mostre sua passagem de trem, por favor."))
add("дешёвый", "barato", "barato",
    ("Эта одежда очень дешёвая.", "Esta prenda es muy barata.", "Esta roupa é bem barata."),
    ("Можно немного дешевле?", "¿Se puede un poco más barato?", "Dá para ficar um pouco mais barato?"))
add("рядом / сбоку", "al lado / junto a", "ao lado / ao lado de",
    ("Рядом со школой есть супермаркет.", "Hay un supermercado al lado de la escuela.", "Tem um supermercado ao lado da escola."),
    ("Человек рядом со мной — Сяо Мин.", "La persona sentada a mi lado es Xiaoming.", "A pessoa sentada ao meu lado é o Xiaoming."))
add("бегать / бегать трусцой", "correr / trotar", "correr / correr ao ar livre",
    ("Каждое утро я хожу на пробежку.", "Cada mañana salgo a correr.", "Toda manhã eu saio para correr."),
    ("Бег очень полезен для здоровья.", "Correr es muy bueno para la salud.", "Correr faz muito bem à saúde."))
add("тысяча", "mil", "mil",
    ("Этот компьютер стоит пять тысяч юаней.", "Esta computadora cuesta cinco mil yuanes.", "Este computador custa cinco mil yuans."),
    ("В нашей школе тысяча студентов.", "Nuestra escuela tiene mil estudiantes.", "Nossa escola tem mil alunos."))
add("карандаш", "lápiz", "lápis",
    ("Пишите, пожалуйста, карандашом.", "Escriba con lápiz, por favor.", "Escreva a lápis, por favor."),
    ("У меня новый карандаш.", "Tengo un lápiz nuevo.", "Tenho um lápis novo."))
add("ясно / солнечная погода", "despejado / soleado", "ensolarado / céu limpo",
    ("Сегодня солнечный день.", "Hoy es un día soleado.", "Hoje está um dia de sol."),
    ("Завтра прояснится.", "Mañana el tiempo se despejará.", "Amanhã o tempo vai abrir."))
add("в прошлом году", "el año pasado", "ano passado",
    ("В прошлом году я ездил в Китай.", "El año pasado fui a China.", "Ano passado eu fui à China."),
    ("Он начал учить китайский в прошлом году.", "Empezó a estudiar chino el año pasado.", "Ele começou a estudar chinês no ano passado."))
add("жена", "esposa", "esposa",
    ("Моя жена — врач.", "Mi esposa es médica.", "Minha esposa é médica."),
    ("Он поехал путешествовать вместе с женой.", "Fue de viaje con su esposa.", "Ele viajou com a esposa."))
add("вставать (с постели)", "levantarse de la cama", "acordar / levantar da cama",
    ("Я встаю каждый день в семь.", "Me levanto todos los días a las siete.", "Eu acordo todo dia às sete."),
    ("Вставай скорее, опоздаешь!", "¡Levántate rápido, vas a llegar tarde!", "Levanta logo, você vai se atrasar!"))
add("позволять / пусть / заставлять", "dejar / hacer que / permitir", "deixar / fazer com que / permitir",
    ("Мама велит мне есть больше овощей.", "Mamá me hace comer más verduras.", "A mamãe manda eu comer mais verdura."),
    ("Дай-ка я посмотрю.", "Déjame echar un vistazo.", "Deixa eu dar uma olhada."))
add("день / число / солнце", "día / fecha / sol", "dia / data / sol",
    ("Сегодня 1 мая, Международный день труда.", "Hoy es el 1 de mayo, Día Internacional del Trabajo.", "Hoje é 1.º de maio, Dia Internacional do Trabalho."),
    ("Восход очень красивый.", "El amanecer es precioso.", "O nascer do sol é lindo."))
add("идти на работу", "ir a trabajar", "ir trabalhar",
    ("Я каждый день выхожу на работу в половине девятого.", "Voy a trabajar a las 8:30 todas las mañanas.", "Eu saio para trabalhar às 8h30 toda manhã."),
    ("Папа сейчас на работе.", "Papá está trabajando ahora.", "O papai está no trabalho agora."))
add("дело / обстоятельство", "asunto / cosa", "assunto / coisa",
    ("Сегодня мне нужно решить важное дело.", "Hoy tengo un asunto importante que resolver.", "Hoje tenho um assunto importante para resolver."),
    ("Это дело уже решено.", "Este asunto ya está resuelto.", "Esse assunto já foi resolvido."))
add("время", "tiempo / hora", "tempo / horário",
    ("У меня нет времени идти в кино.", "No tengo tiempo para ir al cine.", "Não tenho tempo de ir ao cinema."),
    ("Время летит так быстро.", "El tiempo pasa muy rápido.", "O tempo passa muito rápido."))
add("заболеть", "enfermarse / ponerse enfermo", "ficar doente",
    ("Он заболел и не пошёл в школу.", "Se enfermó y no fue a la escuela.", "Ele ficou doente e não foi à escola."),
    ("Похолодало, не заболей.", "Está haciendo frío, cuidado de no enfermarte.", "Está esfriando, cuidado para não ficar doente."))
add("день рождения", "cumpleaños", "aniversário",
    ("Сегодня мой день рождения.", "Hoy es mi cumpleaños.", "Hoje é o meu aniversário."),
    ("С днём рождения!", "¡Feliz cumpleaños!", "Feliz aniversário!"))
add("тело / здоровье", "cuerpo / salud", "corpo / saúde",
    ("Желаю тебе здоровья!", "¡Que tengas buena salud!", "Desejo saúde a você!"),
    ("В последнее время я в хорошей форме.", "Últimamente mi salud está muy bien.", "Ultimamente minha saúde está ótima."))
add("наручные часы", "reloj de pulsera", "relógio de pulso",
    ("Эти часы мне подарила мама.", "Este reloj me lo regaló mamá.", "Este relógio foi presente da mamãe."),
    ("Посмотри на часы: который час?", "Mira el reloj, ¿qué hora es?", "Olha o relógio, que horas são?"))
add("мобильный телефон", "teléfono móvil", "celular",
    ("У моего телефона сел аккумулятор.", "Se me acabó la batería del móvil.", "Meu celular está sem bateria."),
    ("Он купил новый телефон.", "Compró un teléfono nuevo.", "Ele comprou um celular novo."))
add("поэтому / так что", "por eso / así que", "por isso / então",
    ("Потому что шёл дождь, мы не пошли.", "Como llovió, no fuimos.", "Como choveu, a gente não foi."),
    ("Он очень старается, поэтому оценки хорошие.", "Estudia mucho, por eso saca buenas notas.", "Ele estuda muito, por isso as notas são boas."))
add("дарить / провожать / отправлять", "regalar / despedir / entregar", "presentear / despedir / entregar",
    ("Я дарю тебе подарок.", "Te regalo un presente.", "Te dou um presente."),
    ("Я еду в аэропорт проводить друга.", "Voy al aeropuerto a despedir a un amigo.", "Vou ao aeroporto despedir um amigo."))
add("танцевать", "bailar", "dançar",
    ("Она любит петь и танцевать.", "Le gusta cantar y bailar.", "Ela gosta de cantar e dançar."),
    ("Давайте потанцуем вместе.", "Bailemos juntos.", "Vamos dançar juntos."))
add("задача / вопрос (в задании)", "ejercicio / pregunta", "questão / exercício",
    ("Эта задача слишком сложная, я не умею.", "Este ejercicio es demasiado difícil, no sé hacerlo.", "Essa questão é difícil demais, eu não sei fazer."),
    ("На экзамене всего десять заданий.", "El examen tiene diez preguntas en total.", "A prova tem dez questões no total."))
add("оно / он/она (о предметах и животных)", "ello / él (cosas y animales)", "ele / ela (coisas e animais)",
    ("Это щенок, он очень милый.", "Ese es un perrito, es muy adorable.", "Aquele é um cachorrinho, ele é muito fofo."),
    ("Моя кошка спит, пожалуйста, не беспокой её.", "Mi gato está durmiendo, no lo molestes.", "Meu gato está dormindo, por favor não incomode."))
add("играть в футбол", "jugar al fútbol", "jogar futebol",
    ("По выходным я играю в футбол с друзьями.", "Los fines de semana juego al fútbol con amigos.", "No fim de semana eu jogo futebol com os amigos."),
    ("Он очень хорошо играет в футбол.", "Juega al fútbol extremadamente bien.", "Ele joga futebol extremamente bem."))
add("снаружи / иностранный", "afuera / extranjero", "fora / estrangeiro",
    ("На улице сейчас идёт дождь.", "Afuera está lloviendo.", "Lá fora está chovendo."),
    ("Он уехал учиться за границу.", "Se fue a estudiar al extranjero.", "Ele foi estudar no exterior."))
add("закончить / завершить", "terminar / acabar", "terminar / acabar",
    ("Я уже сделал домашнее задание.", "Ya terminé la tarea.", "Já terminei a lição de casa."),
    ("Ты дочитал эту книгу?", "¿Ya terminaste de leer este libro?", "Você já terminou de ler este livro?"))
add("играть / развлекаться", "jugar / divertirse", "brincar / se divertir",
    ("Дети играют в парке.", "Los niños están jugando en el parque.", "As crianças estão brincando no parque."),
    ("Куда ты ходил развлекаться на выходных?", "¿Adónde fuiste a divertirte el fin de semana?", "Onde você foi se divertir no fim de semana?"))
add("почему", "por qué", "por que",
    ("Почему ты не пошёл на урок?", "¿Por qué no fuiste a clase?", "Por que você não foi à aula?"),
    ("Он не знает, почему все смеются.", "No sabe por qué todos se ríen.", "Ele não sabe por que todo mundo está rindo."))
add("спрашивать", "preguntar", "perguntar",
    ("Можно задать вам вопрос?", "¿Puedo hacerte una pregunta?", "Posso te fazer uma pergunta?"),
    ("Сходи спроси учителя.", "Ve a preguntarle al profesor.", "Vai perguntar ao professor."))
add("вопрос / проблема", "pregunta / problema", "pergunta / problema",
    ("Эта проблема очень сложная.", "Este problema es muy complejo.", "Esse problema é bem complexo."),
    ("У вас есть вопросы?", "¿Tienes alguna pregunta?", "Você tem alguma pergunta?"))
add("в направлении / к", "hacia / en dirección a", "em direção a / para",
    ("Идите, пожалуйста, налево.", "Camine hacia la izquierda, por favor.", "Ande para a esquerda, por favor."),
    ("Пройдите вперёд сто метров — и вы на месте.", "Siga 100 metros hacia adelante y llega.", "Siga 100 metros para a frente e você chega."))
add("вечер / ночь", "noche / tarde-noche", "noite",
    ("Я ложусь спать в десять вечера.", "Me duermo a las diez de la noche.", "Eu durmo às dez da noite."),
    ("Давайте сегодня вечером поужинаем вместе.", "Cenemos juntos esta noche.", "Vamos jantar juntos hoje à noite."))
add("смеяться / улыбаться", "reír / sonreír", "rir / sorrir",
    ("Услышав хорошие новости, все заулыбались.", "Al oír la buena noticia, todos sonrieron.", "Ao ouvir a boa notícia, todo mundo sorriu."),
    ("Она улыбается очень радостно.", "Sonríe con mucha alegría.", "Ela sorri bem feliz."))
add("отдыхать", "descansar", "descansar",
    ("Слишком устал, давайте немного отдохнём.", "Estoy muy cansado, descansemos un poco.", "Estou cansado demais, vamos descansar um pouco."),
    ("На выходных я отдыхаю дома.", "Los fines de semana descanso en casa.", "No fim de semana eu descanso em casa."))
add("час", "hora", "hora",
    ("Я ждал тебя час.", "Te esperé una hora.", "Esperei você por uma hora."),
    ("На самолёте нужно два часа.", "El avión tarda dos horas.", "O avião leva duas horas."))
add("снег", "nieve", "neve",
    ("Выпал снег, кругом всё белое.", "Nevó, afuera todo está blanco.", "Neveu, lá fora está tudo branco."),
    ("Пойдём лепить снеговика.", "Vamos afuera a hacer un muñeco de nieve.", "Vamos lá fora fazer um boneco de neve."))
add("фамилия", "apellido", "sobrenome",
    ("Моя фамилия Чжан, меня зовут Чжан Вэй.", "Mi apellido es Zhang, me llamo Zhang Wei.", "Meu sobrenome é Zhang, me chamo Zhang Wei."),
    ("Как ваша фамилия?", "¿Cuál es su apellido?", "Qual é o seu sobrenome?"))
add("арбуз", "sandía", "melancia",
    ("Летом есть арбуз очень приятно.", "Comer sandía en verano es muy refrescante.", "Comer melancia no verão é muito gostoso."),
    ("Этот арбуз очень сладкий.", "Esta sandía es muy dulce.", "Esta melancia é bem doce."))
add("новый", "nuevo", "novo",
    ("Я купил новый телефон.", "Compré un teléfono nuevo.", "Comprei um celular novo."),
    ("С Новым годом!", "¡Feliz Año Nuevo!", "Feliz Ano Novo!"))
add("надеяться / желание", "esperar / desear", "esperar / desejar",
    ("Надеюсь, завтра будет хорошая погода.", "Espero que mañana haga buen tiempo.", "Espero que amanhã o tempo esteja bom."),
    ("Надеюсь, экзамен пройдёт успешно.", "Espero que te vaya bien en el examen.", "Espero que a prova corra bem."))
add("мыть", "lavar", "lavar",
    ("Перед едой нужно мыть руки.", "Hay que lavarse las manos antes de comer.", "É preciso lavar as mãos antes de comer."),
    ("Он стирает одежду.", "Está lavando la ropa.", "Ele está lavando a roupa."))
add("юань (денежная единица)", "yuan (unidad monetaria)", "yuan (unidade monetária)",
    ("Это яблоко стоит три юаня.", "Esta manzana cuesta tres yuanes.", "Esta maçã custa três yuans."),
    ("Всего пятьдесят юаней.", "En total son cincuenta yuanes.", "No total são cinquenta yuans."))
add("далёкий", "lejos / lejano", "longe / distante",
    ("Мой дом очень далеко от компании.", "Mi casa está muy lejos de la empresa.", "Minha casa fica muito longe da empresa."),
    ("Идти так далеко будет утомительно.", "Caminar tan lejos cansa.", "Andar tão longe cansa."))
add("лекарство", "medicina / medicamento", "remédio / medicamento",
    ("Если заболел, принимай лекарство вовремя.", "Si te enfermas, toma el medicamento a tiempo.", "Se ficar doente, tome o remédio na hora."),
    ("Это лекарство принимают три раза в день.", "Tome este medicamento tres veces al día.", "Tome este remédio três vezes por dia."))
add("хотеть / нужно / собираться", "querer / necesitar / ir a", "querer / precisar / ir",
    ("Я хочу пойти в супермаркет за покупками.", "Quiero ir al supermercado a comprar.", "Quero ir ao supermercado comprar."),
    ("Завтра будет дождь, возьми зонт.", "Mañana va a llover, lleva paraguas.", "Amanhã vai chover, leve o guarda-chuva."))
add("баранина", "cordero / carne de ovino", "carneiro / carne de ovelha",
    ("Сегодня на ужин у нас баранина.", "Hoy cenamos cordero.", "Hoje no jantar vamos comer carneiro."),
    ("Здесь жареная баранина очень вкусная.", "El cordero asado de aquí está riquísimo.", "O carneiro assado daqui está uma delícia."))
add("цвет", "color", "cor",
    ("Какой цвет тебе нравится?", "¿Qué color te gusta?", "Qual cor você gosta?"),
    ("Цвет этой одежды очень красивый.", "El color de esta prenda es muy bonito.", "A cor desta roupa é muito bonita."))
add("вместе", "juntos", "juntos",
    ("Пойдём вместе ужинать.", "Vamos a cenar juntos.", "Vamos jantar juntos."),
    ("Он занимается вместе с другом.", "Estudia junto con un amigo.", "Ele estuda junto com um amigo."))
add("значение / смысл / интересно", "significado / sentido / divertido", "significado / sentido / interessante",
    ("Что значит это слово?", "¿Qué significa esta palabra?", "O que esta palavra significa?"),
    ("Этот фильм очень интересный.", "Esta película es muy interesante.", "Este filme é muito interessante."))
add("немного / разок / на минутку", "un momento / un poco", "um pouco / um instante",
    ("Подождите меня минутку.", "Espéreme un momento, por favor.", "Espere um instante, por favor."),
    ("Можешь взглянуть на это?", "¿Puedes echarle un vistazo?", "Pode dar uma olhada nisso?"))
add("справа / правая сторона", "derecha / lado derecho", "direita / lado direito",
    ("Книжный магазин справа от супермаркета.", "La librería está a la derecha del supermercado.", "A livraria fica à direita do supermercado."),
    ("Идите, пожалуйста, направо.", "Camine hacia la derecha, por favor.", "Ande para a direita, por favor."))
add("плавать", "nadar", "nadar",
    ("Летом я люблю плавать.", "En verano me gusta ir a nadar.", "No verão eu gosto de nadar."),
    ("Он очень хорошо плавает.", "Nada muy bien.", "Ele nada muito bem."))
add("спорт / заниматься спортом", "deporte / hacer ejercicio", "esporte / fazer exercício",
    ("Какой спорт тебе нравится?", "¿Qué deporte te gusta?", "Qual esporte você gosta?"),
    ("Заниматься спортом каждый день полезно для здоровья.", "Hacer ejercicio todos los días es bueno para la salud.", "Fazer exercício todo dia faz bem à saúde."))
add("рыба", "pez / pescado", "peixe",
    ("Кошки любят есть рыбу.", "A los gatos les gusta comer pescado.", "Gatos gostam de comer peixe."),
    ("Сегодня эта рыба очень свежая.", "El pescado de hoy está muy fresco.", "O peixe de hoje está bem fresco."))
add("тоже / также", "también", "também",
    ("Я студент, и он тоже студент.", "Soy estudiante, y él también lo es.", "Eu sou estudante, e ele também é."),
    ("Я тоже хочу поехать в Пекин.", "Yo también quiero viajar a Pekín.", "Eu também quero viajar para Pequim."))
add("пасмурно / облачно", "nublado / cubierto", "nublado / encoberto",
    ("Сегодня пасмурно.", "Hoy está nublado.", "Hoje está nublado."),
    ("Небо заволокло, похоже, будет дождь.", "Se nubló, parece que va a llover.", "O céu nublou, parece que vai chover."))
add("потому что / из-за", "porque / debido a", "porque / por causa de",
    ("Потому что сегодня шёл дождь, я не выходил.", "Como llovió hoy, no salí.", "Como choveu hoje, eu não saí."),
    ("Он не пошёл в школу, потому что заболел.", "No fue a la escuela porque estaba enfermo.", "Ele não foi à escola porque estava doente."))
add("глаз / глаза", "ojo / ojos", "olho / olhos",
    ("У неё большие красивые глаза.", "Tiene los ojos grandes y hermosos.", "Ela tem olhos grandes e bonitos."),
    ("Беречь зрение очень важно.", "Proteger la vista es muy importante.", "Cuidar dos olhos é muito importante."))
add("уже", "ya", "já",
    ("Я уже поел.", "Ya comí.", "Eu já comi."),
    ("Фильм уже начался.", "La película ya empezó.", "O filme já começou."))
add("частица длительного состояния (zhe)", "partícula de acción en curso", "partícula de ação em curso",
    ("Дверь открыта.", "La puerta está abierta.", "A porta está aberta."),
    ("Он говорил со мной улыбаясь.", "Me habló sonriendo.", "Ele falou comigo sorrindo."))
add("муж", "esposo / marido", "marido / esposo",
    ("Её муж — инженер.", "Su esposo es ingeniero.", "O marido dela é engenheiro."),
    ("Мы с мужем планируем поехать в выходные.", "Mi esposo y yo planeamos viajar el fin de semana.", "Eu e meu marido vamos viajar no fim de semana."))
add("как раз / в процессе", "estar + gerundio / ahora mismo", "estar + gerúndio / agora",
    ("Я как раз читаю.", "Estoy leyendo ahora.", "Estou lendo agora."),
    ("Учитель сейчас ведёт урок.", "El profesor está dando clase.", "O professor está dando aula agora."))
add("лист (счётчик плоских предметов)", "clasificador de objetos planos", "classificador de objetos planos",
    ("Дайте мне, пожалуйста, лист бумаги.", "Deme una hoja de papel, por favor.", "Me dê uma folha de papel, por favor."),
    ("Я купил три билета в кино.", "Compré tres entradas de cine.", "Comprei três ingressos de cinema."))
add("действительно / правда", "de verdad / realmente", "de verdade / realmente",
    ("Сегодня правда хорошая погода!", "¡Hoy el tiempo está realmente bueno!", "Hoje o tempo está realmente bom!"),
    ("Это блюдо правда вкусное.", "Este plato está realmente rico.", "Este prato está realmente gostoso."))
add("знать", "saber / conocer", "saber / conhecer",
    ("Ты знаешь, где он?", "¿Sabes dónde está?", "Você sabe onde ele está?"),
    ("Я уже знаю об этом.", "Ya sé de este asunto.", "Eu já sei disso."))
add("искать / находить / давать сдачу", "buscar / encontrar / dar cambio", "procurar / encontrar / dar troco",
    ("Что ты ищешь?", "¿Qué estás buscando?", "O que você está procurando?"),
    ("Я нашёл свои ключи.", "Encontré mis llaves.", "Encontrei as minhas chaves."))
add("готовиться / собираться", "preparar / planear", "preparar / pretender",
    ("Я готовлюсь к завтрашнему экзамену.", "Estoy preparando el examen de mañana.", "Estou me preparando para a prova de amanhã."),
    ("Когда ты собираешься выезжать?", "¿Cuándo planeas salir?", "Quando você pretende partir?"))
add("самый / наиболее", "el más / -ísimo", "o mais / superlativo",
    ("Больше всего я люблю яблоки.", "Lo que más me gusta es comer manzanas.", "O que eu mais gosto é de maçã."),
    ("Он самый высокий в нашем классе.", "Es el estudiante más alto de la clase.", "Ele é o aluno mais alto da nossa turma."))
add("слева / левая сторона", "izquierda / lado izquierdo", "esquerda / lado esquerdo",
    ("Туалет слева.", "El baño está a la izquierda.", "O banheiro fica à esquerda."),
    ("Посмотрите на фото слева.", "Mire la foto de la izquierda, por favor.", "Olhe a foto da esquerda, por favor."))
add("ещё раз / снова", "otra vez / de nuevo", "de novo / outra vez",
    ("Повторите, пожалуйста, ещё раз.", "Dígalo otra vez, por favor.", "Diga de novo, por favor."),
    ("До завтра, увидимся.", "Nos vemos mañana de nuevo.", "Até amanhã, nos vemos."))
add("велосипед", "bicicleta", "bicicleta",
    ("Я езжу в школу на велосипеде.", "Voy a la escuela en bicicleta.", "Vou à escola de bicicleta."),
    ("Этот велосипед новый.", "Esta bicicleta es nueva.", "Esta bicicleta é nova."))
add("утро", "mañana", "manhã",
    ("Доброе утро!", "¡Buenos días!", "Bom dia!"),
    ("Утром я люблю выпить чашку кофе.", "Por la mañana me gusta tomar una taza de café.", "De manhã eu gosto de tomar uma xícara de café."))
add("идти / уходить", "caminar / irse", "andar / ir embora",
    ("Пойдём пешком.", "Vamos caminando.", "Vamos a pé."),
    ("Время вышло, мне пора идти.", "Se acabó el tiempo, me tengo que ir.", "O tempo acabou, preciso ir embora."))
