#!/usr/bin/env python3
"""Technology study-set translations (100 words)."""
from __future__ import annotations
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
from sidecar_lib import apply_rows

ROWS = []


def add(ru, es, pt, *examples):
    ROWS.append((ru, es, pt, examples))


add("смартфон", "teléfono inteligente / smartphone", "smartphone",
    ("Смартфоны изменили жизнь.", "Los smartphones cambiaron nuestra vida.", "Os smartphones mudaram a nossa vida."),
    ("Я сменил смартфон.", "Me cambié de smartphone.", "Troquei de smartphone."))
add("экран", "pantalla", "tela",
    ("Этот экран очень большой.", "Esta pantalla es enorme.", "Esta tela é enorme."),
    ("Разбитый экран нужно заменить.", "Hay que cambiar la pantalla rota.", "A tela quebrada precisa ser trocada."))
add("заряжать", "cargar", "carregar",
    ("Телефон почти сел, нужно зарядить.", "El teléfono está bajo, hay que cargarlo.", "O celular está fraco, precisa carregar."),
    ("Зарядка на столе.", "El cargador está en la mesa.", "O carregador está na mesa."))
add("приложение", "aplicación / app", "aplicativo / app",
    ("Ты скачал это приложение?", "¿Descargaste esta app?", "Você baixou este app?"),
    ("Это приложение очень удобное.", "Esta app es muy útil.", "Este app é muito útil."))
add("обновлять / обновление", "actualizar / actualizar", "atualizar",
    ("Обновите систему.", "Actualice el sistema.", "Atualize o sistema."),
    ("У приложения есть новое обновление.", "La app tiene una actualización nueva.", "O app tem uma atualização nova."))
add("отпечаток пальца", "huella dactilar", "impressão digital",
    ("Разблокируйте телефон отпечатком.", "Desbloquee el teléfono con la huella.", "Desbloqueie o celular com a digital."),
    ("Распознавание отпечатка очень быстрое.", "El reconocimiento de huella es rápido.", "O reconhecimento da digital é rápido."))
add("фотографировать", "hacer fotos / fotografiar", "tirar foto / fotografar",
    ("Снимать на телефон очень удобно.", "Fotografiar con el móvil es muy práctico.", "Tirar foto no celular é muito prático."),
    ("Сфотографируйте меня, пожалуйста.", "Háganme una foto, por favor.", "Tira uma foto minha, por favor."))
add("память / хранилище", "almacenamiento / memoria", "armazenamento / memória",
    ("Память телефона закончилась.", "El almacenamiento del móvil está lleno.", "O armazenamento do celular está cheio."),
    ("У этой модели большая память.", "Este modelo tiene mucho almacenamiento.", "Este modelo tem bastante armazenamento."))
add("сигнал (связи)", "señal", "sinal",
    ("Здесь плохой сигнал.", "Aquí la señal es mala.", "Aqui o sinal está ruim."),
    ("Сигнал на полных делениях.", "La señal está al máximo.", "O sinal está no máximo."))
add("Bluetooth", "Bluetooth", "Bluetooth",
    ("Включите Bluetooth.", "Active el Bluetooth.", "Ligue o Bluetooth."),
    ("Наушники подключаются по Bluetooth.", "Los auriculares se conectan por Bluetooth.", "O fone conecta via Bluetooth."))
add("компьютер", "ordenador / computadora", "computador",
    ("Мой компьютер работает медленно.", "Mi ordenador va lento.", "Meu computador está lento."),
    ("Попробуйте перезагрузить компьютер.", "Pruebe a reiniciar el ordenador.", "Tente reiniciar o computador."))
add("ноутбук", "portátil / laptop", "notebook / laptop",
    ("На работу я беру ноутбук.", "Llevo el portátil al trabajo.", "Levo o notebook para o trabalho."),
    ("Этот ноутбук очень лёгкий.", "Este portátil es muy ligero.", "Este notebook é bem leve."))
add("клавиатура", "teclado", "teclado",
    ("На клавиатуре сломалась одна клавиша.", "Una tecla del teclado está rota.", "Uma tecla do teclado está quebrada."),
    ("Подключите беспроводную клавиатуру.", "Conecte el teclado inalámbrico.", "Conecte o teclado sem fio."))
add("мышь", "ratón", "mouse",
    ("Мышь плохо реагирует.", "El ratón no responde bien.", "O mouse não responde bem."),
    ("Я привык к беспроводной мыши.", "Prefiero el ratón inalámbrico.", "Prefiro mouse sem fio."))
add("программное обеспечение / софт", "software", "software",
    ("Установите эту программу.", "Instale este software.", "Instale este software."),
    ("Программа зависла.", "El software se bloqueó.", "O software travou."))
add("жёсткий диск", "disco duro", "disco rígido / HD",
    ("Места на диске не хватает.", "No hay espacio en el disco duro.", "Não há espaço no HD."),
    ("Я поставил SSD.", "Lo cambié por un disco de estado sólido.", "Troquei por um SSD."))
add("делать резервную копию / бэкап", "hacer copia de seguridad", "fazer backup",
    ("Регулярно делайте резервные копии.", "Haga copias de seguridad con regularidad.", "Faça backup com regularidade."),
    ("Я уже сохранил копию в облаке.", "Ya hice la copia en la nube.", "Já fiz o backup na nuvem."))
add("перезагружать", "reiniciar", "reiniciar",
    ("Попробуйте перезагрузить компьютер.", "Pruebe a reiniciar el ordenador.", "Tente reiniciar o computador."),
    ("После обновления нужна перезагрузка.", "Tras actualizar hay que reiniciar.", "Depois de atualizar é preciso reiniciar."))
add("монитор", "monitor / pantalla", "monitor",
    ("Я купил два монитора.", "Compré dos monitores.", "Comprei dois monitores."),
    ("У монитора высокое разрешение.", "El monitor tiene mucha resolución.", "O monitor tem alta resolução."))
add("файл / документ", "archivo / fichero", "arquivo",
    ("Файл сохранён на рабочем столе.", "El archivo está guardado en el escritorio.", "O arquivo está salvo na área de trabalho."),
    ("Пришлите мне этот файл.", "Envíeme este archivo.", "Me envie este arquivo."))
add("интернет", "internet", "internet",
    ("Интернет изменил мир.", "Internet cambió el mundo.", "A internet mudou o mundo."),
    ("Без интернета я не могу работать.", "Sin internet no puedo trabajar.", "Sem internet não consigo trabalhar."))
add("сайт / веб-сайт", "sitio web", "site / website",
    ("Зайдите на наш сайт.", "Visite nuestro sitio web.", "Visite o nosso site."),
    ("Этот сайт загружается медленно.", "Este sitio carga muy lento.", "Este site carrega muito lento."))
add("браузер", "navegador", "navegador",
    ("Попробуйте другой браузер.", "Pruebe otro navegador.", "Tente outro navegador."),
    ("Браузер нужно обновить.", "El navegador necesita una actualización.", "O navegador precisa de atualização."))
add("скачивать / загружать", "descargar", "baixar / fazer download",
    ("Скачайте последнюю версию.", "Descargue la última versión.", "Baixe a versão mais recente."),
    ("Файл скачивается.", "El archivo se está descargando.", "O arquivo está baixando."))
add("загружать на сервер / выкладывать", "subir / cargar (upload)", "enviar / fazer upload",
    ("Загрузите резюме.", "Suba su currículum.", "Envie o seu currículo."),
    ("Видео уже загружено.", "La subida del vídeo terminó.", "O upload do vídeo terminou."))
add("искать / поиск", "buscar / buscar en internet", "pesquisar / buscar",
    ("Поищите в интернете.", "Búsquelo en internet.", "Pesquise na internet."),
    ("Поисковик работает быстро.", "El buscador es rápido.", "O buscador é rápido."))
add("ссылка", "enlace / vínculo", "link",
    ("Нажмите на эту ссылку.", "Haga clic en este enlace.", "Clique neste link."),
    ("Ссылка уже недействительна.", "El enlace caducó.", "O link expirou."))
add("пароль", "contraseña", "senha",
    ("Установите надёжный пароль.", "Ponga una contraseña fuerte.", "Coloque uma senha forte."),
    ("Я забыл пароль.", "Olvidé la contraseña.", "Esqueci a senha."))
add("Wi-Fi", "Wi-Fi", "Wi-Fi",
    ("Какой пароль от Wi-Fi?", "¿Cuál es la contraseña del Wi-Fi?", "Qual é a senha do Wi-Fi?"),
    ("Здесь сильный сигнал Wi-Fi.", "Aquí la señal Wi-Fi es fuerte.", "Aqui o sinal de Wi-Fi é forte."))
add("облако / облачное хранилище", "nube / almacenamiento en la nube", "nuvem / armazenamento na nuvem",
    ("Данные хранятся в облаке.", "Los datos están en la nube.", "Os dados estão na nuvem."),
    ("Синхронизация с облаком завершена.", "La sincronización en la nube terminó.", "A sincronização na nuvem terminou."))
add("искусственный интеллект", "inteligencia artificial", "inteligência artificial",
    ("ИИ развивается очень быстро.", "La IA avanza muy rápido.", "A IA avança muito rápido."),
    ("ИИ изменил многие отрасли.", "La IA transformó muchos sectores.", "A IA transformou muitos setores."))
add("алгоритм", "algoritmo", "algoritmo",
    ("Алгоритм рекомендаций очень точный.", "El algoritmo de recomendación es muy preciso.", "O algoritmo de recomendação é bem preciso."),
    ("Алгоритмы нужно постоянно улучшать.", "Los algoritmos hay que optimizarlos siempre.", "Os algoritmos precisam ser otimizados sempre."))
add("модель (ИИ)", "modelo (IA)", "modelo (IA)",
    ("Эта языковая модель очень мощная.", "Este modelo de lenguaje es muy potente.", "Este modelo de linguagem é muito poderoso."),
    ("Модели нужно много данных для обучения.", "Los modelos necesitan muchos datos para entrenarse.", "Os modelos precisam de muitos dados para treinar."))
add("обучать (модель ИИ)", "entrenar (IA)", "treinar (IA)",
    ("Обучение модели занимает много времени.", "Entrenar el modelo lleva mucho tiempo.", "Treinar o modelo leva muito tempo."),
    ("Они обучают новый ИИ.", "Están entrenando una IA nueva.", "Eles estão treinando uma IA nova."))
add("распознавание / распознавать", "reconocimiento / reconocer", "reconhecimento / reconhecer",
    ("Распознавание лиц очень быстрое.", "El reconocimiento facial es rápido.", "O reconhecimento facial é rápido."),
    ("Точность распознавания речи высокая.", "La precisión del reconocimiento de voz es alta.", "A precisão do reconhecimento de voz é alta."))
add("автоматизация", "automatización", "automação",
    ("Завод автоматизировали.", "La fábrica se automatizó.", "A fábrica foi automatizada."),
    ("Автоматизация повысила эффективность.", "La automatización mejoró la eficiencia.", "A automação melhorou a eficiência."))
add("умный / интеллектуальный", "inteligente / smart", "inteligente / smart",
    ("Это система умного дома.", "Este es un sistema de hogar inteligente.", "Este é um sistema de casa inteligente."),
    ("Умный помощник может отвечать на вопросы.", "El asistente inteligente puede responder preguntas.", "O assistente inteligente pode responder perguntas."))
add("данные", "datos", "dados",
    ("Безопасность данных очень важна.", "La seguridad de los datos es importante.", "A segurança dos dados é importante."),
    ("Проанализируйте эти данные.", "Analice estos datos.", "Analise estes dados."))
add("машинное обучение", "aprendizaje automático", "aprendizado de máquina",
    ("Машинное обучение — основа ИИ.", "El aprendizaje automático es la base de la IA.", "O aprendizado de máquina é a base da IA."),
    ("Он изучает машинное обучение.", "Estudia aprendizaje automático.", "Ele estuda aprendizado de máquina."))
add("чат-бот", "chatbot", "chatbot",
    ("Служба поддержки — чат-бот.", "La atención al cliente es un chatbot.", "O atendimento é um chatbot."),
    ("Чат-бот отвечает очень быстро.", "El chatbot responde muy rápido.", "O chatbot responde muito rápido."))
add("лента «Моменты» (WeChat)", "Momentos (feed de WeChat)", "Momentos (feed do WeChat)",
    ("Он выложил фото в «Моменты».", "Publicó fotos en Momentos.", "Ele postou fotos nos Momentos."),
    ("Не выкладывайте всё в «Моменты».", "No publiques todo en Momentos.", "Não poste tudo nos Momentos."))
add("ставить лайк", "dar me gusta / like", "dar like / curtir",
    ("Поставьте лайк моему видео.", "Dale me gusta a mi vídeo.", "Dê like no meu vídeo."),
    ("У этого поста много лайков.", "Este post tiene muchos me gusta.", "Este post tem muitos likes."))
add("комментарий", "comentario", "comentário",
    ("Оставьте свой комментарий.", "Deje su comentario.", "Deixe o seu comentário."),
    ("В комментариях оживлённое обсуждение.", "En los comentarios hay un debate animado.", "Nos comentários a discussão está animada."))
add("делиться / репост", "compartir", "compartilhar",
    ("Поделитесь этой статьёй.", "Comparta este artículo.", "Compartilhe este artigo."),
    ("Я отправил это в WeChat.", "Lo compartí en WeChat.", "Compartilhei no WeChat."))
add("подписываться / следить", "seguir", "seguir",
    ("Подпишитесь на мой аккаунт.", "Sígame en la cuenta.", "Siga a minha conta."),
    ("Он подписан на многих блогеров.", "Sigue a muchos influencers.", "Ele segue muitos influenciadores."))
add("фанаты / подписчики", "seguidores / fans", "seguidores / fãs",
    ("У него миллион подписчиков.", "Tiene un millón de seguidores.", "Ele tem um milhão de seguidores."),
    ("Фанаты очень горячие.", "Los fans son muy entusiastas.", "Os fãs são muito entusiasmados."))
add("прямая трансляция / стрим", "directo / live", "live / transmissão ao vivo",
    ("Сегодня вечером у неё стрим.", "Esta noche tiene un directo.", "Hoje à noite ela tem uma live."),
    ("Продажи в прямом эфире очень популярны.", "La venta en directo es muy popular.", "Venda em live é muito popular."))
add("короткое видео", "vídeo corto", "vídeo curto",
    ("Короткие видео легко вызывают зависимость.", "Los vídeos cortos enganchan fácil.", "Vídeo curto vicia fácil."),
    ("Он снял много коротких видео.", "Hizo muchos vídeos cortos.", "Ele fez muitos vídeos curtos."))
add("трендовые поиски / хот-сёрч", "búsquedas en tendencia", "pesquisas em alta / trending",
    ("Эта новость попала в тренды.", "Esta noticia llegó a tendencias.", "Esta notícia entrou nos trending."),
    ("Эта тема — номер один в трендах.", "Este tema es el número uno en tendencias.", "Este assunto é o número um nos trending."))
add("личное сообщение / директ", "mensaje privado / DM", "mensagem direta / DM",
    ("Напишите мне в личку.", "Contácteme por mensaje privado.", "Me chame no privado."),
    ("Я получил личное сообщение.", "Recibí un mensaje privado.", "Recebi uma mensagem direta."))
add("покупки онлайн", "compra en línea", "compra online",
    ("Я привык покупать онлайн.", "Estoy acostumbrado a comprar en línea.", "Estou acostumado a comprar online."),
    ("Онлайн-покупки очень удобны.", "Comprar en línea es muy práctico.", "Comprar online é muito prático."))
add("корзина (в магазине)", "carrito de compra", "carrinho de compras",
    ("Добавьте в корзину.", "Añádalo al carrito.", "Adicione ao carrinho."),
    ("Моя корзина полная.", "Mi carrito está lleno.", "Meu carrinho está cheio."))
add("оформить заказ", "hacer un pedido", "fazer um pedido",
    ("Я уже оформил заказ.", "Ya hice el pedido.", "Já fiz o pedido."),
    ("Оформите заказ до вечера.", "Haga el pedido antes de esta noche.", "Faça o pedido até hoje à noite."))
add("экспресс-доставка / курьер", "mensajería urgente", "encomenda expressa / sedex",
    ("Курьер прибудет завтра.", "El envío express llega mañana.", "A encomenda expressa chega amanhã."),
    ("Проверьте, где посылка.", "Revise dónde está el paquete.", "Veja onde está o pacote."))
add("отзыв / оценка", "reseña / valoración", "avaliação / review",
    ("Оставьте отзыв о товаре.", "Valore el producto, por favor.", "Avalie o produto, por favor."),
    ("Этот отзыв очень полезный.", "Esta reseña es muy útil.", "Esta avaliação é muito útil."))
add("возврат денег", "reembolso", "reembolso",
    ("Можно запросить возврат?", "¿Puedo pedir un reembolso?", "Posso pedir reembolso?"),
    ("Деньги уже вернулись на счёт.", "El reembolso ya se abonó.", "O reembolso já caiu na conta."))
add("купон", "cupón", "cupom",
    ("У меня есть купон.", "Tengo un cupón.", "Tenho um cupom."),
    ("Купон истекает сегодня.", "El cupón caduca hoy.", "O cupom vence hoje."))
add("молниеносная распродажа / сеоша", "oferta relámpago", "oferta relâmpago",
    ("Сегодня в восемь вечера молниеносная распродажа.", "A las ocho hay una oferta relámpago.", "Às oito tem uma oferta relâmpago."),
    ("Цены на сеоша очень выгодные.", "Los precios relámpago son muy buenos.", "Os preços relâmpago são ótimos."))
add("бесплатная доставка", "envío gratis", "frete grátis",
    ("От ста юаней — бесплатная доставка.", "Envío gratis a partir de 100.", "Frete grátis a partir de 100."),
    ("У этого товара бесплатная доставка.", "Este artículo tiene envío gratis.", "Este item tem frete grátis."))
add("служба поддержки / клиентский сервис", "atención al cliente", "atendimento ao cliente / SAC",
    ("Свяжитесь с онлайн-поддержкой.", "Contacte con atención al cliente en línea.", "Fale com o atendimento online."),
    ("Поддержка ответила быстро.", "Atención al cliente respondió rápido.", "O atendimento respondeu rápido."))
add("доставка еды / takeaway", "comida a domicilio / delivery", "delivery / comida por aplicativo",
    ("Давайте сегодня вечером закажем еду.", "Pidamos comida a domicilio esta noche.", "Vamos pedir delivery hoje à noite."),
    ("Доставка за тридцать минут.", "El pedido llega en treinta minutos.", "O delivery chega em trinta minutos."))
add("курьер на велосипеде / райдер", "repartidor", "entregador",
    ("Курьер уже в пути.", "El repartidor ya está en camino.", "O entregador já está a caminho."),
    ("Курьер позвонил, что уже на месте.", "El repartidor llamó para decir que llegó.", "O entregador ligou dizendo que chegou."))
add("доставка / развоз", "reparto / entrega", "entrega / distribuição",
    ("Плата за доставку — пять юаней.", "El envío cuesta cinco yuanes.", "A taxa de entrega é cinco yuans."),
    ("Ожидаемое время доставки — сорок минут.", "El tiempo estimado de entrega es de cuarenta minutos.", "O tempo estimado de entrega é de quarenta minutos."))
add("заказ", "pedido", "pedido",
    ("Ваш заказ отправлен.", "Su pedido ya se envió.", "Seu pedido já foi enviado."),
    ("Подтвердите данные заказа.", "Confirme los datos del pedido.", "Confirme os dados do pedido."))
add("отслеживать", "rastrear", "rastrear",
    ("Доставку можно отслеживать в реальном времени.", "Puede rastrear la entrega en tiempo real.", "Dá para rastrear a entrega em tempo real."),
    ("Отследите мою посылку.", "Rastree mi paquete.", "Rastreie o meu pacote."))
add("вовремя", "a tiempo / puntual", "no horário / pontual",
    ("Еду доставили вовремя.", "La comida llegó a tiempo.", "A comida chegou no horário."),
    ("Постарайтесь доставить вовремя.", "Entregue a tiempo si es posible.", "Entregue no horário se possível."))
add("сохранять тепло (упаковка)", "mantener caliente (embalaje)", "manter quente (embalagem)",
    ("Еду привезли в термосумке.", "El pedido venía en bolsa térmica.", "O pedido veio em sacola térmica."),
    ("Тепло сохранилось неплохо.", "El aislamiento funciona bastante bien.", "O isolamento funciona relativamente bem."))
add("код получения заказа", "código de recogida", "código de retirada",
    ("Посмотрите код получения.", "Mire el código de recogida.", "Olhe o código de retirada."),
    ("Этот код получения очень важен.", "Este código de recogida es importante.", "Este código de retirada é importante."))
add("чаевые", "propina", "gorjeta",
    ("Хотите дать курьеру чаевые?", "¿Quiere dar propina al repartidor?", "Quer dar gorjeta ao entregador?"),
    ("Я дал десять юаней чаевых.", "Di diez yuanes de propina.", "Dei dez yuans de gorjeta."))
add("доставка точно в срок", "entrega puntual garantizada", "entrega pontual garantida",
    ("Площадка обещает доставку точно в срок.", "La plataforma promete entrega puntual.", "A plataforma promete entrega pontual."),
    ("Если не успеют — можно вернуть деньги.", "Si no llega a tiempo, puede pedir reembolso.", "Se não chegar no horário, dá para pedir reembolso."))
add("игра", "juego", "jogo",
    ("Во что ты играешь?", "¿A qué juegos juegas?", "Que jogos você joga?"),
    ("Эта игра очень увлекательная.", "Este juego es muy divertido.", "Este jogo é muito divertido."))
add("игрок / геймер", "jugador / gamer", "jogador / gamer",
    ("Он опытный игрок.", "Es un gamer veterano.", "Ele é um gamer veterano."),
    ("Онлайн сейчас много игроков.", "Hay muchos jugadores en línea.", "Há muitos jogadores online."))
add("геймпад / контроллер", "mando / control", "controle / gamepad",
    ("Подключите геймпад.", "Conecte el mando.", "Conecte o controle."),
    ("У этого геймпада приятный хват.", "Este mando se siente muy bien.", "Este controle tem um toque muito bom."))
add("уровень / этап (игры)", "nivel / fase", "fase / nível",
    ("Этот уровень очень сложный.", "Este nivel es muy difícil.", "Esta fase é muito difícil."),
    ("Я прошёл третий уровень.", "Pasé el nivel tres.", "Passei a terceira fase."))
add("рейтинг / место в таблице", "clasificación / ranking", "ranking / classificação",
    ("Моё место в рейтинге выросло.", "Subí en la clasificación.", "Minha posição no ranking subiu."),
    ("Он первый в мировом рейтинге.", "Está el número uno del mundo.", "Ele é o número um do mundo."))
add("собирать команду / играть в группе", "formar equipo", "montar time / jogar em grupo",
    ("Давайте сыграем вместе.", "Juguemos en equipo.", "Vamos jogar em time."),
    ("Для команды нужно четверо.", "Hace falta ser cuatro para formar equipo.", "É preciso ser quatro para montar o time."))
add("пополнять счёт / донат", "recargar / donar en el juego", "recarregar / fazer recarga",
    ("В игре нужно пополнять счёт?", "¿El juego exige recargas?", "O jogo exige recarga?"),
    ("Я пополнил на шестьдесят восемь юаней.", "Recargué sesenta y ocho yuanes.", "Recarreguei sessenta e oito yuans."))
add("снаряжение / экипировка (в игре)", "equipamiento / gear", "equipamento / gear",
    ("У этой экипировки отличные характеристики.", "Este equipo tiene muy buenas estadísticas.", "Este equipamento tem ótimos atributos."),
    ("Прокачайте снаряжение.", "Mejore su equipamiento.", "Melhore o seu equipamento."))
add("скорость интернета", "velocidad de internet", "velocidade da internet",
    ("Медленный интернет мешает игре.", "Internet lenta afecta al juego.", "Internet lenta atrapalha o jogo."),
    ("После смены тарифа интернет стал быстрее.", "Tras cambiar de fibra, la velocidad mejoró.", "Depois de trocar a banda, a velocidade melhorou."))
add("киберспорт", "deporte electrónico / esports", "esports / esportes eletrônicos",
    ("Киберспорт теперь официальные соревнования.", "Los esports ya son competición oficial.", "Esports já é competição oficial."),
    ("Он мечтает стать киберспортсменом.", "Sueña con ser jugador profesional.", "Ele sonha em ser jogador profissional."))
add("умная колонка", "altavoz inteligente", "caixa de som inteligente",
    ("Умная колонка может управлять техникой.", "El altavoz inteligente controla electrodomésticos.", "A caixa inteligente controla eletrodomésticos."),
    ("Говорите с умной колонкой.", "Hable al altavoz inteligente.", "Fale com a caixa inteligente."))
add("умные часы", "reloj inteligente", "relógio inteligente",
    ("Умные часы измеряют пульс.", "El reloj inteligente mide el ritmo cardíaco.", "O relógio inteligente mede a frequência cardíaca."),
    ("Я бегаю с умными часами.", "Corro con el reloj inteligente.", "Corro com o relógio inteligente."))
add("умный дом", "hogar inteligente", "casa inteligente",
    ("Умный дом делает жизнь удобнее.", "El hogar inteligente hace la vida más fácil.", "A casa inteligente deixa a vida mais fácil."),
    ("Мы установили систему умного дома.", "Instalamos un sistema de hogar inteligente.", "Instalamos um sistema de casa inteligente."))
add("голосовой помощник", "asistente de voz", "assistente de voz",
    ("Голосовой помощник может поставить будильник.", "El asistente de voz puede poner una alarma.", "O assistente de voz pode colocar um alarme."),
    ("Попросите помощника включить музыку.", "Pida al asistente que ponga música.", "Peça ao assistente para tocar música."))
add("робот-пылесос", "robot aspirador", "robô aspirador",
    ("Робот-пылесос убирает сам каждый день.", "El robot aspirador limpia solo todos los días.", "O robô aspirador limpa sozinho todo dia."),
    ("Очистите контейнер робота-пылесоса.", "Vacíe el depósito del robot.", "Esvazie o depósito do robô."))
add("умный дверной замок", "cerradura inteligente", "fechadura inteligente",
    ("Умный замок открывается паролем.", "La cerradura inteligente se abre con código.", "A fechadura inteligente abre com senha."),
    ("Я настроил умный замок.", "Configuré una cerradura inteligente.", "Configurei uma fechadura inteligente."))
add("видеонаблюдение / мониторинг", "vigilancia / monitorizar", "vigilância / monitorar",
    ("У двери стоит камера наблюдения.", "Hay una cámara de seguridad en la puerta.", "Tem uma câmera de segurança na porta."),
    ("Наблюдение можно смотреть с телефона.", "Se puede ver la vigilancia en el móvil.", "Dá para ver a vigilância no celular."))
add("датчик / сенсор", "sensor", "sensor",
    ("Датчик обнаружил человека.", "El sensor detectó a alguien.", "O sensor detectou alguém."),
    ("Датчик температуры очень точный.", "El sensor de temperatura es muy preciso.", "O sensor de temperatura é bem preciso."))
add("удалённое управление", "control remoto / control a distancia", "controle remoto / controle à distância",
    ("Кондиционером можно управлять удалённо.", "Se puede controlar el aire a distancia.", "Dá para controlar o ar à distância."),
    ("Удалённое управление очень удобно.", "El control a distancia es muy práctico.", "O controle à distância é muito prático."))
add("подключать / соединение", "conectar / conexión", "conectar / conexão",
    ("Устройство успешно подключилось.", "El dispositivo se conectó correctamente.", "O dispositivo conectou com sucesso."),
    ("Подключитесь к той же сети Wi-Fi.", "Conéctese al mismo Wi-Fi.", "Conecte no mesmo Wi-Fi."))
add("батарейка / аккумулятор", "batería / pila", "bateria / pilha",
    ("Батарея почти села.", "La batería está casi agotada.", "A bateria está quase no fim."),
    ("Поставьте новую батарею.", "Ponga una batería nueva.", "Coloque uma bateria nova."))
add("кабель зарядки", "cable de carga", "cabo de carregamento",
    ("Мой кабель зарядки сломался.", "Se me rompió el cable de carga.", "Meu cabo de carregamento quebrou."),
    ("Одолжите кабель зарядки.", "Préstenme un cable de carga.", "Me empreste um cabo de carregamento."))
add("наушники", "auriculares / cascos", "fone de ouvido / headphone",
    ("Беспроводные наушники очень удобны.", "Los auriculares inalámbricos son muy prácticos.", "Fone sem fio é muito prático."),
    ("У наушников отличный звук.", "Los auriculares tienen muy buen sonido.", "O fone tem um som ótimo."))
add("камера (устройства)", "cámara (del dispositivo)", "câmera (do aparelho)",
    ("У ноутбука есть камера.", "El portátil tiene cámara.", "O notebook tem câmera."),
    ("Включите камеру.", "Encienda la cámara.", "Ligue a câmera."))
add("роутер / маршрутизатор", "router / enrutador", "roteador",
    ("Роутер в гостиной.", "El router está en el salón.", "O roteador fica na sala."),
    ("Перезагрузите роутер.", "Reinicie el router.", "Reinicie o roteador."))
add("розетка", "enchufe / toma de corriente", "tomada",
    ("Где розетка?", "¿Dónde está el enchufe?", "Onde fica a tomada?"),
    ("Эта розетка сломана.", "Este enchufe está roto.", "Esta tomada está quebrada."))
add("питание / блок питания", "fuente de alimentación", "fonte de alimentação",
    ("Проверьте подключение питания.", "Revise la conexión de alimentación.", "Confira a conexão da alimentação."),
    ("Адаптер питания пропал.", "Falta el adaptador de corriente.", "O adaptador de energia sumiu."))
add("разъём / порт / интерфейс", "puerto / conector", "porta / conector",
    ("Этот разъём — USB-C.", "Este puerto es USB-C.", "Esta porta é USB-C."),
    ("Разъём сломан, не заряжается.", "El puerto está roto y no carga.", "A porta está quebrada e não carrega."))
add("гарантия", "garantía", "garantia",
    ("У этого товара гарантия год.", "Este producto tiene un año de garantía.", "Este produto tem um ano de garantia."),
    ("Гарантия уже закончилась.", "La garantía ya caducó.", "A garantia já venceu."))
add("ремонт / обслуживание", "reparar / mantenimiento", "consertar / manutenção",
    ("Телефон нужно отремонтировать.", "El teléfono necesita reparación.", "O celular precisa de conserto."),
    ("Мастерская в торговом центре.", "El taller de reparación está en el centro comercial.", "A assistência fica no shopping."))

apply_rows("technology", ROWS)
print("technology rows", len(ROWS))
