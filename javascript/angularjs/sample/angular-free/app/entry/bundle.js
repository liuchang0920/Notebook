webpackJsonp([0],[
/* 0 */
/*!*****************!*\
  !*** multi app ***!
  \*****************/
/***/ (function(module, exports, __webpack_require__) {

	module.exports = __webpack_require__(/*! ./app/bootstrap.js */1);


/***/ }),
/* 1 */
/*!**************************!*\
  !*** ./app/bootstrap.js ***!
  \**************************/
/***/ (function(module, exports, __webpack_require__) {

	'use strict';
	
	var _app = __webpack_require__(/*! ./app.js */ 2);
	
	var _app2 = _interopRequireDefault(_app);
	
	function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }
	
	// bootstrap.js
	// 注入babel-polyfill
	__webpack_require__(/*! babel-polyfill */ 4);
	// 注入angular相关配置，如路由等
	
	// 获取angular相关依赖
	var angular = __webpack_require__(/*! angular */ 330);
	var ngRoute = __webpack_require__(/*! angular-route */ 332);
	var uiRouter = __webpack_require__(/*! angular-ui-router */ 334);
	// 注入angular相关依赖
	var dependencies = [ngRoute, uiRouter];
	// 获取angular的app
	var ngModule = angular.module('AngularFree', dependencies);
	// 进行angular相关配置
	(0, _app2.default)(ngModule, angular);
	// 启动应用
	angular.bootstrap(document, ['AngularFree']);

/***/ }),
/* 2 */
/*!********************!*\
  !*** ./app/app.js ***!
  \********************/
/***/ (function(module, exports, __webpack_require__) {

	'use strict';
	
	Object.defineProperty(exports, "__esModule", {
	    value: true
	});
	
	// app.js
	exports.default = function (ngModule, angular) {
	    ngModule.config(['$stateProvider', '$compileProvider', '$httpProvider', function ($stateProvider, $compileProvider, $httpProvider) {
	        $compileProvider.debugInfoEnabled(true);
	        // 未登录则跳转至登录页
	        if (!sessionStorage.getItem('username') && location.href.indexOf('login') === -1) {
	            location.href = 'index.html#/login';
	        }
	        // ui-router路由的参数
	        var routerStates = [{
	            name: 'login',
	            url: '/login',
	            templateUrl: __webpack_require__(/*! file?name=[path][name].[ext]!./modules/login/login.template.html */ 3)
	        }];
	        // ui-router路由设置
	        routerStates.forEach(function (stateParams) {
	            $stateProvider.state(stateParams);
	        });
	    }]);
	};

/***/ })
]);
//# sourceMappingURL=bundle.js.map