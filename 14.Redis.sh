#윈도우에서는 redis가 직접설치가 안됨 -> 도커를 통한 resis 설치
docker run --name my-redis container -d -p 6379:6379

#redis 접속 명령어
redis -cli

#docker에 설치된 redis 접속명령어
docker exec -it 컨테이너ID redis-cli

#redis는 0~15번까지의 db로 구성(default 0번)
select db번호

#db내 모든 키값 조회
keys *

#String 자료구조
#set key:value 형식으로 값 세팅 
set user:email:1 hong1@naver.com
set user:email:2 hong2@naver.com
#이미 존재하는 key를 set하면 덮어쓰기 
#키값이 이미 존재하면 pass시키고 없을때만 set하기 위해서는 nx옵션 사용
set user:email:1 hong@naver.com nx

#만료시간(TTL) 설정은 ex옵션 사용(초단위)
set user email:2 hong2@naver.com ex 30
#get key를 통해 value값 구함 
get user:email:1

#특정 key값 삭제
del 키값
del user:email:2

#현재 DB내 모든 key값 삭제
flushdb
#활용
-좋아요 기능 구현
-재고 처리(동시성 이휴 해결)
-캐싱처리(JSON형식의 데이터를 value값으로 많이 사용)
-로그인 구현시 토큰 저장 목적 


#list 자료구조


#set 자료구조

#zset 자료구조

#hashse 자료구조 