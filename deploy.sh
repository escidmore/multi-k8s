docker build -t escidmore/multi-client:latest -t escidmore/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t escidmore/multi-server:latest -t escidmore/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t escidmore/multi-worker:latest -t escidmore/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push escidmore/multi-client:latest
docker push escidmore/multi-server:latest
docker push escidmore/multi-worker:latest
docker push escidmore/multi-client:$SHA
docker push escidmore/multi-server:$SHA
docker push escidmore/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=escidmore/multi-client:$SHA
kubectl set image deployments/server-deployment server=escidmore/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=escidmore/multi-worker:$SHA