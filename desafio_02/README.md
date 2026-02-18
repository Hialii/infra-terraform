🚀 Desafio: O Coletor de Lixo Automatizado (S3)
O objetivo é criar uma infraestrutura que armazena arquivos temporários e um script que limpa esses arquivos para economizar custos.

Parte 1: O Arquiteto (Terraform)
Sua missão é provisionar a estrutura base de forma replicável.

Crie um arquivo main.tf.

Provisione 2 Buckets S3:

bucket-producao-dados-[seu-nome]

bucket-temporario-logs-[seu-nome]

Configure o Terraform para que o bucket de logs tenha uma Tag: Ambiente = Temporario.

Extra: Use uma variável para definir a região da AWS.

Parte 2: O Operário (Python + Boto3)
Agora, você vai criar um script de automação que não poderia ser feito facilmente só com Terraform.

Crie um script limpeza_s3.py.

O script deve:

Listar todos os buckets da sua conta.

Identificar apenas o bucket que possui a Tag Ambiente = Temporario.

Deletar todos os arquivos dentro desse bucket específico que foram criados há mais de 24 horas.

Imprimir no terminal o nome dos arquivos deletados.

🛠️ O que você vai exercitar:
Terraform: Uso de Tags, gerenciamento de estado e terraform destroy ao final.

Boto3: Filtros de coleções, manipulação de objetos e lógica de data/hora com a biblioteca datetime.

Diferenciação: Você perceberá que o Terraform é ótimo para criar os buckets, mas o Boto3 é necessário para "olhar" dentro deles e tomar decisões baseadas em lógica de tempo.

Critérios de Sucesso (Checklist)
[ ] Conseguiu subir os buckets com terraform apply sem erros.

[ ] O script Python consegue diferenciar os dois buckets apenas pelas Tags (sem "chumbar" o nome do bucket no código).

[ ] O script deleta apenas os arquivos velhos e mantém os novos.

[ ] Você destruiu tudo com terraform destroy para não gerar custos desnecessários.

Dica para o LinkedIn: Quando terminar, tire um print do seu código Terraform e um print do log do Python deletando os arquivos. Isso mostra que você domina IaC e Automação ao mesmo tempo.