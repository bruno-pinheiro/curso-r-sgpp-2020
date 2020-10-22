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

# Definir ordem de execução dos scripts
names(scripts) <- c(1, 3, 5, 2, 4)
scripts <- scripts[order(names(scripts))]

# Rodar cada um dos scripts
lapply(scripts, function(x){
  source(paste0(getwd(), "/dados/", x))
})
