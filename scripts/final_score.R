

get_final <- function(scores){
    sVector = character()
    pVector = integer()
    for (i in 1:nrow(scores)){
    w_team <- scores[i, 3]
    l_team <- scores[i, 5]
    
    if (w_team < l_team){
      temp <- paste0('2016', '_', w_team, '_', l_team)
      temp1 <- 1
    } else {
      temp <- paste0('2016', '_', l_team, '_', w_team)
      temp1 <- 0 
    }
    
    sVector <- c(sVector, temp)
    pVector <- c(pVector, temp1)
    
    }
  df <- data.frame(sVector, pVector)
  colnames(df) <- c('id', 'pred')
  return(df)  
}

