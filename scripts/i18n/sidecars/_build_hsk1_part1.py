#!/usr/bin/env python3
"""Build scripts/i18n/sidecars/hsk1.json from ordered triples matching hsk1.json."""
from __future__ import annotations
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SRC = ROOT / "HanziPlus/Resources/Data/hsk1.json"
OUT = ROOT / "scripts/i18n/sidecars/hsk1.json"

# Ordered: one tuple per source word: (ru, es, pt, [(ru,es,pt), ...examples])
ROWS = []

def add(ru, es, pt, *examples):
    ROWS.append((ru, es, pt, examples))

# 0-24
add("ехать в командировку", "ir de viaje de negocios", "viajar a trabalho",
    ("На следующей неделе менеджер едет в командировку в Шанхай.", "La semana que viene el gerente va de viaje de negocios a Shanghái.", "Na semana que vem o gerente viaja a trabalho para Xangai."),
    ("Он часто ездит в командировки по работе.", "A menudo viaja por trabajo.", "Ele costuma viajar a trabalho."))
add("отправляться / уходить", "salir / partir", "partir / sair",
    ("Мы планируем отправиться завтра рано утром.", "Planeamos salir mañana muy temprano.", "Vamos partir amanhã de manhã cedo."),
    ("Поезд сейчас отправится.", "El tren está a punto de partir.", "O trem está prestes a partir."))
add("родиться", "nacer", "nascer",
    ("Он родился в красивом южном городе.", "Nació en una hermosa ciudad del sur.", "Ele nasceu numa bela cidade do sul."),
    ("Пожалуйста, запишите дату рождения.", "Por favor, anote su fecha de nacimiento.", "Por favor, anote a data de nascimento."))
add("кухня", "cocina", "cozinha",
    ("Мама готовит ужин на кухне.", "Mamá está preparando la cena en la cocina.", "A mamãe está fazendo o jantar na cozinha."),
    ("Пожалуйста, уберите на кухне.", "Por favor, limpia la cocina.", "Por favor, limpe a cozinha."))
add("слова / выражения", "palabras / expresiones", "palavras / expressões",
    ("Составьте предложения с этими словами.", "Hagan oraciones con estas palabras.", "Façam frases com estas palavras."),
    ("Накапливать словарь очень полезно для изучения языка.", "Acumular vocabulario es muy útil para aprender un idioma.", "Acumular vocabulário ajuda muito a aprender um idioma."))
add("мешать / беспокоить", "molestar / interrumpir", "incomodar / interromper",
    ("Извините, можно вас побеспокоить на секунду.", "Perdón, siento molestarlo un segundo.", "Com licença, desculpe incomodar um segundo."),
    ("Он работает, пожалуйста, не мешайте.", "Está trabajando, por favor no lo molesten.", "Ele está trabalhando, por favor não incomodem."))
add("печатать", "imprimir", "imprimir",
    ("Пожалуйста, распечатайте этот документ.", "Por favor, imprima una copia de este documento.", "Por favor, imprima uma cópia deste documento."),
    ("В принтере закончилась бумага.", "La impresora se quedó sin papel.", "A impressora está sem papel."))
add("давать скидку", "hacer descuento", "dar desconto",
    ("В этом торговом центре сейчас скидки.", "Este centro comercial tiene descuentos ahora.", "Este shopping está com descontos agora."),
    ("Эта одежда продаётся со скидкой 20%.", "Esta prenda está al 80% del precio original.", "Esta roupa está com 20% de desconto."))
add("делать укол / ставить инъекцию", "poner una inyección", "aplicar uma injeção",
    ("Медсестра делает укол пациенту.", "La enfermera le está poniendo una inyección al paciente.", "A enfermeira está aplicando uma injeção no paciente."),
    ("Я не боюсь таблеток, но боюсь уколов.", "No temo los medicamentos, pero sí las inyecciones.", "Não tenho medo de remédio, mas tenho medo de injeção."))
add("посольство", "embajada", "embaixada",
    ("Нам нужно в посольство оформить визу.", "Tenemos que ir a la embajada a tramitar el visado.", "Precisamos ir à embaixada para tratar do visto."),
    ("Китайское посольство прямо впереди.", "La embajada de China está justo delante.", "A embaixada da China fica logo à frente."))
add("примерно / около", "aproximadamente / unos", "cerca de / aproximadamente",
    ("Отсюда до аэропорта примерно час.", "De aquí al aeropuerto hay aproximadamente una hora.", "Daqui até o aeroporto dá cerca de uma hora."),
    ("Сегодня на мероприятии было около ста человек.", "Hoy asistieron unas cien personas al evento.", "Hoje cerca de cem pessoas participaram do evento."))
add("надевать (очки, шляпу, украшения)", "ponerse (gafas, sombrero, accesorios)", "usar / colocar (óculos, chapéu, acessórios)",
    ("Он носит очки в чёрной оправе.", "Lleva unas gafas de montura negra.", "Ele usa óculos de armação preta."),
    ("Зимой на улице надевайте шапку.", "Póngase un sombrero al salir en invierno.", "Use um chapéu ao sair no inverno."))
add("представитель / представлять", "representante / representar", "representante / representar",
    ("Он говорит от имени компании.", "Habla en nombre de la empresa.", "Ele fala em nome da empresa."),
    ("Он наш студенческий представитель.", "Es nuestro representante estudiantil.", "Ele é o nosso representante estudantil."))
add("заменять / вместо", "reemplazar / en lugar de", "substituir / no lugar de",
    ("Никто не заменит твоё место в моём сердце.", "Nadie puede reemplazar tu lugar en mi corazón.", "Ninguém substitui o seu lugar no meu coração."),
    ("Сегодня Сяо Ли пошла на собрание вместо меня.", "Hoy Xiao Li asistió a la reunión en mi lugar.", "Hoje a Xiao Li foi à reunião no meu lugar."))
add("гид / экскурсовод", "guía turístico", "guia de turismo",
    ("Гид подробно рассказал нам историю достопримечательности.", "El guía nos explicó en detalle la historia del lugar.", "O guia nos contou em detalhe a história do ponto turístico."),
    ("Она очень душевный гид.", "Es una guía extremadamente entusiasta.", "Ela é uma guia extremamente atenciosa."))
add("гордиться собой / быть довольным собой", "estar orgulloso de sí / engreído", "orgulhoso de si / convencido",
    ("Набрав полный балл, он гордо улыбнулся.", "Al sacar la nota máxima, sonrió orgulloso.", "Ao tirar nota máxima, ele sorriu orgulhoso."),
    ("Даже при хорошем результате не зазнавайтесь.", "Aunque logres buenos resultados, no te engrias.", "Mesmo com bons resultados, não fique convencido."))
add("дно / конец (месяца, года)", "fondo / finales de", "fundo / fim de (mês/ano)",
    ("В конце месяца у нас будет экзамен.", "A finales de mes haremos un examen.", "No fim do mês teremos uma prova."),
    ("На дне чашки следы воды.", "Hay marcas de agua en el fondo de la taza.", "Há marcas de água no fundo da xícara."))
add("Земля", "la Tierra", "a Terra",
    ("Земля — наш общий дом.", "La Tierra es nuestro hogar compartido.", "A Terra é o nosso lar compartilhado."),
    ("Мы должны вместе беречь окружающую среду Земли.", "Debemos proteger juntos el entorno de la Tierra.", "Precisamos proteger juntos o ambiente da Terra."))
add("адрес", "dirección", "endereço",
    ("Пришлите мне домашний адрес.", "Envíeme su dirección de casa.", "Me envie o seu endereço residencial."),
    ("Адрес на конверте написан неверно.", "La dirección del sobre está mal escrita.", "O endereço no envelope está errado."))
add("расследование / опрос / расследовать", "investigación / encuesta / investigar", "investigação / pesquisa / investigar",
    ("Нужно провести исследование рынка.", "Tenemos que hacer un estudio de mercado.", "Precisamos fazer uma pesquisa de mercado."),
    ("Полиция сейчас расследует это дело.", "La policía está investigando este asunto.", "A polícia está investigando este caso."))
add("терять / выбрасывать", "perder / tirar", "perder / jogar fora",
    ("О нет, я потерял кошелёк!", "¡Ay, se me perdió la cartera!", "Puxa, perdi a carteira!"),
    ("Пожалуйста, не бросайте мусор.", "Por favor, no tire basura.", "Por favor, não jogue lixo no chão."))
add("движение / действие", "movimiento / acción", "movimento / ação",
    ("Движения танцора очень изящны.", "Los movimientos de la bailarina son muy elegantes.", "Os movimentos da dançarina são muito elegantes."),
    ("Пожалуйста, делайте движения медленнее.", "Por favor, ralentice los movimientos.", "Por favor, faça os movimentos mais devagar."))
add("пробка (на дороге)", "atasco / tráfico", "engarrafamento",
    ("На дороге была сильная пробка, я опоздал.", "El atasco era terrible y llegué tarde.", "O trânsito estava horrível e eu me atrasei."),
    ("В утренний час пик пробки бывают часто.", "En hora punta de la mañana hay atascos a menudo.", "No horário de pico da manhã o trânsito trava com frequência."))
add("живот", "barriga / estómago", "barriga / estômago",
    ("Я голоден, живот урчит.", "Tengo hambre, me ruge el estómago.", "Estou com fome, a barriga está roncando."),
    ("От несвежей еды легко заболеть животом.", "Comer comida sucia causa dolor de estómago.", "Comida estragada facilmente dá dor de barriga."))
add("сочувствие / сочувствовать", "simpatía / simpatizar", "compaixão / solidarizar-se",
    ("Все глубоко сочувствовали его положению.", "Todos simpatizaron profundamente con su situación.", "Todos se solidarizaram profundamente com a situação dele."),
    ("Сочувствие — прекрасная добродетель.", "La compasión es una virtud admirable.", "A compaixão é uma bela virtude."))

# 25-49
add("откладывать / переносить", "aplazar / posponer", "adiar / postergar",
    ("Из-за погоды собрание перенесли на завтра.", "Por el tiempo, la reunión se aplazó hasta mañana.", "Por causa do tempo, a reunião foi adiada para amanhã."),
    ("Это решение больше нельзя откладывать.", "Esta decisión no se puede posponer más.", "Essa decisão não pode ser adiada mais."))
add("снимать (одежду, обувь)", "quitarse (ropa, zapatos)", "tirar (roupa, sapato)",
    ("В комнате жарко, снимите куртку.", "Hace calor en la habitación, quítese la chaqueta.", "Está quente no quarto, tire o casaco."),
    ("Пожалуйста, снимите обувь перед входом.", "Quítese los zapatos antes de entrar.", "Tire os sapatos antes de entrar."))
add("опасность / опасный", "peligro / peligroso", "perigo / perigoso",
    ("Здесь глубоко, не плавайте — очень опасно!", "El agua es profunda, no nade, ¡es muy peligroso!", "A água é fundo, não nade — é muito perigoso!"),
    ("В опасности сохраняйте спокойствие.", "Mantenga la calma ante el peligro.", "Mantenha a calma diante do perigo."))
add("температура", "temperatura", "temperatura",
    ("Сегодня температура на три градуса ниже, чем вчера.", "Hoy la temperatura es tres grados más baja que ayer.", "Hoje a temperatura está três graus mais baixa que ontem."),
    ("Пожалуйста, измерьте температуру в помещении.", "Mida la temperatura interior.", "Meça a temperatura do ambiente."))
add("статья / сочинение", "artículo / texto", "artigo / texto",
    ("Эта статья написана очень живо.", "Este artículo está escrito de forma muy viva.", "Este artigo está escrito de forma muito viva."),
    ("Пожалуйста, внимательно прочитайте эту статью.", "Lea este artículo con atención.", "Leia este artigo com atenção."))
add("загрязнение / загрязнять", "contaminación / contaminar", "poluição / poluir",
    ("Выхлопы машин загрязняют воздух.", "Los gases de los coches contaminan el aire.", "A fumaça dos carros polui o ar."),
    ("Нужно уменьшить загрязнение водных ресурсов.", "Debemos reducir la contaminación del agua.", "Precisamos reduzir a poluição da água."))
add("скучный / скучать", "aburrido / aburrirse", "entediante / entediado",
    ("Весь день дома мне было очень скучно.", "Estar en casa todo el día me aburrió mucho.", "Ficar em casa o dia todo me deixou entediado."),
    ("Сюжет этого фильма слишком скучный.", "La trama de esta película es demasiado aburrida.", "O enredo deste filme é tedioso demais."))
add("недоразумение / неправильно понять", "malentendido / malinterpretar", "mal-entendido / entender mal",
    ("Извините, это всё недоразумение.", "Perdón, todo esto es un malentendido.", "Desculpe, isso é só um mal-entendido."),
    ("Ясное объяснение устраняет недоразумения.", "Explicar con claridad elimina malentendidos.", "Explicar com clareza elimina mal-entendidos."))
add("помидор", "tomate", "tomate",
    ("Яичница с помидорами — известное китайское блюдо.", "Huevos revueltos con tomate es un plato chino famoso.", "Ovos mexidos com tomate é um prato chinês famoso."),
    ("Свежие помидоры богаты витаминами.", "Los tomates frescos son ricos en vitaminas.", "Tomates frescos são ricos em vitaminas."))
add("привлекать", "atraer", "atrair",
    ("Красивые виды привлекли много туристов.", "El paisaje hermoso atrajo a muchos turistas.", "A paisagem bonita atraiu muitos turistas."),
    ("Сюжет этой истории очень увлекательный.", "La trama de esta historia es muy atractiva.", "O enredo desta história é muito atraente."))
add("солёный", "salado", "salgado",
    ("Положили слишком много соли — блюдо пересолено.", "Pusieron mucha sal, el plato está demasiado salado.", "Colocaram sal demais, o prato ficou muito salgado."),
    ("Я не люблю слишком солёное.", "No me gusta la comida demasiado salada.", "Não gosto de comida muito salgada."))
add("наличные", "efectivo", "dinheiro vivo",
    ("Вы платите наличными или картой?", "¿Paga en efectivo o con tarjeta?", "O pagamento é em dinheiro ou no cartão?"),
    ("В кармане только немного наличных.", "Solo llevo un poco de efectivo.", "Só tenho um pouco de dinheiro no bolso."))
add("завидовать / восхищаться", "envidiar / admirar", "invejar / admirar",
    ("Я очень завидую, что он может учиться за границей.", "Envidio que pueda estudiar en el extranjero.", "Tenho inveja de ele poder estudar no exterior."),
    ("Их счастливая жизнь вызывает восхищение.", "Su vida feliz despierta admiración.", "A vida feliz deles causa admiração."))
add("наоборот / противоположный", "al contrario / opuesto", "ao contrário / oposto",
    ("События пошли в прямо противоположную сторону.", "El rumbo de los hechos fue exactamente el opuesto.", "O rumo dos acontecimentos foi exatamente o oposto."),
    ("Я не устал, наоборот, полон сил.", "No solo no estoy cansado, al contrario, tengo mucha energía.", "Não estou cansado; ao contrário, estou cheio de energia."))
add("подробный / подробно", "detallado / en detalle", "detalhado / em detalhe",
    ("Пожалуйста, подробно объясните причины.", "Explique las razones en detalle.", "Explique os motivos em detalhe."),
    ("Это очень подробный рабочий план.", "Este es un plan de trabajo muy detallado.", "Este é um plano de trabalho bem detalhado."))
add("эффект / результат", "efecto / resultado", "efeito / resultado",
    ("Это новое лекарство хорошо помогает от простуды.", "Este medicamento nuevo funciona muy bien contra el resfriado.", "Este remédio novo funciona muito bem para resfriado."),
    ("После практики результат выступления сильно улучшился.", "Tras practicar, el resultado del discurso mejoró mucho.", "Depois de treinar, o resultado da fala melhorou muito."))
add("настроение", "ánimo / estado de ánimo", "humor / estado de espírito",
    ("Сегодня солнечно, настроение отличное.", "Hoy hace sol y tengo muy buen ánimo.", "Hoje está ensolarado e meu humor está ótimo."),
    ("Музыка помогает расслабить настроение.", "Escuchar música relaja el ánimo.", "Ouvir música relaxa o humor."))
add("тяжёлый труд / уставать на работе", "esforzado / pasar fatigas", "trabalhoso / dar duro",
    ("Папа очень много работает.", "Papá trabaja muy duro.", "O papai trabalha muito duro."),
    ("Спасибо всем за труд, сегодня отдыхайте пораньше.", "Gracias a todos por el esfuerzo, descansen pronto.", "Obrigado a todos pelo esforço; descansem cedo hoje."))
add("доверие / доверять", "confianza / confiar", "confiança / confiar",
    ("Взаимное доверие — основа сотрудничества.", "La confianza mutua es la base de la cooperación.", "A confiança mútua é a base da cooperação."),
    ("Я очень доверяю его профессионализму.", "Confío mucho en su capacidad de trabajo.", "Confio muito na capacidade de trabalho dele."))
add("уверенность", "confianza / fe", "confiança / convicção",
    ("Мы должны быть уверены в будущем.", "Debemos estar llenos de confianza en el futuro.", "Precisamos ter confiança no futuro."),
    ("После практики у него прибавилось уверенности перед экзаменом.", "Tras practicar, ganó confianza para el examen.", "Depois de treinar, ele ganhou confiança para a prova."))
add("возбуждённый / радостное волнение", "emocionado / emoción", "empolgado / empolgação",
    ("Услышав новость о победе, все очень обрадовались.", "Al oír la noticia de la victoria, todos se emocionaron.", "Ao ouvir a notícia da vitória, todos ficaram empolgados."),
    ("Ребёнок так возбудился, что не мог уснуть.", "El niño estaba demasiado emocionado para dormir.", "A criança estava empolgada demais para dormir."))
add("чинить / ремонтировать", "reparar / arreglar", "consertar / reparar",
    ("Велосипед сломался, его нужно починить.", "Mi bicicleta está rota y hay que repararla.", "Minha bicicleta quebrou e precisa de conserto."),
    ("Мастер сейчас чинит компьютер.", "El técnico está reparando el ordenador.", "O técnico está consertando o computador."))
add("давление / стресс", "presión / estrés", "pressão / estresse",
    ("Перед экзаменами студенты испытывают большой стресс.", "Ante los exámenes, los estudiantes sienten mucho estrés.", "Perto das provas, os alunos sentem muito estresse."),
    ("Нужно учиться снимать рабочее давление.", "Aprenda a aliviar la presión laboral.", "É preciso aprender a aliviar a pressão do trabalho."))
add("зубная паста", "pasta de dientes", "creme dental",
    ("Паста закончилась, куплю новую.", "Se acabó la pasta, iré a comprar una caja nueva.", "O creme dental acabou; vou comprar outro."),
    ("При чистке зубов выдавите немного пасты.", "Al cepillarse, ponga un poco de pasta.", "Na hora de escovar, coloque um pouco de creme."))

assert len(ROWS) == 49, len(ROWS)
Path("/tmp/hsk1_part1.json").write_text(json.dumps(ROWS, ensure_ascii=False), encoding="utf-8")
print("part1", len(ROWS))