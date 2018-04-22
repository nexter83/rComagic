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

tagComagic <- do.call(rbind.data.frame, tags$result$data)
return(tagComagic)
}
