#!/usr/bin/env python3
from __future__ import annotations
import json
from pathlib import Path

ROWS = []
def add(ru, es, pt, *examples):
    ROWS.append((ru, es, pt, examples))

# 50-74
add("строгий", "estricto / riguroso", "rígido / rigoroso",
    ("Тренер очень строго нас тренирует.", "El entrenador es extremadamente estricto con nosotros.", "O técnico é extremamente rigoroso no treino."),
    ("Нужно строго соблюдать правила безопасности.", "Debemos cumplir estrictamente las normas de seguridad.", "Precisamos cumprir rigorosamente as normas de segurança."))
add("серьёзный / тяжёлый", "grave / serio", "grave / sério",
    ("У него сильная простуда, нужна госпитализация.", "Su resfriado es grave, necesita hospitalización.", "O resfriado dele está grave; precisa internar."),
    ("Это дело вызвало серьёзные последствия.", "Este asunto provocó consecuencias graves.", "Esse assunto causou consequências graves."))
add("исследование / исследовать", "investigación / investigar", "pesquisa / pesquisar",
    ("Учёные исследуют новые технологии.", "Los científicos investigan nuevas tecnologías.", "Os cientistas estão pesquisando novas tecnologias."),
    ("Этот вопрос стоит глубоко изучить.", "Este tema merece un estudio a fondo.", "Esse tema merece um estudo aprofundado."))
add("солнечный свет", "luz del sol / sol", "luz do sol / sol",
    ("Тёплое утреннее солнце вошло в комнату.", "La cálida luz de la mañana entró en la habitación.", "A luz quente da manhã entrou no quarto."),
    ("Больше бывать на солнце полезно для здоровья.", "Tomar más sol es muy bueno para la salud.", "Pegar mais sol faz bem à saúde."))
add("приглашать / приглашение", "invitar / invitación", "convidar / convite",
    ("Хочу пригласить вас на день рождения.", "Quiero invitarte a mi fiesta de cumpleaños.", "Quero convidar você para a minha festa de aniversário."),
    ("Большое спасибо за тёплое приглашение.", "Muchas gracias por su cálida invitación.", "Muito obrigado pelo convite caloroso."))
add("ключ", "llave", "chave",
    ("Не забудьте ключи от дома.", "Recuerde llevar las llaves de casa.", "Lembre-se de levar as chaves de casa."),
    ("Не могу найти ключ от машины.", "No encuentro la llave del coche.", "Não acho a chave do carro."))
add("страница", "página", "página",
    ("Откройте, пожалуйста, десятую страницу.", "Abran la página diez del libro.", "Abram a página dez do livro."),
    ("В этой статье всего три страницы.", "Este artículo tiene tres páginas en total.", "Este artigo tem três páginas no total."))
add("возможно / может быть", "quizá / tal vez", "talvez / quem sabe",
    ("Он сегодня не пришёл, возможно, заболел.", "Hoy no vino; quizá se enfermó.", "Ele não veio hoje; talvez esteja doente."),
    ("Продолжайте, завтра, возможно, получится.", "Sigue adelante; tal vez mañana lo logres.", "Continue; talvez amanhã você consiga."))
add("мнение / предложение", "opinión / sugerencia", "opinião / sugestão",
    ("Какие у всех мнения по этому плану?", "¿Qué opiniones tienen sobre este plan?", "Que opiniões vocês têm sobre este plano?"),
    ("Важно смиренно слушать чужие мнения.", "Escuchar con humildad las opiniones ajenas es importante.", "Ouvir com humildade as opiniões dos outros é importante."))
add("искусство", "arte", "arte",
    ("Живопись — великое искусство.", "La pintura es un gran arte.", "A pintura é uma grande arte."),
    ("Его очень интересует современное искусство.", "Le interesa mucho el arte moderno.", "Ele se interessa muito por arte moderna."))
add("приятный / радостный", "agradable / feliz", "agradável / feliz",
    ("Желаю приятных выходных!", "¡Que tengas un fin de semana agradable!", "Tenha um fim de semana agradável!"),
    ("Мы очень приятно поболтали.", "Conversamos de forma muy agradable.", "Conversamos de um jeito muito agradável."))
add("круглый / круг", "redondo / círculo", "redondo / círculo",
    ("На Праздник середины осени луна большая и круглая.", "En el Festival del Medio Otoño la luna es grande y redonda.", "No Festival da Lua a lua fica grande e redonda."),
    ("Все сели в круг.", "Todos se sentaron en círculo.", "Todos se sentaram em círculo."))
add("журнал", "revista", "revista",
    ("На столе свежий модный журнал.", "Hay una revista de moda reciente sobre la mesa.", "Há uma revista de moda recente sobre a mesa."),
    ("В свободное время он любит читать журналы.", "Le gusta leer revistas en su tiempo libre.", "No tempo livre ele gosta de ler revistas."))
add("набор персонала / нанимать", "contratación / contratar", "contratação / contratar",
    ("Наша компания набирает новых сотрудников.", "Nuestra empresa está contratando personal nuevo.", "Nossa empresa está contratando novos funcionários."),
    ("Следите за объявлениями о вакансиях на сайте.", "Preste atención a la información de empleo en la web.", "Acompanhe as vagas no site."))
add("приводить в порядок / организовывать", "ordenar / organizar", "organizar / arrumar",
    ("Пожалуйста, разберите книги в комнате.", "Ordene los libros de la habitación.", "Organize os livros do quarto."),
    ("Он готовит материалы к собранию.", "Está organizando los materiales de la reunión.", "Ele está organizando os materiais da reunião."))
add("нормальный / обычный", "normal / regular", "normal / regular",
    ("После проверки все показатели в норме.", "Tras la revisión, todos los indicadores son normales.", "Após o exame, todos os indicadores estão normais."),
    ("Встречать трудности — это нормально.", "Encontrar dificultades es un fenómeno normal.", "Enfrentar dificuldades é um fenômeno normal."))
add("официальный / формальный", "formal / oficial", "formal / oficial",
    ("На собеседование наденьте официальную одежду.", "Póngase ropa formal para la entrevista.", "Use roupa formal na entrevista."),
    ("Стороны официально подписали контракт.", "Ambas partes firmaron el contrato oficialmente.", "As partes assinaram o contrato oficialmente."))
add("знания", "conocimiento", "conhecimento",
    ("Чтение расширяет знания.", "Leer amplía el conocimiento.", "A leitura amplia o conhecimento."),
    ("Нужно постоянно учиться новому.", "Debemos aprender conocimientos nuevos sin parar.", "Precisamos aprender conhecimentos novos o tempo todo."))
add("поздравлять", "felicitar", "parabenizar",
    ("Поздравляем с успешным выпуском!", "¡Felicitaciones por graduarte sin problemas!", "Parabéns pela formatura!"),
    ("Мы собрались, чтобы поздравить его с успехом.", "Nos reunimos para felicitar su éxito.", "Nos reunimos para parabenizar o sucesso dele."))
add("известный", "famoso / conocido", "famoso / conhecido",
    ("Он известный художник.", "Es un artista famoso.", "Ele é um artista famoso."),
    ("Запретный город — известная достопримечательность Пекина.", "El Palacio Imperial es un atractivo famoso de Pekín.", "A Cidade Proibida é um ponto turístico famoso de Pequim."))
add("специально / специально предназначенный", "especialmente / especializado", "especialmente / especializado",
    ("Я специально пришёл вас увидеть.", "Vine especialmente a verte.", "Vim especialmente para te ver."),
    ("Это магазин, который специализируется на книгах.", "Esta es una tienda especializada en libros.", "Esta é uma loja especializada em livros."))
add("специальность / профессиональный", "carrera / profesional", "curso / profissional",
    ("Какую специальность вы изучаете в университете?", "¿Qué carrera estudias en la universidad?", "Qual curso você faz na universidade?"),
    ("Его ответ был очень профессиональным.", "Su respuesta fue extremadamente profesional.", "A resposta dele foi extremamente profissional."))
add("природа / естественный", "naturaleza / natural", "natureza / natural",
    ("Нужно уважать природу и жить с ней в гармонии.", "Debemos respetar la naturaleza y convivir en armonía.", "Precisamos respeitar a natureza e conviver em harmonia."),
    ("Улыбка — самый естественный язык.", "Una sonrisa es el lenguaje más natural.", "O sorriso é a linguagem mais natural."))
add("итог / подводить итоги", "resumen / resumir", "resumo / resumir",
    ("На собрании менеджер подвёл итоги работы.", "En la reunión el gerente hizo un resumen del trabajo.", "Na reunião o gerente fez um resumo do trabalho."),
    ("Стоит уметь обобщать опыт и уроки.", "Debemos saber resumir experiencias y lecciones.", "É preciso saber resumir experiências e lições."))
add("уважать", "respetar", "respeitar",
    ("Каждый должен уважать чужой выбор.", "Todos deben respetar las decisiones ajenas.", "Todos devem respeitar as escolhas dos outros."),
    ("Нужно уважать мнение старших.", "Debemos respetar las opiniones de los mayores.", "Devemos respeitar as opiniões dos mais velhos."))

# 75-99 beginner block
add("место / сиденье", "asiento", "assento",
    ("Найдите своё место и садитесь.", "Busque su asiento y siéntese.", "Encontre o seu assento e sente-se."),
    ("Это место занято?", "¿Está ocupado este asiento?", "Este assento está ocupado?"))
add("дочь", "hija", "filha",
    ("У меня есть дочь.", "Tengo una hija.", "Eu tenho uma filha."),
    ("Её дочь очень милая.", "Su hija es muy linda.", "A filha dela é muito fofa."))
add("друг", "amigo", "amigo",
    ("Он мой хороший друг.", "Es mi buen amigo.", "Ele é meu bom amigo."),
    ("У меня много друзей.", "Tengo muchos amigos.", "Tenho muitos amigos."))
add("красивый", "bonito / hermoso", "bonito / lindo",
    ("Эта одежда очень красивая.", "Esta prenda es muy bonita.", "Esta roupa é muito bonita."),
    ("Она очень красивая.", "Se ve muy bonita.", "Ela é muito bonita."))
add("яблоко", "manzana", "maçã",
    ("Хочу съесть яблоко.", "Quiero comer una manzana.", "Quero comer uma maçã."),
    ("Это яблоко очень большое.", "Esta manzana es muy grande.", "Esta maçã é muito grande."))
add("семь", "siete", "sete",
    ("Сейчас семь часов.", "Son las siete.", "São sete horas."),
    ("Нас семеро идём.", "Vamos los siete.", "Nós sete vamos."))
add("деньги", "dinero", "dinheiro",
    ("Сколько это стоит?", "¿Cuánto cuesta esto?", "Quanto custa isto?"),
    ("У меня нет денег.", "No tengo dinero.", "Não tenho dinheiro."))
add("впереди / перед", "delante / frente", "na frente / adiante",
    ("Он передо мной.", "Está delante de mí.", "Ele está na minha frente."),
    ("Впереди есть магазин.", "Hay una tienda más adelante.", "Tem uma loja mais à frente."))
add("пожалуйста / приглашать", "por favor / invitar", "por favor / convidar",
    ("Садитесь, пожалуйста.", "Siéntese, por favor.", "Sente-se, por favor."),
    ("Пожалуйста, выпейте воды.", "Beba agua, por favor.", "Beba água, por favor."))
add("идти", "ir", "ir",
    ("Мы идём в школу.", "Vamos a la escuela.", "Estamos indo para a escola."),
    ("Куда вы идёте?", "¿Adónde vas?", "Aonde você vai?"))
add("горячий", "caliente / calor", "quente",
    ("Сегодня очень жарко.", "Hoy hace mucho calor.", "Hoje está muito quente."),
    ("Вода слишком горячая.", "El agua está demasiado caliente.", "A água está quente demais."))
add("человек / люди", "persona / gente", "pessoa / gente",
    ("Он китаец.", "Es chino.", "Ele é chinês."),
    ("Здесь много людей.", "Hay mucha gente aquí.", "Tem muita gente aqui."))
add("знать / быть знакомым", "conocer / reconocer", "conhecer / reconhecer",
    ("Приятно познакомиться.", "Encantado de conocerle.", "Prazer em conhecer você."),
    ("Вы знаете этого человека?", "¿Conoce a esta persona?", "Você conhece esta pessoa?"))
add("три", "tres", "três",
    ("В моей семье трое.", "Somos tres en mi familia.", "Somos três na minha família."),
    ("Сейчас три часа.", "Son las tres.", "São três horas."))
add("магазин", "tienda", "loja",
    ("Я иду в магазин за покупками.", "Voy a la tienda a comprar cosas.", "Vou à loja comprar coisas."),
    ("Магазин впереди.", "La tienda está más adelante.", "A loja fica mais à frente."))
add("на / сверху / подниматься", "sobre / arriba / subir", "em cima / acima / subir",
    ("Книга на столе.", "El libro está sobre la mesa.", "O livro está sobre a mesa."),
    ("Давайте сядем в машину.", "Subamos al coche.", "Vamos entrar no carro."))
add("утро (до полудня)", "mañana", "manhã",
    ("Утром у меня занятия.", "Tengo clase por la mañana.", "De manhã eu tenho aula."),
    ("Сегодня утром была хорошая погода.", "Esta mañana el tiempo estuvo muy bueno.", "Nesta manhã o tempo estava ótimo."))
add("мало / немного", "poco / faltar", "pouco / faltar",
    ("Здесь очень мало людей.", "Hay muy poca gente aquí.", "Tem pouquíssima gente aqui."),
    ("Положите меньше соли.", "Ponga menos sal, por favor.", "Coloque menos sal, por favor."))
add("кто", "quién", "quem",
    ("Кто он?", "¿Quién es él?", "Quem é ele?"),
    ("Кто в комнате?", "¿Quién está en la habitación?", "Quem está no quarto?"))
add("что", "qué", "o que / que",
    ("Что это?", "¿Qué es esto?", "O que é isto?"),
    ("Что вы делаете?", "¿Qué estás haciendo?", "O que você está fazendo?"))
add("десять", "diez", "dez",
    ("У меня десять книг.", "Tengo diez libros.", "Eu tenho dez livros."),
    ("Сейчас десять часов.", "Son las diez.", "São dez horas."))
add("время / момент", "momento / cuando", "hora / momento",
    ("Когда вы придёте?", "¿Cuándo vienes?", "Quando você vem?"),
    ("В детстве я любил кошек.", "De pequeño me gustaban los gatos.", "Quando eu era criança, gostava de gatos."))
add("быть / являться", "ser / estar", "ser / estar",
    ("Я студент.", "Soy estudiante.", "Eu sou estudante."),
    ("Он мой учитель.", "Es mi profesor.", "Ele é meu professor."))

assert len(ROWS) == 48, len(ROWS)
Path("/tmp/hsk1_part2.json").write_text(json.dumps(ROWS, ensure_ascii=False), encoding="utf-8")
print("part2", len(ROWS))
