
function create(hemera, opts) {

    const { store, cfg } = opts;
    const { collection } = cfg;

    return async (req) => {
        const{ Name, Email, Password,  } = req.query;

        let res = {};

        try {
            
        } catch(e) {
            return { error: true, message: 'Database error', details: e }
        }
    };
}

module.exports = create;