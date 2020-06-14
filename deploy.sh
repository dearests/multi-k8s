docker build -t soguazu/multi-client:latest -t soguazu/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t soguazu/multi-server:latest -t soguazu/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t soguazu/multi-worker:latest -t soguazu/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push soguazu/multi-client:latest
docker push soguazu/multi-server:latest
docker push soguazu/multi-worker:latest

docker push soguazu/multi-client:$SHA
docker push soguazu/multi-server:$SHA
docker push soguazu/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=soguazu/multi-client:$SHA
kubectl set image deployments/server-deployment server=soguazu/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=soguazu/multi-worker:$SHA