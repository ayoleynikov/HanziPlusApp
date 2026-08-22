#!/usr/bin/env python3
"""Travel study-set translations (100 words)."""
from __future__ import annotations
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
from sidecar_lib import apply_rows

ROWS = []


def add(ru, es, pt, *examples):
    ROWS.append((ru, es, pt, examples))


add("привет / здравствуйте", "hola", "olá / oi",
    ("Здравствуйте, я турист.", "Hola, soy turista.", "Olá, sou turista."),
    ("Здравствуйте, как пройти сюда?", "Hola, ¿cómo llego aquí?", "Olá, como chego aqui?"))
add("спасибо", "gracias", "obrigado / obrigada",
    ("Спасибо за помощь.", "Gracias por tu ayuda.", "Obrigado pela ajuda."),
    ("Большое спасибо!", "¡Muchísimas gracias!", "Muito obrigado!"))
add("извините / простите", "perdón / lo siento", "desculpe / com licença",
    ("Извините, я опоздал.", "Perdón, llegué tarde.", "Desculpe, cheguei atrasado."),
    ("Извините, можно вас на минутку.", "Perdón, siento molestarlo.", "Com licença, desculpe incomodar."))
add("скажите, пожалуйста", "disculpe / por favor", "com licença / por favor",
    ("Скажите, пожалуйста, где туалет?", "Disculpe, ¿dónde está el baño?", "Com licença, onde fica o banheiro?"),
    ("Скажите, вы говорите по-английски?", "Disculpe, ¿habla inglés?", "Com licença, você fala inglês?"))
add("не умею / не могу", "no saber / no poder", "não saber / não conseguir",
    ("Я не говорю по-китайски.", "No hablo chino.", "Não falo chinês."),
    ("Я не умею пользоваться этим приложением.", "No sé usar esta app.", "Não sei usar este app."))
add("не понимаю (на слух)", "no entiendo (lo hablado)", "não entendo (falado)",
    ("Извините, я не понимаю.", "Perdón, no entiendo.", "Desculpe, não entendo."),
    ("Говорите помедленнее, я не понимаю.", "Hable más despacio, no entiendo.", "Fale mais devagar, não entendo."))
add("китайский язык", "chino (idioma)", "chinês (idioma)",
    ("Вы говорите по-китайски?", "¿Habla chino?", "Você fala chinês?"),
    ("Я учу китайский.", "Estoy aprendiendo chino.", "Estou aprendendo chinês."))
add("английский язык", "inglés", "inglês",
    ("Скажите это, пожалуйста, по-английски.", "Dígalo en inglés, por favor.", "Diga em inglês, por favor."),
    ("Есть меню на английском?", "¿Hay menú en inglés?", "Tem cardápio em inglês?"))
add("карта", "mapa", "mapa",
    ("Можно воспользоваться картой?", "¿Puedo usar un mapa?", "Posso usar um mapa?"),
    ("Посмотрю на карте.", "Lo miro en el mapa.", "Vou olhar no mapa."))
add("туалет / уборная", "baño / aseos", "banheiro",
    ("Где туалет?", "¿Dónde está el baño?", "Onde fica o banheiro?"),
    ("Есть ли поблизости общественный туалет?", "¿Hay un baño público cerca?", "Tem um banheiro público por perto?"))
add("регистрация (на рейс)", "facturación / check-in", "check-in",
    ("Где стойка регистрации?", "¿Dónde está el mostrador de facturación?", "Onde fica o balcão de check-in?"),
    ("Я уже зарегистрировался онлайн.", "Ya hice el check-in en línea.", "Já fiz o check-in online."))
add("садиться на самолёт / посадка", "embarcar", "embarcar",
    ("Посадка уже началась.", "Ya empezó el embarque.", "O embarque já começou."),
    ("Приготовьтесь к посадке.", "Prepárese para embarcar.", "Prepare-se para embarcar."))
add("паспорт", "pasaporte", "passaporte",
    ("Предъявите, пожалуйста, паспорт.", "Muestre su pasaporte, por favor.", "Mostre o passaporte, por favor."),
    ("Паспорт должен быть действительным.", "El pasaporte debe estar vigente.", "O passaporte precisa estar válido."))
add("досмотр / контроль безопасности", "control de seguridad", "inspeção de segurança",
    ("На досмотре достаньте ноутбук.", "Saque el portátil en el control de seguridad.", "Retire o notebook na inspeção."),
    ("Жидкости через досмотр не пропускают.", "Los líquidos no pasan el control.", "Líquidos não passam na inspeção."))
add("въезд / паспортный контроль", "inmigración / entrada", "imigração / entrada",
    ("Паспортный контроль — сюда.", "Inmigración es por aquí.", "A imigração é por aqui."),
    ("Для въезда нужно заполнить декларацию.", "Para entrar hay que llenar una declaración.", "Para entrar é preciso preencher uma declaração."))
add("выход на посадку", "puerta de embarque", "portão de embarque",
    ("Выход сменили на A12.", "La puerta cambió a A12.", "O portão mudou para A12."),
    ("Как пройти к выходу на посадку?", "¿Cómo llego a la puerta de embarque?", "Como chego ao portão de embarque?"))
add("багаж", "equipaje", "bagagem",
    ("Лента выдачи багажа слева от выхода.", "La cinta de equipaje está a la izquierda de la salida.", "A esteira de bagagem fica à esquerda da saída."),
    ("Мой багаж ещё не вышел.", "Mi equipaje aún no ha salido.", "Minha bagagem ainda não saiu."))
add("таможня", "aduana", "alfândega",
    ("Пройдите таможню по красному коридору.", "Pase por el canal rojo de aduana.", "Passe pelo canal vermelho da alfândega."),
    ("Эти вещи нужно задекларировать.", "Estos artículos hay que declararlos en aduana.", "Estes itens precisam ser declarados na alfândega."))
add("посадочный талон", "tarjeta de embarque", "cartão de embarque",
    ("Предъявите посадочный талон и паспорт.", "Muestre la tarjeta de embarque y el pasaporte.", "Mostre o cartão de embarque e o passaporte."),
    ("Посадочный талон можно отсканировать.", "Puede embarcar escaneando la tarjeta.", "Dá para embarcar escaneando o cartão."))
add("рейс", "vuelo", "voo",
    ("Ваш рейс вылетает вовремя.", "Su vuelo sale a tiempo.", "Seu voo parte no horário."),
    ("В каком терминале этот рейс?", "¿En qué terminal está este vuelo?", "Em qual terminal é este voo?"))
add("бронь / бронирование", "reserva", "reserva",
    ("Я забронировал номер онлайн.", "Reservé una habitación en internet.", "Reservei um quarto pela internet."),
    ("Бронь на имя Smith.", "La reserva está a nombre de Smith.", "A reserva está no nome Smith."))
add("ресепшен / стойка регистрации", "recepción", "recepção",
    ("Ресепшен в холле на первом этаже.", "La recepción está en el vestíbulo de la planta baja.", "A recepção fica no saguão do térreo."),
    ("По вопросам можно обратиться на ресепшен.", "Si tiene dudas, pregunte en recepción.", "Se tiver dúvida, pergunte na recepção."))
add("номер (в отеле)", "habitación", "quarto",
    ("Хочу более тихий номер.", "Quisiera una habitación más silenciosa.", "Quero um quarto mais silencioso."),
    ("В номере есть горячая вода?", "¿Hay agua caliente en la habitación?", "Tem água quente no quarto?"))
add("карточка от номера", "tarjeta de habitación", "cartão do quarto",
    ("Сохраните карточку от номера.", "Guarde bien la tarjeta.", "Guarde bem o cartão do quarto."),
    ("Карточка не открывает дверь.", "La tarjeta no abre la puerta.", "O cartão não abre a porta."))
add("завтрак", "desayuno", "café da manhã",
    ("Завтрак в ресторане на втором этаже.", "El desayuno es en el restaurante del segundo piso.", "O café da manhã é no restaurante do segundo andar."),
    ("Во сколько начинается завтрак?", "¿A qué hora empieza el desayuno?", "A que horas começa o café da manhã?"))
add("лифт", "ascensor / elevador", "elevador",
    ("Лифт там.", "El ascensor está allí.", "O elevador fica ali."),
    ("Возьмите лифт справа.", "Tome el ascensor de la derecha.", "Pegue o elevador da direita."))
add("заселяться / регистрация в отеле", "hacer el check-in", "fazer check-in",
    ("Хочу заселиться.", "Quisiera hacer el check-in.", "Quero fazer o check-in."),
    ("Заселение с двух часов дня.", "El check-in es a las 2 de la tarde.", "O check-in é às 14h."))
add("выселяться / выезд из отеля", "hacer el check-out", "fazer check-out",
    ("Завтра в полдень выезжаю.", "Hago el check-out mañana al mediodía.", "Faço o check-out amanhã ao meio-dia."),
    ("Перед выездом сдайте карточку на ресепшен.", "Devuelva la tarjeta en recepción antes del check-out.", "Devolva o cartão na recepção antes do check-out."))
add("стирка / прачечная", "lavandería", "lavanderia",
    ("В отеле есть услуга стирки?", "¿El hotel tiene servicio de lavandería?", "O hotel tem serviço de lavanderia?"),
    ("Прачечная в цокольном этаже.", "La lavandería está en el sótano.", "A lavanderia fica no subsolo."))
add("отель / гостиница", "hotel", "hotel",
    ("Этот отель очень близко к метро.", "Este hotel está muy cerca del metro.", "Este hotel fica bem perto do metrô."),
    ("Отвезите меня, пожалуйста, в этот отель.", "Lléveme a este hotel, por favor.", "Me leve a este hotel, por favor."))
add("метро", "metro", "metrô",
    ("Где ближайшая станция метро?", "¿Dónde está la estación de metro más cercana?", "Onde fica a estação de metrô mais próxima?"),
    ("Поедем на метро.", "Vamos en metro.", "Vamos de metrô."))
add("вокзал", "estación de tren", "estação de trem",
    ("Вокзал далеко отсюда?", "¿La estación de tren está lejos de aquí?", "A estação de trem fica longe daqui?"),
    ("До вокзала, пожалуйста.", "A la estación de tren, por favor.", "Até a estação de trem, por favor."))
add("скоростной поезд / гао те", "tren de alta velocidad", "trem-bala / trem de alta velocidade",
    ("Я еду в Пекин на скоростном поезде.", "Voy a Pekín en tren de alta velocidad.", "Vou a Pequim de trem-bala."),
    ("Билет на скоростной поезд купили?", "¿Compraste el billete del tren de alta velocidad?", "Você comprou a passagem do trem-bala?"))
add("билет (на поезд/автобус)", "billete / boleto", "passagem",
    ("Где купить билет?", "¿Dónde se compra el billete?", "Onde se compra a passagem?"),
    ("Предъявите, пожалуйста, билет.", "Muestre su billete, por favor.", "Mostre a passagem, por favor."))
add("автобус", "autobús", "ônibus",
    ("Этот автобус идёт в центр?", "¿Este autobús va al centro?", "Este ônibus vai ao centro?"),
    ("Когда следующий автобус?", "¿Cuándo llega el próximo autobús?", "Quando chega o próximo ônibus?"))
add("остановитесь здесь", "párese aquí", "pare aqui",
    ("Водитель, остановитесь здесь.", "Maestro, puede parar aquí.", "Motorista, pode parar aqui."),
    ("Остановитесь у отеля впереди.", "Pare aquí en el hotel de adelante.", "Pare aqui no hotel à frente."))
add("побыстрее", "un poco más rápido", "um pouco mais rápido",
    ("Можно побыстрее? Я спешу.", "¿Puede ir un poco más rápido? Tengo prisa.", "Pode ir um pouco mais rápido? Estou com pressa."),
    ("Пожалуйста, чуть быстрее, спасибо.", "Un poco más rápido, por favor.", "Um pouco mais rápido, por favor."))
add("помедленнее", "un poco más despacio", "um pouco mais devagar",
    ("Помедленнее, мне нехорошо.", "Más despacio, por favor, no me siento bien.", "Mais devagar, por favor, não estou bem."),
    ("Дорога скользкая, езжайте медленнее.", "La carretera está resbaladiza, vaya más despacio.", "A pista está escorregadia, vá mais devagar."))
add("пробка", "atasco / tráfico", "engarrafamento",
    ("Впереди пробка.", "Hay un atasco adelante.", "Tem engarrafamento à frente."),
    ("В час пик очень стоят.", "En hora punta hay mucho tráfico.", "No horário de pico o trânsito está pesado."))
add("такси", "taxi", "táxi",
    ("Вызовите мне, пожалуйста, такси.", "Pida un taxi para mí, por favor.", "Chame um táxi para mim, por favor."),
    ("Стоянка такси за выходом.", "La parada de taxis está fuera de la salida.", "O ponto de táxi fica do lado de fora da saída."))
add("меню", "menú / carta", "cardápio",
    ("Покажите, пожалуйста, меню.", "La carta, por favor.", "O cardápio, por favor."),
    ("Есть меню на английском?", "¿Tienen menú en inglés?", "Tem cardápio em inglês?"))
add("чай", "té", "chá",
    ("Принесите, пожалуйста, чайник горячего чая.", "Una tetera de té caliente, por favor.", "Uma chaleira de chá quente, por favor."),
    ("Здесь чай подают бесплатно.", "Aquí el té es gratis.", "Aqui o chá é de graça."))
add("вода", "agua", "água",
    ("Дайте мне, пожалуйста, тёплой воды.", "Un vaso de agua tibia, por favor.", "Um copo de água morna, por favor."),
    ("Бутилированную или из-под крана?", "¿Agua embotellada o del grifo?", "Água engarrafada ou da torneira?"))
add("рис", "arroz", "arroz",
    ("Ещё одну миску риса, пожалуйста.", "Otro tazón de arroz, por favor.", "Mais uma tigela de arroz, por favor."),
    ("Это блюдо хорошо идёт с рисом.", "Este plato queda muy bien con arroz.", "Este prato combina muito com arroz."))
add("лапша", "fideos / tallarines", "macarrão",
    ("Хочу лапшу с говядиной.", "Quisiera fideos con ternera.", "Quero macarrão com carne."),
    ("Можно лапшу менее острую?", "¿Pueden los fideos ser menos picantes?", "Dá para o macarrão ficar menos picante?"))
add("говядина", "ternera / carne de res", "carne bovina",
    ("Тут есть говядина?", "¿Esto lleva ternera?", "Isso tem carne bovina?"),
    ("Порекомендуйте блюдо с говядиной.", "Recomiende un plato de ternera.", "Recomende um prato de carne."))
add("курица", "pollo", "frango",
    ("Я не ем курицу.", "No como pollo.", "Não como frango."),
    ("Гунбао с курицей — классика.", "El pollo kung pao es un clásico.", "Frango kung pao é um clássico."))
add("свинина", "cerdo", "porco",
    ("Сделайте порцию пельменей со свининой.", "Una ración de dumplings de cerdo, por favor.", "Uma porção de dumpling de porco, por favor."),
    ("В этом блюде есть свинина?", "¿Este plato lleva cerdo?", "Este prato tem porco?"))
add("рыба", "pescado / pez", "peixe",
    ("Сегодня рыба очень свежая.", "El pescado de hoy está muy fresco.", "O peixe de hoje está bem fresco."),
    ("Приготовьте рыбу на пару.", "Cueza un pescado al vapor, por favor.", "Cozinhe um peixe no vapor, por favor."))
add("овощи", "verduras / vegetales", "verduras / legumes",
    ("Положите, пожалуйста, больше овощей.", "Ponga más verduras, por favor.", "Coloque mais verdura, por favor."),
    ("Есть овощи обжаренные без острого?", "¿Tienen verduras salteadas?", "Tem verdura refogada?"))
add("цена", "precio", "preço",
    ("Можно немного дешевле?", "¿Se puede un poco más barato?", "Dá para ficar um pouco mais barato?"),
    ("Скажите итоговую цену.", "Dígame el precio total.", "Diga o preço total."))
add("скидка", "descuento", "desconto",
    ("Сегодня скидка 20% на всё.", "Hoy todo está al 80%.", "Hoje tudo está com 20% de desconto."),
    ("Студентам есть скидка?", "¿Hay descuento para estudiantes?", "Tem desconto para estudante?"))
add("размер", "talla / talla de ropa", "tamanho",
    ("Есть размер побольше?", "¿Tienen una talla más grande?", "Tem um tamanho maior?"),
    ("Мой размер — средний.", "Mi talla es mediana.", "Meu tamanho é médio."))
add("цвет", "color", "cor",
    ("Есть другие цвета?", "¿Hay otros colores?", "Tem outras cores?"),
    ("Мне нравится этот цвет.", "Me gusta este color.", "Gosto desta cor."))
add("примерять", "probarse", "provar",
    ("Можно примерить?", "¿Puedo probármelo?", "Posso provar?"),
    ("Где примерочная?", "¿Dónde está el probador?", "Onde fica o provador?"))
add("фискальный чек / фапяо", "factura / fapiao", "nota fiscal / fapiao",
    ("Выпишите, пожалуйста, чек.", "Emita una factura, por favor.", "Emita uma nota fiscal, por favor."),
    ("Чек можно отправить в отель?", "¿Pueden enviar la factura al hotel?", "Dá para enviar a nota para o hotel?"))
add("дорогой", "caro", "caro",
    ("Немного дорого, можно дешевле?", "Está un poco caro, ¿se puede bajar?", "Está um pouco caro, dá para baixar?"),
    ("Это дороже, чем в интернете.", "Esto es más caro que en internet.", "Isso é mais caro do que na internet."))
add("дешёвый", "barato", "barato",
    ("Есть что-нибудь подешевле?", "¿Hay algo más barato?", "Tem algo mais barato?"),
    ("Здесь сувениры дешевле.", "Aquí las especialidades salen más baratas.", "Aqui as especialidades saem mais baratas."))
add("без пошлины / duty-free", "libre de impuestos / duty free", "livre de impostos / duty-free",
    ("В этом магазине можно без пошлины?", "¿Esta tienda es duty free?", "Esta loja é duty-free?"),
    ("В аэропорту я купил товары duty-free.", "Compré artículos libres de impuestos en el aeropuerto.", "Comprei itens duty-free no aeroporto."))
add("возврат налога / tax refund", "devolución de impuestos", "reembolso de imposto",
    ("Туристы могут оформить возврат налога в аэропорту.", "Los turistas pueden solicitar la devolución en el aeropuerto.", "Turistas podem pedir o reembolso no aeroporto."),
    ("Сохраните чек для возврата налога.", "Guarde la factura para la devolución.", "Guarde a nota para o reembolso."))
add("пункт назначения", "destino", "destino",
    ("Мой пункт назначения — набережная Вайтань.", "Mi destino es el Bund.", "Meu destino é o Bund."),
    ("Водитель, сюда, пожалуйста.", "Conductor, a este destino, por favor.", "Motorista, para este destino, por favor."))
add("налево / слева", "izquierda", "esquerda",
    ("На перекрёстке впереди налево.", "Gire a la izquierda en el cruce de adelante.", "Vire à esquerda no cruzamento à frente."),
    ("Банк слева.", "El banco está a la izquierda.", "O banco fica à esquerda."))
add("направо / справа", "derecha", "direita",
    ("На следующем перекрёстке направо.", "Gire a la derecha en el próximo cruce.", "Vire à direita no próximo cruzamento."),
    ("Вход справа.", "La entrada está a la derecha.", "A entrada fica à direita."))
add("прямо", "siga recto", "siga em frente",
    ("Идите прямо — и вы на месте.", "Siga recto y llega.", "Siga em frente e você chega."),
    ("После светофора прямо.", "Después del semáforo, siga recto.", "Depois do semáforo, siga em frente."))
add("достопримечательность", "atractivo turístico", "ponto turístico",
    ("Это очень известная достопримечательность.", "Este atractivo es muy famoso.", "Este ponto turístico é muito famoso."),
    ("Сегодня мы посетим три места.", "Hoy visitamos tres atractivos.", "Hoje vamos a três pontos turísticos."))
add("входной билет", "entrada / boleto de admisión", "ingresso",
    ("Сколько стоит один билет?", "¿Cuánto cuesta una entrada?", "Quanto custa um ingresso?"),
    ("Студентам — льготные билеты.", "Los estudiantes pueden comprar entradas con descuento.", "Estudantes podem comprar ingresso com desconto."))
add("гид", "guía turístico", "guia de turismo",
    ("Гид объясняет по-китайски.", "El guía explica en chino.", "O guia explica em chinês."),
    ("Нам нужен англоязычный гид.", "Necesitamos un guía en inglés.", "Precisamos de um guia em inglês."))
add("фотографировать", "tomar fotos", "tirar fotos",
    ("Здесь можно фотографировать?", "¿Se pueden tomar fotos aquí?", "Pode tirar foto aqui?"),
    ("Сфотографируйте меня, пожалуйста.", "Háganme una foto, por favor.", "Tira uma foto minha, por favor."))
add("музей", "museo", "museu",
    ("В понедельник музей закрыт.", "El museo cierra los lunes.", "O museu fecha às segundas."),
    ("Мы провели в музее два часа.", "Pasamos dos horas en el museo.", "Passamos duas horas no museu."))
add("Запретный город / Гугун", "Ciudad Prohibida", "Cidade Proibida",
    ("Гугун — обязательное место в Пекине.", "La Ciudad Prohibida es imprescindible en Pekín.", "A Cidade Proibida é imperdível em Pequim."),
    ("Утром мы посетили Запретный город.", "Visitamos la Ciudad Prohibida esta mañana.", "Visitamos a Cidade Proibida esta manhã."))
add("мобильный телефон", "teléfono móvil", "celular",
    ("У телефона сел аккумулятор.", "Se me acabó la batería del móvil.", "Meu celular está sem bateria."),
    ("Можно воспользоваться вашим телефоном?", "¿Puedo usar tu teléfono?", "Posso usar o seu celular?"))
add("Wi-Fi / беспроводная сеть", "Wi-Fi", "Wi-Fi",
    ("Какой пароль от Wi-Fi?", "¿Cuál es la contraseña del Wi-Fi?", "Qual é a senha do Wi-Fi?"),
    ("В номере Wi-Fi быстрый.", "El Wi-Fi de la habitación es rápido.", "O Wi-Fi do quarto é rápido."))
add("мобильный трафик / интернет", "datos móviles", "dados móveis",
    ("У меня закончился трафик.", "Se me acabaron los datos.", "Meus dados acabaram."),
    ("Здесь есть бесплатный мобильный интернет?", "¿Hay datos móviles gratis aquí?", "Tem dados móveis grátis aqui?"))
add("заряжать", "cargar (un dispositivo)", "carregar (aparelho)",
    ("Где можно зарядить телефон?", "¿Dónde puedo cargar el teléfono?", "Onde posso carregar o celular?"),
    ("Мой телефон нужно зарядить.", "Mi teléfono necesita carga.", "Meu celular precisa carregar."))
add("сканировать QR-код", "escanear un código QR", "escanear QR code",
    ("Оплатите, пожалуйста, по QR-коду.", "Pague escaneando el código QR.", "Pague escaneando o QR code."),
    ("Перед входом нужно отсканировать код.", "Hay que escanear el código para entrar.", "É preciso escanear o código para entrar."))
add("пароль", "contraseña", "senha",
    ("Какой пароль от Wi-Fi?", "¿Cuál es la contraseña del Wi-Fi?", "Qual é a senha do Wi-Fi?"),
    ("Введите пароль.", "Introduzca su contraseña.", "Digite a senha."))
add("сеть / интернет", "red / internet", "rede / internet",
    ("Здесь сеть быстрая.", "La red aquí es rápida.", "A internet daqui é rápida."),
    ("Я не могу подключиться к сети.", "No puedo conectarme a la red.", "Não consigo conectar à rede."))
add("WeChat", "WeChat", "WeChat",
    ("Можно добавить друг друга в WeChat?", "¿Nos añadimos en WeChat?", "Podemos nos adicionar no WeChat?"),
    ("Пришлите адрес в WeChat.", "Envíeme la dirección por WeChat.", "Me envie o endereço no WeChat."))
add("SIM-карта", "tarjeta SIM", "chip / cartão SIM",
    ("Помогите заменить SIM-карту.", "Ayúdeme a cambiar la SIM.", "Me ajude a trocar o chip."),
    ("В аэропорту можно купить туристическую SIM.", "En el aeropuerto se puede comprar una SIM de viaje.", "No aeroporto dá para comprar um chip de viagem."))
add("роуминг", "roaming", "roaming",
    ("Перед поездкой включите международный роуминг.", "Active el roaming internacional antes de salir.", "Ative o roaming internacional antes de viajar."),
    ("Роуминг довольно дорогой.", "Las tarifas de roaming son altas.", "A tarifa de roaming é alta."))
add("деньги", "dinero", "dinheiro",
    ("Я забыл деньги.", "Olvidé traer dinero.", "Esqueci o dinheiro."),
    ("Можно заплатить с телефона?", "¿Puedo pagar con el móvil?", "Posso pagar com o celular?"))
add("оплата", "pago", "pagamento",
    ("Можно оплатить с телефона?", "¿Puedo pagar con el móvil?", "Posso pagar com o celular?"),
    ("Оплачу по прибытии.", "Pago al llegar.", "Pago na chegada."))
add("наличные", "efectivo", "dinheiro em espécie",
    ("Можно наличными?", "¿Puedo pagar en efectivo?", "Posso pagar em dinheiro?"),
    ("Наличных с собой не хватает.", "No llevo suficiente efectivo.", "Não tenho dinheiro suficiente em espécie."))
add("оплатить картой", "pagar con tarjeta", "pagar no cartão",
    ("Можно картой?", "¿Puedo pagar con tarjeta?", "Aceita cartão?"),
    ("Проведите карту здесь.", "Pase la tarjeta aquí.", "Passe o cartão aqui."))
add("Alipay", "Alipay", "Alipay",
    ("Здесь принимают Alipay?", "¿Se puede pagar con Alipay aquí?", "Aceita Alipay aqui?"),
    ("Я обычно плачу через Alipay.", "Suelo pagar con Alipay.", "Costumo pagar com Alipay."))
add("WeChat Pay", "WeChat Pay", "WeChat Pay",
    ("Откройте WeChat Pay.", "Abra WeChat Pay.", "Abra o WeChat Pay."),
    ("Магазин принимает только WeChat Pay.", "La tienda solo acepta WeChat Pay.", "A loja só aceita WeChat Pay."))
add("курс обмена", "tipo de cambio", "câmbio / taxa de câmbio",
    ("Какой сегодня курс?", "¿Cuál es el tipo de cambio de hoy?", "Qual é o câmbio de hoje?"),
    ("Курс меняется каждый день.", "El tipo de cambio cambia todos los días.", "O câmbio muda todo dia."))
add("сдача", "cambio (dinero)", "troco",
    ("Сдачу не надо.", "Quédese con el cambio.", "Pode ficar com o troco."),
    ("Продавец быстро дал сдачу.", "El empleado dio el cambio de inmediato.", "O atendente deu o troco na hora."))
add("чек / квитанция", "recibo", "recibo",
    ("Дайте, пожалуйста, чек.", "Un recibo, por favor.", "Um recibo, por favor."),
    ("Чек я положил в кошелёк.", "Puse el recibo en la cartera.", "Coloquei o recibo na carteira."))
add("бюджет", "presupuesto", "orçamento",
    ("Мой бюджет на поездку ограничен.", "Mi presupuesto de viaje es limitado.", "Meu orçamento de viagem é limitado."),
    ("Маршрут планируем по бюджету.", "Planeamos el viaje según el presupuesto.", "Planejamos a viagem de acordo com o orçamento."))
add("помощь", "ayuda", "ajuda",
    ("Помогите, пожалуйста!", "¡Ayúdenme, por favor!", "Por favor, me ajudem!"),
    ("Вы можете мне помочь?", "¿Puede ayudarme?", "Você pode me ajudar?"))
add("полиция", "policía", "polícia",
    ("Вызовите полицию, пожалуйста.", "Llame a la policía, por favor.", "Chame a polícia, por favor."),
    ("Полицейский участок впереди.", "La comisaría está más adelante.", "A delegacia fica à frente."))
add("больница", "hospital", "hospital",
    ("Где ближайшая больница?", "¿Dónde está el hospital más cercano?", "Onde fica o hospital mais próximo?"),
    ("Отвезите меня в больницу.", "Lléveme al hospital, por favor.", "Me leve ao hospital, por favor."))
add("врач", "médico / doctora", "médico / médica",
    ("Мне нужно к врачу.", "Necesito ver a un médico.", "Preciso ver um médico."),
    ("Есть врач, который говорит по-английски?", "¿Hay un médico que hable inglés?", "Tem médico que fale inglês?"))
add("аптека", "farmacia", "farmácia",
    ("Есть аптека поблизости?", "¿Hay una farmacia cerca?", "Tem farmácia por perto?"),
    ("Хочу купить лекарство от простуды.", "Quiero ir a la farmacia a comprar medicina para el resfriado.", "Quero ir à farmácia comprar remédio para resfriado."))
add("скорая помощь", "ambulancia", "ambulância",
    ("Вызовите скорую!", "¡Llame a una ambulancia!", "Chame uma ambulância!"),
    ("Скорая уже в пути.", "La ambulancia ya está en camino.", "A ambulância já está a caminho."))
add("пожар / горит", "incendio / en llamas", "incêndio / pegando fogo",
    ("Пожар, быстро уходите!", "¡Hay fuego, salgan rápido!", "Pegou fogo, saiam rápido!"),
    ("Сообщите о пожаре.", "Avise del incendio.", "Avise o incêndio."))
add("опасно / опасность", "peligroso / peligro", "perigoso / perigo",
    ("Здесь опасно, не подходите.", "Es peligroso aquí, no se acerque.", "Aqui é perigoso, não se aproxime."),
    ("Будьте осторожны, впереди опасность.", "Tenga cuidado, hay peligro adelante.", "Tenha cuidado, tem perigo à frente."))
add("вызывать полицию / заявлять", "llamar a la policía", "chamar a polícia",
    ("В опасности сразу вызывайте полицию.", "Si hay peligro, llame a la policía de inmediato.", "Se houver perigo, chame a polícia na hora."),
    ("Я уже вызвал полицию.", "Ya llamé a la policía.", "Já chamei a polícia."))
add("потерян паспорт", "pasaporte perdido", "passaporte perdido",
    ("Я потерял паспорт, что делать?", "Perdí el pasaporte, ¿qué hago?", "Perdi o passaporte, o que eu faço?"),
    ("Паспорт потерян, помогите связаться с посольством.", "Perdí el pasaporte, ayúdeme a contactar la embajada.", "Perdi o passaporte, me ajude a falar com a embaixada."))

apply_rows("travel", ROWS)
print("travel rows", len(ROWS))
