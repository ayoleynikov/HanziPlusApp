//
//  PathGrammarCardLibrary.swift
//  HanziPlus
//

import Foundation

enum PathGrammarCardLibrary {

    static func card(lessonNumber: Int, chapterNumber: Int) -> PathGrammarCard? {
        cards[lessonNumber]?[chapterNumber]
    }

    private static let cards: [Int: [Int: PathGrammarCard]] = [
        1: lesson1Cards,
        2: lesson2Cards,
        3: lesson3Cards,
        4: lesson4Cards,
        5: lesson5Cards,
        6: lesson6Cards,
        7: lesson7Cards,
        8: lesson8Cards,
        9: lesson9Cards,
        10: lesson10Cards,
        11: lesson11Cards,
        12: lesson12Cards,
        13: lesson13Cards,
        14: lesson14Cards,
        15: lesson15Cards,
    ]
}

private func tr(_ ru: String, _ en: String, _ es: String, _ pt: String) -> PathLocalizedText {
    PathLocalizedText(values: ["ru": ru, "en": en, "es": es, "pt-BR": pt])
}

private func example(_ hanzi: String, _ pinyin: String, _ ru: String, _ en: String, _ es: String, _ pt: String) -> PathGrammarCard.PathGrammarExample {
    PathGrammarCard.PathGrammarExample(
        hanzi: hanzi,
        pinyin: pinyin,
        translation: tr(ru, en, es, pt)
    )
}

private let lesson1Cards: [Int: PathGrammarCard] = [
    2: PathGrammarCard(
        id: "l01_greeting",
        title: tr("Приветствие 你好", "Greeting 你好", "Saludo 你好", "Saudação 你好"),
        explanation: tr(
            "Два слова 你 и 好 образуют приветствие. Буквально: «ты хороший».",
            "The words 你 and 好 form a greeting. Literally: “you good.”",
            "Las palabras 你 y 好 forman un saludo. Literalmente: «tú bueno».",
            "As palavras 你 e 好 formam uma saudação. Literalmente: «você bom»."
        ),
        formula: tr("你 + 好 → 你好", "你 + 好 → 你好", "你 + 好 → 你好", "你 + 好 → 你好"),
        positiveExample: example("你好！", "Nǐ hǎo!", "Привет!", "Hello!", "¡Hola!", "Olá!"),
        questionExample: nil,
        negativeExample: nil,
        practicePrompt: nil
    ),
    3: PathGrammarCard(
        id: "l01_ma_question",
        title: tr("Вопрос с 吗", "Questions with 吗", "Preguntas con 吗", "Perguntas com 吗"),
        explanation: tr(
            "Частица 吗 в конце превращает утверждение в вопрос «да/нет». Перед 吗 не ставят 不.",
            "The particle 吗 at the end turns a statement into a yes/no question.",
            "La partícula 吗 al final convierte una frase en pregunta de sí/no.",
            "A partícula 吗 no final transforma uma frase em pergunta de sim/não."
        ),
        formula: tr("Утверждение + 吗", "Statement + 吗", "Oración + 吗", "Frase + 吗"),
        positiveExample: example("你好。", "Nǐ hǎo.", "Привет.", "Hello.", "Hola.", "Olá."),
        questionExample: example("你好吗？", "Nǐ hǎo ma?", "Как ты?", "How are you?", "¿Cómo estás?", "Como você está?"),
        negativeExample: example("不好。", "Bù hǎo.", "Не очень.", "Not good.", "No muy bien.", "Não muito bem."),
        practicePrompt: nil
    ),
]

private let lesson2Cards: [Int: PathGrammarCard] = [
    1: PathGrammarCard(
        id: "l02_hen",
        title: tr("Очень — 很", "Very — 很", "Muy — 很", "Muito — 很"),
        explanation: tr("很 ставится перед прилагательным: 很好 — «очень хорошо».", "很 goes before adjectives: 很好 — “very good.”", "很 va antes del adjetivo: 很好 — «muy bien».", "很 vem antes do adjetivo: 很好 — «muito bom»."),
        formula: tr("很 + прилагательное", "很 + adjective", "很 + adjetivo", "很 + adjetivo"),
        positiveExample: example("很好！", "Hěn hǎo!", "Очень хорошо!", "Very good!", "¡Muy bien!", "Muito bom!"),
        questionExample: example("你忙吗？", "Nǐ máng ma?", "Ты занят?", "Are you busy?", "¿Estás ocupado?", "Você está ocupado?"),
        negativeExample: example("不忙。", "Bù máng.", "Не занят.", "Not busy.", "No ocupado.", "Não ocupado."),
        practicePrompt: nil
    ),
]

private let lesson3Cards: [Int: PathGrammarCard] = [
    1: PathGrammarCard(
        id: "l03_ma_time",
        title: tr("Вопрос и время", "Questions and time", "Preguntas y tiempo", "Perguntas e tempo"),
        explanation: tr("С 吗 спрашивают о действии. 明天 — «завтра».", "Use 吗 for yes/no questions. 明天 means tomorrow.", "Usa 吗 para preguntas de sí/no. 明天 es mañana.", "Use 吗 para perguntas sim/não. 明天 é amanhã."),
        formula: tr("Глагол + 吗", "Verb + 吗", "Verbo + 吗", "Verbo + 吗"),
        positiveExample: example("明天见！", "Míngtiān jiàn!", "До завтра!", "See you tomorrow!", "¡Hasta mañana!", "Até amanhã!"),
        questionExample: example("你去邮局吗？", "Nǐ qù yóujú ma?", "Ты идёшь на почту?", "Are you going to the post office?", "¿Vas a la oficina de correos?", "Você vai aos correios?"),
        negativeExample: example("不去。", "Bú qù.", "Не иду.", "Not going.", "No voy.", "Não vou."),
        practicePrompt: nil
    ),
]

private let lesson4Cards: [Int: PathGrammarCard] = [
    1: PathGrammarCard(
        id: "l04_nar",
        title: tr("Где — 哪儿", "Where — 哪儿", "Dónde — 哪儿", "Onde — 哪儿"),
        explanation: tr("哪儿 спрашивает о месте. A-not-A: 回不回 — «вернёшься или нет».", "哪儿 asks about place. A-not-A: 回不回 — “will you return or not.”", "哪儿 pregunta el lugar. A-not-A: 回不回.", "哪儿 pergunta o lugar. A-not-A: 回不回."),
        formula: tr("去哪儿？ / V不V", "去哪儿？ / V不V", "去哪儿？ / V不V", "去哪儿？ / V不V"),
        positiveExample: example("去学校。", "Qù xuéxiào.", "Иду в школу.", "Go to school.", "Voy a la escuela.", "Vou à escola."),
        questionExample: example("你去哪儿？", "Nǐ qù nǎr?", "Куда ты идёшь?", "Where are you going?", "¿A dónde vas?", "Para onde você vai?"),
        negativeExample: example("不回。", "Bù huí.", "Не возвращаюсь.", "Not returning.", "No vuelvo.", "Não volto."),
        practicePrompt: nil
    ),
]

private let lesson5Cards: [Int: PathGrammarCard] = [
    1: PathGrammarCard(
        id: "l05_shi",
        title: tr("Это — 是", "This is — 是", "Esto es — 是", "Isto é — 是"),
        explanation: tr("是 связывает подлежащее и именную часть. 这 — «это». 您 и 请 — вежливые формы.", "是 links subject and noun. 这 is “this.” 您 and 请 are polite forms.", "是 une sujeto y sustantivo. 这 es «esto». 您 y 请 son formas corteses.", "是 liga sujeito e substantivo. 这 é «isto». 您 e 请 são formas educadas."),
        formula: tr("这 + 是 + …", "这 + 是 + …", "这 + 是 + …", "这 + 是 + …"),
        positiveExample: example("这是王老师。", "Zhè shì Wáng lǎoshī.", "Это учитель Ван.", "This is Teacher Wang.", "Este es el profesor Wang.", "Este é o professor Wang."),
        questionExample: example("您好！", "Nín hǎo!", "Здравствуйте!", "Hello!", "¡Hola!", "Olá!"),
        negativeExample: nil,
        practicePrompt: nil
    ),
]

private let lesson6Cards: [Int: PathGrammarCard] = [
    1: PathGrammarCard(
        id: "l06_questions",
        title: tr("什么, 谁, 哪国人", "什么, 谁, 哪国人", "什么, 谁, 哪国人", "什么, 谁, 哪国人"),
        explanation: tr("什么 — «что», 谁 — «кто». 的 показывает принадлежность.", "什么 is “what,” 谁 is “who.” 的 shows possession.", "什么 es «qué», 谁 es «quién». 的 indica posesión.", "什么 é «o quê», 谁 é «quem». 的 indica posse."),
        formula: tr("谁的 + существительное", "谁的 + noun", "谁的 + sustantivo", "谁的 + substantivo"),
        positiveExample: example("我姓张。", "Wǒ xìng Zhāng.", "Моя фамилия Чжан.", "My surname is Zhang.", "Mi apellido es Zhang.", "Meu sobrenome é Zhang."),
        questionExample: example("你叫什么名字？", "Nǐ jiào shénme míngzi?", "Как тебя зовут?", "What is your name?", "¿Cómo te llamas?", "Como você se chama?"),
        negativeExample: nil,
        practicePrompt: nil
    ),
]

private let lesson7Cards: [Int: PathGrammarCard] = [
    1: PathGrammarCard(
        id: "l07_food",
        title: tr("吃什么, 要, 碗", "吃什么, 要, 碗", "吃什么, 要, 碗", "吃什么, 要, 碗"),
        explanation: tr("吃什么 спрашивает о еде. 要 — «хотеть». 碗 — счётное слово для супа.", "吃什么 asks about food. 要 means “want.” 碗 counts bowls of soup.", "吃什么 pregunta por comida. 要 es «querer». 碗 cuenta tazones.", "吃什么 pergunta sobre comida. 要 é «querer». 碗 conta tigelas."),
        formula: tr("要 + число + 碗 + блюдо", "要 + number + 碗 + dish", "要 + número + 碗 + plato", "要 + número + 碗 + prato"),
        positiveExample: example("我吃馒头。", "Wǒ chī mántou.", "Я ем маньтоу.", "I eat mantou.", "Como mantou.", "Eu como mantou."),
        questionExample: example("你吃什么？", "Nǐ chī shénme?", "Что ты ешь?", "What are you eating?", "¿Qué comes?", "O que você come?"),
        negativeExample: nil,
        practicePrompt: nil
    ),
]

private let lesson8Cards: [Int: PathGrammarCard] = [
    1: PathGrammarCard(
        id: "l08_money",
        title: tr("多少, 斤, 太贵了", "多少, 斤, 太贵了", "多少, 斤, 太贵了", "多少, 斤, 太贵了"),
        explanation: tr("多少钱 — «сколько стоит». 斤 — мера веса. 太贵了 — «слишком дорого».", "多少钱 asks price. 斤 is a weight unit. 太贵了 means “too expensive.”", "多少钱 pregunta el precio. 斤 es una unidad de peso. 太贵了 es «demasiado caro».", "多少钱 pergunta o preço. 斤 é unidade de peso. 太贵了 é «caro demais»."),
        formula: tr("多少 + 钱", "多少 + 钱", "多少 + 钱", "多少 + 钱"),
        positiveExample: example("三块。", "Sān kuài.", "Три юаня.", "Three yuan.", "Tres yuanes.", "Três yuan."),
        questionExample: example("一共多少钱？", "Yígòng duōshao qián?", "Сколько всего?", "How much in total?", "¿Cuánto en total?", "Quanto no total?"),
        negativeExample: nil,
        practicePrompt: nil
    ),
]

private let lesson9Cards: [Int: PathGrammarCard] = [
    1: PathGrammarCard(
        id: "l09_numbers",
        title: tr("百, 千, 万 и валюты", "百, 千, 万 and currencies", "百, 千, 万 y monedas", "百, 千, 万 e moedas"),
        explanation: tr("百 — сто, 千 — тысяча, 万 — десять тысяч. 换 — менять валюту.", "百 is hundred, 千 thousand, 万 ten thousand. 换 means exchange.", "百 es cien, 千 mil, 万 diez mil. 换 es cambiar.", "百 é cem, 千 mil, 万 dez mil. 换 é trocar."),
        formula: tr("换 + валюта", "换 + currency", "换 + moneda", "换 + moeda"),
        positiveExample: example("我换人民币。", "Wǒ huàn rénmínbì.", "Меняю на юани.", "I exchange to RMB.", "Cambio a yuanes.", "Troco para yuan."),
        questionExample: example("换多少？", "Huàn duōshao?", "Сколько менять?", "How much to exchange?", "¿Cuánto cambiar?", "Quanto trocar?"),
        negativeExample: nil,
        practicePrompt: nil
    ),
]

private let lesson10Cards: [Int: PathGrammarCard] = [
    1: PathGrammarCard(
        id: "l10_location",
        title: tr("在, 住, адрес", "在, 住, address", "在, 住, dirección", "在, 住, endereço"),
        explanation: tr("在 — «находиться», 住 — «жить». 号 — номер дома или комнаты.", "在 means “be at,” 住 means “live.” 号 is a house/room number.", "在 es «estar en», 住 es «vivir». 号 es número.", "在 é «estar em», 住 é «morar». 号 é número."),
        formula: tr("在 + место", "在 + place", "在 + lugar", "在 + lugar"),
        positiveExample: example("他在家呢。", "Tā zài jiā ne.", "Он дома.", "He is at home.", "Está en casa.", "Ele está em casa."),
        questionExample: example("他住哪儿？", "Tā zhù nǎr?", "Где он живёт?", "Where does he live?", "¿Dónde vive?", "Onde ele mora?"),
        negativeExample: nil,
        practicePrompt: nil
    ),
]

private let lesson11Cards: [Int: PathGrammarCard] = [
    1: PathGrammarCard(
        id: "l11_dou_ye",
        title: tr("都, 也, 俩", "都, 也, 俩", "都, 也, 俩", "都, 也, 俩"),
        explanation: tr("都 — «все», 也 — «тоже». 俩 — разговорное «двое».", "都 means “all,” 也 means “also.” 俩 is colloquial “two (people).”", "都 es «todos», 也 es «también». 俩 es «dos (personas)».", "都 é «todos», 也 é «também». 俩 é «dois (pessoas)»."),
        formula: tr("都 / 也 + глагол", "都 / 也 + verb", "都 / 也 + verbo", "都 / 也 + verbo"),
        positiveExample: example("我们都是留学生。", "Wǒmen dōu shì liúxuéshēng.", "Мы все иностранные студенты.", "We are all international students.", "Todos somos estudiantes extranjeros.", "Todos somos estudantes estrangeiros."),
        questionExample: example("你也是中国人吗？", "Nǐ yě shì Zhōngguó rén ma?", "Ты тоже китаец?", "Are you also Chinese?", "¿Tú también eres chino?", "Você também é chinês?"),
        negativeExample: example("不是。我是学生。", "Bú shì. Wǒ shì xuésheng.", "Нет. Я студент.", "No. I am a student.", "No. Soy estudiante.", "Não. Sou estudante."),
        practicePrompt: nil
    ),
]

private let lesson12Cards: [Int: PathGrammarCard] = [
    1: PathGrammarCard(
        id: "l12_zenmeyang",
        title: tr("在 + место + действие", "在 + place + action", "在 + lugar + acción", "在 + lugar + ação"),
        explanation: tr("Вопрос 怎么样 спрашивает «как?». 比较 — «сравнительно».", "怎么样 asks “how about?” 比较 means “relatively.”", "怎么样 pregunta «¿qué tal?». 比较 es «relativamente».", "怎么样 pergunta «como é?». 比较 é «relativamente»."),
        formula: tr("在 + место + 学习", "在 + place + 学习", "在 + lugar + 学习", "在 + lugar + 学习"),
        positiveExample: example("很好！", "Hěn hǎo!", "Очень хорошо!", "Very good!", "¡Muy bien!", "Muito bom!"),
        questionExample: example("你觉得学习汉语难吗？", "Nǐ juéde xuéxí Hànyǔ nán ma?", "Как тебе учить китайский?", "Do you find Chinese hard?", "¿Te parece difícil el chino?", "Você acha o chinês difícil?"),
        negativeExample: nil,
        practicePrompt: nil
    ),
]

private let lesson13Cards: [Int: PathGrammarCard] = [
    1: PathGrammarCard(
        id: "l13_you",
        title: tr("有 / 没有, 是不是", "有 / 没有, 是不是", "有 / 没有, 是不是", "有 / 没有, 是不是"),
        explanation: tr("有 — «есть», 没有 — «нет». 这/那 — «это/то».", "有 means “have,” 没有 means “don’t have.” 这/那 are this/that.", "有 es «tener», 没有 es «no tener». 这/那 son esto/eso.", "有 é «ter», 没有 é «não ter». 这/那 são isto/isso."),
        formula: tr("有 / 没有 + существительное", "有 / 没有 + noun", "有 / 没有 + sustantivo", "有 / 没有 + substantivo"),
        positiveExample: example("有。", "Yǒu.", "Есть.", "Yes, there is.", "Sí, hay.", "Sim, tem."),
        questionExample: example("你有没有箱子？", "Nǐ yǒu méiyǒu xiāngzi?", "У тебя есть чемодан?", "Do you have a suitcase?", "¿Tienes maleta?", "Você tem mala?"),
        negativeExample: example("不是。", "Bú shì.", "Нет.", "No.", "No.", "Não."),
        practicePrompt: nil
    ),
]

private let lesson14Cards: [Int: PathGrammarCard] = [
    1: PathGrammarCard(
        id: "l14_haishi",
        title: tr("还是, 有一点儿", "还是, 有一点儿", "还是, 有一点儿", "还是, 有一点儿"),
        explanation: tr("还是 предлагает выбор. Прилагательное + 的 описывает предмет. 有一点儿 — «немного».", "还是 offers a choice. Adjective + 的 describes things. 有一点儿 means “a little.”", "还是 ofrece elección. Adjetivo + 的 describe. 有一点儿 es «un poco».", "还是 oferece escolha. Adjetivo + 的 descreve. 有一点儿 é «um pouco»."),
        formula: tr("A 还是 B", "A 还是 B", "A 还是 B", "A 还是 B"),
        positiveExample: example("喝杯茶吧！", "Hē bēi chá ba!", "Выпей чаю!", "Have some tea!", "¡Toma té!", "Tome chá!"),
        questionExample: example("你喝茶还是咖啡？", "Nǐ hē chá háishi kāfēi?", "Чай или кофе?", "Tea or coffee?", "¿Té o café?", "Chá ou café?"),
        negativeExample: nil,
        practicePrompt: nil
    ),
]

private let lesson15Cards: [Int: PathGrammarCard] = [
    1: PathGrammarCard(
        id: "l15_family",
        title: tr("几, 口, семья", "几, 口, family", "几, 口, familia", "几, 口, família"),
        explanation: tr("几口人 спрашивает о числе людей в семье. 口 — счётное слово для членов семьи.", "几口人 asks family size. 口 counts family members.", "几口人 pregunta el tamaño familiar. 口 cuenta miembros.", "几口人 pergunta o tamanho da família. 口 conta membros."),
        formula: tr("几 + 口 + 人", "几 + 口 + 人", "几 + 口 + 人", "几 + 口 + 人"),
        positiveExample: example("我家有五口人。", "Wǒ jiā yǒu wǔ kǒu rén.", "В нашей семье пять человек.", "There are five people in my family.", "Somos cinco en mi familia.", "Somos cinco na minha família."),
        questionExample: example("你家有几口人？", "Nǐ jiā yǒu jǐ kǒu rén?", "Сколько человек в твоей семье?", "How many people are in your family?", "¿Cuántas personas hay en tu familia?", "Quantas pessoas há na sua família?"),
        negativeExample: nil,
        practicePrompt: nil
    ),
]
