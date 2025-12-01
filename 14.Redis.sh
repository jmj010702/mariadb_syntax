#윈도우에서는 redis가 직접설치가 안됨 -> 도커를 통한 resis 설치
docker run --name my-redis container -d -p 6379:6379

#redis 접속 명령어
redis -cli

#docker에 설치된 redis 접속명령어
docker exec -it 컨테이너ID redis-cli
