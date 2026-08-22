//
//  JourneyCityCatalog.swift
//  HanziPlus
//

import SwiftUI

enum JourneyCityCatalog {
    static let all: [JourneyCity] = [
        beijing, xian, chengdu, guilin, shanghai, hangzhou, suzhou, harbin, hongkong
    ]

    // MARK: - Beijing

    private static let beijing = JourneyCity.make(
        id: "beijing",
        name: "Beijing",
        emoji: "🏯",
        province: "Beijing Municipality",
        population: "21.5 million",
        introduction: "Welcome to Beijing — China's historic capital with more than 3,000 years of history.",
        famousFor: "Imperial palaces, hutong alleys, and Peking opera",
        bestSeason: "September – October ( crisp autumn skies )",
        localFood: "Peking Duck, jianbing, zhajiangmian",
        culturalFact: "Beijing has been China's capital for over 700 years and is home to the Forbidden City.",
        localAchievement: "Capital Explorer",
        souvenirEmoji: "🏮",
        souvenirName: "Lantern",
        travelCollectible: "🏯",
        theme: JourneyColorTheme(
            primary: Color(red: 0.86, green: 0.15, blue: 0.15),
            secondary: Color(red: 0.95, green: 0.75, blue: 0.2),
            heroGradient: [
                Color(red: 0.75, green: 0.1, blue: 0.12),
                Color(red: 0.95, green: 0.55, blue: 0.15)
            ]
        ),
        facts: [
            JourneyFact(id: "bj1", icon: "building.columns.fill", text: "The Forbidden City has nearly 9,000 rooms."),
            JourneyFact(id: "bj2", icon: "figure.walk", text: "The Great Wall stretches over 21,000 km across northern China."),
            JourneyFact(id: "bj3", icon: "theatermasks.fill", text: "Beijing opera is one of China's most celebrated art forms.")
        ],
        attractions: [
            JourneyAttraction(id: "bj-a1", name: "Forbidden City", emoji: "🏯", description: "Imperial palace of the Ming and Qing dynasties."),
            JourneyAttraction(id: "bj-a2", name: "Great Wall", emoji: "🧱", description: "Ancient fortification winding through mountains."),
            JourneyAttraction(id: "bj-a3", name: "Temple of Heaven", emoji: "⛩", description: "Sacred site where emperors prayed for harvests."),
            JourneyAttraction(id: "bj-a4", name: "Peking Duck", emoji: "🦆", description: "Crispy-skinned duck, Beijing's signature dish.")
        ],
        vocabulary: vocab(
            ("北京", "Běijīng", "Beijing", "Пекин", "Pekín", "Pequim"),
            ("故宫", "Gùgōng", "Forbidden City", "Запретный город", "Ciudad Prohibida", "Cidade Proibida"),
            ("长城", "Chángchéng", "Great Wall", "Великая стена", "Gran Muralla", "Grande Muralha"),
            ("酒店", "jiǔdiàn", "hotel", "отель", "hotel", "hotel"),
            ("旅游", "lǚyóu", "travel", "путешествовать", "viajar", "viajar"),
            ("地铁", "dìtiě", "subway", "метро", "metro", "metrô")
        ),
        miniActivity: JourneyMiniActivity(
            title: "Find the Great Wall",
            instruction: "Tap the hidden Great Wall tile before time runs out!",
            icon: "binoculars.fill",
            targetEmoji: "🧱",
            xpReward: 25
        ),
        requirements: .none
    )

    // MARK: - Xi'an

    private static let xian = JourneyCity.make(
        id: "xian",
        name: "Xi'an",
        emoji: "🏺",
        province: "Shaanxi",
        population: "13 million",
        introduction: "Step into Xi'an — ancient capital of thirteen dynasties and gateway to the Silk Road.",
        famousFor: "Terracotta Warriors, city walls, and Muslim Quarter street food",
        bestSeason: "March – May & September – November",
        localFood: "Biang biang noodles, roujiamo, yangrou paomo",
        culturalFact: "Xi'an was the starting point of the ancient Silk Road and capital of 13 dynasties.",
        localAchievement: "Silk Road Scholar",
        souvenirEmoji: "🏺",
        souvenirName: "Terracotta Warrior",
        travelCollectible: "🗿",
        theme: JourneyColorTheme(
            primary: Color(red: 0.82, green: 0.42, blue: 0.18),
            secondary: Color(red: 0.65, green: 0.32, blue: 0.14),
            heroGradient: [
                Color(red: 0.72, green: 0.35, blue: 0.12),
                Color(red: 0.9, green: 0.55, blue: 0.25)
            ]
        ),
        facts: [
            JourneyFact(id: "xa1", icon: "person.3.fill", text: "Over 8,000 Terracotta Warriors guard Emperor Qin's tomb."),
            JourneyFact(id: "xa2", icon: "road.lanes", text: "The Silk Road began here, connecting China to the Mediterranean."),
            JourneyFact(id: "xa3", icon: "square.fill", text: "Xi'an's city wall is one of the best preserved in the world.")
        ],
        attractions: [
            JourneyAttraction(id: "xa-a1", name: "Terracotta Army", emoji: "🏺", description: "Life-size clay soldiers buried with China's first emperor."),
            JourneyAttraction(id: "xa-a2", name: "City Wall", emoji: "🧱", description: "Cycle atop Ming-era fortifications."),
            JourneyAttraction(id: "xa-a3", name: "Muslim Quarter", emoji: "🕌", description: "Vibrant lanes of street food and culture."),
            JourneyAttraction(id: "xa-a4", name: "Big Wild Goose Pagoda", emoji: "🛕", description: "Buddhist pagoda from the Tang dynasty.")
        ],
        vocabulary: vocab(
            ("西安", "Xī'ān", "Xi'an", "Сиань", "Xi'an", "Xi'an"),
            ("历史", "lìshǐ", "history", "история", "historia", "história"),
            ("博物馆", "bówùguǎn", "museum", "музей", "museo", "museu"),
            ("古城", "gǔchéng", "ancient city", "древний город", "ciudad antigua", "cidade antiga"),
            ("文化", "wénhuà", "culture", "культура", "cultura", "cultura"),
            ("参观", "cānguān", "to visit", "посещать", "visitar", "visitar")
        ),
        miniActivity: JourneyMiniActivity(
            title: "Assemble a Warrior",
            instruction: "Match the Terracotta Warrior pieces in the correct order!",
            icon: "puzzlepiece.fill",
            targetEmoji: "🏺",
            xpReward: 25
        ),
        requirements: CityRequirements(items: [.learnedWords(30), .xp(500), .gamesPlayed(5)])
    )

    // MARK: - Chengdu

    private static let chengdu = JourneyCity.make(
        id: "chengdu",
        name: "Chengdu",
        emoji: "🐼",
        province: "Sichuan",
        population: "21 million",
        introduction: "Welcome to Chengdu — relaxed tea-house culture and homeland of the giant panda.",
        famousFor: "Giant pandas, spicy hot pot, and laid-back lifestyle",
        bestSeason: "March – June & September – November",
        localFood: "Mapo tofu, hot pot, dan dan noodles",
        culturalFact: "Chengdu is the homeland of giant pandas and famous for its relaxed tea house culture.",
        localAchievement: "Panda Friend",
        souvenirEmoji: "🐼",
        souvenirName: "Panda",
        travelCollectible: "🐼",
        theme: JourneyColorTheme(
            primary: Color(red: 0.18, green: 0.62, blue: 0.35),
            secondary: Color(red: 0.35, green: 0.78, blue: 0.45),
            heroGradient: [
                Color(red: 0.12, green: 0.48, blue: 0.28),
                Color(red: 0.4, green: 0.75, blue: 0.42)
            ]
        ),
        facts: [
            JourneyFact(id: "cd1", icon: "pawprint.fill", text: "Chengdu is home to the world-famous giant panda breeding center."),
            JourneyFact(id: "cd2", icon: "cup.and.saucer.fill", text: "Tea houses here are social hubs where locals play mahjong for hours."),
            JourneyFact(id: "cd3", icon: "flame.fill", text: "Sichuan cuisine is legendary for its bold, numbing spice.")
        ],
        attractions: [
            JourneyAttraction(id: "cd-a1", name: "Panda Base", emoji: "🐼", description: "Meet giant pandas up close."),
            JourneyAttraction(id: "cd-a2", name: "Jinli Street", emoji: "🏮", description: "Ancient-style pedestrian lane at night."),
            JourneyAttraction(id: "cd-a3", name: "Hot Pot", emoji: "🍲", description: "Simmering spicy broth, Chengdu style."),
            JourneyAttraction(id: "cd-a4", name: "Wuhou Shrine", emoji: "⛩", description: "Temple honoring Three Kingdoms heroes.")
        ],
        vocabulary: vocab(
            ("成都", "Chéngdū", "Chengdu", "Чэнду", "Chengdú", "Chengdu"),
            ("熊猫", "xióngmāo", "panda", "панда", "panda", "panda"),
            ("火锅", "huǒguō", "hot pot", "хого", "hot pot", "hot pot"),
            ("辣", "là", "spicy", "острый", "picante", "picante"),
            ("茶", "chá", "tea", "чай", "té", "chá"),
            ("慢", "màn", "slow", "медленный", "lento", "lento")
        ),
        miniActivity: JourneyMiniActivity(
            title: "Find the Panda",
            instruction: "Spot the panda hiding among the bamboo!",
            icon: "leaf.fill",
            targetEmoji: "🐼",
            xpReward: 25
        ),
        requirements: CityRequirements(items: [.learnedWords(80), .xp(1500), .gamesPlayed(10)])
    )

    // MARK: - Guilin

    private static let guilin = JourneyCity.make(
        id: "guilin",
        name: "Guilin",
        emoji: "🏞",
        province: "Guangxi",
        population: "4.9 million",
        introduction: "Discover Guilin — misty karst peaks rising from the Li River like a painted scroll.",
        famousFor: "Karst mountains, Li River cruises, and rice terraces",
        bestSeason: "April – October",
        localFood: "Guilin rice noodles, beer fish, stuffed snails",
        culturalFact: "Guilin's limestone karst mountains rise dramatically from the Li River mist.",
        localAchievement: "River Wanderer",
        souvenirEmoji: "⛰",
        souvenirName: "Karst Peaks",
        travelCollectible: "⛰",
        theme: JourneyColorTheme(
            primary: Color(red: 0.12, green: 0.72, blue: 0.78),
            secondary: Color(red: 0.28, green: 0.85, blue: 0.82),
            heroGradient: [
                Color(red: 0.08, green: 0.55, blue: 0.65),
                Color(red: 0.35, green: 0.82, blue: 0.75)
            ]
        ),
        facts: [
            JourneyFact(id: "gl1", icon: "mountain.2.fill", text: "\"Guilin's scenery is the finest under heaven\" — ancient Chinese proverb."),
            JourneyFact(id: "gl2", icon: "sailboat.fill", text: "Li River cruises pass landscapes printed on the 20 yuan note."),
            JourneyFact(id: "gl3", icon: "camera.fill", text: "Photographers flock here for sunrise over the karst peaks.")
        ],
        attractions: [
            JourneyAttraction(id: "gl-a1", name: "Li River", emoji: "🚣", description: "Bamboo raft through iconic karst scenery."),
            JourneyAttraction(id: "gl-a2", name: "Yangshuo", emoji: "🌄", description: "Countryside town surrounded by peaks."),
            JourneyAttraction(id: "gl-a3", name: "Reed Flute Cave", emoji: "🪨", description: "Illuminated limestone cavern."),
            JourneyAttraction(id: "gl-a4", name: "Longji Terraces", emoji: "🌾", description: "Dragon's Backbone rice terraces.")
        ],
        vocabulary: vocab(
            ("桂林", "Guìlín", "Guilin", "Гуйлинь", "Guilin", "Guilin"),
            ("山", "shān", "mountain", "гора", "montaña", "montanha"),
            ("河", "hé", "river", "река", "río", "rio"),
            ("风景", "fēngjǐng", "scenery", "пейзаж", "paisaje", "paisagem"),
            ("漂亮", "piàoliang", "beautiful", "красивый", "bonito", "bonito"),
            ("画", "huà", "painting", "картина", "pintura", "pintura")
        ),
        miniActivity: JourneyMiniActivity(
            title: "Paint the Landscape",
            instruction: "Trace the karst peaks to complete the scroll!",
            icon: "paintbrush.fill",
            targetEmoji: "🏞",
            xpReward: 25
        ),
        requirements: CityRequirements(items: [.learnedWords(280), .xp(8000), .gamesPlayed(40), .accuracy(72)])
    )

    // MARK: - Shanghai

    private static let shanghai = JourneyCity.make(
        id: "shanghai",
        name: "Shanghai",
        emoji: "🏙",
        province: "Shanghai Municipality",
        population: "24.9 million",
        introduction: "Arrive in Shanghai — where Art Deco heritage meets one of the world's most futuristic skylines.",
        famousFor: "The Bund, Pudong skyline, and maglev train",
        bestSeason: "March – May & September – November",
        localFood: "Xiaolongbao, shengjianbao, hairy crab",
        culturalFact: "Shanghai blends Art Deco heritage with one of the world's most futuristic skylines.",
        localAchievement: "Metro Master",
        souvenirEmoji: "🌃",
        souvenirName: "Skyline",
        travelCollectible: "🌉",
        theme: JourneyColorTheme(
            primary: Color(red: 0.15, green: 0.45, blue: 0.92),
            secondary: Color(red: 0.35, green: 0.65, blue: 0.98),
            heroGradient: [
                Color(red: 0.08, green: 0.28, blue: 0.72),
                Color(red: 0.25, green: 0.55, blue: 0.95)
            ]
        ),
        facts: [
            JourneyFact(id: "sh1", icon: "tram.fill", text: "Shanghai has one of the world's fastest maglev trains — 431 km/h."),
            JourneyFact(id: "sh2", icon: "building.2.fill", text: "The Bund showcases 52 buildings of diverse architectural styles."),
            JourneyFact(id: "sh3", icon: "ferry.fill", text: "Huangpu River cruises offer stunning night views of both banks.")
        ],
        attractions: [
            JourneyAttraction(id: "sh-a1", name: "The Bund", emoji: "🌃", description: "Colonial waterfront facing Pudong's towers."),
            JourneyAttraction(id: "sh-a2", name: "Oriental Pearl", emoji: "🗼", description: "Iconic TV tower on the Pudong skyline."),
            JourneyAttraction(id: "sh-a3", name: "Yu Garden", emoji: "🏯", description: "Classical Ming-era garden in Old City."),
            JourneyAttraction(id: "sh-a4", name: "Nanjing Road", emoji: "🛍", description: "Premier shopping street, dazzling at night.")
        ],
        vocabulary: vocab(
            ("上海", "Shànghǎi", "Shanghai", "Шанхай", "Shanghái", "Xangai"),
            ("城市", "chéngshì", "city", "город", "ciudad", "cidade"),
            ("现代", "xiàndài", "modern", "современный", "moderno", "moderno"),
            ("高楼", "gāolóu", "skyscraper", "небоскрёб", "rascacielos", "arranha-céu"),
            ("地铁", "dìtiě", "subway", "метро", "metro", "metrô"),
            ("快", "kuài", "fast", "быстрый", "rápido", "rápido")
        ),
        miniActivity: JourneyMiniActivity(
            title: "Skyline Puzzle",
            instruction: "Arrange the buildings to complete the Shanghai skyline!",
            icon: "building.2.fill",
            targetEmoji: "🏙",
            xpReward: 30
        ),
        requirements: CityRequirements(items: [.learnedWords(150), .xp(3000), .gamesPlayed(20), .hsk1Complete])
    )

    // MARK: - Hangzhou

    private static let hangzhou = JourneyCity.make(
        id: "hangzhou",
        name: "Hangzhou",
        emoji: "🌸",
        province: "Zhejiang",
        population: "12.3 million",
        introduction: "Explore Hangzhou — West Lake serenity and the birthplace of Longjing tea.",
        famousFor: "West Lake, Longjing tea, and silk production",
        bestSeason: "March – May & September – October",
        localFood: "West Lake fish, dongpo pork, Longjing shrimp",
        culturalFact: "Hangzhou's West Lake has inspired poets and painters for over a thousand years.",
        localAchievement: "West Lake Poet",
        souvenirEmoji: "🍵",
        souvenirName: "Longjing Tea",
        travelCollectible: "🍵",
        theme: JourneyColorTheme(
            primary: Color(red: 0.1, green: 0.68, blue: 0.48),
            secondary: Color(red: 0.35, green: 0.85, blue: 0.62),
            heroGradient: [
                Color(red: 0.06, green: 0.52, blue: 0.38),
                Color(red: 0.3, green: 0.78, blue: 0.55)
            ]
        ),
        facts: [
            JourneyFact(id: "hz1", icon: "leaf.fill", text: "Longjing tea from Hangzhou is among China's most prized green teas."),
            JourneyFact(id: "hz2", icon: "water.waves", text: "West Lake is a UNESCO World Heritage site with ten scenic spots."),
            JourneyFact(id: "hz3", icon: "book.fill", text: "Marco Polo called Hangzhou \"the finest city in the world.\"")
        ],
        attractions: [
            JourneyAttraction(id: "hz-a1", name: "West Lake", emoji: "🌊", description: "Willow-lined shores and misty pagodas."),
            JourneyAttraction(id: "hz-a2", name: "Leifeng Pagoda", emoji: "🛕", description: "Legendary tower overlooking the lake."),
            JourneyAttraction(id: "hz-a3", name: "Tea Plantations", emoji: "🍵", description: "Rolling hills of Longjing tea bushes."),
            JourneyAttraction(id: "hz-a4", name: "Lingyin Temple", emoji: "⛩", description: "Ancient Buddhist temple in forested hills.")
        ],
        vocabulary: vocab(
            ("杭州", "Hángzhōu", "Hangzhou", "Ханчжоу", "Hangzhou", "Hangzhou"),
            ("西湖", "Xīhú", "West Lake", "Западное озеро", "Lago del Oeste", "Lago Ocidental"),
            ("茶", "chá", "tea", "чай", "té", "chá"),
            ("安静", "ānjìng", "quiet", "тихий", "tranquilo", "tranquilo"),
            ("春天", "chūntiān", "spring", "весна", "primavera", "primavera"),
            ("美丽", "měilì", "beautiful", "прекрасный", "hermoso", "bonito")
        ),
        miniActivity: JourneyMiniActivity(
            title: "Steep the Tea",
            instruction: "Complete the tea ceremony steps in order!",
            icon: "cup.and.saucer.fill",
            targetEmoji: "🍵",
            xpReward: 25
        ),
        requirements: CityRequirements(items: [.learnedWords(200), .xp(5000), .gamesPlayed(30), .accuracy(70)])
    )

    // MARK: - Suzhou

    private static let suzhou = JourneyCity.make(
        id: "suzhou",
        name: "Suzhou",
        emoji: "🏡",
        province: "Jiangsu",
        population: "12.7 million",
        introduction: "Enter Suzhou — the Venice of the East, where classical gardens whisper centuries of elegance.",
        famousFor: "Classical gardens, canals, and silk embroidery",
        bestSeason: "March – May & September – November",
        localFood: "Squirrel mandarin fish, biluochun tea, sweet osmanthus cake",
        culturalFact: "Suzhou's classical gardens are UNESCO masterpieces of landscape design.",
        localAchievement: "Garden Poet",
        souvenirEmoji: "🎋",
        souvenirName: "Silk Fan",
        travelCollectible: "🏡",
        theme: JourneyColorTheme(
            primary: Color(red: 0.45, green: 0.55, blue: 0.72),
            secondary: Color(red: 0.65, green: 0.75, blue: 0.85),
            heroGradient: [
                Color(red: 0.35, green: 0.45, blue: 0.62),
                Color(red: 0.55, green: 0.72, blue: 0.82)
            ]
        ),
        facts: [
            JourneyFact(id: "sz1", icon: "leaf.fill", text: "The Humble Administrator's Garden is one of China's four great gardens."),
            JourneyFact(id: "sz2", icon: "scissors", text: "Suzhou silk embroidery can take months to complete a single piece."),
            JourneyFact(id: "sz3", icon: "water.waves", text: "Ancient canals weave through the old town like Venetian waterways.")
        ],
        attractions: [
            JourneyAttraction(id: "sz-a1", name: "Humble Garden", emoji: "🏡", description: "Ming-era garden of ponds and pavilions."),
            JourneyAttraction(id: "sz-a2", name: "Tiger Hill", emoji: "🐯", description: "Leaning pagoda atop a legendary hill."),
            JourneyAttraction(id: "sz-a3", name: "Pingjiang Road", emoji: "🛶", description: "Canalside lane of teahouses and shops."),
            JourneyAttraction(id: "sz-a4", name: "Silk Museum", emoji: "🧵", description: "Centuries of silk weaving tradition.")
        ],
        vocabulary: vocab(
            ("苏州", "Sūzhōu", "Suzhou", "Сучжоу", "Suzhou", "Suzhou"),
            ("花园", "huāyuán", "garden", "сад", "jardín", "jardim"),
            ("丝绸", "sīchóu", "silk", "шёлк", "seda", "seda"),
            ("桥", "qiáo", "bridge", "мост", "puente", "ponte"),
            ("水", "shuǐ", "water", "вода", "agua", "água"),
            ("传统", "chuántǒng", "tradition", "традиция", "tradición", "tradição")
        ),
        miniActivity: JourneyMiniActivity(
            title: "Design a Garden",
            instruction: "Place the pavilion, bridge, and pond to complete the garden!",
            icon: "tree.fill",
            targetEmoji: "🏡",
            xpReward: 25
        ),
        requirements: CityRequirements(items: [.learnedWords(240), .xp(6500), .gamesPlayed(35), .accuracy(71)])
    )

    // MARK: - Harbin

    private static let harbin = JourneyCity.make(
        id: "harbin",
        name: "Harbin",
        emoji: "❄️",
        province: "Heilongjiang",
        population: "10 million",
        introduction: "Venture to Harbin — China's ice city, where winter magic transforms the landscape.",
        famousFor: "Ice Festival, Russian architecture, and winter sports",
        bestSeason: "December – February ( Ice Festival )",
        localFood: "Guo bao rou, Harbin sausage, frozen pear",
        culturalFact: "Harbin hosts the world's largest ice and snow sculpture festival each winter.",
        localAchievement: "Ice Explorer",
        souvenirEmoji: "🧊",
        souvenirName: "Ice Crystal",
        travelCollectible: "❄️",
        theme: JourneyColorTheme(
            primary: Color(red: 0.45, green: 0.72, blue: 0.95),
            secondary: Color(red: 0.75, green: 0.88, blue: 0.98),
            heroGradient: [
                Color(red: 0.25, green: 0.55, blue: 0.85),
                Color(red: 0.65, green: 0.85, blue: 0.98)
            ]
        ),
        facts: [
            JourneyFact(id: "hb1", icon: "snowflake", text: "The Ice Festival uses over 200,000 cubic meters of ice each year."),
            JourneyFact(id: "hb2", icon: "building.columns.fill", text: "Central Street features beautiful Russian-style architecture."),
            JourneyFact(id: "hb3", icon: "thermometer.snowflake", text: "Winter temperatures can drop below −30°C in Harbin.")
        ],
        attractions: [
            JourneyAttraction(id: "hb-a1", name: "Ice Festival", emoji: "🧊", description: "Massive illuminated ice sculptures at night."),
            JourneyAttraction(id: "hb-a2", name: "Central Street", emoji: "🏛", description: "Historic cobblestone boulevard."),
            JourneyAttraction(id: "hb-a3", name: "Saint Sophia", emoji: "⛪", description: "Byzantine-style cathedral turned museum."),
            JourneyAttraction(id: "hb-a4", name: "Snow World", emoji: "❄️", description: "Fantasy snow castles and slides.")
        ],
        vocabulary: vocab(
            ("哈尔滨", "Hā'ěrbīn", "Harbin", "Харбин", "Harbin", "Harbin"),
            ("冰", "bīng", "ice", "лёд", "hielo", "gelo"),
            ("雪", "xuě", "snow", "снег", "nieve", "neve"),
            ("冷", "lěng", "cold", "холодный", "frío", "frio"),
            ("冬天", "dōngtiān", "winter", "зима", "invierno", "inverno"),
            ("漂亮", "piàoliang", "beautiful", "красивый", "bonito", "bonito")
        ),
        miniActivity: JourneyMiniActivity(
            title: "Carve the Ice",
            instruction: "Tap to sculpt the ice block before it melts!",
            icon: "hammer.fill",
            targetEmoji: "🧊",
            xpReward: 25
        ),
        requirements: CityRequirements(items: [.learnedWords(310), .xp(9500), .gamesPlayed(45), .accuracy(74)])
    )

    // MARK: - Hong Kong

    private static let hongkong = JourneyCity.make(
        id: "hongkong",
        name: "Hong Kong",
        emoji: "🌊",
        province: "Hong Kong SAR",
        population: "7.5 million",
        introduction: "Reach Hong Kong — where East meets West on a glittering harbor of endless energy.",
        famousFor: "Victoria Harbour, dim sum, and skyline views",
        bestSeason: "October – December",
        localFood: "Dim sum, egg tarts, pineapple bun",
        culturalFact: "Hong Kong is where East meets West — a vibrant port city with deep Cantonese roots.",
        localAchievement: "Harbor Voyager",
        souvenirEmoji: "⛴",
        souvenirName: "Star Ferry",
        travelCollectible: "🌊",
        theme: JourneyColorTheme(
            primary: Color(red: 0.52, green: 0.28, blue: 0.85),
            secondary: Color(red: 0.72, green: 0.45, blue: 0.95),
            heroGradient: [
                Color(red: 0.38, green: 0.18, blue: 0.72),
                Color(red: 0.62, green: 0.35, blue: 0.92)
            ]
        ),
        facts: [
            JourneyFact(id: "hk1", icon: "tram.fill", text: "The Peak Tram has operated since 1888 — one of the world's oldest funiculars."),
            JourneyFact(id: "hk2", icon: "ferry.fill", text: "The Star Ferry has crossed Victoria Harbour since 1888."),
            JourneyFact(id: "hk3", icon: "building.2.fill", text: "Hong Kong has more skyscrapers than any other city on Earth.")
        ],
        attractions: [
            JourneyAttraction(id: "hk-a1", name: "Victoria Peak", emoji: "🏔", description: "Panoramic views over the harbor."),
            JourneyAttraction(id: "hk-a2", name: "Star Ferry", emoji: "⛴", description: "Historic harbor crossing at sunset."),
            JourneyAttraction(id: "hk-a3", name: "Temple Street", emoji: "🏮", description: "Night market of food and fortune tellers."),
            JourneyAttraction(id: "hk-a4", name: "Dim Sum", emoji: "🥟", description: "Steamed baskets of Cantonese delights.")
        ],
        vocabulary: vocab(
            ("香港", "Xiānggǎng", "Hong Kong", "Гонконг", "Hong Kong", "Hong Kong"),
            ("港口", "gǎngkǒu", "harbor", "гавань", "puerto", "porto"),
            ("点心", "diǎnxin", "dim sum", "димсам", "dim sum", "dim sum"),
            ("购物", "gòuwù", "shopping", "шопинг", "compras", "compras"),
            ("晚上", "wǎnshang", "evening", "вечер", "noche", "noite"),
            ("热闹", "rènao", "lively", "оживлённый", "animado", "movimentado")
        ),
        miniActivity: JourneyMiniActivity(
            title: "Catch the Ferry",
            instruction: "Guide the Star Ferry across Victoria Harbour!",
            icon: "ferry.fill",
            targetEmoji: "⛴",
            xpReward: 30
        ),
        requirements: CityRequirements(items: [
            .learnedWords(350), .xp(12000), .gamesPlayed(50), .hsk2Complete, .accuracy(75)
        ])
    )

    private static func vocab(_ items: (String, String, String, String, String, String)...) -> [JourneyVocabularyWord] {
        items.enumerated().map { index, item in
            JourneyVocabularyWord(
                id: "v-\(index)",
                hanzi: item.0,
                pinyin: item.1,
                english: item.2,
                translations: ["en": item.2, "ru": item.3, "es": item.4, "pt-BR": item.5]
            )
        }
    }
}

private extension JourneyRequirement {
    static func learnedWords(_ count: Int) -> JourneyRequirement {
        JourneyRequirementFactory.learnedWords(count)
    }

    static func xp(_ amount: Int) -> JourneyRequirement {
        JourneyRequirementFactory.xp(amount)
    }

    static func gamesPlayed(_ count: Int) -> JourneyRequirement {
        JourneyRequirementFactory.gamesPlayed(count)
    }

    static func accuracy(_ percent: Int) -> JourneyRequirement {
        JourneyRequirementFactory.accuracy(percent)
    }

    static var hsk1Complete: JourneyRequirement { JourneyRequirementFactory.hsk1Complete }
    static var hsk2Complete: JourneyRequirement { JourneyRequirementFactory.hsk2Complete }
}
