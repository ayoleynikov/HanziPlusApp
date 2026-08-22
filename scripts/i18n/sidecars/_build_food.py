#!/usr/bin/env python3
"""Food study-set translations (100 words)."""
from __future__ import annotations
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
from sidecar_lib import apply_rows

ROWS = []


def add(ru, es, pt, *examples):
    ROWS.append((ru, es, pt, examples))


add("яблоко", "manzana", "maçã",
    ("Я каждый день ем яблоко.", "Como una manzana todos los días.", "Como uma maçã todos os dias."),
    ("Эти яблоки очень сладкие.", "Estas manzanas son muy dulces.", "Estas maçãs são muito doces."))
add("банан", "plátano / banana", "banana",
    ("Бананы чернеют, если долго лежат.", "Los plátanos se ponen negros si se guardan mucho.", "As bananas escurecem se ficarem guardadas tempo demais."),
    ("Дети любят бананы.", "A los niños les gusta el plátano.", "Crianças gostam de banana."))
add("апельсин", "naranja", "laranja",
    ("В апельсинах много витаминов.", "Las naranjas son ricas en vitaminas.", "As laranjas são ricas em vitaminas."),
    ("Дайте мне, пожалуйста, два апельсина.", "Deme dos naranjas, por favor.", "Me dê duas laranjas, por favor."))
add("виноград", "uva", "uva",
    ("Эта гроздь винограда большая.", "Este racimo de uvas es grande.", "Este cacho de uvas é grande."),
    ("Виноград лучше всего летом.", "Las uvas saben mejor en verano.", "Uva fica melhor no verão."))
add("арбуз", "sandía", "melancia",
    ("Арбуз освежает летом.", "La sandía refresca en verano.", "Melancia refresca no verão."),
    ("Этот арбуз сладкий.", "Esta sandía es dulce.", "Esta melancia é doce."))
add("клубника", "fresa", "morango",
    ("Клубничный торт популярен.", "El pastel de fresa es popular.", "Bolo de morango é popular."),
    ("Свежая клубника уже покраснела.", "Las fresas frescas ya están rojas.", "Os morangos frescos já estão vermelhos."))
add("персик", "melocotón / durazno", "pêssego",
    ("Спелые персики чудесно пахнут.", "Los duraznos maduros huelen muy bien.", "Pêssegos maduros cheiram muito bem."),
    ("Я купил три цзиня персиков.", "Compré tres jin de duraznos.", "Comprei três jin de pêssego."))
add("груша", "pera", "pera",
    ("Этот сорт груш очень сочный.", "Este tipo de pera es muy jugosa.", "Este tipo de pera é bem suculenta."),
    ("Груши зимой полезны для горла.", "Comer peras en invierno es bueno para la garganta.", "Comer pera no inverno faz bem à garganta."))
add("манго", "mango", "manga",
    ("Манго — тропический фрукт.", "El mango es una fruta tropical.", "Manga é uma fruta tropical."),
    ("Мне нравится вкус манго.", "Me gusta el sabor del mango.", "Gosto do sabor da manga."))
add("вишня / черешня", "cereza", "cereja",
    ("Сезон вишни короткий.", "La temporada de cerezas es corta.", "A temporada de cereja é curta."),
    ("Эти вишни очень свежие.", "Estas cerezas están muy frescas.", "Estas cerejas estão bem frescas."))
add("пекинская капуста", "col china", "repolho chinês",
    ("Капусту можно жарить или варить.", "La col se puede saltear o hervir.", "O repolho pode ser refogado ou cozido."),
    ("Мне, пожалуйста, один кочан капусты.", "Quisiera una pieza de col china.", "Quero uma cabeça de repolho chinês."))
add("помидор", "tomate", "tomate",
    ("Жареные помидоры с яйцом очень вкусные.", "El salteado de tomate y huevo está delicioso.", "Tomate com ovo mexido fica uma delícia."),
    ("Эти помидоры очень красные.", "Estos tomates están muy rojos.", "Estes tomates estão bem vermelhos."))
add("картофель", "patata / papa", "batata",
    ("Я люблю жареный картофель.", "Me gustan las patatas fritas.", "Gosto de batata frita."),
    ("Из картофеля можно приготовить много блюд.", "Con patatas se pueden hacer muchos platos.", "Dá para fazer muitos pratos com batata."))
add("морковь", "zanahoria", "cenoura",
    ("Морковь полезна для глаз.", "Las zanahorias son buenas para la vista.", "Cenoura faz bem aos olhos."),
    ("Нарежьте, пожалуйста, морковь.", "Corte unas zanahorias, por favor.", "Corte umas cenouras, por favor."))
add("огурец", "pepino", "pepino",
    ("Огурец освежает летом.", "El pepino refresca en verano.", "Pepino refresca no verão."),
    ("Сделаю салат из огурцов.", "Haré una ensalada de pepino.", "Vou fazer uma salada de pepino."))
add("баклажан", "berenjena", "berinjela",
    ("Баклажаны «юй сян» хорошо идут с рисом.", "La berenjena yu xiang queda bien con arroz.", "Berinjela yu xiang combina com arroz."),
    ("Баклажан нужно хорошо протушить.", "La berenjena hay que cocinarla blandita.", "A berinjela precisa cozinhar até ficar macia."))
add("шпинат", "espinaca", "espinafre",
    ("В шпинате много железа.", "Las espinacas tienen mucho hierro.", "Espinafre tem muito ferro."),
    ("Дайте мне пучок шпината.", "Deme un manojo de espinacas.", "Me dê um maço de espinafre."))
add("кукуруза", "maíz", "milho",
    ("Варёная кукуруза отлично пахнет.", "El maíz hervido huele muy bien.", "Milho cozido cheira muito bem."),
    ("Я купил початок кукурузы.", "Compré una mazorca de maíz.", "Comprei uma espiga de milho."))
add("гриб", "champiñón / seta", "cogumelo",
    ("В этот суп добавили грибы.", "A esta sopa le pusieron setas.", "Colocaram cogumelo nesta sopa."),
    ("Грибы нужно хорошо промыть.", "Las setas hay que lavarlas bien.", "Cogumelo precisa lavar bem."))
add("перец чили", "chile / ají", "pimenta",
    ("В этом блюде есть перец чили.", "Este plato lleva chile.", "Este prato tem pimenta."),
    ("Я плохо переношу острое.", "No aguanto bien lo picante.", "Não aguento bem comida picante."))
add("говядина", "ternera / carne de res", "carne bovina",
    ("Лапша с говядиной очень популярна.", "Los fideos con ternera son muy populares.", "Macarrão com carne é muito popular."),
    ("Дайте мне, пожалуйста, цзинь говядины.", "Deme un jin de ternera, por favor.", "Me dê um jin de carne, por favor."))
add("свинина", "cerdo", "porco",
    ("Из свинины можно приготовить много блюд.", "Con cerdo se pueden hacer muchos platos.", "Dá para fazer muitos pratos com porco."),
    ("Сегодня купили свежую свинину.", "Hoy compramos cerdo fresco.", "Hoje compramos porco fresco."))
add("курица", "pollo", "frango",
    ("Курица «бай це» — знаменитое кантонское блюдо.", "El pollo blanco es un plato famoso de Cantón.", "Frango branco é um prato famoso de Cantão."),
    ("Курица сравнительно полезная.", "El pollo es relativamente saludable.", "Frango é relativamente saudável."))
add("баранина", "cordero / carne de ovino", "carneiro",
    ("Зимой едим баранью хого.", "En invierno comemos hot pot de cordero.", "No inverno comemos hot pot de carneiro."),
    ("Баранину нужно долго тушить.", "El cordero hay que estofarlo mucho rato.", "Carneiro precisa cozinhar por bastante tempo."))
add("рёбрышки", "costillas", "costela",
    ("Рёбрышки в соевом соусе очень вкусные.", "Las costillas estofadas están riquísimas.", "Costela estufada fica uma delícia."),
    ("Дайте два цзиня рёбрышек.", "Deme dos jin de costillas.", "Me dê dois jin de costela."))
add("колбаса / сосиски", "salchicha", "salsicha",
    ("На завтрак часто едят сосиски.", "La salchicha es habitual en el desayuno.", "Salsicha é comum no café da manhã."),
    ("Эта колбаса очень ароматная.", "Esta salchicha huele muy bien.", "Esta salsicha cheira muito bem."))
add("бекон", "tocino / bacon", "bacon",
    ("Я люблю бекон с яйцом.", "Me gustan el tocino y los huevos.", "Gosto de bacon com ovo."),
    ("Дайте три ломтика бекона.", "Deme tres lonchas de tocino.", "Me dê três fatias de bacon."))
add("ветчина", "jamón", "presunto",
    ("В сэндвич положили ветчину.", "Al sándwich le pusieron jamón.", "Colocaram presunto no sanduíche."),
    ("Нарезанная ветчина очень удобна.", "El jamón en lonchas es práctico.", "Presunto fatiado é prático."))
add("стейк", "bistec / filete", "bife / steak",
    ("Стейк, пожалуйста, средней прожарки.", "El bistec a término medio, por favor.", "O bife no ponto, por favor."),
    ("Этот стейк-хаус очень известный.", "Este restaurante de bistec es famoso.", "Este restaurante de bife é famoso."))
add("утка по-пекински / жареная утка", "pato asado", "pato assado",
    ("Пекинская утка очень знаменита.", "El pato pekinés es famoso.", "O pato à Pequim é famoso."),
    ("Закажем одну утку.", "Pidamos un pato asado.", "Vamos pedir um pato assado."))
add("рыба", "pescado / pez", "peixe",
    ("Эта рыба очень свежая.", "Este pescado está muy fresco.", "Este peixe está bem fresco."),
    ("Я ем рыбу два раза в неделю.", "Como pescado dos veces por semana.", "Como peixe duas vezes por semana."))
add("креветки", "camarones / gambas", "camarão",
    ("Варёные креветки очень простые.", "Los camarones escaldados son sencillos.", "Camarão cozido é simples."),
    ("Эти креветки крупные.", "Estos camarones son grandes.", "Estes camarões são grandes."))
add("краб", "cangrejo", "caranguejo",
    ("Осень — сезон крабов.", "El otoño es la temporada del cangrejo.", "O outono é a temporada de caranguejo."),
    ("Крабов нужно готовить на пару пятнадцать минут.", "Los cangrejos se cuecen al vapor quince minutos.", "Caranguejo precisa de quinze minutos no vapor."))
add("моллюски / морепродукты в раковине", "mariscos / moluscos", "moluscos / mariscos",
    ("Моллюски нужно хорошо проварить.", "Los mariscos hay que cocerlos bien.", "Moluscos precisam cozinhar bem."),
    ("Я люблю разные моллюски.", "Me gustan todo tipo de mariscos.", "Gosto de vários tipos de marisco."))
add("кальмар", "calamar", "lula",
    ("Жареный кальмар очень ароматный.", "El calamar a la parrilla huele muy bien.", "Lula grelhada cheira muito bem."),
    ("Дайте порцию жареного кальмара.", "Una ración de calamar salteado, por favor.", "Uma porção de lula refogada, por favor."))
add("лосось", "salmón", "salmão",
    ("Лосось можно есть сырым.", "El salmón se puede comer crudo.", "Salmão pode ser comido cru."),
    ("Закажу сашими из лосося.", "Pediré sashimi de salmón.", "Vou pedir sashimi de salmão."))
add("устрица", "ostra", "ostra",
    ("Устрицы хорошо идут с лимонным соком.", "Las ostras van bien con limón.", "Ostra combina com suco de limão."),
    ("Я не привык есть устриц.", "No estoy acostumbrado a las ostras.", "Não estou acostumado a ostra."))
add("морская капуста / ламинария", "alga kombu / kelp", "alga / kombu",
    ("Суп с морской капустой лёгкий и освежающий.", "La sopa de alga es ligera y refrescante.", "Sopa de alga é leve e refrescante."),
    ("В салат добавили полоски морской капусты.", "A la ensalada le pusieron alga en tiras.", "Colocaram alga em tiras na salada."))
add("рыба-сабля / волосатик", "pez sable", "peixe-espada / peixe-fita",
    ("Рыба-сабля в соусе — домашнее блюдо.", "El pez sable estofado es un plato casero.", "Peixe-fita estufado é prato caseiro."),
    ("Рыбу-саблю жарят до золотистой корочки с двух сторон.", "El pez sable se fríe dorado por ambos lados.", "O peixe-fita é frito dourado dos dois lados."))
add("омар / лобстер", "langosta", "lagosta",
    ("Омар довольно дорогой.", "La langosta es relativamente cara.", "Lagosta é relativamente cara."),
    ("В праздник едим лобстера.", "Comemos langosta para celebrar.", "Comemos lagosta para comemorar."))
add("рис (варёный)", "arroz (cocido)", "arroz (cozido)",
    ("Дайте мне миску риса.", "Un tazón de arroz, por favor.", "Uma tigela de arroz, por favor."),
    ("Рис — основной гарнир.", "El arroz es el alimento básico.", "Arroz é o alimento básico."))
add("лапша", "fideos / tallarines", "macarrão",
    ("Эта лапша очень упругая.", "Estos fideos están muy al dente.", "Este macarrão está bem firme."),
    ("Я люблю лапшу в бульоне.", "Me gusta la sopa de fideos.", "Gosto de macarrão na sopa."))
add("пельмени / цзяоцзы", "dumplings / jiaozi", "bolinho / jiaozi",
    ("На Чуньцзе едят пельмени.", "En el Año Nuevo se comen dumplings.", "No Ano Novo Chinês se come jiaozi."),
    ("Я слепил блюдо пельменей.", "Hice un plato de dumplings.", "Fiz um prato de jiaozi."))
add("паровые булочки / баоцзы", "panecillo al vapor / baozi", "pãozinho no vapor / baozi",
    ("На завтрак купил две булочки.", "Compré dos baozi para el desayuno.", "Comprei dois baozi no café da manhã."),
    ("Баоцзы с мясом очень ароматные.", "Los baozi de carne huelen muy bien.", "Baozi de carne cheira muito bem."))
add("хого / горячий котёл", "olla caliente / hot pot", "hot pot / fondue chinesa",
    ("Зимой лучше всего хого.", "El hot pot es perfecto en invierno.", "Hot pot é perfeito no inverno."),
    ("Сегодня вечером идём на хого.", "Esta noche vamos a comer hot pot.", "Hoje à noite vamos comer hot pot."))
add("жареный рис", "arroz frito", "arroz frito",
    ("Янчжоуский жареный рис очень знаменит.", "El arroz frito de Yangzhou es famoso.", "Arroz frito de Yangzhou é famoso."),
    ("Дайте порцию жареного риса с яйцом.", "Un arroz frito con huevo, por favor.", "Um arroz frito com ovo, por favor."))
add("суп", "sopa", "sopa",
    ("Этот суп немного горячий.", "Esta sopa está un poco caliente.", "Esta sopa está um pouco quente."),
    ("Перед едой выпейте миску супа.", "Tome un tazón de sopa antes de la comida.", "Tome uma tigela de sopa antes da refeição."))
add("жаркое / обжаривать", "salteado / saltear", "refogado / refogar",
    ("Мама отлично жарит.", "Mamá saltea muy bien.", "A mamãe refoga muito bem."),
    ("Пожарьте ещё одно блюдо.", "Saltee un plato más, por favor.", "Refogue mais um prato, por favor."))
add("закуска / стритфуд", "aperitivo / comida callejera", "petisco / comida de rua",
    ("На этой улице много закусок.", "En esta calle hay muchos aperitivos.", "Nesta rua tem muitos petiscos."),
    ("Закуски дешёвые и вкусные.", "Los aperitivos son baratos y ricos.", "Os petiscos são baratos e gostosos."))
add("фирменное блюдо", "plato típico / especialidad", "prato típico / especialidade",
    ("Порекомендуйте фирменное блюдо.", "Recomiende un plato típico, por favor.", "Recomende um prato típico, por favor."),
    ("Это фирменное блюдо заведения.", "Este es el plato estrella del local.", "Este é o prato especial da casa."))
add("цзяньбин (китайский блин)", "crepe chino / jianbing", "crepe chinês / jianbing",
    ("На завтрак часто едят цзяньбин.", "El jianbing es un desayuno habitual.", "Jianbing é um café da manhã comum."),
    ("В этот цзяньбин добавили яйцо.", "Este jianbing lleva huevo.", "Este jianbing tem ovo."))
add("шашлычки / шампуры", "brochetas / pinchos", "espetinho / churrasquinho",
    ("На ночном рынке много шашлычков.", "En el mercado nocturno hay muchas brochetas.", "No mercado noturno tem muitos espetinhos."),
    ("Дайте пять шампуров.", "Cinco brochetas, por favor.", "Cinco espetinhos, por favor."))
add("малатан (острый суп с выбором ингредиентов)", "sopa picante malatang", "sopa picante malatang",
    ("В малатане ингредиенты выбираешь сам.", "En el malatang eliges tus ingredientes.", "No malatang você escolhe os ingredientes."),
    ("Эта миска малатана очень острая.", "Este malatang está muy picante.", "Este malatang está muito picante."))
add("жоуцзямо (китайский бургер)", "sándwich de carne chino / roujiamo", "sanduíche de carne chinês / roujiamo",
    ("Жоуцзямо — знаменитая закуска Шэньси.", "El roujiamo es un snack famoso de Shaanxi.", "Roujiamo é um lanche famoso de Shaanxi."),
    ("Я купил жоуцзямо.", "Compré un roujiamo.", "Comprei um roujiamo."))
add("вонючий тофу", "tofu fétido / stinky tofu", "tofu fedido",
    ("Вонючий тофу пахнет резко, но вкусный.", "El tofu fétido huele fuerte, pero sabe bien.", "Tofu fedido cheira forte, mas é gostoso."),
    ("Осмелишься съесть вонючий тофу?", "¿Te atreves a comer tofu fétido?", "Você ousa comer tofu fedido?"))
add("танхулу (ягоды в сахаре)", "brocheta de acerola caramelizada", "espetinho de fruta cristalizada / tanghulu",
    ("Зимой часто продают танхулу.", "El tanghulu es común en invierno.", "Tanghulu é comum no inverno."),
    ("Ребёнок хочет шампур танхулу.", "El niño quiere un tanghulu.", "A criança quer um espetinho de tanghulu."))
add("чёнфан / рисовые рулеты", "rollo de fideo de arroz / cheung fun", "rolo de arroz / cheung fun",
    ("В Гуандуне на завтрак часто едят чёнфан.", "El cheung fun es un desayuno habitual en Guangdong.", "Cheung fun é café da manhã comum em Guangdong."),
    ("Дайте порцию чёнфана с яйцом.", "Un cheung fun con huevo, por favor.", "Um cheung fun com ovo, por favor."))
add("сяолунбао (пельмени с бульоном)", "dumpling de sopa / xiaolongbao", "bolinho de sopa / xiaolongbao",
    ("Сяолунбао осторожно: внутри горячо.", "Cuidado, los xiaolongbao queman.", "Cuidado, xiaolongbao queima."),
    ("Шанхайские сяолунбао очень знамениты.", "Los xiaolongbao de Shanghái son famosos.", "Xiaolongbao de Xangai é famoso."))
add("лянпи (холодная лапша)", "fideos fríos liangpi", "macarrão frio liangpi",
    ("Летом лянпи хорошо освежает.", "Los liangpi refrescan en verano.", "Liangpi refresca no verão."),
    ("Добавьте уксус и перечное масло.", "Ponga vinagre y aceite de chile, por favor.", "Coloque vinagre e óleo de pimenta, por favor."))
add("жацзянмянь (лапша с соевой пастой)", "fideos con salsa de soja fermentada", "macarrão com molho de soja / zhajiangmian",
    ("Жацзянмянь — пекинская классика.", "El zhajiangmian es típico de Pekín.", "Zhajiangmian é típico de Pequim."),
    ("Эта миска жацзянмянь очень аутентичная.", "Este zhajiangmian es auténtico.", "Este zhajiangmian é autêntico."))
add("торт / пирог", "pastel / tarta", "bolo",
    ("С днём рождения, давайте торт.", "Feliz cumpleaños, comamos pastel.", "Feliz aniversário, vamos comer bolo."),
    ("Этот торт шоколадный.", "Este pastel es de chocolate.", "Este bolo é de chocolate."))
add("мороженое", "helado", "sorvete",
    ("Летом я больше всего люблю мороженое.", "En verano lo que más me gusta es el helado.", "No verão o que eu mais gosto é sorvete."),
    ("Дайте два мороженых.", "Dos helados, por favor.", "Dois sorvetes, por favor."))
add("пудинг", "pudín / flan", "pudim",
    ("Манговый пудинг очень нежный.", "El pudín de mango es suave.", "O pudim de manga é bem cremoso."),
    ("На десерт я взял пудинг.", "Elegí pudín de postre.", "Escolhi pudim de sobremesa."))
add("лунный пряник / юэбин", "pastel de luna / mooncake", "bolo da lua / mooncake",
    ("На праздник середины осени едят юэбин.", "En el Festival del Medio Otoño se comen pasteles de luna.", "No Festival do Meio Outono se come bolo da lua."),
    ("Этот юэбин с ореховой начинкой у жэнь.", "Este pastel de luna es de frutos secos.", "Este bolo da lua é de mix de nozes."))
add("танъюань (рисовые шарики)", "bolitas de arroz glutinoso / tangyuan", "bolinho de arroz glutinoso / tangyuan",
    ("На Юаньсяо едят танъюань.", "En el Festival de los Faroles se comen tangyuan.", "No Festival das Lanternas se come tangyuan."),
    ("Танъюань сладкие.", "Los tangyuan son dulces.", "Tangyuan é doce."))
add("паста из красной фасоли", "pasta de judía roja", "pasta de feijão vermelho",
    ("Начинка баоцзы — паста из красной фасоли.", "El relleno del baozi es pasta de judía roja.", "O recheio do baozi é pasta de feijão vermelho."),
    ("Я люблю сладости с красной фасолью.", "Me gustan los postres de judía roja.", "Gosto de doce de feijão vermelho."))
add("пирожное из водяного каштана", "pastel de castaña de agua", "bolo de castanha-d'água",
    ("Это кантонский димсам.", "Es un dim sum cantonés.", "É um dim sum cantonês."),
    ("Эта выпечка очень лёгкая.", "Este pastel es ligero y fresco.", "Este doce é leve e fresco."))
add("яичный тарт", "tarta de huevo / egg tart", "torta de ovo / egg tart",
    ("Свежие из печи тарты самые вкусные.", "Los egg tarts recién horneados son los mejores.", "Egg tart recém-assado é o melhor."),
    ("Дайте три яичных тарта.", "Tres tartas de huevo, por favor.", "Três egg tarts, por favor."))
add("шуанпинай (молочный пудинг с корочкой)", "natillas de doble piel", "pudim de leite de pele dupla",
    ("Шуанпинай — знаменитый десерт Шуньдэ.", "La leche de doble piel es típica de Shunde.", "O leite de pele dupla é típico de Shunde."),
    ("Эта чашка шуанпинай очень нежная.", "Esta leche de doble piel está muy suave.", "Este leite de pele dupla está bem macio."))
add("махуа (жареный крученый хворост)", "rosca frita mahua", "rosquinha frita mahua",
    ("Махуа хрустящая и ароматная.", "La mahua está crujiente y aromática.", "Mahua fica crocante e cheirosa."),
    ("Купил махуа на перекус.", "Compré mahua de snack.", "Comprei mahua de lanche."))
add("кофе", "café", "café",
    ("Каждое утро я пью кофе.", "Tomo café todas las mañanas.", "Tomo café toda manhã."),
    ("Дайте чашку горячего кофе.", "Un café caliente, por favor.", "Um café quente, por favor."))
add("латте", "latte / café con leche", "latte / café com leite",
    ("Мне айс-латте.", "Un latte helado, por favor.", "Um latte gelado, por favor."),
    ("Пенка у латте очень нежная.", "La espuma del latte es muy fina.", "A espuma do latte é bem fina."))
add("американо", "americano", "americano",
    ("Американо довольно горький.", "El americano es bastante amargo.", "O americano é bem amargo."),
    ("Большой американо, пожалуйста.", "Un americano grande, por favor.", "Um americano grande, por favor."))
add("капучино", "capuchino", "cappuccino",
    ("Сверху у капучино молочная пенка.", "El capuchino lleva espuma arriba.", "O cappuccino tem espuma em cima."),
    ("Она заказала капучино.", "Pidió un capuchino.", "Ela pediu um cappuccino."))
add("эспрессо", "espresso", "espresso",
    ("Эспрессо подают в маленькой чашке.", "El espresso viene en taza pequeña.", "O espresso vem em xícara pequena."),
    ("Сделайте двойной эспрессо.", "Un espresso doble, por favor.", "Um espresso duplo, por favor."))
add("кофейные зёрна", "granos de café", "grãos de café",
    ("Эти зёрна свежие.", "Estos granos de café están frescos.", "Estes grãos de café estão frescos."),
    ("Я купил эфиопские зёрна.", "Compré granos de Etiopía.", "Comprei grãos da Etiópia."))
add("молоть (кофе)", "moler (café)", "moer (café)",
    ("Помолите, пожалуйста, зёрна.", "Muela los granos, por favor.", "Moa os grãos, por favor."),
    ("Свежемолотый кофе ароматнее.", "El café recién molido huele mejor.", "Café moído na hora cheira melhor."))
add("с собой / на вынос", "para llevar", "para viagem",
    ("Кофе с собой или здесь?", "¿El café para llevar o para tomar aquí?", "O café para viagem ou para tomar aqui?"),
    ("Мне с собой.", "Para llevar.", "Para viagem."))
add("половина сахара", "mitad de azúcar", "meio açúcar",
    ("Сделайте, пожалуйста, половину сахара.", "Con la mitad de azúcar, por favor.", "Com meio açúcar, por favor."),
    ("Половина сахара мне как раз.", "La mitad de azúcar me viene bien.", "Meio açúcar está no ponto para mim."))
add("латте-арт / рисунок на кофе", "arte latte", "arte no café / latte art",
    ("На этом кофе красивый рисунок.", "El arte latte de este café es precioso.", "A arte neste café está linda."),
    ("Бариста хорошо рисует на кофе.", "El barista es bueno con el arte latte.", "O barista é bom em latte art."))
add("зелёный чай", "té verde", "chá verde",
    ("Зелёный чай более лёгкий.", "El té verde es relativamente suave.", "Chá verde é relativamente leve."),
    ("Заварите чашку зелёного чая.", "Una taza de té verde, por favor.", "Uma xícara de chá verde, por favor."))
add("чёрный чай", "té negro", "chá preto",
    ("Чёрный чай хорошо идёт с молоком.", "El té negro va bien con leche.", "Chá preto combina com leite."),
    ("Английский чёрный чай крепкий.", "El té negro inglés es fuerte.", "O chá preto inglês é forte."))
add("улун", "té oolong", "chá oolong",
    ("Улун можно заваривать много раз.", "El oolong se puede infusionar varias veces.", "Oolong pode ser infundido várias vezes."),
    ("Тегуаньинь — это улун.", "El Tieguanyin es un oolong.", "Tieguanyin é um oolong."))
add("жасминовый чай", "té de jazmín", "chá de jasmim",
    ("Жасминовый чай очень ароматный.", "El té de jazmín es muy fragante.", "Chá de jasmim é muito aromático."),
    ("После еды я пью жасминовый чай.", "Después de comer tomo té de jazmín.", "Depois de comer eu tomo chá de jasmim."))
add("чай пуэр", "té pu-erh", "chá pu-erh",
    ("Пуэр можно коллекционировать.", "El pu-erh se puede guardar y coleccionar.", "Pu-erh pode ser guardado e colecionado."),
    ("Выдержанный пуэр густой и мягкий.", "El pu-erh maduro tiene un sabor rico.", "O pu-erh maduro tem sabor encorpado."))
add("заваривать чай", "infusionar té / preparar té", "preparar chá / infundir chá",
    ("Я заварю чай.", "Yo preparo el té.", "Eu preparo o chá."),
    ("Слишком горячая вода не подходит для заваривания.", "El agua demasiado caliente no sirve para el té.", "Água quente demais não serve para o chá."))
add("чайный лист", "hojas de té", "folhas de chá",
    ("Это чай нового урожая.", "Estas hojas son de la cosecha de este año.", "Estas folhas são da colheita deste ano."),
    ("Чай нужно хранить герметично.", "Las hojas de té hay que guardarlas selladas.", "As folhas de chá devem ser guardadas bem fechadas."))
add("чай гунфу / чайная церемония", "té gongfu / ceremonia del té", "chá gongfu / cerimônia do chá",
    ("В Гуандуне любят чай гунфу.", "En Guangdong les gusta el té gongfu.", "Em Guangdong gostam de chá gongfu."),
    ("В гунфу важен температура воды.", "El té gongfu cuida la temperatura del agua.", "O chá gongfu dá atenção à temperatura da água."))
add("чайная / чайный дом", "casa de té / salón de té", "casa de chá",
    ("Пойдём посидим в чайной.", "Vamos a sentarnos en una casa de té.", "Vamos sentar numa casa de chá."),
    ("В этой чайной приятная атмосфера.", "Esta casa de té tiene un ambiente agradable.", "Esta casa de chá tem um ambiente gostoso."))
add("наливать чай", "servir té", "servir chá",
    ("Налейте мне, пожалуйста, чай.", "Sírvame té, por favor.", "Me sirva chá, por favor."),
    ("Чай сначала наливают старшим.", "Al servir té, se sirve primero a los mayores.", "Ao servir chá, sirva primeiro os mais velhos."))
add("вода", "agua", "água",
    ("Дайте мне стакан воды.", "Un vaso de agua, por favor.", "Um copo de água, por favor."),
    ("Пить больше воды полезно.", "Beber más agua es bueno para la salud.", "Beber mais água faz bem."))
add("фруктовый сок", "zumo / jugo de fruta", "suco de fruta",
    ("Свежевыжатый сок без добавок.", "El jugo recién exprimido no tiene aditivos.", "Suco natural não tem aditivo."),
    ("Дети любят апельсиновый сок.", "A los niños les gusta el jugo de naranja.", "Crianças gostam de suco de laranja."))
add("молоко", "leche", "leite",
    ("На завтрак я пью молоко.", "En el desayuno tomo leche.", "No café da manhã eu tomo leite."),
    ("Эту пачку молока нужно держать в холодильнике.", "Esta leche hay que refrigerarla.", "Este leite precisa ir na geladeira."))
add("кола", "cola / refresco de cola", "refrigerante de cola",
    ("Дайте банку колы.", "Una lata de cola, por favor.", "Uma lata de cola, por favor."),
    ("Колу лучше пить меньше.", "Es mejor beber menos cola.", "É melhor beber menos cola."))
add("пиво", "cerveza", "cerveja",
    ("Летом холодное пиво отлично идёт.", "En verano una cerveza fría sienta genial.", "No verão uma cerveja gelada cai muito bem."),
    ("Две бутылки пива, пожалуйста.", "Dos botellas de cerveza, por favor.", "Duas garrafas de cerveja, por favor."))
add("байцзю (китайский крепкий алкоголь)", "baijiu (licor chino)", "baijiu (destilado chinês)",
    ("У байцзю высокая крепость.", "El baijiu tiene mucha graduación.", "O baijiu tem teor alcoólico alto."),
    ("На банкетах часто пьют байцзю.", "En los banquetes suele servirse baijiu.", "Em banquetes costuma-se beber baijiu."))
add("красное вино", "vino tinto", "vinho tinto",
    ("Красному вину нужно подышать.", "El vino tinto hay que oxigenarlo.", "Vinho tinto precisa respirar."),
    ("На праздник мы открыли бутылку красного.", "Abrimos una botella de tinto para celebrar.", "Abrimos uma garrafa de tinto para comemorar."))
add("соевое молоко", "leche de soja", "leite de soja",
    ("Завтрак с ютяо и соевым молоком.", "Desayuno con youtiao y leche de soja.", "Café da manhã com youtiao e leite de soja."),
    ("Горячее соевое молоко очень вкусное.", "La leche de soja caliente está riquísima.", "Leite de soja quente está uma delícia."))
add("молочный чай", "té con leche", "chá com leite / milk tea",
    ("Бабл-ти очень популярен.", "El té con perlas es muy popular.", "Milk tea com pérola é muito popular."),
    ("Мне молочный чай с меньшим сахаром.", "Un té con leche con menos azúcar.", "Um chá com leite com menos açúcar."))
add("энергетический напиток", "bebida energética", "bebida energética",
    ("После спорта пьют энергетик.", "Después de hacer deporte se toma una bebida energética.", "Depois do exercício toma-se uma bebida energética."),
    ("Энергетики лучше не злоупотреблять.", "No hay que beber demasiadas bebidas energéticas.", "Não se deve tomar bebida energética demais."))

apply_rows("food", ROWS)
print("food rows", len(ROWS))
