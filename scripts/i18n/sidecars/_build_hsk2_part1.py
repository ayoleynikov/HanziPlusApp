#!/usr/bin/env python3
"""HSK 2 translations 0–74."""
from __future__ import annotations

ROWS = []


def add(ru, es, pt, *examples):
    ROWS.append((ru, es, pt, examples))


add("модальная частица (давай / ведь / правда?)", "partícula modal (vamos / ¿verdad?)", "partícula modal (vamos / né?)",
    ("Пойдём.", "Vámonos.", "Vamos."),
    ("Ты ведь студент, правда?", "Eres estudiante, ¿verdad?", "Você é estudante, né?"))
add("не / не надо", "no (prohibición)", "não (proibição)",
    ("Не разговаривай, пожалуйста, послушай меня.", "No hables, por favor escúchame.", "Não fale, por favor me escute."),
    ("Не волнуйся, всё в порядке.", "No te preocupes, no pasa nada.", "Não se preocupe, está tudo bem."))
add("газета", "periódico", "jornal",
    ("Папа читает газету.", "Papá está leyendo el periódico.", "O papai está lendo o jornal."),
    ("Я купил газету.", "Compré un periódico.", "Comprei um jornal."))
add("белый", "blanco", "branco",
    ("Она любит носить белую одежду.", "Le gusta usar ropa blanca.", "Ela gosta de usar roupa branca."),
    ("Снег белый.", "La nieve es blanca.", "A neve é branca."))
add("помогать / помощь", "ayudar / ayuda", "ajudar / ajuda",
    ("Спасибо за помощь.", "Gracias por tu ayuda.", "Obrigado pela ajuda."),
    ("Могу я вам помочь?", "¿Puedo ayudarte?", "Posso te ajudar?"))
add("сто / сотня", "cien / ciento", "cem",
    ("Эта книга стоит сто юаней.", "Este libro cuesta cien yuanes.", "Este livro custa cem yuans."),
    ("В нашей школе сто учителей.", "En nuestra escuela hay cien profesores.", "Na nossa escola há cem professores."))
add("чем / по сравнению с", "comparado con / que", "comparado com / do que",
    ("Старший брат выше меня.", "Mi hermano mayor es más alto que yo.", "Meu irmão mais velho é mais alto do que eu."),
    ("Сегодня холоднее, чем вчера.", "Hoy hace más frío que ayer.", "Hoje está mais frio do que ontem."))
add("лодка / корабль", "barco / buque", "barco / navio",
    ("Мы едем в Шанхай на корабле.", "Vamos a Shanghái en barco.", "Vamos a Xangai de barco."),
    ("Этот корабль очень большой.", "Este barco es muy grande.", "Este barco é muito grande."))
add("надевать / носить (одежду)", "ponerse / llevar (ropa)", "vestir / usar (roupa)",
    ("Сегодня холодно, надень побольше одежды.", "Hoy hace frío, ponte más ropa.", "Hoje está frio, vista mais roupa."),
    ("Она в красной одежде.", "Lleva ropa roja.", "Ela está de roupa vermelha."))
add("петь", "cantar", "cantar",
    ("Младшая сестра любит петь.", "A mi hermana menor le gusta cantar.", "Minha irmã mais nova gosta de cantar."),
    ("Мы поём вместе.", "Estamos cantando juntos.", "Estamos cantando juntos."))
add("длинный", "largo", "longo",
    ("Эта дорога очень длинная.", "Este camino es muy largo.", "Esta estrada é muito longa."),
    ("У неё очень длинные волосы.", "Tiene el pelo muy largo.", "Ela tem o cabelo bem longo."))
add("выходить / выходить наружу", "salir / salir afuera", "sair / sair para fora",
    ("Он только что вышел.", "Acaba de salir.", "Ele acabou de sair."),
    ("Учитель вышел.", "El profesor salió.", "O professor saiu."))
add("ошибка / неверный", "error / incorrecto", "erro / errado",
    ("Извини, я ошибся.", "Perdón, me equivoqué.", "Desculpe, eu errei."),
    ("Этот ответ довольно хороший.", "Esta respuesta está bastante bien.", "Essa resposta está bem boa."))
add("раз (счётчик раз)", "vez (clasificador)", "vez (classificador)",
    ("Я был в Пекине один раз.", "He estado en Pekín una vez.", "Já estive em Pequim uma vez."),
    ("Это мой первый раз, когда я ем это блюдо.", "Es la primera vez que como este plato.", "É a primeira vez que como este prato."))
add("из / от / с", "desde / de", "de / desde",
    ("Я из Китая.", "Vengo de China.", "Eu venho da China."),
    ("Отсюда до моего дома очень близко.", "De aquí a mi casa está muy cerca.", "Daqui até a minha casa é bem perto."))
add("частица степени/образа действия (de)", "partícula de grado/modo", "partícula de grau/modo",
    ("Она бегает очень быстро.", "Corre muy rápido.", "Ela corre muito rápido."),
    ("Ты очень хорошо говоришь по-китайски.", "Hablas chino muy bien.", "Você fala chinês muito bem."))
add("верный / по отношению к", "correcto / hacia", "certo / para",
    ("Ты совершенно прав.", "Tienes toda la razón.", "Você tem toda a razão."),
    ("Есть больше фруктов полезно для здоровья.", "Comer más fruta es bueno para la salud.", "Comer mais fruta faz bem à saúde."))
add("все / все вместе", "todos", "todo mundo / todos",
    ("Прошу всех сесть.", "Por favor, siéntense todos.", "Por favor, sentem-se todos."),
    ("Все готовы?", "¿Están listos todos?", "Todo mundo está pronto?"))
add("но / однако", "pero / sin embargo", "mas / porém",
    ("Я хочу пойти, но у меня нет времени.", "Quiero ir, pero no tengo tiempo.", "Quero ir, mas não tenho tempo."),
    ("Это очень хорошо, но слишком дорого.", "Esto está muy bien, pero es demasiado caro.", "Isso é muito bom, mas é caro demais."))
add("прибывать / доходить", "llegar / alcanzar", "chegar / alcançar",
    ("Мы доехали до школы.", "Llegamos a la escuela.", "Chegamos à escola."),
    ("Самолёт прибывает в три часа дня.", "El avión llega a las 3 de la tarde.", "O avião chega às 15h."))
add("первый / номер один", "primero / número uno", "primeiro / número um",
    ("Это первая страница.", "Esta es la primera página.", "Esta é a primeira página."),
    ("Он занял первое место на экзамене.", "Quedó en primer lugar en el examen.", "Ele ficou em primeiro lugar na prova."))
add("младший брат", "hermano menor", "irmão mais novo",
    ("Мой младший брат очень умный.", "Mi hermano menor es muy inteligente.", "Meu irmão mais novo é muito inteligente."),
    ("Младший брат делает домашнее задание.", "Mi hermano menor está haciendo la tarea.", "O irmão mais novo está fazendo a lição."))
add("ждать", "esperar", "esperar",
    ("Подождите, пожалуйста, снаружи.", "Espere afuera un momento, por favor.", "Espere lá fora um pouco, por favor."),
    ("Я жду автобус.", "Estoy esperando el autobús.", "Estou esperando o ônibus."))
add("играть в баскетбол", "jugar al baloncesto", "jogar basquete",
    ("Пойдём играть в баскетбол.", "Vamos a jugar al baloncesto.", "Vamos jogar basquete."),
    ("Он очень хорошо играет в баскетбол.", "Juega muy bien al baloncesto.", "Ele joga basquete muito bem."))
add("понимать", "entender / comprender", "entender / compreender",
    ("Ты понял это предложение?", "¿Entendiste esta frase?", "Você entendeu esta frase?"),
    ("Я не понимаю, что он имеет в виду.", "No entiendo lo que quiere decir.", "Não entendo o que ele quer dizer."))
add("комната", "habitación / cuarto", "quarto",
    ("Моя комната очень большая.", "Mi habitación es muy grande.", "Meu quarto é muito grande."),
    ("Он ушёл в комнату спать.", "Volvió a su habitación a dormir.", "Ele voltou para o quarto dormir."))
add("официант / официантка", "camarero / camarera", "garçom / garçonete",
    ("Официант, можно сделать заказ.", "Camarero, queremos pedir.", "Garçom, queremos pedir."),
    ("Здесь официанты очень приветливые.", "Los camareros de aquí son muy amables.", "Os garçons daqui são muito atenciosos."))
add("очень / чрезвычайно", "muy / extremadamente", "muito / extremamente",
    ("Сегодня погода отличная.", "Hoy el tiempo está excelente.", "Hoje o tempo está excelente."),
    ("Мне очень нравится это блюдо.", "Me gusta muchísimo este plato.", "Gosto muito deste prato."))
add("дорогой", "caro", "caro",
    ("Эта одежда слишком дорогая.", "Esta prenda es demasiado cara.", "Esta roupa é cara demais."),
    ("Есть что-нибудь подешевле?", "¿Hay algo un poco más barato?", "Tem algo um pouco mais barato?"))
add("уже (опыт) / проходить", "partícula de experiencia / pasar", "partícula de experiência / passar",
    ("Ты бывал в Китае?", "¿Has estado en China?", "Você já esteve na China?"),
    ("Через несколько дней я снова приеду.", "Dentro de unos días volveré.", "Daqui a alguns dias eu volto."))
add("говорить / сообщать", "decir / contar", "dizer / contar",
    ("Скажите, пожалуйста, как вас зовут.", "Dígame su nombre, por favor.", "Diga seu nome, por favor."),
    ("Я уже сказал ему.", "Ya se lo dije.", "Eu já disse a ele."))
add("высокий", "alto", "alto",
    ("Та гора очень высокая.", "Esa montaña es muy alta.", "Aquela montanha é muito alta."),
    ("Он немного выше старшего брата.", "Es un poco más alto que su hermano mayor.", "Ele é um pouco mais alto que o irmão mais velho."))
add("старший брат", "hermano mayor", "irmão mais velho",
    ("Мой старший брат учится в университете.", "Mi hermano mayor estudia en la universidad.", "Meu irmão mais velho estuda na universidade."),
    ("Старший брат любит смотреть фильмы.", "A mi hermano mayor le gusta ver películas.", "O irmão mais velho gosta de ver filme."))
add("давать / для", "dar / a", "dar / para",
    ("Дайте мне, пожалуйста, стакан воды.", "Por favor, deme un vaso de agua.", "Por favor, me dê um copo de água."),
    ("Я ему позвоню.", "Le voy a llamar.", "Vou ligar para ele."))
add("автобус", "autobús", "ônibus",
    ("Я езжу на работу на автобусе.", "Voy al trabajo en autobús.", "Vou ao trabalho de ônibus."),
    ("Автобус подъехал.", "Llegó el autobús.", "O ônibus chegou."))
add("компания", "empresa / compañía", "empresa",
    ("Я работаю в компьютерной компании.", "Trabajo en una empresa de informática.", "Trabalho numa empresa de informática."),
    ("Наша компания большая.", "Nuestra empresa es grande.", "Nossa empresa é grande."))
add("приветствовать / добро пожаловать", "dar la bienvenida", "dar as boas-vindas",
    ("Добро пожаловать в Пекин!", "¡Bienvenido a Pekín!", "Bem-vindo a Pequim!"),
    ("Мы вас приветствуем.", "Le damos la bienvenida.", "Damos as boas-vindas a você."))
add("вокзал / железнодорожная станция", "estación de tren", "estação de trem",
    ("Скажите, пожалуйста, где вокзал?", "Perdón, ¿dónde está la estación de tren?", "Com licença, onde fica a estação de trem?"),
    ("Мы едем на вокзал встретить друга.", "Vamos a la estación a recoger a un amigo.", "Vamos à estação buscar um amigo."))
add("ещё / всё ещё / также", "todavía / aún / también", "ainda / também",
    ("Он всё ещё читает.", "Todavía está leyendo.", "Ele ainda está lendo."),
    ("Кроме яблок я ещё хочу купить фрукты.", "Además de manzanas, también quiero comprar fruta.", "Além de maçã, ainda quero comprar fruta."))
add("ребёнок / дети", "niño / hijo", "criança / filho",
    ("Дети играют на улице.", "Los niños están jugando afuera.", "As crianças estão brincando lá fora."),
    ("У неё двое детей.", "Tiene dos hijos.", "Ela tem dois filhos."))
add("красный", "rojo", "vermelho",
    ("Яблоки красные.", "Las manzanas son rojas.", "As maçãs são vermelhas."),
    ("На ней красная юбка.", "Lleva una falda roja.", "Ela está de saia vermelha."))
add("чёрный / тёмный", "negro / oscuro", "preto / escuro",
    ("Уже темнеет, пойдём домой.", "Ya oscurece, vámonos a casa.", "Já está escurecendo, vamos para casa."),
    ("Он купил чёрную кошку.", "Compró un gato negro.", "Ele comprou um gato preto."))
add("штука (счётчик одежды, дел)", "clasificador de prendas y asuntos", "classificador de roupas e assuntos",
    ("Эта одежда очень красивая.", "Esta prenda es muy bonita.", "Esta roupa é muito bonita."),
    ("Мне нужно сказать тебе одну вещь.", "Tengo una cosa que contarte.", "Tenho uma coisa para te contar."))
add("аудитория / класс", "aula / salón de clase", "sala de aula",
    ("Все ученики в классе.", "Los estudiantes están todos en el aula.", "Os alunos estão todos na sala."),
    ("Пожалуйста, соблюдайте тишину в классе.", "Por favor, mantengan el aula en silencio.", "Por favor, mantenham silêncio na sala."))
add("представлять / знакомить", "presentar / introducir", "apresentar / apresentar",
    ("Позвольте представить моего друга.", "Permítame presentarle a mi amigo.", "Deixe-me apresentar meu amigo."),
    ("Учитель рассказал ученикам о новой школе.", "El profesor presentó la nueva escuela a los alumnos.", "O professor apresentou a nova escola aos alunos."))
add("тогда / как раз / сразу", "entonces / justo / ya", "então / logo / justamente",
    ("Как дочитаю, сразу лягу спать.", "En cuanto termine de leer, me duermo.", "Assim que terminar de ler, vou dormir."),
    ("Вот именно мой ответ.", "Esta es precisamente mi respuesta.", "Esta é justamente a minha resposta."))
add("старшая сестра", "hermana mayor", "irmã mais velha",
    ("Моя старшая сестра работает в больнице.", "Mi hermana mayor trabaja en un hospital.", "Minha irmã mais velha trabalha no hospital."),
    ("Старшая сестра очень любит читать.", "A mi hermana mayor le gusta mucho leer.", "A irmã mais velha gosta muito de ler."))
add("считать / чувствовать", "sentir / parecer / pensar", "achar / sentir",
    ("Мне кажется, сегодня немного холодно.", "Siento que hoy hace un poco de frío.", "Acho que hoje está um pouco frio."),
    ("Как тебе этот фильм?", "¿Qué te parece esta película?", "O que você acha deste filme?"))
add("входить", "entrar", "entrar",
    ("Входите, пожалуйста!", "¡Pase, por favor!", "Entre, por favor!"),
    ("Он вошёл внутрь.", "Entró.", "Ele entrou."))
add("близко / недалеко", "cerca / cercano", "perto / próximo",
    ("Мой дом очень близко к школе.", "Mi casa está muy cerca de la escuela.", "Minha casa fica bem perto da escola."),
    ("Как ты в последнее время?", "¿Cómo has estado últimamente?", "Como você tem estado ultimamente?"))
add("аэропорт", "aeropuerto", "aeroporto",
    ("Я еду в аэропорт на такси.", "Voy al aeropuerto en taxi.", "Vou ao aeroporto de táxi."),
    ("Аэропорт очень большой.", "El aeropuerto es muy grande.", "O aeroporto é muito grande."))
add("яйцо", "huevo", "ovo",
    ("Утром я съел яйцо.", "Por la mañana comí un huevo.", "De manhã eu comi um ovo."),
    ("Яйца полезны для здоровья.", "Los huevos son buenos para la salud.", "Ovo faz bem à saúde."))
add("быстрый / скоро", "rápido / pronto", "rápido / já já",
    ("Он бегает очень быстро.", "Corre muy rápido.", "Ele corre muito rápido."),
    ("Сейчас дождь, давайте быстрее.", "Va a llover, vamos rápido.", "Já vai chover, vamos rápido."))
add("счастливый / радостный", "feliz / alegre", "feliz / alegre",
    ("С днём рождения!", "¡Feliz cumpleaños!", "Feliz aniversário!"),
    ("Желаю всем приятных выходных!", "¡Que tengan un fin de semana feliz!", "Bom fim de semana a todos!"))
add("урок / занятие", "clase / lección", "aula / lição",
    ("Сегодня утром у меня два урока.", "Esta mañana tengo dos clases.", "Esta manhã tenho duas aulas."),
    ("Учитель ведёт урок.", "El profesor está dando clase.", "O professor está dando aula."))
add("кофе", "café", "café",
    ("Утром я люблю пить кофе.", "Por la mañana me gusta tomar café.", "De manhã eu gosto de tomar café."),
    ("Дайте мне, пожалуйста, чашку горячего кофе.", "Por favor, deme una taza de café caliente.", "Por favor, me dê uma xícara de café quente."))
add("начинать / начало", "empezar / comenzar", "começar / início",
    ("Мы начинаем урок в восемь.", "Empezamos la clase a las ocho.", "Começamos a aula às oito."),
    ("Во сколько начинается фильм?", "¿A qué hora empieza la película?", "A que horas começa o filme?"))
add("возможно / может быть", "posible / tal vez", "possível / talvez",
    ("Он сегодня, возможно, не придёт.", "Es posible que hoy no venga.", "Talvez ele não venha hoje."),
    ("Завтра может пойти дождь.", "Mañana puede llover.", "Amanhã pode chover."))
add("можно / мочь", "poder / se puede", "poder / pode",
    ("Можно на минутку воспользоваться вашим компьютером?", "¿Puedo usar tu computadora un momento?", "Posso usar seu computador um instante?"),
    ("Можете идти.", "Ya puedes irte.", "Você já pode ir."))
add("экзамен / тест", "examen / prueba", "prova / exame",
    ("Завтра у нас экзамен по китайскому.", "Mañana tenemos un examen de chino.", "Amanhã temos prova de chinês."),
    ("Удачи на экзамене!", "¡Que te vaya bien en el examen!", "Boa sorte na prova!"))
add("два (со счётным словом)", "dos (con clasificador)", "dois (com classificador)",
    ("У меня два старших брата.", "Tengo dos hermanos mayores.", "Tenho dois irmãos mais velhos."),
    ("Дайте мне две книги.", "Deme dos libros.", "Me dê dois livros."))
add("усталый", "cansado", "cansado",
    ("Сегодня я работал весь день, очень устал.", "Hoy trabajé todo el día, estoy muy cansado.", "Hoje trabalhei o dia todo, estou muito cansado."),
    ("Если устал — отдохни.", "Si estás cansado, descansa un poco.", "Se estiver cansado, descanse um pouco."))
add("в (расстоянии от)", "a (distancia de)", "a (distância de)",
    ("Мой дом недалеко от школы.", "Mi casa no está lejos de la escuela.", "Minha casa não fica longe da escola."),
    ("Где ближайший ресторан отсюда?", "¿Dónde está el restaurante más cercano?", "Onde fica o restaurante mais perto daqui?"))
add("ноль", "cero", "zero",
    ("Сейчас 2026 год.", "Este año es 2026.", "Este ano é 2026."),
    ("Номер моей комнаты — 102.", "Mi número de habitación es 102.", "O número do meu quarto é 102."))
add("дорога / путь / маршрут", "camino / calle / ruta", "estrada / caminho / rota",
    ("Эта дорога очень широкая.", "Este camino es muy ancho.", "Esta estrada é bem larga."),
    ("Как по этой дороге доехать до станции?", "¿Cómo llego a la estación por este camino?", "Como chego à estação por este caminho?"))
add("путешествовать / туризм", "viajar / turismo", "viajar / turismo",
    ("Я люблю путешествовать по разным местам.", "Me gusta viajar a distintos lugares.", "Gosto de viajar para lugares diferentes."),
    ("Летом мы планируем поехать в Пекин.", "Planeamos viajar a Pekín en verano.", "Vamos viajar para Pequim no verão."))
add("продавать", "vender", "vender",
    ("В этом магазине продают много фруктов.", "Esta tienda vende mucha fruta.", "Esta loja vende muita fruta."),
    ("Он продал старую машину.", "Vendió su coche viejo.", "Ele vendeu o carro velho."))
add("медленный", "lento", "lento",
    ("Говорите, пожалуйста, помедленнее.", "Hable un poco más despacio, por favor.", "Fale um pouco mais devagar, por favor."),
    ("Он идёт очень медленно.", "Camina muy despacio.", "Ele anda bem devagar."))
add("занятой", "ocupado", "ocupado",
    ("Ты в последнее время занят?", "¿Has estado ocupado últimamente?", "Você tem andado ocupado?"),
    ("Сегодня я очень занят.", "Hoy estoy extremadamente ocupado.", "Hoje estou extremamente ocupado."))
add("младшая сестра", "hermana menor", "irmã mais nova",
    ("Моя младшая сестра очень красивая.", "Mi hermana menor es muy bonita.", "Minha irmã mais nova é muito bonita."),
    ("Она моя младшая сестра.", "Ella es mi hermana menor.", "Ela é minha irmã mais nova."))
add("дверь / ворота", "puerta / portón", "porta / portão",
    ("Закройте, пожалуйста, дверь.", "Cierre la puerta, por favor.", "Feche a porta, por favor."),
    ("Он ждёт тебя у двери.", "Te está esperando en la puerta.", "Ele está te esperando na porta."))
add("молоко", "leche", "leite",
    ("Утром я выпил стакан молока.", "Por la mañana tomé un vaso de leche.", "De manhã tomei um copo de leite."),
    ("Молоко очень полезно.", "La leche es muy buena para el cuerpo.", "Leite faz muito bem ao corpo."))
add("мужчина", "hombre", "homem",
    ("Тот мужчина — мой учитель.", "Ese hombre es mi profesor.", "Aquele homem é o meu professor."),
    ("Он смелый мужчина.", "Es un hombre valiente.", "Ele é um homem corajoso."))
add("женский / женщина", "femenino / mujer", "feminino / mulher",
    ("Та девушка — моя однокурсница.", "Esa estudiante es mi compañera de clase.", "Aquela aluna é minha colega de turma."),
    ("Она хозяйка этой компании.", "Ella es la jefa de esta empresa.", "Ela é a chefe desta empresa."))
add("женщина", "mujer", "mulher",
    ("Та женщина — моя мама.", "Esa mujer es mi mamá.", "Aquela mulher é a minha mãe."),
    ("Две женщины разговаривают.", "Dos mujeres están hablando.", "Duas mulheres estão conversando."))
