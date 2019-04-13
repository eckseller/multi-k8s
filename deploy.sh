docker build -t eckseller/multi-client:latest -t eckseller/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t eckseller/multi-server:latest -t eckseller/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t eckseller/multi-worker:latest -t eckseller/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push eckseller/multi-client:latest
docker push eckseller/multi-server:latest
docker push eckseller/multi-worker:latest

docker push eckseller/multi-client:$SHA
docker push eckseller/multi-server:$SHA
docker push eckseller/multi-worker:$SHA

kubectl apply -f ./k8s
kubectl set image deployments/server-deployment server=eckseller/multi-server:$SHA
kubectl set image deployments/client-deployment client=eckseller/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=eckseller/multi-worker:$SHA