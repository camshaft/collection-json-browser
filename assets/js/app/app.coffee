deps = [
  "collection-browser.controllers"
  "collection-browser.directives"
  "collection-browser.filters"
  "collection-browser.services"
]

app = angular.module("collection-browser", deps)

app.config [
  "$locationProvider"

  ($locationProvider) ->
    $locationProvider.html5Mode true
]
