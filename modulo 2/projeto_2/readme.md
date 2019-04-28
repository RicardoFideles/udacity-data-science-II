### Meta

Sua meta: fazer wrangling dos dados de tweets de WeRateDoga para que você possa criar análises e visualizações interessantes e confiáveis. Sim, WeRateDogs deu à Udacity acesso exclusivo a seu arquivo de tweets, mas ele contém informações muito básicas. Coleta, avaliação e limpeza adicionais são necessárias para análises e visualizações que mereçam uma reação de "Uau!"

### Contexto

Este arquivo contém dados básicos de tweets para os mais de 5000 de seus tweets, mas não tudo. Uma coluna o arquivo contém com certeza: cada texto de tweet, o que eu usei para extrair classificação, nome e "estágio" do cachorro (ou seja, doggo, floofer, pupper e puppo).


#### pontos

Pontos principais
Pontos-chave para ter mente quando ao fazer data wrangling para esse projeto:

Só queremos classificações originais (não retweets) que têm imagens.
Avaliar e limpar totalmente todo o banco de dados requer um esforço excepcional para que apenas um subconjunto de seus problemas (oito problemas de qualidade e dois problemas de arrumação) precisem ser avaliados e limpos.
A limpeza inclui a fusão de acordo com as regras de dados arrumados para facilitar a análise e visualização.
*Curiosidade: criar esta rede neural é um dos projetos do programa Nanodegree de Inteligência Artificial na Udacity.


Coletando dados para esse projeto
Colete cada um dos três pedaços de dados conforme descritos abaixo em um notebook Jupyter intitulado wrangle_act.ipynb:

O arquivo WeRateDogs. Estou dando este arquivo a você, então o imagine como um arquivo já em mãos. Baixe este arquivo manualmente clicando no link a seguir: twitter_archive_enhanced.csv

As previsões de imagens em tweets, isto é, qual raça de cachorro ou objeto inanimado está presente em cada tweet Este arquivo (image_predictions.tsv) está hospedado nos servidores da Udacity e devem ser baixados programaticamente usando a seguinte URL: https://d17h27t6h515a5.cloudfront.net/topher/2017/August/599fd2ad_image-predictions/image-predictions.tsv

A contagem de retweets e favoritos (curtida) de cada tweet, no mínimo, e quaisquer dados adicionais que você achar interessantes. Faça uma consulta na API do Twitter (usando as ID de tweets no arquivo do Twitter de WeRateDogs) para o conjunto de dados completo de cada tweet usando a biblioteca Tweepy do Python e armazene esses dados em um arquivo chamado tweet_json.txt, onde os dados JSON armazenados de cada tweet devem ser escritos em sua própria linha. Então, leia este .txt linha por linha em um dataframe do Pandas com (no mínimo) ID de tweet, contagem de retweets e contagem de favoritos. Obs.: não inclua suas chaves de API do Twitter e tokens de acesso no envio de seu projeto.