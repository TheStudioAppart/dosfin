
function manager(hemera, opts) {

    const communicator = require('./communicator');
    const da = require('./data-access');

    opts = { ...opts, communicator, da };
    
    const create = require('./handler/create')(hemera, opts);
    const _delete = require('./handler/delete')(hemera, opts);
    const update = require('./handler/update')(hemera, opts);
    const findAll = require('./handler/findAll')(hemera, opts);
    const findOne = require('./handler/findOne')(hemera, opts);
    
    return {
        create,
        delete: _delete,
        update,
        findAll,
        findOne
    };
}

module.exports = manager;