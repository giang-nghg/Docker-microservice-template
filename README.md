# Docker microservice sample

## Requirements:
- Docker

(all commands below are supposed to run on the Docker host)

## Setup:
```
bash init-swarm.sh # Init a swarm, you can supply DB_MASTER_PASSWORD, READER_PASSWORD, WRITER_PASSWORD environment variables if you like

bash rebuild-image.sh db # Build Docker image for database service

bash rebuild-image.sh watermark # Build Docker image for watermark service

bash deploy.sh # Deploy the stack

sudo docker service ls # List the services, once all 3 services: 'db', 'msg_broker' and 'watermark' is ready (their REPLICATES is all 1/1), you are ready to test
```

## Test
Use a REST client such as Postman, make the following request to the machine you are running the stack on:
### Create a watermark:
* **Request**:
    * *Method*: POST
    * *Endpoint*: /watermark/
    * *Body*:
      * content: 'book' or 'journal'
      * author: 'author'
      * title: 'title'
      * topic: '' if content is 'journal', or any topic if 'book'. If content is 'journal' and topic is not '' then the server will throw a Bad Request indicating the error
* **Response**:
    * *ticket_id*: The ticket ID for polling status and retrieve the watermark

### Polling status of ticket:
* **Request**:
    * *Method*: GET
    * *Endpoint*: /ticket/<id>
* **Response**:
    * If the ticket status if it is not finished, response contain its status
    * If the ticket is finished, the watermark's data & permanent id is returned (this ID can later be used to retrieve watermark, once the ticket is destroyed)

### Get watermark:
* **Request**:
    * *Method:* GET
    * *Endpoint:* /watermark/<id>
* **Response:** The watermark's data

## Unit test suite:
Inside watermark/tests/. To run, on the Docker host, cd to <project root>/watermark/ and run:
```
python manage.py test
```

## Implementation details:
- **watermark**: The watermark service, implemented as a Django app, running together with a Celery task queue server in a container. They could be separated into 2 containers, but I think for this use case, they are related enough to be grouped together. It's also more convenient for development since in the Celery task we must use the Django's models.
- **db**: The database to permanently save watermarks, implemented as a PostgreSQL container.
- **msg_broker**: The message broker backend for Celery task queue, implemented as a RabbitMQ container.

## Further improvements:
- Separate Django and Celery without losing convenience for development
- More secure setup for RabbitMQ
- Ensure these services scale up (multiple containers for each service)

## Cleanup:
```
bash rm-stack.sh
bash leave-swarm.sh
```
