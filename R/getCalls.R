getCalls <- function(
  token = NULL,
  user_id = NULL,
  date_from = NULL,
  date_till = NULL,
  fields = NULL){

  fields <- if(is.null(fields)) {list("contact_phone_number",
                                      "id",
                                      "start_time")
  }else {as.list(fields) }

Calls <- content(POST("https://dataapi.uiscom.ru/v2.0",
                          body = toJSON(
                            list(
                              jsonrpc="2.0",
                              id=sample(100000:999999, 1, replace=TRUE),
                              method="get.calls_report",
                              params= list(
                                access_token=token,
                                user_id=userId,
                                date_from = paste(date_from,"00:00:00",sep = " "),
                                date_till = paste(date_till,"00:00:00",sep = " "),
                                fields = fields)
                            )
                          )),"parsed", "application/json")

totalItems <- Calls$result$metadata$total_items
page <- floor(totalItems/1000)
calls <- NULL
for (p in 0:page) {
   Calls <- content(POST("https://dataapi.uiscom.ru/v2.0",
                        body = toJSON(
                          list(
                            jsonrpc="2.0",
                            id=sample(100000:999999, 1, replace=TRUE),
                            method="get.calls_report",
                            params= list(
                              access_token=token,
                              user_id=userId,
                              offset = p*1000,
                              date_from = paste(date_from,"00:00:00",sep = " "),
                              date_till = paste(date_till,"00:00:00",sep = " "),
                              fields = fields)
                          )
                        )),"parsed", "application/json")

  CallsT <- map_df(Calls$result$data, flatten)
  calls <- rbind(calls,CallsT)
    }
return(calls)
}
