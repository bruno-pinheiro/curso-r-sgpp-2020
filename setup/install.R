###############################################################################
#                                                                             #
# ESSE SCRIPT INSTALAR OS PACOTES QUE SÃO DEPENDÊNCIAS DO CURSO (USADOS       #
# DURANTE A ATIVIDADE. PODE SER QUE O SEU COMPUTADOR NECESSITE INSTALAR UM    #
# OUTRO PROGRAMA PARA QUE OS PACOTES POSSAM SER INSTALADOS.                   # 
#                                                                             #
###############################################################################

# Instalar pacotes
dependencies <- c("tidyverse", "sf", "fontawesome", "xaringan", "xanringanthemer", "showtext")
lapply(dependencies, install.packages)
