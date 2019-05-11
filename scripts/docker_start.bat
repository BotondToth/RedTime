docker stop redtime
docker rm redtime
::docker stop redmine_db
::docker rm redmine_db
::docker run -d --name redmine_db -p 6543:5432 -e POSTGRES_PASSWORD=redmine -e POSTGRES_USER=redmine postgres
docker build -t redtime ../.
docker run -p 8080:3000 --name redtime redtime 