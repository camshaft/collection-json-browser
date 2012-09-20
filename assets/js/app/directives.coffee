
directives = angular.module 'collection-browser.directives', []

directives.directive 'prettify', [
  () ->
    link: (scope, elem, attrs, ctrl)->
      prettyPrint()
]
