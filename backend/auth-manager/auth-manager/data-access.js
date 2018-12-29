module.exports = (hemera, cfg) => {

    const { collection } = cfg;

    return {
        findByLogin: async (token, query) => {
            return await hemera.act({
                topic: 'sql-store',
                cmd: 'find',
                collection: collection,
                query: { Login: query.Login }
            })
        },
        findByToken: async (token, query) => {
            return await hemera.act({
                topic: 'sql-store',
                cmd: 'find',
                collections: collection,
                query: {} //CACHE MANAGER }
            })
        }
    }

}
