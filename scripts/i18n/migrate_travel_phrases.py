#!/usr/bin/env python3
"""Add ru/es/pt-BR translations to travel_phrases.json without changing IDs or Chinese."""

from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
PATH = ROOT / "HanziPlus" / "Resources" / "Data" / "travel_phrases.json"

# id -> (ru, es, pt-BR, usage_ru, usage_es, usage_pt, tags_ru, tags_es, tags_pt)
# usage/tags None means keep/translate only if source exists
PHRASES: dict[str, dict] = {}


def T(ru, es, pt, note_ru=None, note_es=None, note_pt=None, tags=None):
    return {
        "ru": ru, "es": es, "pt-BR": pt,
        "note_ru": note_ru, "note_es": note_es, "note_pt": note_pt,
        "tags": tags,  # {en: [...]} optional override; else translate known tags
    }

TAG_MAP = {
    "hello": ("приветствие", "saludo", "saudação"),
    "greeting": ("приветствие", "saludo", "saudação"),
    "polite": ("вежливость", "cortesía", "educação"),
    "thanks": ("благодарность", "agradecimiento", "agradecimento"),
    "thank-you": ("спасибо", "gracias", "obrigado"),
    "excuse": ("извинение", "perdón", "desculpa"),
    "ask": ("вопрос", "pregunta", "pergunta"),
    "sorry": ("извинение", "perdón", "desculpa"),
    "apology": ("извинение", "disculpa", "desculpa"),
    "understand": ("понимание", "entender", "entender"),
    "listen": ("слушать", "escuchar", "ouvir"),
    "beginner": ("новичок", "principiante", "iniciante"),
    "english": ("английский", "inglés", "inglês"),
    "language": ("язык", "idioma", "idioma"),
    "toilet": ("туалет", "baño", "banheiro"),
    "bathroom": ("ванная", "baño", "banheiro"),
    "restroom": ("туалет", "aseos", "toalete"),
    "help": ("помощь", "ayuda", "ajuda"),
    "assist": ("помощь", "ayuda", "ajuda"),
    "photo": ("фото", "foto", "foto"),
    "camera": ("камера", "cámara", "câmera"),
    "slow": ("медленнее", "despacio", "devagar"),
    "speak": ("говорить", "hablar", "falar"),
    "check-in": ("регистрация", "facturación", "check-in"),
    "airport": ("аэропорт", "aeropuerto", "aeroporto"),
    "counter": ("стойка", "mostrador", "balcão"),
    "boarding": ("посадка", "embarque", "embarque"),
    "passport": ("паспорт", "pasaporte", "passaporte"),
    "gate": ("выход", "puerta", "portão"),
    "luggage": ("багаж", "equipaje", "bagagem"),
    "baggage": ("багаж", "equipaje", "bagagem"),
    "delay": ("задержка", "retraso", "atraso"),
    "flight": ("рейс", "vuelo", "voo"),
    "customs": ("таможня", "aduana", "alfândega"),
    "immigration": ("иммиграция", "inmigración", "imigração"),
    "lost": ("потеря", "perdido", "perdido"),
    "transfer": ("пересадка", "transbordo", "conexão"),
    "connection": ("стыковка", "conexión", "conexão"),
    "taxi": ("такси", "taxi", "táxi"),
    "address": ("адрес", "dirección", "endereço"),
    "driver": ("водитель", "conductor", "motorista"),
    "stop": ("остановка", "parar", "parar"),
    "price": ("цена", "precio", "preço"),
    "fare": ("тариф", "tarifa", "tarifa"),
    "metro": ("метро", "metro", "metrô"),
    "subway": ("метро", "metro", "metrô"),
    "line": ("линия", "línea", "linha"),
    "train": ("поезд", "tren", "trem"),
    "station": ("станция", "estación", "estação"),
    "directions": ("направление", "direcciones", "direções"),
    "platform": ("платформа", "andén", "plataforma"),
    "number": ("номер", "número", "número"),
    "ticket": ("билет", "billete", "bilhete"),
    "buy": ("купить", "comprar", "comprar"),
    "left": ("налево", "izquierda", "esquerda"),
    "right": ("направо", "derecha", "direita"),
    "hotel": ("отель", "hotel", "hotel"),
    "booking": ("бронь", "reserva", "reserva"),
    "reservation": ("бронь", "reserva", "reserva"),
    "problem": ("проблема", "problema", "problema"),
    "issue": ("проблема", "problema", "problema"),
    "wifi": ("вайфай", "wifi", "wifi"),
    "password": ("пароль", "contraseña", "senha"),
    "checkout": ("выезд", "salida", "check-out"),
    "room": ("номер", "habitación", "quarto"),
    "breakfast": ("завтрак", "desayuno", "café da manhã"),
    "towel": ("полотенце", "toalla", "toalha"),
    "request": ("просьба", "petición", "pedido"),
    "menu": ("меню", "menú", "cardápio"),
    "spicy": ("острое", "picante", "picante"),
    "mild": ("неостро", "suave", "suave"),
    "food": ("еда", "comida", "comida"),
    "allergy": ("аллергия", "alergia", "alergia"),
    "peanuts": ("арахис", "cacahuetes", "amendoim"),
    "ingredients": ("состав", "ingredientes", "ingredientes"),
    "vegetarian": ("вегетарианство", "vegetariano", "vegetariano"),
    "meat": ("мясо", "carne", "carne"),
    "bill": ("счёт", "cuenta", "conta"),
    "check": ("счёт", "cuenta", "conta"),
    "pay": ("оплата", "pagar", "pagar"),
    "restaurant": ("ресторан", "restaurante", "restaurante"),
    "delicious": ("вкусно", "delicioso", "delicioso"),
    "compliment": ("комплимент", "cumplido", "elogio"),
    "recommend": ("рекомендация", "recomendación", "recomendação"),
    "water": ("вода", "agua", "água"),
    "drink": ("напиток", "bebida", "bebida"),
    "takeaway": ("с собой", "para llevar", "para viagem"),
    "pack": ("упаковать", "empaquetar", "embalar"),
    "shopping": ("покупки", "compras", "compras"),
    "bargain": ("торг", "regatear", "pechincha"),
    "cash": ("наличные", "efectivo", "dinheiro"),
    "payment": ("оплата", "pago", "pagamento"),
    "alipay": ("Alipay", "Alipay", "Alipay"),
    "wechat": ("WeChat", "WeChat", "WeChat"),
    "receipt": ("чек", "recibo", "recibo"),
    "invoice": ("счёт-фактура", "factura", "nota fiscal"),
    "try": ("примерка", "probar", "provar"),
    "clothing": ("одежда", "ropa", "roupa"),
    "size": ("размер", "talla", "tamanho"),
    "internet": ("интернет", "internet", "internet"),
    "sim": ("SIM", "SIM", "chip"),
    "phone": ("телефон", "teléfono", "celular"),
    "card": ("карта", "tarjeta", "cartão"),
    "esim": ("eSIM", "eSIM", "eSIM"),
    "mobile": ("мобильный", "móvil", "celular"),
    "qr": ("QR", "QR", "QR"),
    "scan": ("сканировать", "escanear", "escanear"),
    "code": ("код", "código", "código"),
    "signal": ("сигнал", "señal", "sinal"),
    "charge": ("зарядка", "cargar", "carregar"),
    "battery": ("батарея", "batería", "bateria"),
    "emergency": ("экстренное", "emergencia", "emergência"),
    "police": ("полиция", "policía", "polícia"),
    "ambulance": ("скорая", "ambulancia", "ambulância"),
    "hospital": ("больница", "hospital", "hospital"),
    "pharmacy": ("аптека", "farmacia", "farmácia"),
    "medicine": ("лекарство", "medicina", "remédio"),
    "stolen": ("кража", "robado", "roubado"),
    "theft": ("кража", "robo", "roubo"),
    "sick": ("плохо", "enfermo", "doente"),
    "danger": ("опасность", "peligro", "perigo"),
}

REPLIES = {
    "会一点": ("Немного", "Un poco", "Um pouco"),
    "不会": ("Нет", "No", "Não"),
    "在那边": ("Вон там", "Allí", "Ali"),
    "在左边": ("Слева", "A la izquierda", "À esquerda"),
    "直走就到": ("Прямо и будете на месте", "Siga todo recto", "Siga em frente"),
    "可以": ("Да", "Sí", "Sim"),
    "只收微信或支付宝": ("Только WeChat или Alipay", "Solo WeChat o Alipay", "Só WeChat ou Alipay"),
}

# phrase translations
DATA = {
"ess-hello": ("Здравствуйте", "Hola", "Olá", "Стандартное вежливое приветствие.", "Saludo educado habitual.", "Saudação educada padrão."),
"ess-thank-you": ("Спасибо", "Gracias", "Obrigado", None, None, None),
"ess-excuse-me": ("Извините / Можно спросить…", "Perdón / ¿Puedo preguntar…?", "Com licença / Posso perguntar…?", "Так начинают вежливый вопрос.", "Úsalo para empezar una pregunta.", "Use para começar uma pergunta."),
"ess-sorry": ("Извините", "Lo siento", "Desculpe", None, None, None),
"ess-dont-understand": ("Извините, я не понимаю", "Lo siento, no entiendo", "Desculpe, não entendo", "Полезно, если говорят слишком быстро.", "Útil si el chino es demasiado rápido.", "Útil quando o chinês está rápido demais."),
"ess-speak-english": ("Вы говорите по-английски?", "¿Habla inglés?", "Você fala inglês?", None, None, None),
"ess-toilet": ("Где туалет?", "¿Dónde está el baño?", "Onde fica o banheiro?", None, None, None),
"ess-help": ("Можете мне помочь?", "¿Puede ayudarme?", "Pode me ajudar?", None, None, None),
"ess-photo": ("Можете сфотографировать меня?", "¿Puede tomarme una foto?", "Pode tirar uma foto para mim?", None, None, None),
"ess-slow": ("Говорите, пожалуйста, медленнее", "Hable más despacio, por favor", "Por favor, fale mais devagar", None, None, None),
"air-checkin": ("Где стойка регистрации?", "¿Dónde está el mostrador de facturación?", "Onde fica o balcão de check-in?", None, None, None),
"air-boarding-pass": ("Предъявите посадочный талон и паспорт", "Muestre su tarjeta de embarque y pasaporte", "Mostre o cartão de embarque e o passaporte", "Так могут сказать у выхода на посадку.", "Puedes oírlo en la puerta de embarque.", "Você pode ouvir isso no portão de embarque."),
"air-gate": ("Где выход на посадку?", "¿Dónde está la puerta de embarque?", "Onde fica o portão de embarque?", None, None, None),
"air-baggage": ("Где лента выдачи багажа?", "¿Dónde está la cinta de equipaje?", "Onde fica a esteira de bagagem?", None, None, None),
"air-delay": ("Рейс задерживается?", "¿El vuelo está retrasado?", "O voo está atrasado?", None, None, None),
"air-customs": ("Таможня в эту сторону?", "¿La aduana es por aquí?", "A alfândega é por aqui?", None, None, None),
"air-lost-luggage": ("Мой багаж пропал", "Falta mi equipaje", "Minha bagagem desapareceu", "Идите к стойке багажа авиакомпании.", "Vaya al mostrador de equipaje de la aerolínea.", "Vá ao balcão de bagagem da companhia aérea."),
"air-transfer": ("У меня пересадка. Как пройти?", "Tengo un vuelo de conexión. ¿Cómo llego?", "Tenho um voo de conexão. Como chego lá?", None, None, None),
"tr-taxi-address": ("Шифу, отвезите меня по этому адресу", "Maestro, lléveme a esta dirección", "Motorista, me leve a este endereço", "Покажите адрес на телефоне, когда говорите это.", "Muestra la dirección en el teléfono al decirlo.", "Mostre o endereço no celular ao falar."),
"tr-stop-here": ("Остановитесь здесь, пожалуйста", "Pare aquí, por favor", "Pare aqui, por favor", None, None, None),
"tr-how-much": ("Сколько примерно будет доехать?", "¿Cuánto cuesta más o menos llegar?", "Quanto custa mais ou menos para chegar?", None, None, None),
"tr-metro": ("Где ближайшая станция метро?", "¿Dónde está la estación de metro más cercana?", "Onde fica a estação de metrô mais próxima?", None, None, None),
"tr-which-line": ("На какую линию садиться?", "¿Qué línea de metro debo tomar?", "Qual linha de metrô eu pego?", None, None, None),
"tr-train-station": ("Как пройти на вокзал?", "¿Cómo llego a la estación de tren?", "Como chego à estação de trem?", None, None, None),
"tr-platform": ("Какая платформа?", "¿Cuál es el andén?", "Qual é a plataforma?", "Полезно на скоростных поездах.", "Útil en el tren de alta velocidad.", "Útil no trem-bala."),
"tr-train-number": ("Это поезд G123?", "¿Este es el tren G123?", "Este é o trem G123?", "Подставьте свой номер поезда.", "Sustituye el número por el tuyo.", "Troque o número pelo seu."),
"tr-ticket": ("Где купить билет?", "¿Dónde puedo comprar un billete?", "Onde posso comprar um bilhete?", None, None, None),
"tr-left-right": ("Налево или направо?", "¿A la izquierda o a la derecha?", "É para a esquerda ou para a direita?", None, None, None),
"hot-checkin": ("Здравствуйте, я хочу зарегистрироваться", "Hola, quiero hacer el check-in", "Olá, quero fazer o check-in", None, None, None),
"hot-booking": ("У меня бронь, фамилия…", "Tengo una reserva. El nombre es…", "Tenho uma reserva. O nome é…", "После этой фразы назовите имя.", "Di tu nombre después.", "Diga seu nome em seguida."),
"hot-booking-problem": ("Похоже, с моей бронью проблема", "Parece que hay un problema con mi reserva", "Parece que há um problema com a minha reserva", None, None, None),
"hot-wifi": ("Какой пароль от Wi‑Fi?", "¿Cuál es la contraseña del Wi‑Fi?", "Qual é a senha do Wi‑Fi?", None, None, None),
"hot-checkout": ("Я хочу выехать / сделать check-out", "Quiero hacer el check-out", "Quero fazer o check-out", None, None, None),
"hot-room": ("Какой у меня номер комнаты?", "¿Cuál es mi número de habitación?", "Qual é o número do meu quarto?", None, None, None),
"hot-breakfast": ("Где завтрак?", "¿Dónde está el desayuno?", "Onde fica o café da manhã?", None, None, None),
"hot-extra-towel": ("Можно ещё одно полотенце?", "¿Me puede dar otra toalla?", "Pode me dar outra toalha?", None, None, None),
"food-menu": ("Есть меню на английском?", "¿Tienen menú en inglés?", "Vocês têm cardápio em inglês?", None, None, None),
"food-not-spicy": ("Пожалуйста, не очень остро", "Por favor, que no pique mucho", "Por favor, sem muito picante", None, None, None),
"food-allergy": ("У меня аллергия на арахис", "Soy alérgico/a al cacahuete", "Tenho alergia a amendoim", "При необходимости замените 花生 на свой аллерген.", "Sustituye 花生 por tu alérgeno si hace falta.", "Troque 花生 pelo seu alérgeno se precisar."),
"food-ingredients": ("Что в этом блюде?", "¿Qué lleva este plato?", "O que tem neste prato?", None, None, None),
"food-no-meat": ("Мне без мяса", "No quiero carne", "Não quero carne", None, None, None),
"food-bill": ("Счёт, пожалуйста", "La cuenta, por favor", "A conta, por favor", "Вежливый способ попросить счёт в ресторане.", "Forma educada de pedir la cuenta.", "Jeito educado de pedir a conta."),
"food-delicious": ("Очень вкусно", "Está delicioso", "Está uma delícia", None, None, None),
"food-recommend": ("Что посоветуете?", "¿Qué recomienda?", "O que você recomenda?", None, None, None),
"food-water": ("Принесите, пожалуйста, стакан воды", "Un vaso de agua, por favor", "Por favor, um copo d’água", None, None, None),
"food-takeaway": ("Можно с собой?", "¿Me lo puede poner para llevar?", "Pode ser para viagem?", None, None, None),
"shop-how-much": ("Сколько это стоит?", "¿Cuánto cuesta esto?", "Quanto custa isto?", None, None, None),
"shop-too-expensive": ("Дорого. Можно чуть дешевле?", "Es caro. ¿Puede ser un poco más barato?", "Está caro. Pode ser um pouco mais barato?", "Естественнее на рынке, чем в крупном магазине.", "Más natural en mercados que en grandes tiendas.", "Mais natural em feiras do que em lojas grandes."),
"shop-cash": ("Можно наличными?", "¿Puedo pagar en efectivo?", "Posso pagar em dinheiro?", None, None, None),
"shop-alipay": ("Можно через Alipay?", "¿Puedo pagar con Alipay?", "Posso pagar com Alipay?", None, None, None),
"shop-wechat-pay": ("Можно через WeChat Pay?", "¿Puedo pagar con WeChat Pay?", "Posso pagar com WeChat Pay?", None, None, None),
"shop-receipt": ("Дайте, пожалуйста, чек / фапяо", "Por favor, deme un recibo / fapiao", "Por favor, me dê um recibo / fapiao", None, None, None),
"shop-try-on": ("Можно примерить?", "¿Puedo probármelo?", "Posso experimentar?", None, None, None),
"shop-smaller": ("Есть размер поменьше?", "¿Tienen una talla más pequeña?", "Tem um tamanho menor?", None, None, None),
"net-wifi": ("У вас есть Wi‑Fi?", "¿Tienen Wi‑Fi?", "Vocês têm Wi‑Fi?", None, None, None),
"net-password": ("Какой пароль от Wi‑Fi?", "¿Cuál es la contraseña del Wi‑Fi?", "Qual é a senha do Wi‑Fi?", None, None, None),
"net-sim": ("Я хочу купить SIM-карту", "Quiero comprar una tarjeta SIM", "Quero comprar um chip", None, None, None),
"net-esim": ("У вас есть eSIM?", "¿Tienen eSIM?", "Vocês têm eSIM?", None, None, None),
"net-scan": ("Отсканируйте этот код, пожалуйста", "Escanee este código, por favor", "Por favor, escaneie este código", None, None, None),
"net-no-signal": ("Здесь нет сигнала", "Aquí no hay señal", "Aqui não tem sinal", None, None, None),
"net-charge": ("Где можно зарядить телефон?", "¿Dónde puedo cargar el teléfono?", "Onde posso carregar o celular?", None, None, None),
"em-help": ("На помощь!", "¡Socorro!", "Socorro!", None, None, None),
"em-police": ("Вызовите, пожалуйста, полицию", "Llame a la policía, por favor", "Por favor, chame a polícia", None, None, None),
"em-ambulance": ("Вызовите скорую", "Llame una ambulancia, por favor", "Por favor, chame uma ambulância", None, None, None),
"em-hospital": ("Где ближайшая больница?", "¿Dónde está el hospital más cercano?", "Onde fica o hospital mais próximo?", None, None, None),
"em-pharmacy": ("Рядом есть аптека?", "¿Hay una farmacia cerca?", "Tem uma farmácia por perto?", None, None, None),
"em-passport-lost": ("Я потерял паспорт", "He perdido el pasaporte", "Perdi o passaporte", "Свяжитесь с посольством и полицией.", "Contacta tu embajada y la policía local.", "Contate sua embaixada e a polícia local."),
"em-stolen": ("У меня украли вещи", "Me han robado las cosas", "Minhas coisas foram roubadas", None, None, None),
"em-feel-sick": ("Мне плохо", "No me siento bien", "Não estou me sentindo bem", None, None, None),
"em-danger": ("Здесь опасно", "Este sitio es peligroso", "Este lugar é perigoso", None, None, None),
}


def translate_tags(tags: list[str]) -> dict[str, list[str]]:
    ru, es, pt = [], [], []
    for tag in tags:
        mapped = TAG_MAP.get(tag.lower())
        if mapped:
            ru.append(mapped[0]); es.append(mapped[1]); pt.append(mapped[2])
        else:
            ru.append(tag); es.append(tag); pt.append(tag)
    return {"en": list(tags), "ru": ru, "es": es, "pt-BR": pt}


def main() -> int:
    phrases = json.loads(PATH.read_text(encoding="utf-8"))
    missing = [p["id"] for p in phrases if p["id"] not in DATA]
    if missing:
        raise SystemExit(f"missing translations for: {missing}")

    for phrase in phrases:
        ru, es, pt, nru, nes, npt = DATA[phrase["id"]]
        phrase["translations"] = {
            "en": phrase["english"],
            "ru": ru,
            "es": es,
            "pt-BR": pt,
        }
        if phrase.get("usageNote"):
            phrase["usageNoteTranslations"] = {
                "en": phrase["usageNote"],
                "ru": nru or phrase["usageNote"],
                "es": nes or phrase["usageNote"],
                "pt-BR": npt or phrase["usageNote"],
            }
        tags = phrase.get("tags") or []
        if tags:
            phrase["tagTranslations"] = translate_tags(tags)
        replies = phrase.get("possibleReplies") or []
        new_replies = []
        for reply in replies:
            zh = reply["chinese"]
            if zh not in REPLIES:
                raise SystemExit(f"missing reply translation: {zh}")
            rru, res, rpt = REPLIES[zh]
            reply = dict(reply)
            reply["translations"] = {
                "en": reply["english"],
                "ru": rru,
                "es": res,
                "pt-BR": rpt,
            }
            new_replies.append(reply)
        if replies:
            phrase["possibleReplies"] = new_replies

    PATH.write_text(json.dumps(phrases, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(f"updated {len(phrases)} phrases")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
