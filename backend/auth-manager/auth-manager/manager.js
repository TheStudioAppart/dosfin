
function manager(hemera, opts) {
    const communicator = require('./communicator');
    const da = require('./data-access');

    opts = { ...opts, communicator, da };

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