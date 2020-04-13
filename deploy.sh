docker build -t didoogan/multi-client:latest -t didoogan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t didoogan/multi-worker:latest -t didoogan/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker build -t didoogan/multi-server:latest -t didoogan/multi-server:$SHA -f ./server/Dockerfile ./server

docker push didoogan/multi-client:latest
docker push didoogan/multi-worker:latest
docker push didoogan/multi-server:latest
docker push didoogan/multi-client:$SHA
docker push didoogan/multi-worker:$SHA
docker push didoogan/multi-server:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=didoogan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=didoogan/multi-worker:$SHA
kubectl set image deployments/server-deployment server=didoogan/multi-server:$SHA