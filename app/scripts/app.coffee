"use strict"
angular.module("slick", []).directive "slick", [
  "$timeout"
  ($timeout) ->
    return (
      restrict: "AEC"
      scope:
        initOnload: "@"
        data: "="
        currentIndex: "="
        accessibility: "@"
        arrows: "@"
        autoplay: "@"
        autoplaySpeed: "="
        centerMode: "@"
        centerPadding: "@"
        cssEase: "@"
        dots: "@"
        draggable: "@"
        easing: "@"
        fade: "@"
        infinite: "@"
        lazyLoad: "@"
        nextArrow: "@"
        onBeforeChange: "&"
        onAfterChange: "&"
        onInit: "&"
        onReInit: "&"
        pauseOnHover: "@"
        prevArrow: "@"
        responsive: "&"
        slide: "@"
        slidesToShow: "@"
        slidesToScroll: "@"
        speed: "@"
        swipe: "@"
        touchMove: "@"
        touchThreshold: "@"
        vertical: "@"
        asNavFor: "@"
        focusOnSelect: "@"

      link: (scope, element, attrs) ->
        initializeSlick = undefined
        isInitialized = undefined
        initializeSlick = ->
          $timeout ->
            currentIndex = undefined
            slider = undefined
            slider = $(element)
            currentIndex = scope.currentIndex  if scope.currentIndex?
            slider.slick
              accessibility: scope.accessibility isnt "false"
              arrows: scope.arrows isnt "false"
              autoplay: scope.autoplay is "true"
              autoplaySpeed: (if scope.autoplaySpeed? then parseInt(scope.autoplaySpeed, 10) else 3000)
              centerMode: scope.centerMode is "true"
              centerPadding: scope.centerPadding or "50px"
              cssEase: scope.cssEase or "ease"
              dots: scope.dots is "true"
              draggable: scope.draggable isnt "false"
              easing: scope.easing or "linear"
              fade: scope.fade is "true"
              infinite: scope.infinite isnt "false"
              lazyLoad: scope.lazyLoad or "ondemand"
              asNavFor: (if scope.asNavFor then scope.asNavFor else undefined)
              focusOnSelect: scope.focusOnSelect is "true"
              onBeforeChange: scope.onBeforeChange or null
              onAfterChange: (sl, index) ->
                scope.onAfterChange()  if scope.onAfterChange
                if currentIndex?
                  scope.$apply ->
                    currentIndex = index
                    scope.currentIndex = index


              onInit: (sl) ->
                scope.onInit()  if scope.onInit
                sl.slideHandler currentIndex  if currentIndex?

              onReInit: scope.onReInit or null
              pauseOnHover: scope.pauseOnHover isnt "false"
              responsive: scope.responsive() or null
              slide: scope.slide or "div"
              slidesToShow: (if scope.slidesToShow? then parseInt(scope.slidesToShow, 10) else 1)
              slidesToScroll: (if scope.slidesToScroll? then parseInt(scope.slidesToScroll, 10) else 1)
              prevArrow: (if scope.prevArrow? then scope.prevArrow else "<button type=\"button\" class=\"slick-prev\">Previous</button>")
              nextArrow: (if scope.nextArrow? then scope.nextArrow else "<button type=\"button\" class=\"slick-next\">Next</button>")
              speed: (if scope.speed? then parseInt(scope.speed, 10) else 300)
              swipe: scope.swipe isnt "false"
              touchMove: scope.touchMove isnt "false"
              touchThreshold: (if scope.touchThreshold then parseInt(scope.touchThreshold, 10) else 5)
              vertical: scope.vertical is "true"

            scope.$watch "currentIndex", (newVal, oldVal) ->
              slider.slickGoTo newVal  if currentIndex? and newVal? and newVal isnt currentIndex



        if scope.initOnload
          isInitialized = false
          scope.$watch "data", (newVal, oldVal) ->
            return false  unless newVal?
            if isInitialized
              $(element).slickRemove()
              $(element).removeClass "slick-initialized slick-slider"
              $(element).find(".slick-list").remove()
            initializeSlick()
            isInitialized = true

        else
          initializeSlick()
    )
]