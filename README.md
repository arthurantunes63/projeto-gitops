# Projeto demonstração - DevOps com Docker, Github Actions e ArgoCD
Projeto desenvolvido para a reunião de projetos da empresa Datarisk com foco no tema DevOps.
Instruções para iniciar no ArgoCd podem ser encontrados na documentação [Getting Started](https://argo-cd.readthedocs.io/en/stable/getting_started/).

## Cluster Kuberneters
Para a execução do projeto há a necessidade de termos um cluster Kubernetes local ou em um provedor de nuvem.

Para a demonstração um cluster local empregando o minikube pode ser criado, havendo a necessidade do Docker para essa finalidade.

Além do minikube empregamos o kubectl, sendo ferramenta de linha de comando para se comunicarmos com o cluster Kubernetes via API.

### Verificação e inicialização do Minikube
Verificação do status do minikube:
```sh
minikube status
```

Inicialização do minikube:
```sh
minikube start
```

### Atrelando o cluster do minikube ao kubectl 
Definindo o contexto do minikube:
```sh
kubectl config use-context minikube
```

### Utilizando o minikube
Verificando nós do cluster que estão sendo executados:
```sh
kubectl get nodes
```

Criando um namespace para o argocd e instalando-o: 
```sh
kubectl create ns argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

### Expondo o acesso a UI localmente
Empregando Kubectl 'port-forward'
```sh
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

### Recuperando a senha inicial para Login no ArgoCD
```sh
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

### Criação de aplicação via UI ou CLI

### Verificar serviços em execução
```sh
kubectl get svc -n default
```

### Acessando serviço implantando no cluster Kubernetes
Redireciona a porta exposta (80) para a porta local 8081
```sh
kubectl port-forward svc/fastapi-service -n default 8081:80
```

## Execução local da esteira
Projeto [Act](https://github.com/nektos/act)