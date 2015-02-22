shinyUI(pageWithSidebar(
    headerPanel("NFL ranking on offensive/defensive yards per game"),
    
    
    sidebarPanel(
        h4('please choose year and offense/defense for chart'),
        numericInput('year', 'Year',value = 2014, min = 2001, max = 2014,),
        radioButtons("unit", "Select unit:",
                     c("Offense" = "Offense",
                       "Defense" = "Defense")),
        submitButton('Submit')
        
    ),
    mainPanel(
        plotOutput('newplot'),
        h4( 'data from http://sports.yahoo.com/nfl/stats')
    )
))