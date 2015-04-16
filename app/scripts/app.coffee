'use strict'
angular.module('slick', []).directive 'slick', [
  '$timeout'
  ($timeout) ->
    {
    restrict: 'AEC'
    scope:
      initOnload: '@'
      data: '='
      currentIndex: '='
      accessibility: '@'
      arrows: '@'
      autoplay: '@'
      autoplaySpeed: '='
      centerMode: '@'
      centerPadding: '@'
      cssEase: '@'
      dots: '@'
      draggable: '@'
      easing: '@'
      fade: '@'
      infinite: '@'
      lazyLoad: '@'
      nextArrow: '@'
      onBeforeChange: '&'
      onAfterChange: '&'
      onInit: '&'
      onReInit: '&'
      pauseOnHover: '@'
      prevArrow: '@'
      responsive: '&'
      slide: '@'
      slidesToShow: '@'
      slidesToScroll: '@'
      speed: '@'
      swipe: '@'
      touchMove: '@'
      touchThreshold: '@'
      vertical: '@'
      asNavFor: '@'
      focusOnSelect: '@'
    link: (scope, element, attrs) ->
      initializeSlick = undefined
      isInitialized = undefined
      initializeSlick = undefined
      isInitialized = undefined

      initializeSlick = ->
        $timeout ->
          currentIndex = undefined
          slider = undefined
          currentIndex = undefined
          slider = undefined
          slider = $(element)
          slider.css 'display', 'block'
          loader = $('.slickloader')
          loader.css 'display', 'none'
          if scope.currentIndex != null
            currentIndex = scope.currentIndex
          slider.slick
            accessibility: scope.accessibility != 'false'
            arrows: scope.arrows != 'false'
            autoplay: scope.autoplay == 'true'
            autoplaySpeed: if scope.autoplaySpeed != null then parseInt(scope.autoplaySpeed, 10) else 3000
            centerMode: scope.centerMode == 'true'
            centerPadding: scope.centerPadding or '50px'
            cssEase: scope.cssEase or 'ease'
            dots: scope.dots == 'true'
            draggable: scope.draggable != 'false'
            easing: scope.easing or 'linear'
            fade: scope.fade == 'true'
            infinite: scope.infinite != 'false'
            lazyLoad: scope.lazyLoad or 'ondemand'
            asNavFor: if scope.asNavFor then scope.asNavFor else undefined
            focusOnSelect: scope.focusOnSelect == 'true'
            onBeforeChange: scope.onBeforeChange or null
            onAfterChange: (sl, index) ->
              if scope.onAfterChange
                scope.onAfterChange()
              if currentIndex != null
                return scope.$apply(->
                  currentIndex = index
                  scope.currentIndex = index
                )
              return
            onInit: (sl) ->
              if scope.onInit
                scope.onInit()
              if currentIndex != null
                return sl.slideHandler(currentIndex)
              return
            onReInit: scope.onReInit or null
            pauseOnHover: scope.pauseOnHover != 'false'
            responsive: scope.responsive() or null
            slide: scope.slide or 'div'
            slidesToShow: if scope.slidesToShow != null then parseInt(scope.slidesToShow, 10) else 1
            slidesToScroll: if scope.slidesToScroll != null then parseInt(scope.slidesToScroll, 10) else 1
            prevArrow: if scope.prevArrow != null then scope.prevArrow else '<button type="button" class="slick-prev">Previous</button>'
            nextArrow: if scope.nextArrow != null then scope.nextArrow else '<button type="button" class="slick-next">Next</button>'
            speed: if scope.speed != null then parseInt(scope.speed, 10) else 300
            swipe: scope.swipe != 'false'
            touchMove: scope.touchMove != 'false'
            touchThreshold: if scope.touchThreshold then parseInt(scope.touchThreshold, 10) else 5
            vertical: scope.vertical == 'true'
          scope.$watch 'currentIndex', (newVal, oldVal) ->
            if currentIndex != null and newVal != null and newVal != currentIndex
              return slider.slickGoTo(newVal)
            return

      if scope.initOnload
        isInitialized = false
        scope.$watch 'data', (newVal, oldVal) ->
          if newVal == null
            return false
          if isInitialized
            $(element).slickRemove()
            $(element).removeClass 'slick-initialized slick-slider'
            $(element).find('.slick-list').remove()
          initializeSlick()
          isInitialized = true
      else
        initializeSlick()

    }
]
