

# trey-visay-api
[![Code Climate](https://codeclimate.com/github/ilabsea/trey-visay-api.png)](https://codeclimate.com/github/ilabsea/trey-visay-api)

The trey-visay-api is a Trey-visay web application and backend API for [treyvisay_mobile](https://github.com/ilabsea/trey-visay) Application.

## Development Setup
### System dependencies
trey-visay-api is a standard Rails application, and it also needs the following services to run:
-   Programing language: ruby 3.1.2
-   Framework: Rails 6
-   Database: Mysql:5.7, Redis:7.0.11
-   Background Job: Sidekiq:7.1.3
-   DevOps: Docker and docker-compose
-   Oauth Provider: Gem [doorkeeper](https://github.com/doorkeeper-gem/doorkeeper)

### Configuration
In ```.env``` file: copy content in ```.env.example``` to the file

1. To enable feature **Sign in with Google**:
-   Go to '[https://console.developers.google.com](https://console.developers.google.com/)'
-   Select your project.
-   Go to the "OAuth consent screen" tab on top, and provide an 'EMAIL ADDRESS' and a 'PRODUCT NAME'
-   Go to Credentials, then "+ Create Credential" and choose "OAuth Client ID"
  - Application type: "**Web application**"
  - Authorized **redirect URIs**:
    [https://web_app_domain/auth/google_oauth2/callback](http://localhost:3000/auth/google_oauth2/callback)

Replace with your own Client ID and Client Secret

```
GOOGLE_CLIENT_ID=client_id
GOOGLE_CLIENT_SECRET=client_secret
```
2. To enable the feature **Sentry logger**:
Signup with [sentry.io](https://sentry.io/) to get SENTRY_DSN and replace the URL
```
SENTRY_DSN=url
```

## Installation
- Install [Docker](https://docs.docker.com/get-docker/)
- install [Docker Compose](https://docs.docker.com/compose/install/)

## Docker development
```docker-compose.yml``` file builds a development environment mounting the current folder and running rails in a development environment.

You can just run the following commands to have a stable development environment.
```
$ docker-compose run --rm web bundle install
$ docker-compose run --rm web bundle exec rake db:dev
$ docker-compose up
```
Then visit [localhost:3000](http://localhost:3000)

### To set up and run the test, run
```
$ docker-compose run --rm web bundle exec rspec
```

### To run lint
```
$ docker-compose run --rm web rubocop .
```

### To run annotate
```
$ docker-compose run --rm web annotate --models
```

## Trey Visay API as OAuth provider
It is for the auto sign-in dashboard application here assume we use Grafana
- Go to the URL [https://web_app_domain/oauth/applications](http://localhost:3000/oauth/applications)
- Click on the button **“New Application”**
- Fill in the **name**
- Fill in the **Redirect Url**: [https://dashboard-domain/login/generic_oauth](https://localhost:8000/login/generic_oauth)
 - **Untick** the Confidential
 - Insert **read** to Scopes
 - Click on the button **“Submit”**

**In Dashboard project**
 - Copy and pass to dashboard project's `docker-compose.yml`
    - UID as GF_AUTH_GENERIC_OAUTH_CLIENT_ID
    - Secret as GF_AUTH_GENERIC_OAUTH_CLIENT_SECRET
- And update
  - GF_AUTH_GENERIC_OAUTH_AUTH_URL = https://web_app_domain/oauth/authorize
  - GF_AUTH_GENERIC_OAUTH_TOKEN_URL = https://web_app_domain/oauth/token
  - GF_AUTH_GENERIC_OAUTH_API_URL = https://web_app_domain/oauth/token/info

## Dump and restore db
### Dump db
    docker exec trey-visay-api_db_1 /usr/bin/mysqldump -u treyvisay --password=PWD trey-visay-api_production > trey_visay_production_`date +%Y%m%d"_"%H_%M_%S`.sql

### Restore db
    cat trey_visay_production_xxxx_xxxx.sql | docker exec -i trey-visay-api_db_1 /usr/bin/mysql -u root —password=PWD trey-visay-api_production
