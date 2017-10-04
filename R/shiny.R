# http://shiny.rstudio.com

require(shiny)
require(caret)

model <- readRDS(file = 'data/model.RDS')

ui <- fluidPage(
    titlePanel("V/S Care Classification"
    ),
    
    sidebarLayout(
        sidebarPanel(
            sliderInput('mpg',
                         'Miles Per Gallon:',
                         min = 5,
                         max = 50,
                         value = 20),
            selectInput('cyl',
                        'Cylinders:',
                        c('Four' = 4, 'Six' = 6, 'Eight' = 8)),
            sliderInput('hp',
                        'Horsepower:',
                        min = 50,
                        max = 400,
                        value = 150),
            sliderInput('wt',
                        'Weight:',
                        min = 1.5,
                        max = 6.0,
                        value = 3.3)
        ),
    
        mainPanel(
            plotOutput("distPlot")
        )
    )
)

server <- function(input, output) {
    output$distPlot <- renderPlot({
        df <- data.frame(mpg = input$mpg, cyl = as.numeric(input$cyl), 
                         hp = input$hp, wt = input$wt)
        
        y_pred <- predict(model, newdata = df, type = 'prob')
        
        barplot(as.numeric(y_pred[1,]), names = names(y_pred),
                col = 'darkgray', border = 'white')
        
    })
}

shinyApp(ui = ui, server = server)