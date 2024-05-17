---
header-line1: Київський Національний Університет імені Тараса Шевченка
header-line2: Фізичний факультет
document-type: ЗВІТ
title-line1: про Виконання лабораторних робіт
title-line2: З КУРСУ НИЗЬКОФОНОВІ ЕКСПЕРИМЕНТИ
title-line3: (3й курс)
author-line1: виконував
author-line2: Дяченко Артем
author-line3: студент 3го курсу, ФВЕ
date: травень 2024
prof: PROF_UNIQUE_VARIABLE
code-section-title: Деякі вихідні коди
---

# Робота 1

## Вправа 00

За допомогою наступного скрипту, дізнаємось склад наданого файлу:
```cpp
#include <TFile.h>

void task1_tname(char const *fname) {
    auto fin = TFile::Open(fname);
    fin->ls();
}
```

Отримано такий вивід:

```
TFile**         data_06e_58207_58211_01.root    orange
 TFile*         data_06e_58207_58211_01.root    orange
  KEY: TTree    orange;6        orange tree [current cycle]
  KEY: TTree    orange;5        orange tree [backup cycle]
```

Тож у файлі міститься дві версії дерева із назвою `orange`.

![[Pasted image 20240517105006.png]]


![[Pasted image 20240517112012.png]]

ввв

```sh
fish catch("a whole bunch of nothing");
```
