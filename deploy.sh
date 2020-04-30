docker build -t cgjonesdev/multi-client:latest -t cgjonesdev/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cgjonesdev/multi-server:latest -t cgjonesdev/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t cgjonesdev/multi-worker:latest -t cgjonesdev/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push cgjonesdev/multi-client:latest
docker push cgjonesdev/multi-server:latest
docker push cgjonesdev/multi-worker:latest
docker push cgjonesdev/multi-client:$SHA
docker push cgjonesdev/multi-server:$SHA
docker push cgjonesdev/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=cgjonesdev/multi-client:$SHA
kubectl set image deployments/server-deployment server=cgjonesdev/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=cgjonesdev/multi-worker:$SHA
