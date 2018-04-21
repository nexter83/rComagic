getTags <-
  function(token = NULL,userId = NULL){
  tags <- content(POST("https://dataapi.uiscom.ru/v2.0",
                     body = toJSON(
                       list(
                         jsonrpc="2.0",
                         id=sample(100000:999999, 1, replace=TRUE),
                         method="get.tags",
                         params= list(
                           access_token=token,
                           user_id=userId)
                       )
                     )),"parsed", "application/json")

tagComagic <- data.frame(id = map_chr(tags$result$data,"id"),
                         tagName = map_chr(tags$result$data,"name"),
                         stringsAsFactors = F)
return(tagComagic)
}
