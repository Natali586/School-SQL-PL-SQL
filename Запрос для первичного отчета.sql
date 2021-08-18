SELECT cl_name AS ФИО, num_dog AS Номер_договора, summa_dog AS Сумма_договора,  date_begin AS Дата_начала, date_end AS Дата_окончания, 
month_pay AS Платеж,procent_sum AS Проценты,pay_summa AS Всего_к_оплате, stavka AS Ставка, (months_between(date_end,date_begin)+1) As Период 
from primary_report;
