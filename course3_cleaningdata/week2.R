library(httr)

oauth_endpoints("github")

myapp <- oauth_app("github",
                   key = "33303c0933fd07b1aad7",
                   secret = "f23d82bf6601dfe350151e4004c5a82b177c7f4a"
)

github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
json1 <- content(req)
json2 <- jsonlite::fromJSON(jsonlite::toJSON(json1))

json2[, c(3, 47)]

html <- readLines("http://biostat.jhsph.edu/~jleek/contact.html")

for(i in c(10, 20, 30, 100)) {
  print(nchar(html[i]))
}

fwf <- read.fwf(
  file=url("http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for"),
  skip=4,
  widths=c(12, 7, 4, 9, 4, 9, 4, 9, 4))

sum(fwf["V4"])

str(fwf)
