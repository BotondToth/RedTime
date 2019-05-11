#RedTime

Time visualizier plugin for Redmine.

##Setup

Clone this repository in the plugins folder.
Change the database IP in the database.yml!

###Docker
- Build docker image:
	`docker build -t redtime .`
- Run the image:
	`docker run -p 8080:3000 redtime`
- After these a redmine instance will be available on port 8080