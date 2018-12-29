
function manager(hemera, opts) {

<<<<<<< HEAD
    const communicator = require('./communicator');
    const da = require('./data-access');

    opts = { ...opts, communicator, da };
=======
    // Add comminucator
>>>>>>> 2fc9a06609214302188aec53ea3c14fdf2ced3c2
    

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