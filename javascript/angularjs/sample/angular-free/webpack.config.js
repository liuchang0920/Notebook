var webpack = require('webpack');
var CommonsChunkPlugin = require('webpack/lib/optimize/CommonsChunkPlugin');
var ExtractTextPlugin = require('extract-text-webpack-plugin');

var path = require('path');
var config = {
    entry: {
        app: ['./app/bootstrap.js'] // where the project started
    },
    output: {
        path: path.resolve(__dirname, 'app/entry'), // the folder after compiling
        publicPath: '/entry/',
        filename: 'bundle.js' // generated js file
    }, 
    module: [
        // use CommonsChunksPlugin to load pulic modules
        new CommonsChunkPlugin({
            name: 'vendors.js',
            filename: 'vendors.js',
            minChunks: function(module) {
                var userRequest = module.userRequest;
                if(typeof userRequest !== 'string') {
                    return false;
                }
                return userRequest.indexOf('node_modules') >= 0
            }
        })
    ]
};

module.exports = config;

// bundle.js: compiled js file
// vendor.js: dependency js file


