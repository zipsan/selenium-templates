# selenium-templates

Webサイトの自動化を行う場合によく使うベースのファイルがこちら

デフォルトでは以下を利用して定期実行します。

* Docker
* Selenium (Chrome)
    - https://github.com/SeleniumHQ/docker-selenium
* Python
* Supercronic (定期実行)
    - https://github.com/aptible/supercronic

# 設定

```
cp ./cron/job.cron.template ./cron/job.cron
vim ./cron/job.cron
~~~ Edit ~~~
```

# 起動

```
docker compose up -d
```

スクリプトの実行
```
docker compose run --rm app python3.9 main.py
```
