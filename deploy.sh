docker build -t paesbru/multi-client:latest -t paesbru/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t paesbru/multi-server:latest -t paesbru/multi-server:$SHA -f ./server/Dockerfile ./server 
docker build -t paesbru/multi-worker:latest -t paesbru/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push paesbru/multi-client:latest
docker push paesbru/multi-server:latest
docker push paesbru/multi-worker:latest

docker push paesbru/multi-client:$SHA
docker push paesbru/multi-server:$SHA
docker push paesbru/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=paesbru/multi-server:$SHA 
kubectl set image deployments/client-deployment client=paesbru/multi-client:$SHA 
kubectl set image deployments/worker-deployment worker=paesbru/multi-workert:$SHA 