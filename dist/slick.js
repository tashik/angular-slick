'use strict';
angular.module('slick', []).directive('slick', [
  '$timeout',
  function ($timeout) {
    return {
      restrict: 'AEC',
      scope: {
        initOnload: '@',
        data: '=',
        currentIndex: '=',
        accessibility: '@',
        arrows: '@',
        autoplay: '@',
        autoplaySpeed: '=',
        centerMode: '@',
        centerPadding: '@',
        cssEase: '@',
        dots: '@',
        draggable: '@',
        easing: '@',
        fade: '@',
        infinite: '@',
        lazyLoad: '@',
        nextArrow: '@',
        onBeforeChange: '&',
        onAfterChange: '&',
        onInit: '&',
        onReInit: '&',
        pauseOnHover: '@',
        prevArrow: '@',
        responsive: '&',
        slide: '@',
        slidesToShow: '@',
        slidesToScroll: '@',
        speed: '@',
        swipe: '@',
        touchMove: '@',
        touchThreshold: '@',
        vertical: '@',
        asNavFor: '@',
        focusOnSelect: '@'
      },
      link: function (scope, element, attrs) {
        var initializeSlick, isInitialized;
        initializeSlick = void 0;
        isInitialized = void 0;
        initializeSlick = function () {
          return $timeout(function () {
            var currentIndex, loader, slider;
            currentIndex = void 0;
            slider = void 0;
            slider = $(element);
            slider.css('display', 'block');
            loader = $('.slickloader');
            loader.css('display', 'none');
            if (scope.currentIndex != null) {
              currentIndex = scope.currentIndex;
            }
            slider.slick({
              accessibility: scope.accessibility !== 'false',
              arrows: scope.arrows !== 'false',
              autoplay: scope.autoplay === 'true',
              autoplaySpeed: scope.autoplaySpeed != null ? parseInt(scope.autoplaySpeed, 10) : 3000,
              centerMode: scope.centerMode === 'true',
              centerPadding: scope.centerPadding || '50px',
              cssEase: scope.cssEase || 'ease',
              dots: scope.dots === 'true',
              draggable: scope.draggable !== 'false',
              easing: scope.easing || 'linear',
              fade: scope.fade === 'true',
              infinite: scope.infinite !== 'false',
              lazyLoad: scope.lazyLoad || 'ondemand',
              asNavFor: scope.asNavFor ? scope.asNavFor : void 0,
              focusOnSelect: scope.focusOnSelect === 'true',
              onBeforeChange: scope.onBeforeChange || null,
              onAfterChange: function (sl, index) {
                if (scope.onAfterChange) {
                  scope.onAfterChange();
                }
                if (currentIndex != null) {
                  return scope.$apply(function () {
                    currentIndex = index;
                    return scope.currentIndex = index;
                  });
                }
              },
              onInit: function (sl) {
                if (scope.onInit) {
                  scope.onInit();
                }
                if (currentIndex != null) {
                  return sl.slideHandler(currentIndex);
                }
              },
              onReInit: scope.onReInit || null,
              pauseOnHover: scope.pauseOnHover !== 'false',
              responsive: scope.responsive() || null,
              slide: scope.slide || 'div',
              slidesToShow: scope.slidesToShow != null ? parseInt(scope.slidesToShow, 10) : 1,
              slidesToScroll: scope.slidesToScroll != null ? parseInt(scope.slidesToScroll, 10) : 1,
              prevArrow: scope.prevArrow != null ? scope.prevArrow : '<button type="button" class="slick-prev">Previous</button>',
              nextArrow: scope.nextArrow != null ? scope.nextArrow : '<button type="button" class="slick-next">Next</button>',
              speed: scope.speed != null ? parseInt(scope.speed, 10) : 300,
              swipe: scope.swipe !== 'false',
              touchMove: scope.touchMove !== 'false',
              touchThreshold: scope.touchThreshold ? parseInt(scope.touchThreshold, 10) : 5,
              vertical: scope.vertical === 'true'
            });
            return scope.$watch('currentIndex', function (newVal, oldVal) {
              if (currentIndex != null && newVal != null && newVal !== currentIndex) {
                return slider.slickGoTo(newVal);
              }
            });
          });
        };
        if (scope.initOnload) {
          isInitialized = false;
          return scope.$watch('data', function (newVal, oldVal) {
            if (newVal == null) {
              return false;
            }
            if (isInitialized) {
              $(element).slickRemove();
              $(element).removeClass('slick-initialized slick-slider');
              $(element).find('.slick-list').remove();
            }
            initializeSlick();
            return isInitialized = true;
          });
        } else {
          return initializeSlick();
        }
      }
    };
  }
]);