module.exports = {
    apps: [
        {
            name: 'API',
            script: 'index.js',
            cwd: './api-connector',
            "watch": true,
            env: { "NODE_ENV": "development" }
        },
        {
            name: 'AUTH',
            script: 'index.js',
            cwd: './backend/auth-manager',
            watch: true,
            env: { "NODE_ENV": "development" }
        },
    ],
    deploy: {
        production: {
            user: 'node',
        }
    }
}
