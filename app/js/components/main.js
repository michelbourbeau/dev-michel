require.config({
    baseUrl: 'app/js',
    paths: {
        jquery: 'components/jquery/jquery-3.2.1.min'
    },
    shim: {
        'components/jquery/jquery.pluginA.js': ['jquery'],
        'components/jquery/jquery.pluginB.js': ['jquery']
    }
});