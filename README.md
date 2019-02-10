# README

## 概要

個人用の副業サポートツールです。

## 環境など

* Ruby 2.7.0
* Rails 5.2.2

## データベースについて

* develop, test 環境では sqlite3
* production 環境では postgresql

を使ってます（ローカルにpostgresql入れるのが面倒だったので）

## 環境構築

```
bundle install --without production --path vendor/bundle
rake db:create
rake db:migrate
```
