🛠 Desafio Terraform: Infraestrutura de Duas Camadas (Prod-Ready)
O objetivo: Criar uma VPC resiliente com isolamento total entre a camada web e a camada de dados, usando Terraform.

1. Requisitos de Rede (Networking)
VPC: Crie uma VPC com o CIDR 10.0.0.0/16.

Multi-AZ: Use duas Availability Zones (ex: us-east-1a e us-east-1b).

Subnets:

2 Subnets Públicas (uma em cada AZ).

2 Subnets Privadas (uma em cada AZ).

Conectividade:

Um Internet Gateway para as subnets públicas.

Um NAT Gateway (alocado em uma das subnets públicas) para permitir que as instâncias nas subnets privadas acessem a internet.

Roteamento:

Tabelas de rotas distintas para as subnets públicas e privadas.

Resolução:
VPC => Internet gateway
Public Route table => Internet gateway
Private Route table => Nat Gateway
Public route table association => Public subnet + Public Route table 
Private route table association => Private subnet + Private Route table       
Nat gateway => elastic ip + public subnet + IGW

2. Camada de Segurança (Security Groups)
Não use IPs fixos nas regras. Trabalhe com referências de Security Groups:

SG-Web: Permite entrada na porta 80 (HTTP) de qualquer lugar (0.0.0.0/0).

SG-DB: Permite entrada na porta 5432 (PostgreSQL) apenas se a origem for o SG-Web.

Resolução
Security group WEB => security group ingress rule => security group egress rule
Security group DB => security group ingress rule => referece security group web => security group ingress rule

3. Computação (EC2) - Para testar a rede
Uma instância EC2 na Subnet Pública (com IP público).

Uma instância EC2 na Subnet Privada (sem IP público).

Resolução
EC2 public => ami => instance
EC2 private => ami => instance

🚀 O que você deve praticar no código (O Diferencial):
Para este desafio, tente não escrever tudo em um arquivo main.tf gigante. Use a seguinte estrutura de arquivos:

provider.tf: Configuração do provider AWS.

variables.tf: Definição de variáveis (não deixe CIDRs ou nomes de instâncias fixos no código).

network.tf: Toda a parte de VPC, Subnets, Gateways e Route Tables.

security.tf: Definição dos Security Groups e suas regras.

compute.tf: Definição das instâncias EC2.

outputs.tf: Exiba o IP da instância pública e o ID da VPC ao final do terraform apply.

🏁 Como validar se você venceu o desafio:
Após o terraform apply, faça o seguinte teste:

Acesse a instância Pública via SSH.
```
eval `ssh-agent -s` # captura as informações de configuração e incia o programa do agente 

ssh-add chave.pem 

ssh-add -l  #lista a as chaves-pem configuradas

ssh -A ubuntu@ip.instacia.publica
```

De dentro da instância Pública, tente dar um ping ou acessar via SSH a instância Privada.

```
# acessando a instancia privada:

ssh ubuntu@ip.instancia.privada

# testando a instância privada

ping ip.instancia.privada -c 4 # envia 4 pacotes 

# --- 10.0.3.245 ping statistics ---
# 4 packets transmitted, 0 received, 100% packet loss, time 3080ms
# funciona porque a instância privada não deve receber acesso da internet 
```

Dentro da instância Privada, tente dar um ping google.com.

```
ping google.com -c 4 # envia 4 pacotes
# --- google.com ping statistics ---
# 4 packets transmitted, 4 received, 0% packet loss, time 3005ms
# funciona, porque o nat gatway permite que a instância privada acesse a internet
```

Testando a conexão com a porta 5432

```
# na instancia publica

nc -l 5432 # deixa a instancia escutando na porta

# na instancia publica 

nc -zv ip.instancia.publica 5432 # escaneia a porta sem enviar dados (testar serviço/porta especifica)
# Connection to ip.instancia.privada 5432 port [tcp/postgresql] succeeded!

```


Se o ping funcionar, seu NAT Gateway e suas Route Tables estão corretos.

Se você conseguir conectar do Web para o DB, seu Security Group está correto.

DOCUMENTAÇÃO: https://registry.terraform.io/providers/hashicorp/aws/latest/docs