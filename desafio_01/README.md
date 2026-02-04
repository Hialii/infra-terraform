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

2. Camada de Segurança (Security Groups)
Não use IPs fixos nas regras. Trabalhe com referências de Security Groups:

SG-Web: Permite entrada na porta 80 (HTTP) de qualquer lugar (0.0.0.0/0).

SG-DB: Permite entrada na porta 5432 (PostgreSQL) apenas se a origem for o SG-Web.

3. Computação (EC2) - Para testar a rede
Uma instância EC2 na Subnet Pública (com IP público).

Uma instância EC2 na Subnet Privada (sem IP público).

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

De dentro da instância Pública, tente dar um ping ou acessar via SSH a instância Privada.

Dentro da instância Privada, tente dar um ping google.com.

Se o ping funcionar, seu NAT Gateway e suas Route Tables estão corretos.

Se você conseguir conectar do Web para o DB, seu Security Group está correto.

DOCUMENTAÇÃO: https://registry.terraform.io/providers/hashicorp/aws/latest/docs