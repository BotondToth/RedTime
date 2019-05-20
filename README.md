<h1>RedTime</h1>

Time visualizier plugin for Redmine.

<h2>Setup</h2>

Clone this repository in the plugins folder.
Change the database IP in the database.yml!

<h3>Docker</h3>

- Build docker image:

		`docker build -t redtime .`
	
- Run the image:

		`docker run -p 8080:3000 redtime`
	
- After these steps a redmine instance will be available on port 8080
- Or use the .bat scirpt in the scripts folder (that includes a database container as well)!

