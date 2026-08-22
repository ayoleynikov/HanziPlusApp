#!/usr/bin/env python3
"""Business study-set translations (100 words)."""
from __future__ import annotations
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
from sidecar_lib import apply_rows

ROWS = []


def add(ru, es, pt, *examples):
    ROWS.append((ru, es, pt, examples))


add("совещание / встреча", "reunión", "reunião",
    ("В три часа дня совещание.", "Hay una reunión a las 3 de la tarde.", "Tem reunião às 15h."),
    ("Совещание перенесли на завтра.", "La reunión se pasó a mañana.", "A reunião foi para amanhã."))
add("повестка дня", "orden del día / agenda", "pauta / agenda",
    ("Посмотрите сегодняшнюю повестку.", "Revise la agenda de hoy.", "Veja a pauta de hoje."),
    ("Повестку уже разослали всем.", "La agenda ya se envió a todos.", "A pauta já foi enviada a todos."))
add("докладывать / отчёт", "informar / briefing", "relatar / briefing",
    ("Пусть каждый отдел доложит о прогрессе.", "Que cada departamento informe del avance.", "Cada departamento relata o andamento."),
    ("Он только что закончил отчёт по проекту.", "Acaba de terminar el briefing del proyecto.", "Ele acabou o briefing do projeto."))
add("обсуждать", "discutir", "discutir",
    ("Сначала обсудим этот вопрос.", "Discutamos primero este tema.", "Vamos discutir este assunto primeiro."),
    ("На встрече обсуждение было оживлённым.", "La discusión en la reunión fue animada.", "A discussão na reunião foi animada."))
add("подводить итог / резюме", "resumir / síntesis", "resumir / síntese",
    ("Пожалуйста, резюмируйте основные пункты.", "Resuma los puntos clave, por favor.", "Resuma os pontos-chave, por favor."),
    ("В конце совещания подвели итоги.", "Al final de la reunión se hizo un resumen.", "No fim da reunião fizemos um resumo."))
add("вовремя / пунктуально", "puntual / a tiempo", "pontual / no horário",
    ("Прошу всех прийти вовремя.", "Asistan a la reunión a tiempo.", "Compareçam à reunião no horário."),
    ("Он всегда пунктуален.", "Siempre es puntual.", "Ele sempre é pontual."))
add("откладывать / переносить", "aplazar / posponer", "adiar / postergar",
    ("Проект могут отложить.", "El proyecto puede aplazarse.", "O projeto pode ser adiado."),
    ("Совещание перенесли на следующую неделю.", "La reunión se aplazó a la semana que viene.", "A reunião foi adiada para a semana que vem."))
add("протокол / записывать", "acta / registrar", "ata / registrar",
    ("Ведите протокол совещания.", "Tome bien el acta de la reunión.", "Faça bem a ata da reunião."),
    ("Я записал все ключевые пункты.", "Anoté todos los puntos clave.", "Anotei todos os pontos-chave."))
add("участвовать в совещании", "asistir a la reunión", "participar da reunião",
    ("Тебе нужно быть на совещании?", "¿Necesitas asistir a la reunión?", "Você precisa participar da reunião?"),
    ("Все руководители должны участвовать.", "Todos los mandos deben asistir.", "Todos os gestores devem participar."))
add("решение / резолюция", "resolución / acuerdo", "resolução / deliberação",
    ("Совещание приняло это решение.", "La reunión aprobó esta resolución.", "A reunião aprovou esta resolução."),
    ("Исполняйте решение совещания.", "Ejecute el acuerdo de la reunión.", "Execute a deliberação da reunião."))
add("электронная почта / письмо", "correo electrónico", "e-mail",
    ("Я получил ваше письмо.", "Recibí tu correo.", "Recebi o seu e-mail."),
    ("Проверьте письмо со вложением.", "Revise el correo con el adjunto.", "Confira o e-mail com o anexo."))
add("вложение", "archivo adjunto", "anexo",
    ("Отчёт во вложении.", "El informe está en el adjunto.", "O relatório está no anexo."),
    ("Приложите договор.", "Adjunte el contrato, por favor.", "Anexe o contrato, por favor."))
add("отвечать / ответить", "responder", "responder",
    ("Ответьте на это письмо как можно скорее.", "Responda este correo pronto.", "Responda este e-mail o quanto antes."),
    ("Я уже ответил клиенту.", "Ya respondí al cliente.", "Já respondi ao cliente."))
add("копия / ставить в копию (CC)", "con copia / CC", "com cópia / CC",
    ("Поставьте в копию финансовый отдел.", "Ponga en copia a finanzas.", "Coloque o financeiro em cópia."),
    ("Я поставил менеджера в копию.", "Puse al gerente en copia.", "Coloquei o gerente em cópia."))
add("тема письма", "asunto", "assunto",
    ("Исправьте тему письма.", "Cambie el asunto del correo.", "Altere o assunto do e-mail."),
    ("Тема должна быть понятной.", "El asunto debe estar claro.", "O assunto precisa estar claro."))
add("пересылать", "reenviar / reenviar correo", "encaminhar",
    ("Я переслал вам письмо.", "Te reenvié el correo.", "Encaminhei o e-mail para você."),
    ("Перешлите коллегам по теме.", "Reenvíelo a los colegas implicados.", "Encaminhe aos colegas envolvidos."))
add("подтверждать", "confirmar", "confirmar",
    ("Подтвердите получение письма.", "Confirme la recepción de este correo.", "Confirme o recebimento deste e-mail."),
    ("Клиент подтвердил заказ.", "El cliente confirmó el pedido.", "O cliente confirmou o pedido."))
add("уведомление / извещать", "aviso / notificar", "aviso / notificar",
    ("Компания разослала официальное уведомление.", "La empresa emitió un aviso oficial.", "A empresa emitiu um aviso oficial."),
    ("Известите всех сотрудников.", "Notifique a todos los empleados.", "Avise todos os funcionários."))
add("общаться / коммуникация", "comunicar / comunicación", "comunicar / comunicação",
    ("Нам нужно лучше общаться.", "Necesitamos mejorar la comunicación.", "Precisamos melhorar a comunicação."),
    ("Переписка по почте очень эффективна.", "La comunicación por correo es muy eficaz.", "A comunicação por e-mail é muito eficiente."))
add("получатель", "destinatario", "destinatário",
    ("Проверьте адрес получателя.", "Revise la dirección del destinatario.", "Confira o endereço do destinatário."),
    ("Получателя указали неверно.", "El destinatario se escribió mal.", "O destinatário foi preenchido errado."))
add("клиент / заказчик", "cliente", "cliente",
    ("Этот клиент очень важен.", "Este cliente es muy importante.", "Este cliente é muito importante."),
    ("Ведите работу с новым клиентом.", "Haga el seguimiento del nuevo cliente.", "Faça o follow-up do novo cliente."))
add("заказ", "pedido / orden", "pedido",
    ("Клиент сделал крупный заказ.", "El cliente hizo un pedido grande.", "O cliente fez um pedido grande."),
    ("Заказ уже подтверждён.", "El pedido ya está confirmado.", "O pedido já está confirmado."))
add("коммерческое предложение / котировка", "cotización / presupuesto", "cotação / orçamento",
    ("Пришлите коммерческое предложение.", "Envíe una cotización.", "Envie uma cotação."),
    ("Их цена ниже нашей.", "Su cotización es más baja que la nuestra.", "A cotação deles é mais baixa que a nossa."))
add("акция / продвижение продаж", "promoción / oferta", "promoção",
    ("В торговом центре идёт акция.", "El centro comercial tiene una promoción.", "O shopping está em promoção."),
    ("Акция прошла успешно.", "La promoción fue un éxito.", "A promoção foi um sucesso."))
add("рынок", "mercado", "mercado",
    ("Китайский рынок растёт быстро.", "El mercado chino crece rápido.", "O mercado chinês cresce rápido."),
    ("Мы хотим выйти на новые рынки.", "Queremos abrir nuevos mercados.", "Queremos abrir novos mercados."))
add("цель / план (KPI)", "objetivo / meta", "meta / objetivo",
    ("Цель продаж на квартал высокая.", "La meta de ventas de este trimestre es alta.", "A meta de vendas deste trimestre é alta."),
    ("Мы уже выполнили план.", "Ya cumplimos el objetivo.", "Já batemos a meta."))
add("продвигать / маркетинг", "promocionar / marketing", "divulgar / marketing",
    ("Новый продукт нужно продвигать.", "El producto nuevo necesita marketing.", "O produto novo precisa de marketing."),
    ("Они продвигают в интернете.", "Están haciendo promoción en línea.", "Eles estão fazendo divulgação online."))
add("спрос / потребность", "demanda / necesidad", "demanda / necessidade",
    ("Рыночный спрос растёт.", "La demanda del mercado está aumentando.", "A demanda do mercado está aumentando."),
    ("Сначала разберитесь в потребностях клиента.", "Primero entienda las necesidades del cliente.", "Primeiro entenda as necessidades do cliente."))
add("результаты / показатели", "desempeño / resultados", "desempenho / resultados",
    ("У него отличные показатели.", "Su desempeño comercial es excelente.", "O desempenho de vendas dele é excelente."),
    ("Показатели компании стабильно растут.", "El desempeño de la empresa mejora de forma constante.", "O desempenho da empresa melhora de forma constante."))
add("подписывать договор", "firmar un contrato", "assinar contrato",
    ("Клиент согласился подписать.", "El cliente aceptó firmar.", "O cliente aceitou assinar."),
    ("Подписываем на следующей неделе.", "Firmamos la semana que viene.", "Assinamos na semana que vem."))
add("производство / производить", "producción / producir", "produção / produzir",
    ("Завод работает на полную мощность.", "La fábrica produce a plena capacidad.", "A fábrica produz a plena capacidade."),
    ("Эта линия выпускает тысячу штук в день.", "Esta línea produce mil unidades al día.", "Esta linha produz mil unidades por dia."))
add("качество", "calidad", "qualidade",
    ("Качество продукции должно соответствовать нормам.", "La calidad del producto debe cumplir la norma.", "A qualidade do produto precisa atender à norma."),
    ("Мы повышаем качество.", "Estamos mejorando la calidad.", "Estamos melhorando a qualidade."))
add("цех / производственный участок", "taller / planta", "chão de fábrica / oficina",
    ("Сходите посмотреть цех.", "Vaya a ver el taller.", "Vá ver o chão de fábrica."),
    ("Рабочие в цехе очень добросовестные.", "Los operarios del taller son muy diligentes.", "Os operários do chão de fábrica são muito caprichosos."))
add("сырьё", "materia prima", "matéria-prima",
    ("Цены на сырьё выросли.", "Subió el precio de la materia prima.", "O preço da matéria-prima subiu."),
    ("На складе сырья достаточно.", "Hay materia prima suficiente en el almacén.", "Há matéria-prima suficiente no estoque."))
add("оборудование", "equipo / maquinaria", "equipamento / máquina",
    ("Оборудование нужно регулярно обслуживать.", "El equipo necesita mantenimiento regular.", "O equipamento precisa de manutenção regular."),
    ("Новое оборудование уже установлено.", "El equipo nuevo ya está instalado.", "O equipamento novo já está instalado."))
add("сборка / собирать", "ensamblaje / ensamblar", "montagem / montar",
    ("Процесс сборки очень строгий.", "El proceso de ensamblaje es muy estricto.", "O processo de montagem é muito rigoroso."),
    ("Рабочие собирают детали.", "Los operarios están ensamblando piezas.", "Os operários estão montando peças."))
add("контроль качества / проверка", "inspección / ensayo", "inspeção / teste",
    ("Каждую партию нужно проверять.", "Cada lote debe inspeccionarse.", "Cada lote precisa ser inspecionado."),
    ("Результаты проверки — соответствие норме.", "Los resultados del ensayo son conformes.", "Os resultados do teste estão conformes."))
add("выпуск / объём производства", "producción / volumen de producción", "produção / volume de produção",
    ("В этом месяце выпуск побил рекорд.", "La producción de este mes batió un récord.", "A produção deste mês bateu recorde."),
    ("Нужно увеличить выпуск.", "Hay que aumentar la producción.", "Precisamos aumentar a produção."))
add("конвейер / линия", "línea de montaje", "linha de montagem",
    ("Конвейер работает стабильно.", "La línea de montaje funciona de forma estable.", "A linha de montagem funciona de forma estável."),
    ("Новая линия уже запущена.", "La nueva línea ya está en producción.", "A nova linha já está em produção."))
add("стандарт / норма", "estándar / norma", "padrão / norma",
    ("Продукция должна соответствовать нацстандарту.", "Los productos deben cumplir la norma nacional.", "Os produtos devem atender à norma nacional."),
    ("Мы повысили производственные стандарты.", "Elevamos los estándares de producción.", "Elevamos os padrões de produção."))
add("отгружать / отправлять товар", "enviar / despachar", "enviar / despachar",
    ("Заказ можно отгрузить сегодня.", "El pedido puede enviarse hoy.", "O pedido pode ser enviado hoje."),
    ("Склад уже оформил отгрузку.", "El almacén ya organizó el envío.", "O depósito já organizou o envio."))
add("логистика", "logística", "logística",
    ("Информация по логистике обновлена.", "La información logística se actualizó.", "A informação logística foi atualizada."),
    ("Мы сменили логистическую компанию.", "Cambiamos de empresa de logística.", "Trocamos de empresa de logística."))
add("склад", "almacén / depósito", "armazém / depósito",
    ("Товар на складе.", "La mercancía está en el almacén.", "A mercadoria está no armazém."),
    ("Склад ведётся по регламенту.", "La gestión del almacén es muy ordenada.", "A gestão do armazém é bem organizada."))
add("перевозка / транспортировка", "transporte / envío", "transporte / envio",
    ("Перевозка занимает около трёх дней.", "El transporte tarda unos tres días.", "O transporte leva cerca de três dias."),
    ("Эта партия идёт морем.", "Este lote va por vía marítima.", "Este lote vai por via marítima."))
add("таможенное оформление", "despacho de aduana", "despacho aduaneiro",
    ("Экспортный товар нужно оформлять на таможне.", "La mercancía de exportación requiere despacho.", "Mercadoria de exportação precisa de despacho."),
    ("Таможенные формальности уже готовы.", "Los trámites de aduana ya están listos.", "Os trâmites da alfândega já estão prontos."))
add("экспресс-доставка / курьер", "mensajería urgente / express", "sedex / encomenda expressa",
    ("Отправьте образец курьером.", "Envíe la muestra por mensajería urgente.", "Envie a amostra por encomenda expressa."),
    ("Курьер прибудет завтра.", "El paquete express llega mañana.", "A encomenda expressa chega amanhã."))
add("упаковка", "embalaje / empaque", "embalagem",
    ("Усильте упаковку товара.", "Refuerce el embalaje del producto.", "Reforce a embalagem do produto."),
    ("Упаковка не должна быть повреждена.", "El embalaje no puede estar dañado.", "A embalagem não pode estar danificada."))
add("расписываться за получение", "firmar la recepción", "assinar o recebimento",
    ("Распишитесь на накладной курьера.", "Firme en el albarán, por favor.", "Assine no comprovante, por favor."),
    ("Клиент уже расписался за получение.", "El cliente ya firmó la recepción.", "O cliente já assinou o recebimento."))
add("задержка", "retraso / demora", "atraso / demora",
    ("Задержка рейса повлияла на отгрузку.", "El retraso del vuelo afectó el envío.", "O atraso do voo afetou o envio."),
    ("Объясните причину задержки.", "Explique el motivo del retraso.", "Explique o motivo do atraso."))
add("отслеживать", "rastrear / seguir", "rastrear / acompanhar",
    ("Посылку можно отслеживать онлайн.", "Puede rastrear el paquete en línea.", "Dá para rastrear o pacote online."),
    ("Логистика отслеживает груз.", "Logística está rastreando la mercancía.", "A logística está rastreando a carga."))
add("счёт-фактура / инвойс", "factura", "nota fiscal / fatura",
    ("Выпишите счёт НДС.", "Emita una factura de IVA.", "Emita uma nota fiscal de IVA."),
    ("Счёт уже отправили клиенту.", "La factura ya se envió al cliente.", "A nota já foi enviada ao cliente."))
add("оплата / платёж", "pago", "pagamento",
    ("Оплатите до конца месяца.", "Pague antes de fin de mes.", "Pague até o fim do mês."),
    ("Клиент уже оплатил.", "El cliente ya pagó.", "O cliente já pagou."))
add("бюджет", "presupuesto", "orçamento",
    ("Бюджет на квартал очень жёсткий.", "El presupuesto de este trimestre está muy ajustado.", "O orçamento deste trimestre está apertado."),
    ("Подайте бюджет отдела.", "Presente el presupuesto del departamento.", "Envie o orçamento do departamento."))
add("себестоимость / затраты", "coste / costo", "custo",
    ("Нужно контролировать затраты.", "Hay que controlar los costes.", "Precisamos controlar os custos."),
    ("Себестоимость сырья выросла.", "Subió el coste de la materia prima.", "O custo da matéria-prima subiu."))
add("прибыль", "beneficio / ganancia", "lucro",
    ("Прибыль компании стабильно растёт.", "Los beneficios de la empresa crecen de forma constante.", "O lucro da empresa cresce de forma constante."),
    ("У этого заказа хорошая маржа.", "Este pedido tiene un buen margen.", "Este pedido tem uma boa margem."))
add("счёт (банковский)", "cuenta", "conta",
    ("Переведите деньги на этот счёт.", "Transfiera el pago a esta cuenta.", "Transfira o pagamento para esta conta."),
    ("На счёте компании достаточно средств.", "El saldo de la cuenta es suficiente.", "O saldo da conta é suficiente."))
add("банковский перевод", "transferencia bancaria", "transferência bancária",
    ("Оплатите банковским переводом.", "Pague por transferencia bancaria.", "Pague por transferência bancária."),
    ("Я уже перевёл.", "Ya hice la transferencia.", "Já fiz a transferência."))
add("возмещение расходов / авансовый отчёт", "reembolso de gastos", "reembolso de despesas",
    ("Командировочные можно возместить.", "Los gastos de viaje se pueden reembolsar.", "Despesas de viagem podem ser reembolsadas."),
    ("Подайте документы на возмещение.", "Presente los justificantes de reembolso.", "Envie os comprovantes de reembolso."))
add("аудит / проверка", "auditoría", "auditoria",
    ("В компании идёт аудит.", "La empresa está en auditoría.", "A empresa está em auditoria."),
    ("Аудиторский отчёт выйдет в следующем месяце.", "El informe de auditoría sale el mes que viene.", "O relatório de auditoria sai no mês que vem."))
add("валютный курс", "tipo de cambio", "câmbio",
    ("Колебания курса повлияли на прибыль.", "Las fluctuaciones del tipo de cambio afectaron los beneficios.", "As flutuações do câmbio afetaram o lucro."),
    ("Проверьте сегодняшний курс.", "Consulte el tipo de cambio de hoy.", "Consulte o câmbio de hoje."))
add("входящий звонок", "llamada entrante", "chamada recebida",
    ("У вас входящий звонок.", "Tiene una llamada entrante.", "Você tem uma chamada recebida."),
    ("Только что был важный звонок.", "Hubo una llamada importante hace un momento.", "Houve uma ligação importante agora há pouco."))
add("перезванивать", "devolver la llamada", "retornar a ligação",
    ("Я перезвоню позже.", "Le devuelvo la llamada más tarde.", "Retorno a ligação mais tarde."),
    ("Перезвоните как можно скорее.", "Devuelva la llamada lo antes posible.", "Retorne a ligação o quanto antes."))
add("оставить сообщение", "dejar un recado", "deixar recado",
    ("Его нет, оставьте сообщение.", "No está, deje un recado.", "Ele não está, deixe recado."),
    ("Я оставил сообщение на автоответчике.", "Dejé un recado en el buzón de voz.", "Deixei recado na caixa postal."))
add("соединять (звонок)", "conectar / poner en línea", "conectar / completar a chamada",
    ("Звонок всё не соединяется.", "La llamada no conecta.", "A ligação não completa."),
    ("Наконец соединили.", "Por fin nos pusieron en línea.", "Finalmente a ligação completou."))
add("занято (линия)", "ocupado (línea)", "ocupado (linha)",
    ("Его линия занята.", "Su línea está ocupada.", "A linha dele está ocupada."),
    ("Позвоните позже, линия занята.", "Llame más tarde, la línea está ocupada.", "Ligue mais tarde, a linha está ocupada."))
add("конференц-звонок", "llamada de conferencia", "chamada em conferência",
    ("В десять — конференц-звонок.", "A las diez hay una conferencia.", "Às dez tem uma conferência."),
    ("Подключитесь к конференц-звонку.", "Únase a la conferencia, por favor.", "Entre na conferência, por favor."))
add("сигнал (связи)", "señal", "sinal",
    ("Здесь плохой сигнал.", "Aquí la señal es mala.", "Aqui o sinal está ruim."),
    ("Вас не слышно, сигнал слабый.", "No le oigo, la señal es muy débil.", "Não estou ouvindo, o sinal está fraco."))
add("класть трубку", "colgar", "desligar",
    ("Пока не кладите трубку.", "No cuelgue todavía.", "Não desligue ainda."),
    ("Он сказал и положил трубку.", "Habló y colgó.", "Ele falou e desligou."))
add("набирать номер", "marcar / llamar", "discar / ligar",
    ("Позвоните на горячую линию.", "Marque la línea de atención al cliente.", "Ligue para o SAC."),
    ("Я набирал три раза — никто не взял.", "Marqué tres veces y nadie contestó.", "Disquei três vezes e ninguém atendeu."))
add("разговор / звонок", "llamada / conversación", "ligação / conversa",
    ("Наш разговор записывается.", "Nuestra llamada está siendo grabada.", "Nossa ligação está sendo gravada."),
    ("Не затягивайте разговор.", "No alargue demasiado la llamada.", "Não alongue demais a ligação."))
add("коллега", "compañero de trabajo", "colega de trabalho",
    ("Мои коллеги очень помогают.", "Mis compañeros son de mucha ayuda.", "Meus colegas ajudam muito."),
    ("Передайте это коллеге.", "Entrégueselo a un compañero.", "Entregue isso a um colega."))
add("отдел / департамент", "departamento", "departamento",
    ("Он работает в отделе продаж.", "Trabaja en el departamento de ventas.", "Ele trabalha no departamento de vendas."),
    ("Пусть каждый отдел сдаст отчёт.", "Que cada departamento entregue el informe.", "Cada departamento deve entregar o relatório."))
add("работать сверхурочно", "hacer horas extra", "fazer hora extra",
    ("Сегодня вечером, возможно, придётся задержаться.", "Esta noche puede que hagamos horas extra.", "Hoje à noite talvez tenhamos que fazer hora extra."),
    ("В последнее время он часто остаётся сверхурочно.", "Últimamente hace muchas horas extra.", "Ultimamente ele faz muita hora extra."))
add("брать отгул / оформлять отпуск", "pedir permiso / coger vacaciones", "pedir folga / tirar licença",
    ("Хочу взять завтра отгул.", "Quisiera pedirme mañana libre.", "Quero tirar folga amanhã."),
    ("Она взяла отгул и поехала в больницу.", "Pidió permiso para ir al hospital.", "Ela tirou folga para ir ao hospital."))
add("печатать", "imprimir", "imprimir",
    ("Распечатайте этот документ, пожалуйста.", "Imprima este documento, por favor.", "Imprima este documento, por favor."),
    ("В принтере закончилась бумага.", "La impresora se quedó sin papel.", "A impressora está sem papel."))
add("ксерокопировать", "fotocopiar", "xerox / fotocopiar",
    ("Сделайте пять копий договора.", "Haga cinco copias del contrato.", "Faça cinco cópias do contrato."),
    ("Копир вон там.", "La fotocopiadora está allí.", "A copiadora fica ali."))
add("документ / файл", "documento / archivo", "documento / arquivo",
    ("Документ уже отправили вам.", "El documento ya se le envió.", "O documento já foi enviado a você."),
    ("Подшейте этот документ.", "Archive este documento.", "Arquive este documento."))
add("расписание / календарь встреч", "agenda / calendario", "agenda / calendário",
    ("Посмотрите сегодняшнее расписание.", "Mire la agenda de hoy.", "Olhe a agenda de hoje."),
    ("Я добавил встречу в календарь.", "Añadí la reunión a la agenda.", "Incluí a reunião na agenda."))
add("рабочее место", "puesto de trabajo", "estação de trabalho / mesa",
    ("Моё место у окна.", "Mi puesto está junto a la ventana.", "Minha mesa fica junto à janela."),
    ("Приведите в порядок рабочее место.", "Ordene su puesto de trabajo.", "Organize a sua mesa."))
add("работать в офисе / офисная работа", "trabajar en la oficina", "trabalhar no escritório",
    ("Я работаю в офисе.", "Trabajo en la oficina.", "Trabalho no escritório."),
    ("Сегодня работаю из дома.", "Hoy trabajo desde casa.", "Hoje trabalho de casa."))
add("переговоры", "negociación", "negociação",
    ("Переговоры длились три часа.", "La negociación duró tres horas.", "A negociação durou três horas."),
    ("Переговоры сторон прошли гладко.", "Ambas partes negociaron sin problemas.", "Os dois lados negociaram sem problemas."))
add("условия", "condiciones / términos", "condições / termos",
    ("Разъясните условия сотрудничества.", "Explique las condiciones de cooperación.", "Explique as condições de cooperação."),
    ("Эти условия мы можем принять.", "Podemos aceptar estas condiciones.", "Podemos aceitar estas condições."))
add("уступать / уступка", "ceder / concesión", "ceder / concessão",
    ("Обе стороны должны пойти на уступки.", "Ambas partes tienen que ceder.", "Os dois lados precisam ceder."),
    ("Мы уступили в цене.", "Hicimos una concesión en el precio.", "Fizemos uma concessão no preço."))
add("сотрудничество / партнёрство", "cooperación / colaboración", "cooperação / parceria",
    ("Мы надеемся на долгосрочное сотрудничество.", "Esperamos una cooperación a largo plazo.", "Esperamos uma parceria de longo prazo."),
    ("Сотрудничество выгодно обеим сторонам.", "La cooperación beneficia a ambas partes.", "A cooperação beneficia os dois lados."))
add("предложение / план / схема", "propuesta / plan", "proposta / plano",
    ("Представьте новое предложение.", "Presente una nueva propuesta.", "Apresente uma nova proposta."),
    ("Этот план более реалистичен.", "Este plan es más viable.", "Este plano é mais viável."))
add("красная черта / нижний предел", "línea roja / mínimo aceptable", "linha vermelha / limite mínimo",
    ("Это наш нижний предел.", "Esta es nuestra línea roja.", "Esta é a nossa linha vermelha."),
    ("Цена не может быть ниже предела.", "El precio no puede bajar de nuestro mínimo.", "O preço não pode ficar abaixo do nosso mínimo."))
add("консенсус / согласие", "consenso", "consenso",
    ("Стороны достигли согласия.", "Ambas partes llegaron a un consenso.", "Os dois lados chegaram a um consenso."),
    ("Нужно ещё лучше согласовать позиции.", "Aún hay que construir más consenso.", "Ainda precisamos construir mais consenso."))
add("пункт / статья (договора)", "cláusula / disposición", "cláusula / disposição",
    ("Внимательно проверьте пункты договора.", "Revise con cuidado las cláusulas del contrato.", "Revise com cuidado as cláusulas do contrato."),
    ("Этот пункт нужно изменить.", "Esta cláusula hay que revisarla.", "Esta cláusula precisa ser alterada."))
add("интересы / выгода", "interés / beneficio", "interesse / benefício",
    ("Нужно учитывать интересы обеих сторон.", "Hay que tener en cuenta el interés de ambas partes.", "É preciso considerar o interesse dos dois lados."),
    ("Это решение сильно затрагивает интересы.", "Esta decisión afecta mucho nuestros intereses.", "Esta decisão afeta muito os nossos interesses."))
add("тупик (в переговорах)", "punto muerto / estancamiento", "impasse",
    ("Переговоры зашли в тупик.", "La negociación llegó a un punto muerto.", "A negociação chegou a um impasse."),
    ("Нужно выйти из тупика.", "Hay que romper el estancamiento.", "Precisamos sair do impasse."))
add("договор / контракт", "contrato", "contrato",
    ("Подпишите договор.", "Firme el contrato.", "Assine o contrato."),
    ("Срок действия договора — год.", "El contrato tiene vigencia de un año.", "O contrato tem validade de um ano."))
add("подписывать", "firmar / suscribir", "assinar",
    ("Сегодня стороны подписывают соглашение.", "Hoy ambas partes firman el acuerdo.", "Hoje os dois lados assinam o acordo."),
    ("Подпишитесь на последней странице.", "Firme en la última página.", "Assine na última página."))
add("нарушение договора", "incumplimiento contractual", "quebra de contrato",
    ("За нарушение договора нужно возмещать убытки.", "El incumplimiento exige compensación.", "A quebra de contrato exige indenização."),
    ("Компания не будет нарушать договор.", "La empresa no incumplirá el contrato.", "A empresa não vai quebrar o contrato."))
add("срок действия", "periodo de vigencia", "prazo de validade",
    ("Срок действия договора — три года.", "El contrato tiene una vigencia de tres años.", "O contrato tem validade de três anos."),
    ("Подтвердите срок действия.", "Confirme el periodo de vigencia.", "Confirme o prazo de validade."))
add("вступать в силу", "entrar en vigor", "entrar em vigor",
    ("Договор вступает в силу в следующем месяце.", "El contrato entra en vigor el mes que viene.", "O contrato entra em vigor no mês que vem."),
    ("Соглашение уже действует.", "El acuerdo ya está en vigor.", "O acordo já está em vigor."))
add("продлевать (договор)", "renovar (un contrato)", "renovar (contrato)",
    ("Мы хотим продлить договор.", "Queremos renovar el contrato.", "Queremos renovar o contrato."),
    ("Договор скоро истекает, нужно продлить.", "El contrato vence pronto y hay que renovarlo.", "O contrato vence em breve e precisa ser renovado."))
add("конфиденциальность / не разглашать", "confidencial / NDA", "confidencial / NDA",
    ("Соблюдайте соглашение о конфиденциальности.", "Cumpla el acuerdo de confidencialidad.", "Cumpra o acordo de confidencialidade."),
    ("Эти материалы нужно держать в тайне.", "Esta información debe mantenerse confidencial.", "Estas informações devem ser mantidas em sigilo."))
add("конфиденциальность (свойство)", "carácter confidencial", "sigilo / confidencialidade",
    ("Обратите внимание на конфиденциальность документа.", "Tenga en cuenta la confidencialidad del documento.", "Atenção ao sigilo do documento."),
    ("Требования к конфиденциальности очень строгие.", "Los requisitos de confidencialidad son muy estrictos.", "Os requisitos de sigilo são muito rigorosos."))
add("сторона А (договора)", "Parte A (contrato)", "Parte A (contrato)",
    ("Сторона А предоставляет оборудование.", "La Parte A se encarga de proporcionar el equipo.", "A Parte A fica responsável por fornecer o equipamento."),
    ("Представитель стороны А уже подписал.", "El representante de la Parte A ya firmó.", "O representante da Parte A já assinou."))
add("сторона Б (договора)", "Parte B (contrato)", "Parte B (contrato)",
    ("Сторона Б должна поставить товар за тридцать дней.", "La Parte B debe entregar en treinta días.", "A Parte B deve entregar em trinta dias."),
    ("Сторона Б согласна с вышеуказанными пунктами.", "La Parte B acepta las cláusulas anteriores.", "A Parte B concorda com as cláusulas acima."))

apply_rows("business", ROWS)
print("business rows", len(ROWS))
