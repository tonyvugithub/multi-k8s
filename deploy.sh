docker build -t tonyvu1991/multi-client:latest -t tonyvu1991/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tonyvu1991/multi-api:latest -t tonyvu1991/multi-api:$SHA -f ./api/Dockerfile ./api
docker build -t tonyvu1991/multi-worker:latest -t tonyvu1991/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tonyvu1991/multi-client:latest
docker push tonyvu1991/multi-api:latest
docker push tonyvu1991/multi-worker:latest

docker push tonyvu1991/multi-client:$SHA
docker push tonyvu1991/multi-api:$SHA
docker push tonyvu1991/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tonyvu1991/multi-api:$SHA
kubectl set image deployments/client-deployment client=tonyvu1991/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tonyvu1991/multi-worker:$SHA