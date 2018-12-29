
function update(hemera, opts) {

    const { store, cfg } = opts;
    const { collection } = cfg;

    return async (req) => {
        const{ Name } = req.query;

        let res = {};

        try {
            
        } catch(e) {
            return { error: true, message: 'Database error', details: e }
        }
    };
}

module.exports = update;