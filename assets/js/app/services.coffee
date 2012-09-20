
services = angular.module "collection-browser.services", []

services.factory "request", [
  "$http"
  "proxy"
  "content-type"

  ($http, proxy, contentType)->
    get: (uri, headers)->
      headers['content-type'] = contentType
      $http.get "#{proxy}?uri=#{encodeURIComponent(uri)}", headers

    post: (uri, data, headers)->
      headers['content-type'] = contentType
      $http.post "#{proxy}?uri=#{encodeURIComponent(uri)}", data, headers

    put: (uri, headers)->
      headers['content-type'] = contentType
      $http.put "#{proxy}?uri=#{encodeURIComponent(uri)}", headers

    "delete": (uri, headers)->
      headers['content-type'] = contentType
      $http.delete "#{proxy}?uri=#{encodeURIComponent(uri)}", headers

]

services.value "content-type", "application/collection+json"

services.factory "proxy", [
  "$location"

  ($location)->
    "#{$location.protocol()}://#{$location.host()}:#{$location.port()}/proxy"
]
