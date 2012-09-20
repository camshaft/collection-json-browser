
services = angular.module "collection-browser.services", []

services.factory "request", [
  "$http"
  "proxy"
  "content-type"

  ($http, proxy, contentType)->
    get: (uri, headers, useProxy)->
      headers['content-type'] = contentType
      if useProxy
        uri = "#{proxy}?uri=#{encodeURIComponent(uri)}"
      
      $http.get uri, headers

    post: (uri, data, headers, useProxy)->
      headers['content-type'] = contentType
      if useProxy
        uri = "#{proxy}?uri=#{encodeURIComponent(uri)}"

      $http.post uri, data, headers

    put: (uri, headers, useProxy)->
      headers['content-type'] = contentType
      if useProxy
        uri = "#{proxy}?uri=#{encodeURIComponent(uri)}"

      $http.put uri, headers

    "delete": (uri, headers, useProxy)->
      headers['content-type'] = contentType
      if useProxy
        uri = "#{proxy}?uri=#{encodeURIComponent(uri)}"

      $http.delete uri, headers

]

services.value "content-type", "application/collection+json"

services.factory "proxy", [
  "$location"

  ($location)->
    "#{$location.protocol()}://#{$location.host()}:#{$location.port()}/proxy"
]
