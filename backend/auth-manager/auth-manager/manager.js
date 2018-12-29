
function manager(hemera, opts) {

    // Add comminucator
    
    const login = require('./handler/login')(hemera, opts);
    const logout = require('./handler/logout')(hemera, opts);
    const getToken = require('./handler/getToken')(hemera, opts);
    const updateToken = require('./handler/updateToken')(hemera, opts);

    return {
        login,
        logout,
        getToken,
        updateToken
    };
}

module.exports = manager;