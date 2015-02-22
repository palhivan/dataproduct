library(XML)
library(ggplot2)
shinyServer(
    function(input, output) {
                
        
        offen <- reactive( getData(input$year,input$unit))
    
  #      offense<- reactive({
  #          if (!offen$adjust) return(offen())
  #         adjust(offen())
  #    })
            
        
        output$newplot <- renderPlot({
            data<-offen()
            ggplot(data,aes(x=Team, y=Pts.G)) + geom_bar(stat='identity',color="black", fill='red') +
                coord_flip() +labs(y="Yards per Game") + ggtitle("Yards per game")
            
        })
            
    }
)
getdata<- function(year) {
    
    urloff <- paste("http://sports.yahoo.com/nfl/stats/byteam?group=Offense&cat=Total&conference=NFL&year=
             season_", year,"&sort=530&old_category=Total&old_group=Offense")
    offense <- readHTMLTable(urloff, encoding ="UTF-8", colClasses="character")[[7]]
    
    offense<- offense[,-c(2,4,6,8,10,12,14,16,18,20,22,24,26,28)]
    
    offense[,1]<- as.character(offense[,1])
    
    offense[,2:13] <- apply(offense[2:13],2,as.numeric)
    offense<-transform(offense, Team=reorder(Team,offense$Pts/G))
    offense
    
    
}
getData<- function(year, unit) {
    
    
    
    if(unit == 'Offense'){
        
        urloff <- paste("http://sports.yahoo.com/nfl/stats/byteam?group=Offense&cat=Total&conference=NFL&year=
                        season_", year,"&sort=530&old_category=Total&old_group=Offense")
        
        offense <- readHTMLTable(urloff, encoding ="UTF-8", colClasses="character")[[7]]
        
        
        offense<- offense[,-c(2,4,6,8,10,12,14,16,18,20,22,24,26,28)]
        
        offense[,1]<- as.character(offense[,1])
        
        offense[,2:13] <- apply(offense[2:13],2,as.numeric)
        
        offense<-transform(offense, Team=reorder(Team,offense$Pts/G))
        offense
    }
    else{
        urldef <-paste("http://sports.yahoo.com/nfl/stats/byteam?group=Defense&cat=Total&conference=NFL&year=
                       season_", year,"&sort=530&old_category=Total&old_group=Defense")
        
        
        defense <- readHTMLTable(urldef, encoding ="UTF-8", colClasses="character")[[7]]
        
        defense<- defense[,-c(2,4,6,8,10,12,14,16,18,20,22,24,26)]
        
        defense[,1]<- as.character(defense[,1])
        
        defense[,2:13] <- apply(defense[2:13],2,as.numeric)
        defense<-transform(defense, Team=reorder(Team,-defense$Pts/G))
        defense
    }
}