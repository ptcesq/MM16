

get_final_season <- function(scores){
    sVector = character()
    pVector = logical()
    for (i in 1:nrow(scores)){
    w_team <- scores[i, 3]
    l_team <- scores[i, 5]
    
    if (w_team < l_team){
      temp <- paste0(w_team, '_', l_team)
      temp1 <- TRUE
    } else {
      temp <- paste0(l_team, '_', w_team)
      temp1 <- FALSE 
    }
    
    sVector <- c(sVector, temp)
    pVector <- c(pVector, temp1)
    
    }
  df <- data.frame(sVector, pVector)
  colnames(df) <- c('id', 'outcome')
  return(df)  
}

