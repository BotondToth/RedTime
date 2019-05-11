FROM redmine
LABEL maintainer=toth.botond@stud.u-szeged.hu
LABEL author=Redtime_csapat
COPY database.yml ./config
COPY . ./plugins/redtime