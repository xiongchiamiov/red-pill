#!/bin/bash

zip -r ./${PWD##*/}.love *
cat `which love` "./red-pill.love" > ./red-pill && chmod +x ./red-pill

