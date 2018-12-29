module.exports = (hemera, cfg) => {


    return {
        findByLogin: async (token, query) => {
            return await hemera.act({
                topic: 'sql-store',
                cmd: 'find',
                collection: 'user',
                query: { Login: query.Login }
            })
        }
    }

}
