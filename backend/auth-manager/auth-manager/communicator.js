module.exports = function communication(hemera) {

    //internal 
    const getTokenMessage = { topic: 'auth-manager', cmd: 'getToken' };
    const getLoginMessage = { topic: 'auth-manager', cmd: 'getLogin' };
    const getRoleMessage = { topic: 'auth-manager', cmd: 'getRole' };
    const dispatchLoginMessage = { topic: 'auth-manager', cmd: 'dispatchLogin' };
    const dispatchLogoutMessage = { topic: 'auth-manager', cmd: 'dispatchLogout' };

    return {

        getToken: async (query) => await hemera.act({getTokenMessage, query}),

    }
}