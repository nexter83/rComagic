getToken <-
function(login=NULL,
         password= NULL){
  resToken <- content(POST("https://dataapi.uiscom.ru/v2.0",
                         body = toJSON(
                           list(
                             jsonrpc="2.0",
                             id="12233",
                             method="login.user",
                             params= list(
                               login=login,
                               password=password)
                           )
                         )),"parsed", "application/json")
token <- resToken$result$data$access_token
return(token)

}
