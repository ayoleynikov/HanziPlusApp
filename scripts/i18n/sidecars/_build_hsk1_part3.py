#!/usr/bin/env python3
from __future__ import annotations
import json
from pathlib import Path

ROWS = []
def add(ru, es, pt, *examples):
    ROWS.append((ru, es, pt, examples))

add("книга", "libro", "livro",
    ("Я читаю книгу.", "Estoy leyendo un libro.", "Estou lendo um livro."),
    ("Эта книга отличная.", "Este libro es genial.", "Este livro é ótimo."))
add("вода", "agua", "água",
    ("Хочу воды.", "Quiero beber agua.", "Quero beber água."),
    ("В стакане нет воды.", "No hay agua en el vaso.", "Não tem água no copo."))
add("фрукты", "fruta", "fruta",
    ("Я очень люблю фрукты.", "Me gusta mucho comer fruta.", "Gosto muito de comer fruta."),
    ("На столе фрукты.", "Hay fruta sobre la mesa.", "Tem fruta sobre a mesa."))
add("спать", "dormir", "dormir",
    ("Я сейчас иду спать.", "Me voy a dormir ahora.", "Vou dormir agora."),
    ("Он спит.", "Está durmiendo.", "Ele está dormindo."))
add("говорить / разговаривать", "hablar", "falar / conversar",
    ("Пожалуйста, не разговаривайте.", "Por favor, no hablen.", "Por favor, não conversem."),
    ("Они разговаривают.", "Están hablando.", "Eles estão conversando."))
add("четыре", "cuatro", "quatro",
    ("У меня четыре яблока.", "Tengo cuatro manzanas.", "Eu tenho quatro maçãs."),
    ("Сейчас четыре часа.", "Son las cuatro.", "São quatro horas."))
add("лет (возраст)", "años (edad)", "anos (idade)",
    ("Мне в этом году двадцать лет.", "Tengo veinte años este año.", "Tenho vinte anos este ano."),
    ("Его ребёнку пять лет.", "Su hijo tiene cinco años.", "O filho dele tem cinco anos."))
add("он", "él", "ele",
    ("Он мой друг.", "Él es mi amigo.", "Ele é meu amigo."),
    ("Он дома читает.", "Está en casa leyendo.", "Ele está em casa lendo."))
add("она", "ella", "ela",
    ("Она моя учительница.", "Ella es mi profesora.", "Ela é minha professora."),
    ("Она очень красивая.", "Es muy bonita.", "Ela é muito bonita."))
add("слишком / чересчур", "demasiado / muy", "demais / muito",
    ("Это слишком дорого.", "Esto es demasiado caro.", "Isto é caro demais."),
    ("Отлично!", "¡Qué bien!", "Que ótimo!"))
add("погода", "tiempo / clima", "tempo / clima",
    ("Сегодня отличная погода.", "Hoy hace muy buen tiempo.", "Hoje o tempo está ótimo."),
    ("Какая завтра погода?", "¿Qué tiempo hará mañana?", "Como está o tempo amanhã?"))
add("слушать / слышать", "escuchar / oír", "ouvir / escutar",
    ("Я люблю слушать музыку.", "Me gusta escuchar música.", "Gosto de ouvir música."),
    ("Пожалуйста, послушайте меня.", "Escúcheme, por favor.", "Por favor, me escute."))
add("одноклассник / однокурсник", "compañero de clase", "colega de classe",
    ("Он мой одноклассник.", "Es mi compañero de clase.", "Ele é meu colega de classe."),
    ("Здравствуйте, однокурсники!", "¡Hola, compañeros!", "Olá, colegas!"))
add("аллё (по телефону) / эй", "¿aló? / oye", "alô / oi",
    ("Аллё, кого вы ищете?", "¿Aló, a quién busca?", "Alô, com quem você quer falar?"),
    ("Эй, ты где?", "Oye, ¿dónde estás?", "Oi, onde você está?"))
add("я", "yo", "eu",
    ("Я студент.", "Soy estudiante.", "Eu sou estudante."),
    ("Дайте мне, пожалуйста, стакан воды.", "Por favor, deme un vaso de agua.", "Por favor, me dê um copo d’água."))
add("мы", "nosotros", "nós",
    ("Мы все студенты.", "Todos somos estudiantes.", "Nós todos somos estudantes."),
    ("Пойдём вместе.", "Vamos juntos.", "Vamos juntos."))
add("пять", "cinco", "cinco",
    ("У меня пять яблок.", "Tengo cinco manzanas.", "Eu tenho cinco maçãs."),
    ("Сейчас пять часов.", "Son las cinco.", "São cinco horas."))
add("нравиться", "gustar", "gostar",
    ("Я люблю чай.", "Me gusta beber té.", "Gosto de beber chá."),
    ("Ей нравится учить китайский.", "A ella le gusta aprender chino.", "Ela gosta de aprender chinês."))
add("под / вниз / следующий / спускаться", "debajo / abajo / siguiente / bajar", "embaixo / abaixo / próximo / descer",
    ("Кот под столом.", "El gato está debajo de la mesa.", "O gato está embaixo da mesa."),
    ("Увидимся на следующей неделе.", "Nos vemos la semana que viene.", "Até a semana que vem."))
add("после полудня", "tarde", "tarde",
    ("Днём я иду в магазин.", "Por la tarde voy a la tienda.", "À tarde vou à loja."),
    ("Сегодня днём дождя не будет.", "Esta tarde no lloverá.", "Nesta tarde não vai chover."))
add("идти дождь", "llover", "chover",
    ("На улице идёт дождь.", "Está lloviendo fuera.", "Está chovendo lá fora."),
    ("Завтра будет дождь?", "¿Lloverá mañana?", "Vai chover amanhã?"))
add("господин / муж", "señor / esposo", "senhor / marido",
    ("Здравствуйте, господин Ван!", "¡Hola, señor Wang!", "Olá, senhor Wang!"),
    ("Это господин Ли.", "Este es el señor Li.", "Este é o senhor Li."))
add("сейчас", "ahora", "agora",
    ("Который сейчас час?", "¿Qué hora es ahora?", "Que horas são agora?"),
    ("Я сейчас иду домой.", "Ahora me voy a casa.", "Agora estou indo para casa."))
add("хотеть / думать / скучать", "querer / pensar / echar de menos", "querer / pensar / sentir falta",
    ("Хочу воды.", "Quiero beber agua.", "Quero beber água."),
    ("О чём вы думаете?", "¿En qué estás pensando?", "No que você está pensando?"))
add("маленький", "pequeño", "pequeno",
    ("Это яблоко очень маленькое.", "Esta manzana es muy pequeña.", "Esta maçã é bem pequena."),
    ("Это маленький котёнок.", "Este es un gatito pequeño.", "Este é um gatinho pequeno."))
add("девушка / барышня", "señorita", "senhorita",
    ("Госпожа Чжан работает.", "La señorita Zhang está trabajando.", "A senhorita Zhang está trabalhando."),
    ("Что бы вы хотели, мисс?", "¿Qué desea, señorita?", "O que a senhorita deseja?"))
add("некоторые / несколько", "algunos / unos", "alguns / uns",
    ("Эти книги мои.", "Estos libros son míos.", "Estes livros são meus."),
    ("Я купил немного фруктов.", "Compré algo de fruta.", "Comprei umas frutas."))
add("писать", "escribir", "escrever",
    ("Он пишет иероглифы.", "Está escribiendo caracteres.", "Ele está escrevendo caracteres."),
    ("Пожалуйста, напишите своё имя.", "Escriba su nombre, por favor.", "Por favor, escreva o seu nome."))
add("спасибо", "gracias", "obrigado",
    ("Спасибо за помощь.", "Gracias por su ayuda.", "Obrigado pela ajuda."),
    ("Спасибо, до свидания.", "Gracias, adiós.", "Obrigado, tchau."))
add("неделя", "semana", "semana",
    ("Какой сегодня день недели?", "¿Qué día de la semana es hoy?", "Que dia da semana é hoje?"),
    ("На следующей неделе я еду в Пекин.", "La semana que viene voy a Pekín.", "Na semana que vem vou a Pequim."))
add("студент / ученик", "estudiante", "estudante",
    ("Я студент.", "Soy estudiante.", "Eu sou estudante."),
    ("В школе много учеников.", "Hay muchos estudiantes en la escuela.", "Há muitos alunos na escola."))
add("учиться / изучать", "estudiar / aprender", "estudar / aprender",
    ("Я изучаю китайский.", "Estoy estudiando chino.", "Estou estudando chinês."),
    ("Ей очень нравится учиться.", "Le gusta mucho estudiar.", "Ela gosta muito de estudar."))
add("школа", "escuela / colegio", "escola",
    ("Наша школа очень большая.", "Nuestra escuela es muy grande.", "Nossa escola é muito grande."),
    ("Он работает в школе.", "Trabaja en una escuela.", "Ele trabalha numa escola."))
add("один", "uno / un", "um",
    ("У меня одна книга.", "Tengo un libro.", "Eu tenho um livro."),
    ("Дайте мне стакан воды.", "Por favor, deme un vaso de agua.", "Por favor, me dê um copo d’água."))
add("одежда", "ropa", "roupa",
    ("Эта одежда очень красивая.", "Esta ropa es muy bonita.", "Esta roupa é muito bonita."),
    ("Я иду покупать одежду.", "Voy a comprar ropa.", "Vou comprar roupa."))
add("врач", "médico", "médico",
    ("Мой папа — врач.", "Mi papá es médico.", "Meu pai é médico."),
    ("Он на приёме в больнице.", "Está viendo al médico en el hospital.", "Ele está no médico no hospital."))
add("больница", "hospital", "hospital",
    ("Эта больница очень большая.", "Este hospital es muy grande.", "Este hospital é muito grande."),
    ("Он работает в больнице.", "Trabaja en un hospital.", "Ele trabalha num hospital."))
add("стул", "silla", "cadeira",
    ("Садитесь на стул, пожалуйста.", "Siéntese en la silla, por favor.", "Sente-se na cadeira, por favor."),
    ("В комнате есть стул.", "Hay una silla en la habitación.", "Tem uma cadeira no quarto."))
add("иметь / есть (имеется)", "tener / haber", "ter / haver",
    ("У меня есть кот.", "Tengo un gato.", "Eu tenho um gato."),
    ("На столе книги.", "Hay libros sobre la mesa.", "Tem livros sobre a mesa."))
add("месяц / луна", "mes / luna", "mês / lua",
    ("Какой сейчас месяц?", "¿En qué mes estamos?", "Que mês é agora?"),
    ("В январе я еду в Китай.", "En enero voy a China.", "Em janeiro vou à China."))
add("до свидания", "adiós / hasta luego", "tchau / até logo",
    ("До свидания, до завтра!", "¡Adiós, hasta mañana!", "Tchau, até amanhã!"),
    ("До свидания, учитель.", "Adiós, profesor.", "Tchau, professor."))
add("в / на / находиться", "en / estar en", "em / estar em",
    ("Часы на столе.", "El reloj está sobre la mesa.", "O relógio está sobre a mesa."),
    ("Я дома смотрю телевизор.", "Estoy en casa viendo la tele.", "Estou em casa assistindo TV."))
add("как / почему", "cómo / por qué", "como / por quê",
    ("Как читается этот иероглиф?", "¿Cómo se lee este carácter?", "Como se lê este caractere?"),
    ("Что с вами?", "¿Qué te pasa?", "O que houve com você?"))
add("как / каково", "qué tal / cómo está", "que tal / como está",
    ("Какая сегодня погода?", "¿Qué tal el tiempo hoy?", "Como está o tempo hoje?"),
    ("Как это блюдо?", "¿Qué tal está este plato?", "Que tal este prato?"))
add("это / этот", "este / esto", "este / isto",
    ("Это моя книга.", "Este es mi libro.", "Este é o meu livro."),
    ("Этот человек — мой учитель.", "Esta persona es mi profesor.", "Esta pessoa é o meu professor."))
add("Китай", "China", "China",
    ("Я люблю Китай.", "Amo China.", "Eu amo a China."),
    ("Он едет в Китай учить китайский.", "Va a China a estudiar chino.", "Ele vai à China estudar chinês."))
add("полдень", "mediodía", "meio-dia",
    ("В полдень мы едим рис.", "Al mediodía comemos arroz.", "Ao meio-dia comemos arroz."),
    ("Сейчас полдень, двенадцать часов.", "Son las doce del mediodía.", "Agora é meio-dia, meio-dia em ponto."))
add("жить / проживать", "vivir / alojarse", "morar / ficar",
    ("Я живу в Пекине.", "Vivo en Pekín.", "Moro em Pequim."),
    ("Где вы живёте?", "¿Dónde vives?", "Onde você mora?"))
add("стол", "mesa / escritorio", "mesa / escrivaninha",
    ("Книга на столе.", "El libro está sobre la mesa.", "O livro está sobre a mesa."),
    ("Этот стол очень большой.", "Esta mesa es muy grande.", "Esta mesa é muito grande."))
add("иероглиф / слово", "carácter / palabra", "caractere / palavra",
    ("Как пишется этот иероглиф?", "¿Cómo se escribe este carácter?", "Como se escreve este caractere?"),
    ("Он знает много китайских иероглифов.", "Conoce muchos caracteres chinos.", "Ele conhece muitos caracteres chineses."))
add("вчера", "ayer", "ontem",
    ("Вчера я ходил в магазин.", "Ayer fui a la tienda.", "Ontem eu fui à loja."),
    ("Вчера была хорошая погода.", "Ayer hizo muy buen tiempo.", "Ontem o tempo estava ótimo."))
add("сидеть / ехать (на транспорте)", "sentarse / tomar (transporte)", "sentar / pegar (transporte)",
    ("Садитесь, пожалуйста.", "Siéntese, por favor.", "Sente-se, por favor."),
    ("Я еду в школу на такси.", "Voy a la escuela en taxi.", "Vou de táxi para a escola."))
add("делать / готовить", "hacer / preparar", "fazer / preparar",
    ("Что вы делаете?", "¿Qué estás haciendo?", "O que você está fazendo?"),
    ("Мама готовит еду.", "Mamá está cocinando.", "A mamãe está cozinhando."))

assert len(ROWS) == 53, len(ROWS)
Path("/tmp/hsk1_part3.json").write_text(json.dumps(ROWS, ensure_ascii=False), encoding="utf-8")
print("part3", len(ROWS))
