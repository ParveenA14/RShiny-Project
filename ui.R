library("DT")

navbarPage(
  "Control updates with actionButton | Chicago Towing Data",
  tabPanel(
    "Selected state",
    fluidPage(fluidRow(
      column(
        selectInput("selected_state",
                    "Select a state",
                    choices = NULL),
        width = 3
      ),
      column(
        selectInput("selected_state",
                    "Select a state",
                    choices = NULL),
        width = 4
      ),
      column(
        selectInput("selected_servicereqno",
                    "Select an Service Request No",
                    choices = NULL,
                    width = "100%"),
        width = 5
      )
    )),
    plotOutput("towing_data_chart")
  ),
  collapsible = TRUE
)