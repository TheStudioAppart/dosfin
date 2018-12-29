
function login(hemera, opts) {

    const { store, cfg, communicator, da } = opts;
    const { collection } = cfg;

    return async (req) => {
        const{ Email, Password } = req.query;

        let res = {};

        try {
            
        } catch(e) {
            return { error: true, message: 'Database error', details: e }
        }
    };
}

module.exports = login;