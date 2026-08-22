#!/usr/bin/env python3
"""HSK 3 translations 200–299."""
from __future__ import annotations

ROWS = []


def add(ru, es, pt, *examples):
    ROWS.append((ru, es, pt, examples))


add("худой / узкий (об одежде)", "delgado / estrecho", "magro / justo (roupa)",
    ("В последнее время он сильно похудел.", "Últimamente adelgazó mucho.", "Ultimamente ele emagreceu muito."),
    ("Эти брюки мне слишком узкие.", "Estos pantalones me quedan demasiado estrechos.", "Esta calça está justa demais em mim."))
add("дерево", "árbol", "árvore",
    ("В парке много больших деревьев.", "Hay muchos árboles grandes en el parque.", "Há muitas árvores grandes no parque."),
    ("Птицы сидят на ветках.", "Los pájaros están posados en las ramas.", "Os pássaros estão nos galhos."))
add("чистить щёткой / красить", "cepillar / pintar", "escovar / pintar",
    ("Я чищу зубы.", "Me estoy cepillando los dientes.", "Estou escovando os dentes."),
    ("Покрасьте, пожалуйста, дверь.", "Pinte la puerta, por favor.", "Pinte a porta, por favor."))
add("пара (счётчик парных предметов)", "par (clasificador)", "par (classificador)",
    ("Я купил новую пару обуви.", "Compré un par de zapatos nuevos.", "Comprei um par de sapatos novos."),
    ("Дайте мне пару перчаток.", "Deme un par de guantes.", "Me dê um par de luvas."))
add("удобный / хорошо себя чувствовать", "cómodo / encontrarse bien", "confortável / se sentir bem",
    ("Лежать в кровати очень удобно.", "Estar en la cama es muy cómodo.", "Ficar na cama é muito confortável."),
    ("Сегодня я не очень хорошо себя чувствую.", "Hoy no me siento muy bien.", "Hoje não estou me sentindo muito bem."))
add("уровень", "nivel / estándar", "nível / padrão",
    ("У него высокий уровень китайского.", "Su nivel de chino es muy alto.", "O nível de chinês dele é muito alto."),
    ("Благодаря усилиям мой уровень заметно вырос.", "Con esfuerzo, mi nivel mejoró claramente.", "Com esforço, meu nível melhorou claramente."))
add("дядя (младший брат отца)", "tío", "tio",
    ("Дядя подарил мне новую игрушку.", "El tío me regaló un peluche nuevo.", "O tio me deu um bicho de pelúcia novo."),
    ("Этот дядя очень приветливый.", "Este tío es muy amable.", "Este tio é muito gentil."))
add("математика", "matemáticas", "matemática",
    ("У него хорошие оценки по математике.", "Saca muy buenas notas en matemáticas.", "As notas dele em matemática são ótimas."),
    ("Завтра у нас экзамен по математике.", "Mañana tenemos examen de matemáticas.", "Amanhã temos prova de matemática."))
add("водитель", "conductor / chofer", "motorista",
    ("Водитель такси хорошо знает маршруты.", "El taxista conoce muy bien las rutas.", "O motorista de táxi conhece bem as rotas."),
    ("Спасибо, водитель.", "Gracias, conductor.", "Obrigado, motorista."))
add("хотя / несмотря на", "aunque", "embora / apesar de",
    ("Хотя устал, но очень рад.", "Aunque estoy cansado, estoy muy feliz.", "Embora esteja cansado, estou muito feliz."),
    ("Хотя шёл дождь, мы всё равно пошли.", "Aunque llovió, igualmente fuimos.", "Embora tenha chovido, mesmo assim fomos."))
add("солнце", "sol", "sol",
    ("Сегодня отличное солнце, можно сушить одежду.", "Hoy hay mucho sol, es bueno para secar la ropa.", "Hoje tem bastante sol, dá para secar roupa."),
    ("Солнце встаёт на востоке.", "El sol sale por el este.", "O sol nasce no leste."))
add("сахар / конфета", "azúcar / caramelo", "açúcar / doce",
    ("Хочешь конфету?", "¿Quieres un caramelo?", "Quer um doce?"),
    ("В этот кофе сахар не кладите.", "No le ponga azúcar a este café.", "Não coloque açúcar neste café."))
add("особенно / особенный", "especialmente / especial", "especialmente / especial",
    ("Сегодня особенно холодно, одевайся теплее.", "Hoy hace especialmente frío, abrígate más.", "Hoje está especialmente frio, vista mais roupa."),
    ("Это очень особенный подарок.", "Este es un regalo muy especial.", "Este é um presente muito especial."))
add("болеть / боль", "doler / dolor", "doer / dor",
    ("У меня немного болит живот.", "Me duele un poco el estómago.", "Meu estômago está doendo um pouco."),
    ("Сильно болит голова, нужно отдохнуть.", "Me duele mucho la cabeza, necesito descansar.", "A cabeça está doendo muito, preciso descansar."))
add("сладкий", "dulce", "doce",
    ("Этот арбуз очень сладкий.", "Esta sandía es extremadamente dulce.", "Esta melancia está extremamente doce."),
    ("Ешьте меньше слишком сладкого.", "Coma menos comida demasiado dulce.", "Coma menos comida doce demais."))
add("штука (счётчик длинных предметов)", "clasificador de objetos alargados", "classificador de objetos longos",
    ("Перед домом протекает маленькая речка.", "Hay un riachuelo delante de mi casa.", "Tem um riacho na frente da minha casa."),
    ("Она купила красную юбку.", "Compró una falda roja.", "Ela comprou uma saia vermelha."))
add("повышать / улучшать", "mejorar / elevar", "melhorar / elevar",
    ("Я хочу улучшить аудирование по китайскому.", "Quiero mejorar mi comprensión auditiva del chino.", "Quero melhorar minha compreensão oral do chinês."),
    ("Производительность компании выросла.", "La eficiencia de la empresa mejoró.", "A eficiência da empresa melhorou."))
add("спорт / физкультура", "deporte / educación física", "esporte / educação física",
    ("Я люблю играть в бадминтон в спортзале.", "Me gusta jugar al bádminton en el polideportivo.", "Gosto de jogar badminton na quadra."),
    ("Днём у нас урок физкультуры.", "Por la tarde tenemos clase de educación física.", "À tarde temos aula de educação física."))
add("коллега", "compañero de trabajo", "colega de trabalho",
    ("Мы с коллегами вместе обедаем.", "Almuerzo con mis compañeros de trabajo.", "Almoço com os colegas de trabalho."),
    ("Он мой новый коллега.", "Es mi nuevo compañero de trabajo.", "Ele é o meu novo colega."))
add("соглашаться", "estar de acuerdo / aceptar", "concordar / aceitar",
    ("Я полностью согласен с твоим мнением.", "Estoy totalmente de acuerdo contigo.", "Concordo totalmente com a sua opinião."),
    ("Папа согласился, чтобы я поехал путешествовать.", "Papá aceptó que fuera de viaje.", "O papai aceitou eu viajar."))
add("волосы", "pelo / cabello", "cabelo",
    ("У неё чёрные длинные волосы.", "Tiene el pelo negro y largo.", "Ela tem cabelo preto e longo."),
    ("Тебе нужно подстричься.", "Necesitas cortarte el pelo.", "Você precisa cortar o cabelo."))
add("нога (от бедра)", "pierna", "perna",
    ("После пробежки у меня ноют ноги.", "Después de correr me duelen un poco las piernas.", "Depois de correr minhas pernas doem um pouco."),
    ("У него длинные ноги.", "Tiene las piernas muy largas.", "Ele tem pernas longas."))
add("внезапно / вдруг", "de repente / súbito", "de repente / súbito",
    ("Вдруг пошёл дождь.", "De repente empezó a llover.", "De repente começou a chover."),
    ("Он внезапно появился в дверях.", "Apareció de repente en la puerta.", "Ele apareceu de repente na porta."))
add("библиотека", "biblioteca", "biblioteca",
    ("Я часто беру книги в библиотеке.", "Voy a menudo a la biblioteca a pedir libros.", "Vou com frequência à biblioteca pegar livros."),
    ("В библиотеке соблюдайте тишину.", "Guarden silencio en la biblioteca.", "Mantenham silêncio na biblioteca."))
add("миска / чашка (глубокая)", "cuenco / tazón", "tigela / bowl",
    ("Дайте мне, пожалуйста, миску риса.", "Deme un tazón de arroz, por favor.", "Me dê uma tigela de arroz, por favor."),
    ("После еды нужно помыть миски.", "Hay que lavar los cuencos después de comer.", "Depois de comer é preciso lavar as tigelas."))
add("десять тысяч / тьма", "diez mil", "dez mil",
    ("Эта машина стоит сто тысяч юаней.", "Este coche cuesta cien mil yuanes.", "Este carro custa cem mil yuans."),
    ("В городе несколько миллионов человек.", "En la ciudad hay varios millones de personas.", "Na cidade há alguns milhões de pessoas."))
add("завершать / выполнять", "completar / terminar", "completar / concluir",
    ("Я вовремя закончил работу.", "Completé el trabajo a tiempo.", "Concluí o trabalho no prazo."),
    ("Все вместе выполнили задание.", "Entre todos completaron la tarea.", "Todos juntos concluíram a tarefa."))
add("забывать", "olvidar", "esquecer",
    ("Извините, я забыл ключи.", "Perdón, olvidé las llaves.", "Desculpe, esqueci as chaves."),
    ("Не забудьте нашу договорённость.", "No olviden nuestro acuerdo.", "Não esqueçam o nosso combinado."))
add("вежливый счётчик людей", "clasificador cortés de personas", "classificador cortês de pessoas",
    ("Сколько вас человек?", "¿Cuántos son ustedes?", "Quantas pessoas são vocês?"),
    ("Это наш новый учитель.", "Esta es nuestra nueva profesora.", "Esta é a nossa nova professora."))
add("ради / для того чтобы", "para / a fin de", "para / a fim de",
    ("Чтобы быть здоровым, нужно больше двигаться.", "Para estar sano, hay que hacer más ejercicio.", "Para ter saúde, é preciso se exercitar mais."),
    ("Ради экзамена он каждый день занимается допоздна.", "Para el examen, repasaba hasta muy tarde.", "Por causa da prova, ele revisa até tarde todo dia."))
add("культура", "cultura", "cultura",
    ("Меня очень интересует традиционная китайская культура.", "Me interesa mucho la cultura tradicional china.", "Me interesso muito pela cultura tradicional chinesa."),
    ("У каждой страны своя культура.", "Cada país tiene su propia cultura.", "Cada país tem a sua própria cultura."))
add("запад", "oeste / occidente", "oeste / ocidente",
    ("Солнце садится на западе.", "El sol se pone por el oeste.", "O sol se põe no oeste."),
    ("Супермаркет к западу от школы.", "El supermercado está al oeste de la escuela.", "O supermercado fica a oeste da escola."))
add("лето", "verano", "verão",
    ("Летом очень жарко.", "En verano hace muchísimo calor.", "No verão faz muito calor."),
    ("Летом поедем на море.", "En verano vamos a la playa.", "No verão vamos à praia."))
add("сначала / прежде", "primero / antes", "primeiro / antes",
    ("Ешьте сначала, меня не ждите.", "Coma primero, no me espere.", "Coma primeiro, não me espere."),
    ("Сначала купим билеты, потом в кино.", "Primero compramos las entradas y luego al cine.", "Primeiro compramos os ingressos e depois vamos ao cinema."))
add("быть похожим / как", "parecerse / como", "parecer / como",
    ("Ты очень похож на маму.", "Te pareces mucho a tu madre.", "Você parece muito com a sua mãe."),
    ("Сегодня погода как весной.", "Hoy el tiempo parece de primavera.", "Hoje o tempo está como na primavera."))
add("банан", "plátano / banana", "banana",
    ("Обезьяны любят бананы.", "A los monos les gusta el plátano.", "Macacos gostam de banana."),
    ("Я купил связку бананов.", "Compré un racimo de plátanos.", "Comprei um cacho de bananas."))
add("одинаковый / тот же", "igual / idéntico", "igual / idêntico",
    ("У нас с тобой одинаковые мысли.", "Nuestras ideas son iguales.", "Nossas ideias são iguais."),
    ("У этой одежды одинаковый цвет.", "Estas dos prendas tienen el mismo color.", "Estas duas roupas têm a mesma cor."))
add("верить", "creer / confiar", "acreditar / confiar",
    ("Я тебе верю.", "Te creo.", "Eu acredito em você."),
    ("Верьте, завтра будет лучше.", "Cree que mañana será mejor.", "Acredite que amanhã será melhor."))
add("осторожно / берегись", "con cuidado / ten cuidado", "cuidado / com cuidado",
    ("Осторожно!", "¡Cuidado!", "Cuidado!"),
    ("Переходя дорогу, будьте осторожны.", "Tenga cuidado al cruzar la calle.", "Tenha cuidado ao atravessar a rua."))
add("директор школы / ректор", "director / rector", "diretor / reitor",
    ("Директор выступил на общешкольном собрании.", "El director habló en la asamblea escolar.", "O diretor falou na assembleia da escola."),
    ("Это наш новый директор.", "Este es nuestro nuevo director.", "Este é o nosso novo diretor."))
add("обувь", "zapatos / calzado", "sapato / calçado",
    ("Эта обувь очень удобная.", "Estos zapatos son muy cómodos.", "Este sapato é muito confortável."),
    ("Входя, снимите обувь.", "Al entrar, quítese los zapatos.", "Ao entrar, tire os sapatos."))
add("привычка / привыкать", "hábito / acostumbrarse", "hábito / se acostumar",
    ("Я привык рано вставать и рано ложиться.", "Estoy acostumbrado a madrugar y acostarme temprano.", "Estou acostumado a acordar cedo e dormir cedo."),
    ("Формировать хорошие привычки очень важно.", "Formar buenos hábitos es muy importante.", "Criar bons hábitos é muito importante."))
add("письмо / верить", "carta / creer", "carta / acreditar",
    ("Я получил письмо от друга.", "Recibí una carta de un amigo.", "Recebi uma carta de um amigo."),
    ("Я верю, что у тебя получится.", "Creo que seguro lo lograrás.", "Acredito que você vai conseguir."))
add("чемодан", "maleta / maletero", "mala",
    ("Сложите одежду в чемодан.", "Meta la ropa en la maleta.", "Coloque a roupa na mala."),
    ("Этот чемодан слишком тяжёлый.", "Esta maleta pesa demasiado.", "Esta mala está pesada demais."))
add("интерес / интерес к чему-либо", "interés", "interesse",
    ("Меня интересует музыка.", "Me interesa la música.", "Tenho interesse em música."),
    ("Какие у тебя интересы?", "¿Cuáles son tus intereses?", "Quais são os seus interesses?"))
add("новости", "noticias", "notícias",
    ("Дедушка каждый вечер в семь смотрит новости.", "El abuelo ve las noticias a las siete todas las noches.", "O vovô assiste ao jornal às sete toda noite."),
    ("Это важная новость.", "Esta es una noticia importante.", "Esta é uma notícia importante."))
add("свежий", "fresco", "fresco",
    ("Здесь все овощи свежие.", "Las verduras de aquí están muy frescas.", "As verduras daqui estão bem frescas."),
    ("Утренний воздух такой свежий.", "El aire de la mañana está realmente fresco.", "O ar da manhã está realmente fresco."))
add("панда", "panda", "panda",
    ("Большая панда — национальное сокровище Китая.", "El panda gigante es un tesoro nacional de China.", "O panda-gigante é um tesouro nacional da China."),
    ("Панды в зоопарке очень милые.", "Los pandas del zoológico son adorables.", "Os pandas do zoológico são muito fofos."))
add("туалет / уборная", "aseo / baño", "banheiro",
    ("Скажите, пожалуйста, где туалет?", "Perdón, ¿dónde está el baño?", "Com licença, onde fica o banheiro?"),
    ("Я отойду в туалет.", "Voy un momento al baño.", "Vou ao banheiro um instante."))
add("принимать душ / купаться", "ducharse / bañarse", "tomar banho",
    ("После спорта я приму душ.", "Después de hacer deporte me ducho.", "Depois do exercício eu tomo banho."),
    ("Температура воды как раз, душ приятный.", "El agua está perfecta, ducharse es agradable.", "A água está no ponto, o banho é gostoso."))
add("выбирать / выбор", "elegir / elección", "escolher / escolha",
    ("Выберите правильный ответ.", "Elija la respuesta correcta.", "Escolha a resposta certa."),
    ("Это трудный выбор.", "Esta es una elección difícil.", "Esta é uma escolha difícil."))
add("нуждаться / нужно", "necesitar / hace falta", "precisar / precisar de",
    ("Тебе нужна моя помощь?", "¿Necesitas mi ayuda?", "Você precisa da minha ajuda?"),
    ("Если заболел, нужно больше отдыхать.", "Si estás enfermo, necesitas descansar más.", "Se ficar doente, precisa descansar mais."))
add("очки", "gafas / lentes", "óculos",
    ("На нём очки в чёрной оправе.", "Lleva unas gafas de montura negra.", "Ele usa óculos de armação preta."),
    ("Я случайно разбил очки.", "Se me rompieron las gafas sin querer.", "Quebrei os óculos sem querer."))
add("требование / требовать", "exigir / requisito", "exigir / exigência",
    ("Учитель предъявляет к нам строгие требования.", "El profesor es muy estricto con nosotros.", "O professor é muito rigoroso conosco."),
    ("Он выдвинул разумное требование.", "Presentó una petición razonable.", "Ele fez um pedido razoável."))
add("дедушка (по отцу)", "abuelo paterno", "avô paterno / vovô",
    ("Дедушка каждое утро гуляет в парке.", "El abuelo pasea por el parque todas las mañanas.", "O vovô passeia no parque toda manhã."),
    ("Моему дедушке в этом году восемьдесят.", "Mi abuelo cumple ochenta este año.", "Meu vovô faz oitenta este ano."))
add("обычно / обыкновенный", "normalmente / corriente", "em geral / comum",
    ("Обычно я встаю в семь.", "Normalmente me levanto a las siete.", "Em geral eu acordo às sete."),
    ("Этот вопрос обычно несложный.", "Esta pregunta por lo general no es difícil.", "Essa pergunta em geral não é difícil."))
add("с одной стороны / одновременно", "a la vez / al mismo tiempo", "ao mesmo tempo / enquanto",
    ("Слушать и одновременно записывать.", "Escucha y toma notas al mismo tiempo.", "Escute e anote ao mesmo tempo."),
    ("Он шёл и одновременно говорил по телефону.", "Caminaba mientras hablaba por teléfono.", "Ele andava enquanto falava ao telefone."))
add("обязательно / непременно", "seguro / sin falta", "com certeza / certamente",
    ("Завтра я обязательно приду вовремя.", "Mañana vendré a tiempo sin falta.", "Amanhã eu venho no horário com certeza."),
    ("Если стараться, обязательно получится.", "Si te esfuerzas, seguro tendrás éxito.", "Se você se esforçar, com certeza vai conseguir."))
add("всего / в сумме", "en total / en conjunto", "no total / ao todo",
    ("Сколько всего выходит?", "¿Cuánto es en total?", "Quanto dá no total?"),
    ("Здесь всего сто книг.", "Aquí hay cien libros en total.", "Aqui há cem livros no total."))
add("после / в будущем", "después / en el futuro", "depois / no futuro",
    ("Впредь приходите пораньше.", "En el futuro, venga más temprano.", "Da próxima, venha mais cedo."),
    ("После выпуска хочу в Китай.", "Después de graduarme quiero ir a China.", "Depois de me formar quero ir à China."))
add("немного / через минуту", "un rato / en un momento", "um instante / daqui a pouco",
    ("Подождите немного, пожалуйста.", "Espere un ratito, por favor.", "Espere um instante, por favor."),
    ("Я скоро вернусь.", "Vuelvo en un momento.", "Já volto daqui a pouco."))
add("следует / должен", "deber / tener que", "dever / ter que",
    ("Тебе следует раньше ложиться.", "Deberías acostarte más temprano.", "Você deveria dormir mais cedo."),
    ("Это то, что я должен сделать.", "Esto es lo que debo hacer.", "Isso é o que eu devo fazer."))
add("влияние / влиять", "influencia / afectar", "influência / afetar",
    ("Пожалуйста, не мешайте другим отдыхать.", "No afecte el descanso de los demás.", "Não atrapalhe o descanso dos outros."),
    ("Среда сильно влияет на развитие человека.", "El entorno influye mucho en el crecimiento de una persona.", "O ambiente influencia muito o crescimento de uma pessoa."))
add("банк", "banco", "banco",
    ("Я иду в банк положить деньги.", "Voy al banco a depositar dinero.", "Vou ao banco depositar dinheiro."),
    ("Банк на углу впереди.", "El banco está en la esquina de adelante.", "O banco fica na esquina à frente."))
add("музыка", "música", "música",
    ("Я люблю слушать музыку.", "Me gusta escuchar música.", "Gosto de ouvir música."),
    ("Что это за музыка?", "¿Qué música es esta?", "Que música é essa?"))
add("раньше / прежде", "antes / antiguamente", "antes / antigamente",
    ("Раньше я здесь не жил.", "Antes no vivía aquí.", "Antes eu não morava aqui."),
    ("Ты раньше учил китайский?", "¿Habías estudiado chino antes?", "Você já tinha estudado chinês antes?"))
add("думать (ошибочно полагать)", "creer (equivocadamente)", "achar (por engano)",
    ("Я думал, что это завтра.", "Creía que era mañana.", "Eu achava que era amanhã."),
    ("Он думал, что я приду.", "Creía que yo vendría.", "Ele achou que eu viria."))
add("одинаковый / такой же", "igual / lo mismo", "igual / o mesmo",
    ("У нас с тобой одинаковые увлечения.", "Nuestras aficiones son las mismas.", "Nossos hobbies são iguais."),
    ("Эти две книги выглядят совершенно одинаково.", "Estos dos libros se ven idénticos.", "Estes dois livros parecem idênticos."))
add("всё время / прямо", "todo el rato / siempre / recto", "o tempo todo / sempre / reto",
    ("Я всё время тебя ждал.", "Te he estado esperando todo el rato.", "Estive te esperando o tempo todo."),
    ("Дождь всё не прекращается.", "La lluvia no deja de caer.", "A chuva não para de cair."))
add("использовать / пользоваться", "usar / utilizar", "usar / utilizar",
    ("Можно воспользоваться твоей ручкой?", "¿Puedo usar tu bolígrafo un momento?", "Posso usar sua caneta um instante?"),
    ("Он работает за компьютером.", "Usa el ordenador para el trabajo.", "Ele usa o computador para trabalhar."))
add("опять / и ... и ...", "otra vez / a la vez", "de novo / ao mesmo tempo",
    ("Сегодня опять шёл дождь.", "Hoy volvió a llover.", "Hoje choveu de novo."),
    ("Это яблоко и большое, и сладкое.", "Esta manzana es grande y dulce a la vez.", "Esta maçã é grande e doce ao mesmo tempo."))
add("знаменитый / известный", "famoso / conocido", "famoso / conhecido",
    ("Великая стена — всемирно известное сооружение.", "La Gran Muralla es una construcción famosa en el mundo.", "A Grande Muralha é uma construção famosa no mundo."),
    ("Он известный повар.", "Es un chef famoso.", "Ele é um chef famoso."))
add("игра", "juego", "jogo",
    ("Дети любят компьютерные игры.", "A los niños les gusta jugar a videojuegos.", "Crianças gostam de jogos de computador."),
    ("Это интересная интерактивная игра.", "Este es un juego interactivo interesante.", "Este é um jogo interativo interessante."))
add("быть готовым / хотеть", "estar dispuesto / querer", "estar disposto / querer",
    ("Ты готов пойти со мной?", "¿Estás dispuesto a ir conmigo?", "Você está disposto a ir comigo?"),
    ("Он с радостью помогает всем.", "Está muy dispuesto a ayudar a todos.", "Ele está muito disposto a ajudar todo mundo."))
add("встречать / сталкиваться", "encontrar / toparse con", "encontrar / se deparar",
    ("На улице я встретил старого друга.", "Me encontré a un viejo amigo en la calle.", "Encontrei um velho amigo na rua."),
    ("Встретив трудности, сохраняйте спокойствие.", "Mantén la calma al encontrar dificultades.", "Fique calmo ao encontrar dificuldades."))
add("чем ... тем ...", "cuanto más... más...", "quanto mais... mais...",
    ("Ветер дует всё сильнее.", "El viento sopla cada vez más fuerte.", "O vento está cada vez mais forte."),
    ("Чем больше читаю эту книгу, тем больше хочется читать.", "Cuanto más leo este libro, más quiero leerlo.", "Quanto mais leio este livro, mais quero ler."))
add("луна", "luna", "lua",
    ("Сегодня луна большая и круглая.", "Esta noche la luna está grande y redonda.", "Hoje a lua está grande e redonda."),
    ("Луна высоко в небе.", "La luna cuelga alta en el cielo.", "A lua está bem alta no céu."))
add("облако", "nube", "nuvem",
    ("На небе много облаков.", "Hay muchas nubes en el cielo.", "Há muitas nuvens no céu."),
    ("Белые облака на синем небе.", "Nubes blancas en el cielo azul.", "Nuvens brancas no céu azul."))
add("станция / стоять", "estación / estar de pie", "estação / ficar de pé",
    ("Встаньте, пожалуйста.", "Póngase de pie, por favor.", "Fique de pé, por favor."),
    ("Я подожду тебя на станции.", "Te espero en la estación.", "Te espero na estação."))
add("ухаживать / заботиться", "cuidar / atender", "cuidar / olhar por",
    ("Берегите себя.", "Cuídate bien.", "Cuide bem de si."),
    ("Сестра дома ухаживает за больным братом.", "La hermana mayor cuida en casa al hermano enfermo.", "A irmã mais velha cuida em casa do irmão doente."))
add("волноваться / спешить", "estar ansioso / precipitarse", "ficar ansioso / ter pressa",
    ("Не волнуйся, не торопись.", "No te apures, con calma.", "Não tenha pressa, com calma."),
    ("Он очень переживает.", "Está muy ansioso.", "Ele está muito ansioso."))
add("фотография", "foto / fotografía", "foto / fotografia",
    ("Это фото получилось очень красивым.", "Esta foto salió muy bonita.", "Esta foto ficou muito bonita."),
    ("Посмотрите наше общее фото.", "Mira nuestra foto de grupo.", "Olhe a nossa foto em grupo."))
add("фотоаппарат", "cámara de fotos", "máquina fotográfica / câmera",
    ("В поездку не забудь фотоаппарат.", "No olvides la cámara al viajar.", "Não esqueça a câmera na viagem."),
    ("Это профессиональный фотоаппарат.", "Esta es una cámara profesional.", "Esta é uma câmera profissional."))
add("так / настолько", "tan / de este modo", "tão / desse jeito",
    ("Почему сегодня так холодно?", "¿Por qué hace tanto frío hoy?", "Por que está tão frio hoje?"),
    ("Ты поступил правильно.", "Hiciste bien al hacerlo así.", "Você fez certo desse jeito."))
add("только / лишь", "solo / solamente", "só / somente",
    ("Я съел только одно яблоко.", "Solo comí una manzana.", "Eu só comi uma maçã."),
    ("В комнате только один человек.", "En la habitación solo hay una persona.", "No quarto só tem uma pessoa."))
add("только если / лишь", "solo si / únicamente", "só se / somente",
    ("Только усердно учась, можно получить хорошие оценки.", "Solo estudiando duro se sacan buenas notas.", "Só estudando com afinco se tira nota boa."),
    ("Только он знает об этом.", "Solo él sabe de este asunto.", "Só ele sabe disso."))
add("вид / сорт / тип", "tipo / clase / especie", "tipo / espécie / tipo",
    ("Я люблю этот вид фруктов.", "Me gusta este tipo de fruta.", "Gosto deste tipo de fruta."),
    ("Здесь много разных видов цветов.", "Hay muchos tipos distintos de flores.", "Há muitos tipos diferentes de flores."))
add("середина / центр", "medio / centro", "meio / centro",
    ("Человек в середине — это я.", "La persona del medio soy yo.", "A pessoa do meio sou eu."),
    ("Посередине стола стоит тарелка с фруктами.", "En el centro de la mesa hay un plato de fruta.", "No centro da mesa tem um prato de fruta."))
add("важный", "importante", "importante",
    ("Здоровье важнее всего.", "La salud es más importante que nada.", "A saúde é mais importante do que tudo."),
    ("Это очень важный документ.", "Este es un documento extremadamente importante.", "Este é um documento extremamente importante."))
add("наконец / в конце концов", "por fin / al fin", "finalmente / enfim",
    ("Я наконец закончил домашнее задание.", "Por fin terminé la tarea.", "Finalmente terminei a lição."),
    ("Поезд наконец прибыл.", "El tren por fin llegó.", "O trem finalmente chegou."))
add("выходные", "fin de semana", "fim de semana",
    ("Приятных выходных!", "¡Que pases un buen fin de semana!", "Bom fim de semana!"),
    ("Что планируешь на эти выходные?", "¿Qué planeas hacer este fin de semana?", "O que você pretende fazer neste fim de semana?"))
add("желать / поздравлять", "desear / felicitar", "desejar / parabenizar",
    ("С днём рождения!", "¡Feliz cumpleaños!", "Feliz aniversário!"),
    ("Желаю успеха!", "¡Te deseo éxito!", "Desejo sucesso a você!"))
add("главный / основной", "principal / esencial", "principal / essencial",
    ("Это наша главная задача на сегодня.", "Esta es nuestra tarea principal de hoy.", "Esta é a nossa tarefa principal de hoje."),
    ("Главная причина неудачи — недостаток усилий.", "La razón principal de su fracaso fue no esforzarse lo suficiente.", "A razão principal do fracasso foi não se esforçar o bastante."))
add("обращать внимание", "prestar atención / fijarse", "prestar atenção / tomar cuidado",
    ("Переходя дорогу, будьте внимательны.", "Al cruzar, preste atención a la seguridad.", "Ao atravessar, preste atenção à segurança."),
    ("Слушайте учителя внимательно.", "Presten atención a la clase, por favor.", "Prestem atenção à aula, por favor."))
add("словарь иероглифов", "diccionario de caracteres", "dicionário de caracteres",
    ("Незнакомый иероглиф можно посмотреть в словаре.", "Si no conoces un carácter, búscalo en el diccionario.", "Se não conhecer um caractere, procure no dicionário."),
    ("Я купил новый словарь.", "Compré un diccionario nuevo.", "Comprei um dicionário novo."))
add("сам / себя", "uno mismo / propio", "si mesmo / próprio",
    ("Верь в себя.", "Cree en ti mismo.", "Acredite em você mesmo."),
    ("Это дело я хочу решить сам.", "Quiero decidir este asunto yo mismo.", "Quero decidir isso eu mesmo."))
add("всегда / вечно", "siempre", "sempre",
    ("Он всегда встречает людей с улыбкой.", "Siempre recibe a la gente con una sonrisa.", "Ele sempre recebe as pessoas com um sorriso."),
    ("Почему ты всегда опаздываешь?", "¿Por qué llegas siempre tarde?", "Por que você sempre chega atrasado?"))
add("в последнее время / недавно", "últimamente / recientemente", "ultimamente / recentemente",
    ("Как ты в последнее время?", "¿Cómo has estado últimamente?", "Como você tem estado ultimamente?"),
    ("В последнее время я очень занят.", "Últimamente estoy muy ocupado.", "Ultimamente estou muito ocupado."))
add("домашнее задание", "deberes / tarea", "lição de casa / dever",
    ("Сделаешь уроки — можно идти играть.", "Cuando termines la tarea, puedes ir a jugar.", "Quando terminar a lição, pode ir brincar."),
    ("Сегодня домашнего задания немного.", "Hoy no hay mucha tarea.", "Hoje não tem muita lição."))
add("действие / роль / эффект", "efecto / función / papel", "efeito / função / papel",
    ("Это лекарство хорошо помогает при простуде.", "Esta medicina es eficaz para el resfriado y tiene un gran efecto.", "Este remédio é eficaz para resfriado e fez grande efeito."),
    ("Сила единства сыграла ключевую роль.", "La fuerza de la unidad desempeñó un papel clave.", "A força da união teve um papel decisivo."))
