## Steps

### Prequisites

You need to install:
- eksctl (https://eksctl.io/)
- kubectl (https://kubernetes.io/docs/tasks/tools/#kubectl)
- awscli (https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- helm (https://helm.sh/docs/intro/install/)

You need to configure awscli with your own access key and secret key (https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html)

### Create EKS cluster

Run command

```
eksctl create cluster --name test-cluster --region us-east-1
```

Wait for the command to complete
After eksctl finished creating cluster, verify the cluster on UI console or using command:

```
kubectl get nodes
```

### Deploy containers

Run

```
kubectl apply -f nginx.yaml
kubectl apply -f nginx-whoami.yaml
```

Verify pods in running state

```
kubectl get pod
```

### Deploy Nginx Ingress Controller

Run

```
helm -n ingress-nginx install ingress-nginx  ingress-nginx/ingress-nginx --create-namespace
```

Verify Nginx pod running

```
kubectl get pod -n ingress-nginx
```

Verify Load Balancer created by controller

```
kubectl get svc -n ingress-nginx
```

Output should look like

```
$ kubectl get svc -n ingress-nginx                                                                                                                                         

NAME                                 TYPE           CLUSTER-IP       EXTERNAL-IP                                                              PORT(S)                      AGE
ingress-nginx-controller             LoadBalancer   10.100.20.221    a6f752d8ef7a94ddfbb0c7123619a4ce-300370210.us-east-1.elb.amazonaws.com   80:30649/TCP,443:32755/TCP   8h
ingress-nginx-controller-admission   ClusterIP      10.100.100.107   <none>                                                                   443/TCP                      8h
```

The load balancer is domain in `EXTERNAL-IP`

### Deploy Ingress objects

Run

```
kubectl apply -f ingress.yaml
```

Verify ingress by accessing above load balancer dns.

Accessing to http://a6f752d8ef7a94ddfbb0c7123619a4ce-300370210.us-east-1.elb.amazonaws.com/ should return "Nginx Main" - which is the index file of first Nginx container

Acccessing to http://a6f752d8ef7a94ddfbb0c7123619a4ce-300370210.us-east-1.elb.amazonaws.com/whoami/ should return "Nginx WhoAmI" - which is the index file of whoami container

