###############################################################################
#                                                                             #
# ESSE SCRIPT EXECUTA OS DEMAIS SCRIPTS PRESENTES NA PASTA \dados DO PROJETO. #
# APÓS A SUA EXECUÇÃO, TODOS OS DADOS NECESSÁRIOS E UTILIZADOS NO curso SERÃO #
# BAIXADOS, PROCESSADOS E ARMAZENADOS PARA USO DOS NOTEBOOKS DO CURSO.        #
#                                                                             #
###############################################################################


# Indentificar arquivos na pasta /dados
arquivos <- list.files(paste0(getwd(), "/dados"))

# Destes arquivos, separar apenas os que terminam com a extensão .R
scripts <- arquivos[grep(".R$", arquivos)]

# Rodar cada um dos scripts
lapply(scripts, function(x){
  source(paste0(getwd(), "/dados/", x))
})
