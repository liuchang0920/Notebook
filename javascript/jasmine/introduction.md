# Jasmine

Jasmine是一款JavaScript 测试框架，它不依赖于其他任何 JavaScript 组件。它有干净清晰的语法，让您可以很简单的写出测试代码。

其次，Jasmine官网介绍里面开篇第一句话是“Jasmine is a behavior-driven development framework for testing JavaScript code.”，主要的意思就是说它是一款BDD模式的测试框架，也就是行为驱动开发，同样它是一种敏捷软件开发的技术。

> BDD 更像是一种团队的约定，javascript 单元测试，也许对于你本人（开发该脚本的前端）意义不是特别突出，但对于整个团队，整个项目来说就是一种财富



1. 在项目根目录中，初始化 package.json

npm init
2. 目录结构：

- src
    - index.js
- test
    - indexTest.js
package.json
3. 安装 karma + jasmine 相关包

npm install -g karma-cli
npm install karma karma-jasmine karma-chrome-launcher jasmine-core --save-dev
4. 开启 Karma

karma start

5. 初始化 karma

karma init


## karma 完整内容

```js
// Karma configuration
// Generated on Wed Nov 16 2016 14:26:14 GMT+0800 (中国标准时间)

module.exports = function(config) {
    config.set({

        // base path that will be used to resolve all patterns (eg. files, exclude)
        basePath: '',

        // frameworks to use
        // available frameworks: https://npmjs.org/browse/keyword/karma-adapter
        frameworks: ['jasmine'],

        // list of files / patterns to load in the browser
        files: [
            'src/**/*.js',
            'test/**/*.js'
        ],

        // list of files to exclude
        exclude: [],

        // preprocess matching files before serving them to the browser
        // available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
        preprocessors: {
           
        },

        // test results reporter to use
        // possible values: 'dots', 'progress'
        // available reporters: https://npmjs.org/browse/keyword/karma-reporter
        reporters: ['progress'],

        // web server port
        port: 9876,

        // enable / disable colors in the output (reporters and logs)
        colors: true,

        // level of logging
        // possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
        logLevel: config.LOG_INFO,

        // enable / disable watching file and executing tests whenever any file changes
        autoWatch: true,

        // start these browsers
        // available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
        browsers: ['Chrome'],

        // Continuous Integration mode
        // if true, Karma captures browsers, runs the tests and exits
        singleRun: false,

        // Concurrency level
        // how many browser should be started simultaneous
        concurrency: Infinity
    })
}

```