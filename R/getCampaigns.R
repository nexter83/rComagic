getCampaigns <- function(
  token = NULL,
  userId = NULL,
  fields = NULL){


fields <- if(is.null(fields)) {list("name","id","status")
  }else {as.list(fields) }



campaigns <- content(POST("https://dataapi.uiscom.ru/v2.0",
                          body = toJSON(
                            list(
                              jsonrpc="2.0",
                              id=sample(100000:999999, 1, replace=TRUE),
                              method="get.campaigns",
                              params = list(
                                access_token=token,
                                user_id=userId,
                                fields = fields)
                            )
                          )),"parsed", "application/json")
totlaItems <- campaigns$result$metadata$total_items
page <- ceiling(totlaItems/1000)
CampaignComagic <- NULL
for (p in 1:page) {
  campaigns <- content(POST("https://dataapi.uiscom.ru/v2.0",
                            body = toJSON(
                              list(
                                jsonrpc="2.0",
                                id=sample(100000:999999, 1, replace=TRUE),
                                method="get.campaigns",
                                params = list(
                                  access_token=token,
                                  user_id=userId,
                                  offset = p,
                                  fields = fields)
                              )
                            )),"parsed", "application/json")
  CampaignComagicT <- do.call(rbind.data.frame,campaigns$result$data)
  CampaignComagic <- rbind(CampaignComagic,CampaignComagicT)
  }
  return(CampaignComagic)
}
