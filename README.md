# README

## Setup

This project is provided with a docker configuration to make it easier to run the project.

### Prerequisites

- Docker
- Docker Compose

### Running the project

To run the project, you can run with docker (Recommended).

```sh
  docker-compose up server
```
This will start the server on port 3000.

Or if you do not want to use docker, you can run the following commands:
The project is using Ruby "3.2.2", so make sure you have it installed.

```sh
  bundle install
  rails db:create db:migrate db:seed
  rails s
```

#### Endpoints

- `GET /api/potatoes/exchange_rate` - Get the exchange rate of potatoes.
- `GET /api/potatoes/best_gains` - Get the best gains of potatoes.

### Running the tests

To run the tests, you can run with docker (Recommended).

```sh
  bundle exec rspec
```

### Troubleshooting

If you have an issue running the project, make sure that you have docker and that the port 3000 and 5432 is not being used by another service.