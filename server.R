library("tidyverse")

towing_data <- read_csv("C:/Users/Pavan/Documents/NEU/SEM1-Winter/ALY6070-Communication & Visualization/Week-3/2011-2018-towing_data_cleaned (1).csv")

states <- towing_data %>%
  filter(name %in% towing_data$`Plate State`)

servicereq_no <- towing_data %>%
  filter(name %in% towing_data$`Service Request No`)

function(input, output, session) {
  
  updateSelectInput(session,
                    "Selected_state",
                    choices = unique(towing_data$`Plate State`))
  
  observeEvent(input$Selected_state,
               {
                 states_in_US <- states %>%
                   filter( Plate State== input$selected_state) %>%
                   pull(name)
                 
                 updateSelectInput(session,
                                   "selected_state",
                                   choices = states)
                 
               })
  
  updateSelectInput(session,
                    "selected_servicereqno",
                    choices = setNames(towing_data$`Plate State`, towing_data$`Service Request No`))
  
  
  output$towing_data_chart <- renderPlot({
    
    selected_serviceregno <- servicereq_no %>%
      filter(servicereq_no == input$selected_servicereqno) %>%
      pull(servicereqno_name)
    
    towing_data %>%
      filter(
        states == input$selected_state
      ) %>%
      filter(servicereq_no == input$selected_servicereqno) %>%
      filter(!is.na(value)) %>%
      ggplot(aes(x = year, y = value)) +
      geom_path() +
      labs(
        title = paste("States in US where Vehicles are Towed between 2011 and 2018", "in", input$selected_state),
        subtitle = "Data source: Chicago Towing Data"
      )
  })
  
}