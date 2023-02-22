FROM node:current-slim

#SERVER
WORKDIR /server

COPY . /server

RUN npm install
RUN apt-get update
RUN apt-get install -y cmake build-essential
RUN apt-get install pkg-config -y
RUN apt-get install git -y
RUN apt-get install uuid-dev -y 
RUN apt-get install openjdk-11-jre -y

EXPOSE 3000

CMD ["npm", "start"]

ENV PROGRAM_ROOT /server/server/programs

#NFA REGEX
WORKDIR ${PROGRAM_ROOT}/nfa-regex

RUN mkdir build && cd build && cmake .. && make

#B-TREE
WORKDIR ${PROGRAM_ROOT}/B-Tree

RUN mkdir build && cd build && cmake .. && make

#GAZPREA
WORKDIR ${PROGRAM_ROOT}/Gazprea22

RUN mkdir build && cd build && cmake .. && make