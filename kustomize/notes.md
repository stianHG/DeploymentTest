flux check --pre
flux bootstrap github --owner=stianhg --repository=fleet-infra --branch=main --path=./clusters/my-cluster --personal
flux get kustomizations --watch



minikube start
minikube dashboard
minikube stop


kubectl port-forward svc/loadbalancer 5002:80 --address=127.0.0.1
kubectl port-forward svc/loadbalancer 5002:80 --address=192.168.68.123
