#!/usr/bin/env python3
"""Daily life study-set translations (100 words)."""
from __future__ import annotations
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
from sidecar_lib import apply_rows

ROWS = []


def add(ru, es, pt, *examples):
    ROWS.append((ru, es, pt, examples))


add("доброе утро", "buenos días", "bom dia",
    ("Доброе утро, сегодня хорошая погода.", "Buenos días, hoy hace buen tiempo.", "Bom dia, hoje o tempo está bom."),
    ("Каждое утро она здоровается с соседями.", "Cada mañana saluda a los vecinos.", "Toda manhã ela cumprimenta os vizinhos."))
add("добрый вечер", "buenas tardes / buenas noches", "boa noite / boa tarde",
    ("Добрый вечер, добро пожаловать.", "Buenas noches, bienvenido.", "Boa noite, seja bem-vindo."),
    ("Добрый вечер, вы уже ели?", "Buenas noches, ¿ya comiste?", "Boa noite, você já comeu?"))
add("до свидания", "adiós / hasta luego", "tchau / até logo",
    ("До свидания, до завтра.", "Adiós, hasta mañana.", "Tchau, até amanhã."),
    ("Я пойду, до свидания.", "Me voy, adiós.", "Vou embora, tchau."))
add("прошу вашей благосклонности / будем на связи", "cuídeme / encantado de conocernos", "conte comigo / prazer em conhecer",
    ("Я здесь новенький, прошу вашей поддержки.", "Soy nuevo aquí, cuídenme por favor.", "Sou novo aqui, contem comigo."),
    ("В дальнейшем прошу вашей поддержки.", "En el futuro, cuídenme.", "Daí pra frente, contem comigo."))
add("давно наслышан / рад знакомству", "mucho gusto / he oído hablar de usted", "prazer / já ouvi falar de você",
    ("Давно наслышан о вашей славе.", "He oído hablar mucho de usted.", "Já ouvi muito falar de você."),
    ("Давно наслышан, наконец встретились.", "Mucho gusto, por fin nos vemos.", "Prazer, finalmente nos encontramos."))
add("как дела в последнее время", "¿cómo te ha ido últimamente?", "como você tem estado?",
    ("Как дела в последнее время?", "¿Cómo te ha ido últimamente?", "Como você tem estado?"),
    ("Давно не виделись, как ты?", "Cuánto tiempo, ¿cómo has estado?", "Há quanto tempo, como você tem estado?"))
add("добро пожаловать / приветствовать", "bienvenido / dar la bienvenida", "bem-vindo / dar as boas-vindas",
    ("Добро пожаловать в Пекин.", "Bienvenido a Pekín.", "Bem-vindo a Pequim."),
    ("Приглашаем всех принять участие.", "Bienvenidos todos a participar.", "Sejam bem-vindos a participar."))
add("поздравлять", "felicitar / enhorabuena", "parabéns / parabenizar",
    ("Поздравляю с повышением.", "Felicidades por tu ascenso.", "Parabéns pela promoção."),
    ("Поздравляю с богатством!", "¡Gong Xi Fa Cai!", "Gong Xi Fa Cai!"))
add("с праздником", "felices fiestas", "boas festas",
    ("С праздником!", "Felices fiestas.", "Boas festas."),
    ("С праздником и счастья вашей семье.", "Felices fiestas y felicidad para tu familia.", "Boas festas e felicidade para a família."))
add("счастливо / осторожно в пути", "que te vaya bien / cuídate", "vai com cuidado / se cuida",
    ("Спасибо, счастливо.", "Gracias, cuídate.", "Obrigado, se cuida."),
    ("Уже темно, осторожно в пути.", "Ya oscureció, ve con cuidado.", "Já escureceu, vai com cuidado."))
add("папа / отец", "papá / padre", "papai / pai",
    ("Мой папа — врач.", "Mi papá es médico.", "Meu pai é médico."),
    ("Папа сегодня задерживается на работе.", "Papá hace horas extra hoy.", "O papai está fazendo hora extra hoje."))
add("мама / мать", "mamá / madre", "mamãe / mãe",
    ("Мамина еда самая вкусная.", "La comida de mamá es la mejor.", "A comida da mamãe é a melhor."),
    ("Я купил маме подарок.", "Le compré un regalo a mamá.", "Comprei um presente para a mamãe."))
add("ребёнок / дети", "hijo / niño", "filho / criança",
    ("У них двое детей.", "Tienen dos hijos.", "Eles têm dois filhos."),
    ("Ребёнок играет в гостиной.", "El niño está jugando en el salón.", "A criança está brincando na sala."))
add("дедушка (по отцу)", "abuelo paterno", "avô paterno / vovô",
    ("Дедушке в этом году семьдесят.", "El abuelo cumple setenta este año.", "O vovô faz setenta este ano."),
    ("На выходных я навещу дедушку.", "El fin de semana voy a ver al abuelo.", "No fim de semana vou ver o vovô."))
add("бабушка (по отцу)", "abuela paterna", "avó paterna / vovó",
    ("У бабушки крепкое здоровье.", "La abuela está muy sana.", "A vovó está com a saúde boa."),
    ("Бабушка готовит на кухне.", "La abuela está cocinando.", "A vovó está cozinhando na cozinha."))
add("старший брат", "hermano mayor", "irmão mais velho",
    ("Мой старший брат учится в университете.", "Mi hermano mayor estudia en la universidad.", "Meu irmão mais velho estuda na universidade."),
    ("Брат старше меня на три года.", "Mi hermano es tres años mayor que yo.", "Meu irmão é três anos mais velho do que eu."))
add("старшая сестра", "hermana mayor", "irmã mais velha",
    ("Старшая сестра работает в Шанхае.", "Mi hermana mayor trabaja en Shanghái.", "Minha irmã mais velha trabalha em Xangai."),
    ("Сестра учит меня английскому.", "Mi hermana me enseña inglés.", "Minha irmã me ensina inglês."))
add("муж", "esposo / marido", "marido / esposo",
    ("Мой муж — инженер.", "Mi esposo es ingeniero.", "Meu marido é engenheiro."),
    ("Муж дома с детьми.", "Mi esposo está en casa con los niños.", "Meu marido está em casa com as crianças."))
add("жена", "esposa", "esposa",
    ("Его жена — учительница.", "Su esposa es profesora.", "A esposa dele é professora."),
    ("Мы с женой едем путешествовать.", "Mi esposa y yo viajamos juntos.", "Eu e minha esposa vamos viajar."))
add("родственники", "parientes / familiares", "parentes / familiares",
    ("На Чуньцзе съезжаются все родственники.", "En el Año Nuevo vienen todos los parientes.", "No Ano Novo Chinês vêm todos os parentes."),
    ("Он мой дальний родственник.", "Es un pariente lejano mío.", "Ele é um parente distante meu."))
add("гостиная", "salón / sala de estar", "sala de estar",
    ("Все смотрят телевизор в гостиной.", "Todos ven la tele en el salón.", "Todo mundo assiste TV na sala."),
    ("Гостиная просторная.", "El salón es amplio.", "A sala é espaçosa."))
add("спальня", "dormitorio / habitación", "quarto",
    ("Моя спальня на втором этаже.", "Mi dormitorio está en el segundo piso.", "Meu quarto fica no segundo andar."),
    ("Держите спальню в порядке.", "Mantenga el dormitorio ordenado.", "Mantenha o quarto arrumado."))
add("кухня", "cocina", "cozinha",
    ("На кухне новая техника.", "Hay electrodomésticos nuevos en la cocina.", "Tem eletrodomésticos novos na cozinha."),
    ("Она готовит ужин на кухне.", "Está preparando la cena en la cocina.", "Ela está fazendo o jantar na cozinha."))
add("ванная / туалет", "baño", "banheiro",
    ("Пользуйтесь ванной внутри.", "Use el baño de adentro.", "Use o banheiro de dentro."),
    ("Ванную нужно убрать.", "El baño necesita limpieza.", "O banheiro precisa de limpeza."))
add("балкон", "balcón", "varanda / sacada",
    ("На балконе посадили цветы.", "Hay flores plantadas en el balcón.", "Tem flores plantadas na varanda."),
    ("Сушите бельё на балконе.", "Tender la ropa en el balcón.", "Pendure a roupa na varanda."))
add("ключ", "llave", "chave",
    ("Я забыл ключи.", "Olvidé las llaves.", "Esqueci as chaves."),
    ("Оставьте ключи у двери.", "Deje las llaves en la puerta.", "Deixe as chaves na porta."))
add("убирать / чистить", "limpiar", "limpar",
    ("Сегодня я буду убирать комнату.", "Hoy voy a limpiar la habitación.", "Hoje vou limpar o quarto."),
    ("Мы убираемся каждую субботу.", "Limpiamos todos los sábados.", "Limpamos todo sábado."))
add("чинить / ремонтировать", "reparar / arreglar", "consertar / reparar",
    ("Кондиционер нужно починить.", "Hay que reparar el aire acondicionado.", "O ar-condicionado precisa de conserto."),
    ("Он починил мне кран.", "Me arregló el grifo.", "Ele consertou a torneira para mim."))
add("сосед", "vecino", "vizinho",
    ("Мои соседи очень дружелюбные.", "Mis vecinos son muy amables.", "Meus vizinhos são muito simpáticos."),
    ("Сосед одолжил мне зонт.", "El vecino me prestó un paraguas.", "O vizinho me emprestou um guarda-chuva."))
add("аренда / квартплата", "alquiler / renta", "aluguel",
    ("Аренда — три тысячи в месяц.", "El alquiler es de tres mil al mes.", "O aluguel é três mil por mês."),
    ("Пора платить за квартиру.", "Es hora de pagar el alquiler.", "Está na hora de pagar o aluguel."))
add("супермаркет", "supermercado", "supermercado",
    ("Иду в супермаркет за продуктами.", "Voy al supermercado a comprar comida.", "Vou ao supermercado comprar comida."),
    ("Этот супермаркет очень большой.", "Este supermercado es enorme.", "Este supermercado é enorme."))
add("тележка", "carrito de compra", "carrinho de compras",
    ("Возьмите тележку.", "Tome un carrito, por favor.", "Pegue um carrinho, por favor."),
    ("Тележка полная.", "El carrito está lleno.", "O carrinho está cheio."))
add("скидка / распродажа", "descuento / oferta", "desconto / promoção",
    ("Эта одежда со скидкой.", "Esta prenda está en oferta.", "Esta roupa está em promoção."),
    ("Сегодня скидка 20% на всё.", "Hoy todo está al 80%.", "Hoje tudo está com 20% de desconto."))
add("стоять в очереди", "hacer cola / hacer fila", "ficar na fila",
    ("На кассе очередь.", "Hay cola en la caja.", "Tem fila no caixa."),
    ("Встаньте в очередь здесь.", "Haga cola aquí, por favor.", "Fique na fila aqui, por favor."))
add("взвешивать", "pesar", "pesar",
    ("Взвесьте на стойке.", "Péselo en el mostrador.", "Pese no balcão."),
    ("Фрукты нужно сначала взвесить.", "La fruta hay que pesarla primero.", "A fruta precisa ser pesada primeiro."))
add("срок годности", "fecha de caducidad", "data de validade",
    ("Посмотрите срок годности.", "Mire la fecha de caducidad.", "Olhe a data de validade."),
    ("У этого молока истёк срок.", "Esta leche está caducada.", "Este leite está vencido."))
add("возврат товара", "devolver un producto", "devolver produto",
    ("Можно вернуть товар?", "¿Puedo devolver este artículo?", "Posso devolver este produto?"),
    ("В течение семи дней можно вернуть.", "Se puede devolver en siete días.", "Dá para devolver em sete dias."))
add("член / карта лояльности", "socio / membresía", "membro / clube de fidelidade",
    ("С картой лояльности копятся баллы.", "Los socios acumulan puntos.", "Membros acumulam pontos."),
    ("Предъявите карту члена.", "Muestre su tarjeta de socio.", "Mostre o cartão de membro."))
add("мелочь / сдача", "cambio menudo", "troco / miúdo",
    ("Есть мелочь?", "¿Tienes cambio menudo?", "Você tem troco?"),
    ("Я разменял мелочь.", "Cambié un poco de menudo.", "Troquei um pouco de miúdo."))
add("пакет для покупок", "bolsa de compra", "sacola de compras",
    ("Нужен пакет?", "¿Necesita una bolsa?", "Precisa de uma sacola?"),
    ("Я принёс свой пакет.", "Traje mi propia bolsa.", "Trouxe minha própria sacola."))
add("ясный день / солнечно", "día soleado", "dia de sol",
    ("Сегодня солнечно.", "Hoy está soleado.", "Hoje está um dia de sol."),
    ("В ясный день хорошо гулять.", "Los días soleados son buenos para salir.", "Dia de sol é bom para sair."))
add("идти дождь", "llover", "chover",
    ("На улице дождь.", "Está lloviendo afuera.", "Está chovendo lá fora."),
    ("Днём может пойти дождь.", "Por la tarde puede llover.", "À tarde pode chover."))
add("идти снег", "nevar", "nevar",
    ("На севере идёт снег.", "Está nevando en el norte.", "Está nevando no norte."),
    ("Дети любят снег.", "A los niños les encanta que nieve.", "Crianças adoram neve."))
add("ветрено / дуть (о ветре)", "hacer viento / ventoso", "ventar / ventania",
    ("Сегодня сильный ветер.", "Hoy hace mucho viento.", "Hoje está ventando muito."),
    ("Не выходи, на улице ветрено.", "No salgas, afuera hace viento.", "Não saia, está ventando lá fora."))
add("температура", "temperatura", "temperatura",
    ("Сегодня высокая температура.", "Hoy la temperatura es alta.", "Hoje a temperatura está alta."),
    ("Посмотрите температуру.", "Mire la temperatura.", "Olhe a temperatura."))
add("прогноз", "pronóstico", "previsão",
    ("По прогнозу похолодает.", "El pronóstico dice que va a enfriar.", "A previsão diz que vai esfriar."),
    ("Послушайте прогноз погоды.", "Escuche el pronóstico del tiempo.", "Ouça a previsão do tempo."))
add("влажный / сырой", "húmedo", "úmido",
    ("На юге летом очень влажно.", "En el sur los veranos son húmedos.", "No sul o verão é úmido."),
    ("В комнате немного сыро.", "La habitación está un poco húmeda.", "O quarto está um pouco úmido."))
add("сухой", "seco", "seco",
    ("Осенью погода сухая.", "En otoño el tiempo es seco.", "No outono o tempo é seco."),
    ("На севере зимой очень сухо.", "En el norte el invierno es muy seco.", "No norte o inverno é muito seco."))
add("пасмурно", "nublado / cubierto", "nublado / encoberto",
    ("Сегодня пасмурно.", "Hoy está nublado.", "Hoje está nublado."),
    ("В пасмурный день людей меньше.", "Los días nublados hay menos gente.", "Em dia nublado tem menos gente."))
add("тайфун", "tifón", "tufão",
    ("Приближается тайфун.", "Se acerca un tifón.", "Um tufão está chegando."),
    ("В тайфун на улицу не выходите.", "No salga durante un tifón.", "Não saia durante um tufão."))
add("сейчас / теперь", "ahora", "agora",
    ("Который сейчас час?", "¿Qué hora es ahora?", "Que horas são agora?"),
    ("Я сейчас очень занят.", "Ahora estoy muy ocupado.", "Agora estou muito ocupado."))
add("сегодня", "hoy", "hoje",
    ("Сегодня понедельник.", "Hoy es lunes.", "Hoje é segunda-feira."),
    ("Сегодня я свободен.", "Hoy estoy libre.", "Hoje estou livre."))
add("завтра", "mañana", "amanhã",
    ("До завтра.", "Hasta mañana.", "Até amanhã."),
    ("Завтра нужно рано встать.", "Mañana hay que madrugar.", "Amanhã preciso acordar cedo."))
add("вчера", "ayer", "ontem",
    ("Вчера я ездил в Пекин.", "Ayer fui a Pekín.", "Ontem eu fui a Pequim."),
    ("Вчера шёл дождь.", "Ayer llovió.", "Ontem choveu."))
add("выходные", "fin de semana", "fim de semana",
    ("Что ты делаешь на выходных?", "¿Qué haces el fin de semana?", "O que você faz no fim de semana?"),
    ("На выходных идём в горы.", "El fin de semana vamos a hacer senderismo.", "No fim de semana vamos fazer trilha."))
add("минута", "minuto", "minuto",
    ("Подождите меня пять минут.", "Espéreme cinco minutos.", "Espere cinco minutos."),
    ("До начала ещё десять минут.", "Empieza en diez minutos.", "Começa em dez minutos."))
add("час", "hora", "hora",
    ("Я спал час.", "Dormí una hora.", "Dormi uma hora."),
    ("На машине нужно два часа.", "En coche se tardan dos horas.", "De carro leva duas horas."))
add("вовремя / пунктуально", "a tiempo / puntual", "no horário / pontual",
    ("Приходите вовремя.", "Llegue a tiempo, por favor.", "Chegue no horário, por favor."),
    ("Поезд отправился вовремя.", "El tren salió puntual.", "O trem partiu no horário."))
add("календарь", "calendario", "calendário",
    ("Посмотрите календарь.", "Mire el calendario.", "Olhe o calendário."),
    ("На календаре отмечены праздники.", "Los festivos están marcados en el calendario.", "Os feriados estão marcados no calendário."))
add("день рождения", "cumpleaños", "aniversário",
    ("Сегодня мой день рождения.", "Hoy es mi cumpleaños.", "Hoje é o meu aniversário."),
    ("С днём рождения!", "¡Feliz cumpleaños!", "Feliz aniversário!"))
add("радостный / рад", "contento / alegre", "feliz / contente",
    ("Я очень рад этой новости.", "Me alegra oír esta noticia.", "Fico feliz com esta notícia."),
    ("Сегодня у меня хорошее настроение.", "Hoy estoy de buen humor.", "Hoje estou de bom humor."))
add("грустный / тяжело", "triste", "triste",
    ("Он выглядит очень грустным.", "Se le ve muy triste.", "Ele parece muito triste."),
    ("Не грусти, всё наладится.", "No estés triste, las cosas mejorarán.", "Não fique triste, as coisas vão melhorar."))
add("злиться", "enfadarse / enojarse", "ficar bravo",
    ("Пожалуйста, не злись.", "Por favor, no te enfades.", "Por favor, não fique bravo."),
    ("Он зол из-за результата.", "Está enfadado con el resultado.", "Ele está bravo com o resultado."))
add("беспокоиться", "preocuparse", "se preocupar",
    ("Не волнуйся, я рядом.", "No te preocupes, estoy aquí.", "Não se preocupe, eu estou aqui."),
    ("Мама очень за тебя переживает.", "Mamá está muy preocupada por ti.", "A mamãe está muito preocupada com você."))
add("нервничать / напряжённый", "nervioso / tenso", "nervoso / tenso",
    ("Перед экзаменом я очень нервничаю.", "Antes del examen estoy muy nervioso.", "Antes da prova fico muito nervoso."),
    ("Не нервничай, не торопись.", "No te pongas nervioso, con calma.", "Não fique nervoso, com calma."))
add("расслабляться", "relajarse", "relaxar",
    ("На выходных хорошенько отдохни.", "Relájate bien el fin de semana.", "Relaxe bem no fim de semana."),
    ("Музыка помогает расслабиться.", "Escuchar música ayuda a relajarse.", "Ouvir música ajuda a relaxar."))
add("быть тронутым / растрогаться", "emocionarse / conmoverse", "se emocionar / se comover",
    ("Эта история очень трогательная.", "Esta historia es muy conmovedora.", "Esta história é muito emocionante."),
    ("Его помощь меня тронула.", "Me conmovió su ayuda.", "A ajuda dele me emocionou."))
add("скучный / скучать (от безделья)", "aburrido", "entediante / entediado",
    ("Дома так скучно.", "Estar en casa es tan aburrido.", "Ficar em casa é tão entediante."),
    ("Этот фильм скучный.", "Esta película es aburrida.", "Este filme é entediante."))
add("в восторге / возбуждённый", "emocionado / entusiasmado", "empolgado / animado",
    ("Дети в восторге.", "Los niños están emocionados.", "As crianças estão empolgadas."),
    ("Я в предвкушении поездки.", "Estoy emocionado por el viaje.", "Estou empolgado com a viagem."))
add("удовлетворённый / довольный", "satisfecho / contento", "satisfeito / realizado",
    ("Я доволен результатом.", "Estoy satisfecho con el resultado.", "Estou satisfeito com o resultado."),
    ("Простая жизнь тоже может давать удовлетворение.", "Una vida sencilla también puede ser plena.", "Uma vida simples também pode ser plena."))
add("одежда", "ropa", "roupa",
    ("Эта одежда очень красивая.", "Esta ropa está muy bonita.", "Esta roupa está muito bonita."),
    ("Я стираю одежду.", "Estoy lavando la ropa.", "Estou lavando a roupa."))
add("брюки", "pantalones", "calça",
    ("Эти брюки слишком длинные.", "Estos pantalones son demasiado largos.", "Esta calça está longa demais."),
    ("Он купил новые брюки.", "Compró unos pantalones nuevos.", "Ele comprou uma calça nova."))
add("обувь", "zapatos", "sapato",
    ("Эта обувь очень удобная.", "Estos zapatos son muy cómodos.", "Este sapato é muito confortável."),
    ("Моя обувь испачкалась.", "Se me ensuciaron los zapatos.", "Meu sapato ficou sujo."))
add("куртка / пальто", "chaqueta / abrigo", "jaqueta / casaco",
    ("На улице холодно, надень куртку.", "Hace frío, ponte la chaqueta.", "Está frio, vista a jaqueta."),
    ("Я забыл куртку в ресторане.", "Olvidé la chaqueta en el restaurante.", "Esqueci a jaqueta no restaurante."))
add("размер", "talla / talla de ropa", "tamanho",
    ("Есть размер побольше?", "¿Tienen una talla más grande?", "Tem um tamanho maior?"),
    ("Размер как раз.", "La talla queda perfecta.", "O tamanho está perfeito."))
add("примерять", "probarse", "provar",
    ("Можно примерить?", "¿Puedo probármelo?", "Posso provar?"),
    ("Примерьте в примерочной.", "Pruébeselo en el probador.", "Prove no provador."))
add("стирка / сдавать в стирку", "lavandería / lavar la ropa", "lavanderia / lavar roupa",
    ("Я отдал одежду в стирку.", "Llevé la ropa a la lavandería.", "Levei a roupa para a lavanderia."),
    ("Прачечная внизу.", "La tintorería está abajo.", "A lavanderia fica embaixo."))
add("шапка / шляпа", "gorro / sombrero", "boné / chapéu",
    ("Летом нужно носить шляпу.", "En verano hay que llevar sombrero.", "No verão é preciso usar chapéu."),
    ("Его шапка синяя.", "Su gorro es azul.", "O boné dele é azul."))
add("шарф", "bufanda", "cachecol / echarpe",
    ("Зимой шарф необходим.", "En invierno la bufanda es esencial.", "No inverno o cachecol é essencial."),
    ("Она подарила мне шарф.", "Me regaló una bufanda.", "Ela me deu um cachecol."))
add("сочетать / подбирать (одежду)", "combinar / coordinar", "combinar / combinar look",
    ("Этот комплект очень хорошо смотрится.", "Este conjunto queda muy bien.", "Esse look ficou muito bom."),
    ("Чёрный легко сочетать.", "El negro combina fácil.", "O preto combina fácil."))
add("здоровье / здоровый", "salud / sano", "saúde / saudável",
    ("Здоровье важнее всего.", "La salud es lo más importante.", "A saúde é o mais importante."),
    ("Он очень здоров.", "Está muy sano.", "Ele está com a saúde ótima."))
add("простуда / простудиться", "resfriado / resfriarse", "resfriado / pegar resfriado",
    ("Я простудился.", "Me resfrié.", "Peguei um resfriado."),
    ("Пейте больше воды, не простудитесь.", "Beba más agua para no resfriarte.", "Beba mais água para não pegar resfriado."))
add("температура / жар", "fiebre", "febre",
    ("У ребёнка температура.", "El niño tiene fiebre.", "A criança está com febre."),
    ("У меня 38 градусов.", "Tengo 38 de fiebre.", "Estou com 38 de febre."))
add("головная боль", "dolor de cabeza", "dor de cabeça",
    ("У меня сильная головная боль.", "Tengo un dolor de cabeza fuerte.", "Estou com uma dor de cabeça forte."),
    ("Из-за бессонницы болит голова.", "Trasnochar da dolor de cabeza.", "Virar a noite dá dor de cabeça."))
add("тренироваться / заниматься спортом", "hacer ejercicio", "fazer exercício",
    ("Каждый день я занимаюсь полчаса.", "Hago ejercicio media hora al día.", "Faço exercício meia hora por dia."),
    ("Спорт полезен для здоровья.", "El ejercicio es bueno para el cuerpo.", "Exercício faz bem ao corpo."))
add("отдыхать", "descansar", "descansar",
    ("Тебе нужно хорошо отдохнуть.", "Necesitas descansar bien.", "Você precisa descansar bem."),
    ("На выходных я отдыхаю дома.", "El fin de semana descanso en casa.", "No fim de semana descanso em casa."))
add("лекарство", "medicina / medicamento", "remédio / medicamento",
    ("Принимайте лекарство вовремя.", "Tome el medicamento a tiempo.", "Tome o remédio na hora."),
    ("Это лекарство очень помогает.", "Esta medicina es muy eficaz.", "Este remédio é muito eficaz."))
add("запись / записываться (к врачу)", "cita / reservar", "consulta / agendar",
    ("Я записался к врачу.", "Pedí cita con el médico.", "Marquei consulta com o médico."),
    ("Запишитесь на медосмотр заранее.", "Reserve el chequeo con antelación.", "Agende o check-up com antecedência."))
add("аллергия", "alergia", "alergia",
    ("У меня аллергия на морепродукты.", "Soy alérgico al marisco.", "Tenho alergia a frutos do mar."),
    ("Весной часто бывает аллергия.", "En primavera son comunes las alergias.", "Na primavera alergia é comum."))
add("сон", "sueño / dormir", "sono / dormir",
    ("Сон очень важен.", "Dormir es muy importante.", "O sono é muito importante."),
    ("Прошлой ночью я плохо спал.", "Anoche no dormí bien.", "Ontem à noite eu não dormi bem."))
add("друг", "amigo", "amigo",
    ("Он мой хороший друг.", "Es un buen amigo mío.", "Ele é um bom amigo meu."),
    ("На выходных встречаюсь с друзьями.", "El fin de semana quedo con amigos.", "No fim de semana encontro os amigos."))
add("встреча / вечеринка / сбор", "quedada / fiesta / reunión", "encontro / festa / reunião",
    ("Сегодня вечером будет встреча.", "Esta noche hay una reunión.", "Hoje à noite tem um encontro."),
    ("Встреча одноклассников была весёлой.", "La reunión de compañeros fue muy divertida.", "O reencontro da turma foi muito divertido."))
add("приглашать", "invitar", "convidar",
    ("Приглашаю тебя ко мне домой.", "Te invito a mi casa.", "Te convido para a minha casa."),
    ("Спасибо за приглашение.", "Gracias por la invitación.", "Obrigado pelo convite."))
add("болтать / общаться", "charlar", "conversar / bater papo",
    ("Мы болтаем в интернете.", "Charlamos por internet.", "A gente conversa pela internet."),
    ("Люблю болтать с друзьями.", "Me gusta charlar con amigos.", "Gosto de bater papo com os amigos."))
add("хобби / увлечение", "afición / hobby", "hobby / passatempo",
    ("Какие у тебя увлечения?", "¿Cuáles son tus aficiones?", "Quais são os seus hobbies?"),
    ("Моё хобби — фотография.", "Mi afición es la fotografía.", "Meu hobby é fotografia."))
add("свидание / встреча", "cita / quedada", "encontro / date",
    ("У них сегодня вечером свидание.", "Esta noche tienen una cita.", "Eles têm um encontro hoje à noite."),
    ("Я договорился с другом выпить кофе.", "Quedé con un amigo para tomar café.", "Marquei de tomar café com um amigo."))
add("представлять / знакомить", "presentar", "apresentar",
    ("Представьтесь, пожалуйста.", "Preséntese, por favor.", "Apresente-se, por favor."),
    ("Познакомлю вас.", "Os presento.", "Vou apresentar vocês."))
add("подарок", "regalo", "presente",
    ("Это тебе подарок.", "Este es un regalo para ti.", "Este é um presente para você."),
    ("Спасибо за подарок.", "Gracias por el regalo.", "Obrigado pelo presente."))
add("пожелания / благословение", "deseos / felicitación", "votos / bênção / desejos",
    ("Поздравляю со свадьбой.", "Mis mejores deseos para vuestra boda.", "Meus votos para o casamento de vocês."),
    ("Получил много пожеланий.", "Recibí muchos buenos deseos.", "Recebi muitos votos de felicidade."))
add("общение / светская жизнь", "vida social / socializar", "vida social / socializar",
    ("Я не очень люблю светские мероприятия.", "No me gusta mucho socializar.", "Não gosto muito de socializar."),
    ("Навыки общения очень важны.", "Las habilidades sociales son importantes.", "Habilidade social é importante."))

apply_rows("daily_life", ROWS)
print("daily_life rows", len(ROWS))
