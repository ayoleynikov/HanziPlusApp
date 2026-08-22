#!/usr/bin/env python3
"""HSK 3 translations 100–199."""
from __future__ import annotations

ROWS = []


def add(ru, es, pt, *examples):
    ROWS.append((ru, es, pt, examples))


add("жёлтый", "amarillo", "amarelo",
    ("Этот цветок жёлтый.", "Esta flor es amarilla.", "Esta flor é amarela."),
    ("Хуанхэ — знаменитая река Китая.", "El Río Amarillo es un río famoso de China.", "O Rio Amarelo é um rio famoso da China."))
add("Хуанхэ / Жёлтая река", "río Amarillo", "Rio Amarelo",
    ("Хуанхэ — вторая по длине река Китая.", "El Río Amarillo es el segundo río más largo de China.", "O Rio Amarelo é o segundo rio mais longo da China."),
    ("В прошлом году мы посетили Хуанхэ.", "El año pasado visitamos el Río Amarillo.", "Ano passado visitamos o Rio Amarelo."))
add("окружающая среда / обстановка", "entorno / medio ambiente", "ambiente / meio ambiente",
    ("Здесь хорошие условия для жизни.", "El entorno de vida aquí es muy bueno.", "O ambiente de vida daqui é muito bom."),
    ("Нужно беречь окружающую среду.", "Debemos proteger el medio ambiente.", "Precisamos proteger o meio ambiente."))
add("сад / цветник", "jardín", "jardim",
    ("В саду много цветов.", "Hay muchas flores en el jardín.", "Há muitas flores no jardim."),
    ("Я фотографирую в саду.", "Estoy tomando fotos en el jardín.", "Estou tirando fotos no jardim."))
add("собрание / совещание", "reunión / conferencia", "reunião / conferência",
    ("Собрание начнётся в девять.", "La reunión empieza a las nueve.", "A reunião começa às nove."),
    ("Все участвовали в этом собрании.", "Todos asistieron a esta reunión.", "Todo mundo participou desta reunião."))
add("или / либо", "o / o bien", "ou / ou então",
    ("Можно ехать на автобусе или на метро.", "Puedes ir en autobús o en metro.", "Você pode ir de ônibus ou de metrô."),
    ("Можно завтра или послезавтра.", "Mañana o pasado mañana está bien.", "Amanhã ou depois de amanhã está bom."))
add("паспорт", "pasaporte", "passaporte",
    ("Для поездки за границу нужен паспорт.", "Para viajar al extranjero hay que llevar pasaporte.", "Para viajar ao exterior é preciso levar passaporte."),
    ("Я потерял паспорт.", "Perdí el pasaporte.", "Perdi o passaporte."))
add("крайне / чрезвычайно", "extremadamente / -ísimo", "extremamente / demais",
    ("Сегодня жарища.", "Hoy hace un calor extremo.", "Hoje está um calor extremo."),
    ("Он крайне интересуется музыкой.", "Le interesa muchísimo la música.", "Ele se interessa extremamente por música."))
add("проверять / осмотр", "revisar / chequeo", "checar / exame",
    ("Врач меня осмотрел.", "El médico me hizo un chequeo.", "O médico me examinou."),
    ("Перед сдачей экзамена внимательно проверьте ответы.", "Revise las respuestas con cuidado antes de entregar.", "Confira as respostas com cuidado antes de entregar."))
add("простой / лёгкий", "simple / fácil", "simples / fácil",
    ("Этот вопрос очень простой.", "Esta pregunta es extremadamente simple.", "Essa pergunta é extremamente simples."),
    ("Мы приготовили простой ужин.", "Preparamos una cena sencilla.", "Fizemos um jantar simples."))
add("рассказывать / объяснять / вести урок", "explicar / contar / dar clase", "explicar / contar / dar aula",
    ("Учитель объясняет ученикам урок.", "El profesor está dando clase a los alumnos.", "O professor está dando aula aos alunos."),
    ("Расскажи мне историю, пожалуйста.", "Cuéntame un cuento, por favor.", "Me conte uma história, por favor."))
add("здоровье / здоровый", "salud / sano", "saúde / saudável",
    ("Желаю тебе здоровья!", "¡Que tengas buena salud!", "Desejo saúde a você!"),
    ("Больше двигаться полезно для здоровья.", "Hacer más ejercicio es bueno para la salud.", "Fazer mais exercício faz bem à saúde."))
add("встречаться / увидеться", "verse / encontrarse", "encontrar / se ver",
    ("Давайте встретимся завтра днём.", "Veámonos mañana por la tarde.", "Vamos nos encontrar amanhã à tarde."),
    ("Очень рад снова тебя видеть.", "Me alegra mucho verte otra vez.", "Que bom te ver de novo."))
add("цзяо (0,1 юаня) / угол", "jiao (0,1 yuan) / esquina", "jiao (0,1 yuan) / canto",
    ("Это яблоко стоит три юаня пять цзяо.", "Esta manzana cuesta tres yuanes y cinco jiao.", "Esta maçã custa três yuans e cinco jiaos."),
    ("На углу стола лежит книга.", "Hay un libro en la esquina de la mesa.", "Tem um livro no canto da mesa."))
add("нога / ступня", "pie", "pé",
    ("От ходьбы у меня ноют ступни.", "De tanto caminar me duelen los pies.", "De tanto andar meus pés doem."),
    ("Он помыл ноги и лёг спать.", "Se lavó los pies y se fue a dormir.", "Ele lavou os pés e foi dormir."))
add("учить / преподавать", "enseñar", "ensinar",
    ("Учитель учит нас китайскому.", "El profesor nos enseña chino.", "O professor nos ensina chinês."),
    ("Папа научил меня плавать.", "Papá me enseñó a nadar.", "O papai me ensinou a nadar."))
add("помнить", "acordarse / recordar", "lembrar / recordar",
    ("Ты меня ещё помнишь?", "¿Todavía te acuerdas de mí?", "Você ainda se lembra de mim?"),
    ("Не забудьте взять паспорт.", "Recuerde llevar el pasaporte.", "Lembre-se de levar o passaporte."))
add("встречать / принимать / брать трубку", "recoger / contestar / recibir", "buscar / atender / receber",
    ("Я еду в аэропорт встретить друга.", "Voy al aeropuerto a recoger a un amigo.", "Vou ao aeroporto buscar um amigo."),
    ("Возьмите, пожалуйста, трубку.", "Conteste el teléfono, por favor.", "Atenda o telefone, por favor."))
add("одалживать / занимать", "prestar / pedir prestado", "emprestar / pegar emprestado",
    ("Можно одолжить твою книгу?", "¿Puedo pedirte prestado el libro?", "Posso pegar seu livro emprestado?"),
    ("Он взял в библиотеке три книги.", "Pidió prestados tres libros en la biblioteca.", "Ele pegou três livros emprestados na biblioteca."))
add("улица", "calle", "rua",
    ("Эта улица очень чистая.", "Esta calle está muy limpia.", "Esta rua está bem limpa."),
    ("По обеим сторонам улицы много магазинов.", "Hay muchas tiendas a ambos lados de la calle.", "Há muitas lojas dos dois lados da rua."))
add("жениться / выходить замуж", "casarse", "casar / se casar",
    ("Они решили пожениться в следующем году.", "Decidieron casarse el año que viene.", "Eles decidiram se casar no ano que vem."),
    ("Поздравляем со свадьбой!", "¡Felicidades por su boda!", "Parabéns pelo casamento!"))
add("решать / разрешать (проблему)", "resolver / solucionar", "resolver / solucionar",
    ("Мы наконец решили эту проблему.", "Por fin resolvimos este problema.", "Finalmente resolvemos esse problema."),
    ("Этот способ может решить трудности.", "Este método puede resolver las dificultades.", "Este método pode resolver as dificuldades."))
add("передача / программа", "programa / show", "programa / atração",
    ("Эта телепередача очень интересная.", "Este programa de TV es muy interesante.", "Este programa de TV é muito interessante."),
    ("Что хорошего сегодня вечером по ТВ?", "¿Qué programas buenos hay esta noche?", "Que programas bons tem hoje à noite?"))
add("праздник", "fiesta / festividad", "festa / feriado",
    ("Чуньцзе — самый важный праздник Китая.", "El Año Nuevo Chino es la festividad más importante de China.", "O Ano Novo Chinês é a festa mais importante da China."),
    ("С праздником!", "¡Felices fiestas a todos!", "Boas festas a todos!"))
add("заканчивать / завершать", "terminar / concluir", "terminar / encerrar",
    ("Собрание закончилось в пять.", "La reunión terminó a las cinco.", "A reunião terminou às cinco."),
    ("Когда экзамен закончится, положите ручки.", "Al terminar el examen, dejen el bolígrafo.", "Quando a prova terminar, abaixem a caneta."))
add("почти", "casi", "quase",
    ("Я почти забыл.", "Casi lo olvido.", "Quase esqueci."),
    ("Почти все уже пришли.", "Casi todos ya llegaron.", "Quase todo mundo já chegou."))
add("шанс / возможность", "oportunidad / ocasión", "oportunidade / chance",
    ("Это отличная возможность.", "Esta es una muy buena oportunidad.", "Esta é uma ótima oportunidade."),
    ("Надеюсь, ещё будет шанс встретиться.", "Espero que haya otra oportunidad de vernos.", "Espero que ainda tenhamos chance de nos ver."))
add("время года / сезон", "estación del año", "estação do ano",
    ("В году четыре сезона.", "Un año tiene cuatro estaciones.", "O ano tem quatro estações."),
    ("Какое время года тебе нравится больше всего?", "¿Cuál es tu estación favorita?", "Qual estação você mais gosta?"))
add("часто / регулярно", "a menudo / con frecuencia", "com frequência / sempre",
    ("Я часто хожу в библиотеку.", "Voy a menudo a la biblioteca.", "Vou com frequência à biblioteca."),
    ("Он часто ест китайскую еду.", "Come comida china con frecuencia.", "Ele come comida chinesa com frequência."))
add("проходить / через / после", "pasar por / a través de", "passar por / depois de",
    ("Я прохожу мимо школы.", "Paso por la escuela.", "Passo pela escola."),
    ("Благодаря усилиям он добился успеха.", "Gracias al esfuerzo, tuvo éxito.", "Depois de se esforçar, ele conseguiu."))
add("менеджер / управляющий", "gerente", "gerente",
    ("Наш менеджер очень добросовестный.", "Nuestro gerente trabaja con mucha seriedad.", "Nosso gerente trabalha com muita seriedade."),
    ("Он только что стал менеджером.", "Acaba de convertirse en gerente.", "Ele acabou de virar gerente."))
add("долго (о времени)", "largo (tiempo) / mucho tiempo", "longo (tempo) / muito tempo",
    ("Давно не виделись!", "¡Cuánto tiempo sin vernos!", "Há quanto tempo!"),
    ("Как долго ты будешь дома?", "¿Cuánto tiempo te vas a quedar en casa?", "Quanto tempo você vai ficar em casa?"))
add("старый / подержанный", "viejo / usado", "velho / usado",
    ("Эта одежда слишком старая, купи новую.", "Esta prenda está demasiado vieja, cámbiala.", "Esta roupa está velha demais, troque por uma nova."),
    ("Он продал старые книги.", "Vendió los libros viejos.", "Ele vendeu os livros velhos."))
add("решать / решение", "decidir / decisión", "decidir / decisão",
    ("Я решил учиться в Китае.", "Decidí ir a estudiar a China.", "Decidi ir estudar na China."),
    ("Это важное решение.", "Esta es una decisión importante.", "Esta é uma decisão importante."))
add("проводить (мероприятие)", "celebrar / celebrarse", "realizar / promover",
    ("Школа проведёт спортивный праздник.", "La escuela celebrará una competición deportiva.", "A escola vai realizar uma gincana esportiva."),
    ("Совещание проходит в Пекине.", "La reunión se celebró en Pekín.", "A reunião foi realizada em Pequim."))
add("предложение (грамматическое)", "oración / frase", "frase / oração",
    ("Составьте предложение с этим словом.", "Escriba una oración con esta palabra.", "Faça uma frase com esta palavra."),
    ("Это предложение звучит естественно.", "Esta oración fluye bien.", "Esta frase está bem natural."))
add("хотеть пить / жажда", "tener sed", "ter sede",
    ("Я немного хочу пить.", "Tengo un poco de sed, quiero agua.", "Estou com um pouco de sede, quero água."),
    ("После игры все захотели пить.", "Después de jugar, todos tenían sed.", "Depois de jogar, todo mundo ficou com sede."))
add("четверть часа / вырезать", "cuarto de hora / grabar", "quinze minutos / gravar",
    ("Сейчас четверть шестого.", "Ahora son las cinco y cuarto.", "Agora são cinco e quinze."),
    ("Подождите, пожалуйста, четверть часа.", "Espere un cuarto de hora, por favor.", "Espere quinze minutos, por favor."))
add("милый / симпатичный", "adorable / lindo", "fofo / fofinho",
    ("Этот кот очень милый.", "Este gato es muy lindo.", "Este gato é muito fofo."),
    ("Дети такие милые.", "Los niños son realmente adorables.", "As crianças são realmente fofas."))
add("гость / клиент", "invitado / cliente", "convidado / cliente",
    ("Сегодня к нам пришли гости.", "Hoy vinieron varios invitados a casa.", "Hoje vieram alguns convidados em casa."),
    ("Принимайте гостей радушно.", "Reciba a los invitados con calidez.", "Receba os convidados com carinho."))
add("кондиционер", "aire acondicionado", "ar-condicionado",
    ("В комнате жарко, включите кондиционер.", "Hace mucho calor, encienda el aire.", "Está muito quente, ligue o ar-condicionado."),
    ("Под кондиционером не простудитесь.", "Cuidado de no resfriarse con el aire.", "Cuidado para não ficar doente com o ar."))
add("рот / глоток / счётчик людей в семье", "boca / sorbo / clasificador de personas", "boca / gole / classificador de pessoas",
    ("В нашей семье трое.", "Somos tres en la familia.", "Somos três na família."),
    ("Выпейте глоток воды.", "Tome un sorbo de agua.", "Tome um gole de água."))
add("плакать", "llorar", "chorar",
    ("Ребёнок заплакал.", "El niño lloró.", "A criança chorou."),
    ("Не плачь, всё в порядке.", "No llores, no pasa nada.", "Não chore, está tudo bem."))
add("палочки для еды", "palillos", "hashi / pauzinhos",
    ("Ты умеешь есть палочками?", "¿Sabes usar palillos?", "Você sabe usar hashi?"),
    ("Дайте, пожалуйста, пару палочек.", "Deme un par de palillos, por favor.", "Me dê um par de hashi, por favor."))
add("брюки / штаны", "pantalones", "calça",
    ("Эти брюки немного длинные.", "Estos pantalones son un poco largos.", "Esta calça está um pouco longa."),
    ("Я купил новую обувь и новые брюки.", "Compré zapatos nuevos y unos pantalones nuevos.", "Comprei sapato novo e uma calça nova."))
add("синий", "azul", "azul",
    ("Небо синее.", "El cielo es azul.", "O céu é azul."),
    ("На ней синяя куртка.", "Lleva una chaqueta azul.", "Ela está de jaqueta azul."))
add("старый / пожилой", "viejo / mayor", "velho / idoso",
    ("Этому пожилому человеку нужна помощь.", "Esta persona mayor necesita ayuda.", "Este idoso precisa de ajuda."),
    ("Дедушка уже в годах.", "El abuelo ya es mayor.", "O vovô já está idoso."))
add("лицо", "cara / rostro", "rosto / cara",
    ("Он покраснел.", "Se le puso la cara roja.", "O rosto dele ficou vermelho."),
    ("Умойтесь, пожалуйста.", "Lávese la cara, por favor.", "Lave o rosto, por favor."))
add("штука (счётчик машин)", "clasificador de vehículos", "classificador de veículos",
    ("У двери стоит машина.", "Hay un coche aparcado en la puerta.", "Tem um carro parado na porta."),
    ("Я купил велосипед.", "Compré una bicicleta.", "Comprei uma bicicleta."))
add("практиковаться / упражнение", "practicar / ejercicio", "praticar / exercício",
    ("Я хочу практиковаться в написании иероглифов.", "Quiero practicar a escribir caracteres.", "Quero praticar a escrita dos caracteres."),
    ("Это сегодняшнее упражнение.", "Este es el ejercicio de hoy.", "Este é o exercício de hoje."))
add("разбираться / узнавать", "conocer / entender", "conhecer / entender",
    ("Я хорошо знаю его характер.", "Conozco muy bien su carácter.", "Eu conheço bem o caráter dele."),
    ("Хочешь узнать китайскую культуру?", "¿Quieres conocer la cultura china?", "Você quer conhecer a cultura chinesa?"))
add("уходить / покидать", "irse / dejar", "sair / deixar",
    ("Он собирается уехать отсюда в следующем месяце.", "Planea irse de aquí el mes que viene.", "Ele pretende sair daqui no mês que vem."),
    ("Пожалуйста, не покидайте свои места.", "No abandonen su asiento, por favor.", "Por favor, não saiam do seu lugar."))
add("сосед", "vecino", "vizinho",
    ("Мой сосед очень отзывчивый.", "Mi vecino es muy servicial.", "Meu vizinho é muito atencioso."),
    ("У нас с соседями хорошие отношения.", "Me llevo muy bien con mi vecino.", "Meu relacionamento com o vizinho é ótimo."))
add("история (наука / прошлое)", "historia", "história",
    ("У Китая очень древняя история.", "China tiene una historia muy larga.", "A China tem uma história muito longa."),
    ("Мне очень нравится изучать историю.", "Me gusta mucho estudiar historia.", "Gosto muito de estudar história."))
add("подарок", "regalo / presente", "presente / presente",
    ("Спасибо за подарок.", "Gracias por el regalo que me diste.", "Obrigado pelo presente que você me deu."),
    ("Это тебе подарок на день рождения.", "Este es tu regalo de cumpleaños.", "Este é o seu presente de aniversário."))
add("здание / этаж", "edificio / piso", "prédio / andar",
    ("Я живу на пятом этаже.", "Vivo en el quinto piso.", "Moro no quinto andar."),
    ("Поднимитесь наверх на собрание.", "Suba a la reunión, por favor.", "Suba para a reunião, por favor."))
add("зелёный", "verde", "verde",
    ("Листья стали зелёными.", "Las hojas se volvieron verdes.", "As folhas ficaram verdes."),
    ("Я люблю зелёный чай.", "Me gusta el té verde.", "Gosto de chá verde."))
add("лошадь", "caballo", "cavalo",
    ("Он катается на лошади на ферме.", "Monta a caballo en la granja.", "Ele anda a cavalo na fazenda."),
    ("Эта лошадь бегает очень быстро.", "Este caballo corre muy rápido.", "Este cavalo corre muito rápido."))
add("довольный / удовлетворённый", "satisfecho / contento", "satisfeito / contente",
    ("Я очень доволен этим результатом.", "Estoy muy satisfecho con este resultado.", "Estou muito satisfeito com este resultado."),
    ("Клиент очень доволен нашим сервисом.", "El cliente está muy satisfecho con nuestro servicio.", "O cliente está muito satisfeito com o nosso serviço."))
add("шапка / шляпа", "gorro / sombrero", "boné / chapéu",
    ("Холодно, надень шапку.", "Hace frío, ponte el gorro.", "Está frio, coloque o gorro."),
    ("Эта шапка очень красивая.", "Este gorro es muy bonito.", "Este chapéu é muito bonito."))
add("сразу / сейчас же", "en seguida / ahora mismo", "já já / agora mesmo",
    ("Я сейчас же приду.", "Voy enseguida.", "Já já eu vou."),
    ("Начинайте сразу, пожалуйста.", "Empiece ahora mismo, por favor.", "Comece agora mesmo, por favor."))
add("метр", "metro (unidad)", "metro (unidade)",
    ("Его рост — метр восемьдесят.", "Mide un metro ochenta.", "Ele tem um metro e oitenta."),
    ("В ста метрах впереди есть парк.", "Hay un parque a 100 metros.", "Tem um parque a 100 metros à frente."))
add("хлеб", "pan", "pão",
    ("Утром я съел кусок хлеба.", "Por la mañana comí un trozo de pan.", "De manhã comi um pedaço de pão."),
    ("В этой пекарне очень вкусный хлеб.", "El pan de esta panadería está riquísimo.", "O pão desta padaria está uma delícia."))
add("лапша / лапша (блюдо)", "fideos / tallarines", "macarrão / macarrão chinês",
    ("В обед пойдём есть лапшу с говядиной.", "A mediodía vamos a comer fideos con ternera.", "Ao meio-dia vamos comer macarrão com carne."),
    ("Эта миска лапши вкусная.", "Este tazón de fideos está rico.", "Este prato de macarrão está gostoso."))
add("понимать / ясно", "entender / claro", "entender / claro",
    ("Учитель объяснил очень ясно.", "El profesor lo explicó con mucha claridad.", "O professor explicou com muita clareza."),
    ("Теперь я понял, что ты имеешь в виду.", "Ahora entiendo lo que quieres decir.", "Agora entendi o que você quis dizer."))
add("брать / держать", "coger / sostener", "pegar / segurar",
    ("Подержи, пожалуйста, сумку.", "Sujétame el bolso un segundo, por favor.", "Segura a bolsa um segundo, por favor."),
    ("В руке у него книга.", "Lleva un libro en la mano.", "Ele está com um livro na mão."))
add("бабушка (по отцу)", "abuela paterna", "avó paterna / vovó",
    ("Бабушка греется во дворе.", "La abuela está tomando el sol en el patio.", "A vovó está tomando sol no quintal."),
    ("На выходных я навещу бабушку.", "El fin de semana voy a visitar a la abuela.", "No fim de semana vou visitar a vovó."))
add("так / тогда / настолько", "tan / entonces", "tão / então",
    ("Почему ты пришёл так рано?", "¿Por qué llegaste tan temprano?", "Por que você chegou tão cedo?"),
    ("Тогда до завтра.", "Entonces, nos vemos mañana.", "Então, até amanhã."))
add("юг", "sur", "sul",
    ("На юге Китая теплее.", "En el sur de China el clima es más cálido.", "No sul da China o clima é mais quente."),
    ("Идите на юг пятьсот метров — и вы на месте.", "Camine 500 metros hacia el sur y llega.", "Ande 500 metros para o sul e você chega."))
add("трудный / сложно", "difícil", "difícil",
    ("Эта задача очень сложная.", "Este problema es extremadamente difícil.", "Essa questão é extremamente difícil."),
    ("Учить новый язык не так уж трудно.", "Aprender un idioma nuevo no es tan difícil.", "Aprender um idioma novo não é tão difícil."))
add("грустно / тяжело на душе", "triste / apenado", "triste / chateado",
    ("Услышав плохие новости, ей стало грустно.", "Al oír la mala noticia, se puso muy triste.", "Ao ouvir a má notícia, ela ficou muito triste."),
    ("Не грусти, всё наладится.", "No estés triste, las cosas mejorarán.", "Não fique triste, as coisas vão melhorar."))
add("класс / курс (в школе)", "curso / año escolar", "série / ano escolar",
    ("Мой младший брат на третьем курсе университета.", "Mi hermano menor está en tercer año de universidad.", "Meu irmão mais novo está no terceiro ano da faculdade."),
    ("В каком ты классе?", "¿En qué curso estás?", "Em que série você está?"))
add("молодой", "joven", "jovem",
    ("Он выглядит очень молодо.", "Se ve extremadamente joven.", "Ele parece extremamente jovem."),
    ("Пока молодой — учись больше.", "Cuando eres joven, estudia más.", "Enquanto é jovem, estude mais."))
add("птица", "pájaro / ave", "pássaro / ave",
    ("На дереве поют маленькие птички.", "Hay muchos pajaritos cantando en el árbol.", "Há muitos passarinhos cantando na árvore."),
    ("Эта птица очень редкая.", "Este tipo de ave es muy rara.", "Esse tipo de ave é muito rara."))
add("стараться / прилагать усилия", "esforzarse / trabajador", "se esforçar / esforçado",
    ("Если стараться, получится.", "Si te esfuerzas, tendrás éxito.", "Se você se esforçar, vai conseguir."),
    ("Он очень старательный ученик.", "Es un estudiante extremadamente trabajador.", "Ele é um aluno extremamente esforçado."))
add("полный / толстый", "gordo / rollizo", "gordo / gordinho",
    ("В последнее время я поправился на несколько килограммов.", "Últimamente engordé unos kilos.", "Ultimamente engordei alguns quilos."),
    ("Этот котёнок пухленький.", "Este gatito está gordito.", "Este gatinho está gordinho."))
add("тарелка", "plato", "prato",
    ("Вымойте, пожалуйста, тарелки.", "Lave los platos, por favor.", "Lave os pratos, por favor."),
    ("Тарелка полна фруктов.", "El plato está lleno de fruta.", "O prato está cheio de fruta."))
add("подниматься в горы", "hacer senderismo / subir montañas", "fazer trilha / subir montanha",
    ("На выходных я хожу в горы с друзьями.", "Los fines de semana subo montañas con amigos.", "No fim de semana eu subo montanha com os amigos."),
    ("Ходить в горы — отличная тренировка.", "Subir montañas es un gran ejercicio.", "Subir montanha é um ótimo exercício."))
add("пиво", "cerveza", "cerveja",
    ("Летом холодное пиво очень приятно.", "En verano una cerveza fría sienta muy bien.", "No verão uma cerveja gelada cai muito bem."),
    ("Дайте мне, пожалуйста, две бутылки пива.", "Deme dos botellas de cerveza, por favor.", "Me dê duas garrafas de cerveja, por favor."))
add("виноград", "uva", "uva",
    ("Я люблю виноград.", "Me gusta comer uvas.", "Gosto de uva."),
    ("Этот виноград очень сладкий.", "Estas uvas son muy dulces.", "Estas uvas estão bem doces."))
add("путунхуа / общекитайский язык", "chino mandarín estándar", "mandarim padrão",
    ("Его путунхуа очень правильный.", "Su mandarín es muy estándar.", "O mandarim dele é muito padrão."),
    ("В школе мы все говорим на путунхуа.", "En la escuela todos hablamos mandarín.", "Na escola todos falamos mandarim."))
add("ехать верхом / кататься (на велосипеде, лошади)", "montar / ir en", "andar de / montar",
    ("Каждый день я езжу в школу на велосипеде.", "Voy a la escuela en bicicleta todos los días.", "Todo dia eu vou à escola de bicicleta."),
    ("Он научился ездить верхом.", "Aprendió a montar a caballo.", "Ele aprendeu a andar a cavalo."))
add("странный / удивительный", "raro / extraño", "estranho / esquisito",
    ("Этот вопрос странный.", "Esta pregunta es muy extraña.", "Essa pergunta é bem estranha."),
    ("Сегодня мне кажется всё странным.", "Hoy me parece todo muy raro.", "Hoje está tudo muito estranho."))
add("ясный / чёткий", "claro / nítido", "claro / nítido",
    ("Ты чётко видишь иероглифы на доске?", "¿Ves claro lo que hay en la pizarra?", "Você está vendo direito o que está na lousa?"),
    ("Этот вопрос объяснили очень ясно.", "Este asunto se explicó con mucha claridad.", "Esse assunto foi explicado com muita clareza."))
add("на самом деле / вообще-то", "en realidad / de hecho", "na verdade / na real",
    ("На самом деле я не занят.", "En realidad no estoy ocupado.", "Na verdade eu não estou ocupado."),
    ("Вообще-то я знаю ответ.", "De hecho, sé la respuesta.", "Na verdade eu sei a resposta."))
add("другие / остальное", "otro / los demás", "outro / os demais",
    ("Есть ещё вопросы?", "¿Hay alguna otra pregunta?", "Tem mais alguma pergunta?"),
    ("Остальные вещи уберите.", "Guarde las otras cosas, por favor.", "Guarde as outras coisas, por favor."))
add("осень", "otoño", "outono",
    ("Осенью очень свежо.", "El otoño es muy fresco.", "O outono é bem fresco."),
    ("Пришла осень, листья пожелтели.", "Llegó el otoño y las hojas se volvieron amarillas.", "Chegou o outono e as folhas amarelaram."))
add("юбка / платье", "falda / vestido", "saia / vestido",
    ("Сегодня на ней красивая новая юбка.", "Hoy lleva una falda nueva y bonita.", "Hoje ela está de saia nova e bonita."),
    ("Эта юбка слишком длинная.", "Esta falda es demasiado larga.", "Esta saia é longa demais."))
add("затем / потом", "luego / después", "depois / em seguida",
    ("Сначала поесть, потом учиться.", "Primero come, luego estudia.", "Primeiro coma, depois estude."),
    ("Он пришёл, и потом мы отправились.", "Llegó y luego partimos.", "Ele chegou e depois partimos."))
add("считать / полагать", "considerar / opinar", "achar / considerar",
    ("Я считаю, что это хороший способ.", "Creo que es una buena idea.", "Acho que é uma boa ideia."),
    ("Как ты думаешь, что нам делать?", "¿Qué crees que deberíamos hacer?", "O que você acha que devemos fazer?"))
add("серьёзный / добросовестный", "serio / concienzudo", "sério / caprichado",
    ("К учёбе он относится очень серьёзно.", "Su actitud de estudio es muy seria.", "A atitude dele nos estudos é muito séria."),
    ("Внимательно проверьте домашнее задание.", "Revise la tarea con seriedad.", "Confira a lição com seriedade."))
add("радушный / тёплый (о людях)", "entusiasta / hospitalario", "caloroso / hospitaleiro",
    ("Здешние люди очень радушные.", "La gente de aquí es muy hospitalaria.", "O povo daqui é muito hospitaleiro."),
    ("Она тепло встретила гостей.", "Recibió a los invitados con entusiasmo.", "Ela recebeu os convidados com calor."))
add("лёгкий / легко", "fácil / sencillo", "fácil / simples",
    ("На этот вопрос легко ответить.", "Esta pregunta es muy fácil de responder.", "Essa pergunta é muito fácil de responder."),
    ("Холодно — легко простудиться.", "Hace frío, es fácil resfriarse.", "Está frio, é fácil pegar resfriado."))
add("если", "si / en caso de que", "se / caso",
    ("Если пойдёт дождь, не пойдём.", "Si llueve, no vamos.", "Se chover, a gente não vai."),
    ("Если будет время, позвони мне.", "Si tienes tiempo, llámame.", "Se tiver tempo, me liga."))
add("зонт", "paraguas", "guarda-chuva",
    ("На улице дождь, возьми зонт.", "Está lloviendo, lleva el paraguas.", "Está chovendo, leve o guarda-chuva."),
    ("Я забыл зонт в автобусе.", "Se me olvidó el paraguas en el autobús.", "Esqueci o guarda-chuva no ônibus."))
add("выходить в интернет", "navegar por internet", "acessar a internet",
    ("Я люблю читать новости в интернете.", "Me gusta navegar para leer noticias.", "Gosto de acessar a internet para ler notícias."),
    ("Сеть здесь плохая, в интернет не выйти.", "La red aquí es mala, no se puede navegar.", "A internet daqui está ruim, não dá para acessar."))
add("злиться / сердиться", "enfadarse / enojarse", "ficar bravo / se irritar",
    ("Не злись, это я виноват.", "No te enfades, fue culpa mía.", "Não fique bravo, a culpa foi minha."),
    ("Он часто злится из-за мелочей.", "A menudo se enfada por nimiedades.", "Ele costuma ficar bravo por besteira."))
add("звук / голос", "sonido / voz", "som / voz",
    ("У неё очень сладкий голос.", "Tiene una voz muy dulce.", "A voz dela é muito doce."),
    ("Сделайте телевизор потише.", "Baje el volumen de la tele, por favor.", "Abaixe o volume da TV, por favor."))
add("заставлять / делать так, что", "hacer que / causar", "fazer com que / causar",
    ("Это меня очень радует.", "Esto me hace muy feliz.", "Isso me deixa muito feliz."),
    ("Учёба делает жизнь более осмысленной.", "Estudiar hace la vida más significativa.", "Estudar torna a vida mais significativa."))
add("мир", "mundo", "mundo",
    ("Я хочу объехать мир.", "Quiero viajar por el mundo.", "Quero viajar pelo mundo."),
    ("Китайцы есть по всему миру.", "Hay chinos en todo el mundo.", "Há chineses no mundo inteiro."))
