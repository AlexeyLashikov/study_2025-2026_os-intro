---
## Front matter
lang: ru-RU
title: Лабораторная работа №1
subtitle: Установка ОС Linux (Fedora Sway) в VirtualBox
author:
  - Лащиков Алексей Антонович
institute:
  - Российский университет дружбы народов, Москва, Россия
date: 2026-02-18
date-format: "YYYY-MM-DD"

babel-lang: russian
babel-otherlangs: english

toc: false
slide_level: 2
aspectratio: 169
section-titles: false
theme: metropolis

pdf-engine: xelatex
header-includes:
  - \metroset{progressbar=frametitle,sectionpage=none,numbering=fraction}
  - \usepackage{fontspec}
  - \usepackage{polyglossia}
  - \setdefaultlanguage{russian}
  - \setotherlanguage{english}
  - \defaultfontfeatures{Ligatures=TeX}
  - \setsansfont{DejaVu Sans}
  - \setmainfont{DejaVu Serif}
  - \setmonofont{DejaVu Sans Mono}
---

# Информация

## Докладчик
:::::::::::::: {.columns align=center}
::: {.column width="70%"}
  * Лащиков Алексей Антонович
  * Студент <группа>
  * Российский университет дружбы народов
  * [1032253527@rudn.ru](mailto:1032253527@rudn.ru)
:::
::: {.column width="30%"}
:::
::::::::::::::

## Цель и задачи
**Цель:** установить Fedora Sway в VirtualBox и выполнить базовую настройку системы.

**Задачи:**

- создать виртуальную машину и установить ОС;
- выполнить первичную настройку (обновления, инструменты, SELinux, раскладка, hostname);
- установить ПО для подготовки отчётов (`pandoc`, TeX Live);
- получить системную информацию через `dmesg`.

# Ход работы

## 1) Создание виртуальной машины
Создал новую виртуальную машину в графическом интерфейсе и задал имя ВМ по логину.

![Создание новой виртуальной машины](image/1.png){#fig-001 width=30%}

## 2) Настройка ресурсов
Указал объём оперативной памяти и размер диска 80 ГБ.

\begin{center}
\begin{minipage}{0.30\linewidth}
\centering
\includegraphics[width=\linewidth]{image/2.png}\\
\footnotesize Память виртуальной машины
\end{minipage}\hfill
\begin{minipage}{0.30\linewidth}
\centering
\includegraphics[width=\linewidth]{image/4.png}\\
\footnotesize Размер диска 80 ГБ
\end{minipage}
\end{center}

## 3) Подключение установочного ISO
Подключил ISO-образ Fedora Sway.

![Подключение ISO Fedora Sway](image/6.png){#fig-006 width=40%}

## 4) Параметры загрузки и виртуализации
Включил ускорение 3D/контроллер VMSVGA и поддержку UEFI.

\begin{center}
\begin{minipage}{0.40\linewidth}
\centering
\includegraphics[width=\linewidth]{image/7.png}\\
\footnotesize VMSVGA и 3D-ускорение
\end{minipage}\hfill
\begin{minipage}{0.40\linewidth}
\centering
\includegraphics[width=\linewidth]{image/8.png}\\
\footnotesize UEFI включён
\end{minipage}
\end{center}

## 5) Установка Fedora Sway
Установил систему на диск и завершил установку.

![Завершение установки Fedora Sway](image/9.png){#fig-009 width=78%}

# Первичная настройка Fedora

## Обновление и инструменты
Установил `development-tools` и обновил пакеты.

![Установка development-tools](image/10.png){#fig-010 width=70%}

![Обновление пакетов](image/11.png){#fig-011 width=60%}

## SELinux и hostname
Перевёл SELinux в режим `permissive` и установил имя хоста по требованиям именования.

![SELinux permissive](image/15.png){#fig-015 width=30%}

![Установка hostname](image/20.png){#fig-020 width=30%}

## Раскладка клавиатуры (Sway + system)
Создал пользовательский конфиг Sway и отредактировал системный конфиг клавиатуры.

![Пользовательский конфиг Sway](image/16.png){#fig-016 width=60%}

![Системный конфиг клавиатуры](image/19.png){#fig-019 width=60%}

# ПО для отчётов и обмен файлами

## Pandoc и TeX Live
Установил `pandoc` и TeX Live для сборки PDF.

![Установка pandoc](image/21.png){#fig-021 width=40%}

![Установка TeX Live](image/23.png){#fig-023 width=40%}

## Общая папка VirtualBox
Настроил shared folder через группу `vboxsf`.

![Подключение общей папки](image/31.png){#fig-031 width=78%}

# Домашнее задание (dmesg)

## Ключевая системная информация (1/4)
Определил версию ядра Linux.

![Версия ядра Linux](image/24.png){#fig-024 width=92%}

## Ключевая системная информация (2/4)
Определил частоту и модель процессора.

![Частота процессора](image/25.png){#fig-025 width=92%}

![Модель процессора](image/26.png){#fig-026 width=92%}

## Ключевая системная информация (3/4)
Определил объём доступной памяти и тип гипервизора.

![Доступная оперативная память](image/27.png){#fig-027 width=92%}

![Тип гипервизора](image/28.png){#fig-028 width=92%}

## Ключевая системная информация (4/4)
Определил тип файловой системы корневого раздела и последовательность монтирования ФС.

\begin{center}
\begin{minipage}{0.48\linewidth}
\centering
\includegraphics[width=\linewidth]{image/29.png}\\
\footnotesize Тип ФС корневого раздела
\end{minipage}\hfill
\begin{minipage}{0.48\linewidth}
\centering
\includegraphics[width=\linewidth]{image/30.png}\\
\footnotesize Последовательность монтирования ФС
\end{minipage}
\end{center}


# Итоги

## Выводы
- Создана ВМ в VirtualBox и установлена Fedora Sway.
- Выполнена первичная настройка: обновления, инструменты, SELinux, раскладка, hostname.
- Установлены `pandoc` и TeX Live; настроена общая папка для обмена файлами.
- По `dmesg` получены параметры загрузки и сведения об окружении (CPU, память, гипервизор, ФС).
