# INSTALL

* RVM
```
$ rvm install 2.5.1
$ rvm use 2.5.1@currency --ruby-version --create
```

* bundle
```
$ bundle install
```

* Изменить файл .env, вставить свой логин, пароль от бд
```
$ rails db:create
$ rails db:migrate
```

* Запуск приложения
```
$ foreman start
```