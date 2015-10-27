### Test file to plot ggplot linking to capability database

# Source ListDir.R to use list.dirs function defined
source("Setup.R")

# connect to the server
meta <- InitConn()

# connect to the server
#SetConnAll() 

# Create UI fluid
ui <- UICreate()

# Create Server Plots
server <- ServerCreate()


shinyApp(ui = ui, server = server)