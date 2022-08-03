# Groovy

## Run groovysh

`docker run -it --rm groovy`

## Run a groovy script

`docker run --rm -v "$PWD":/home/groovy/scripts -w /home/groovy/scripts groovy groovy <script> <script-args>`