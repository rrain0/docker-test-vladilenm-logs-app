# Обучалка по докеру: https://www.youtube.com/watch?v=n9uCgUzfeRQ
# Базируем свой образ на основе ноды
FROM node

# Текущая папка в образе - обращаемся к ней через точку
WORKDIR /app

# Скопировать package.json в /app
# если изменений в package.json не будет, то докер возьмёт node_modules из кэша
COPY package.json /app

# RUN - работает во время сборки образа
# Установить node_modules в образ - если package.json не изменился - возьмёт из кэша
RUN yarn install

# Копировать определённые файлы/папки проекта в образ
# . - копировать всё находящееся в папке, где лежит Dockerfile
# . - вторая точка - корень образа или папка, указанная в WORKDIR
COPY . .

# Задаём Environment переменную
# В коде мы к ней емеем доступ через process.env.PORT
ENV PORT 3000

# Сообщаем докеру, какой порт мы используем
# $PORT - обращение к ENV переменной PORT
# Хотя в коде задан порт 3000,
EXPOSE $PORT

# Анонимный том
VOLUME [ "/app/data" ]

# CMD - работает при каждом запуске образа
CMD ["node", "app.js"]